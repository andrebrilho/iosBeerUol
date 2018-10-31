//
//  ViewController.swift
//  BeerApi
//
//  Created by André Brilho on 30/10/2018.
//  Copyright © 2018 André Brilho. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    var numberPage = 1
    var beers:[Beer] = []
    @IBOutlet weak var tbl: UITableView!
    var finished:Bool = false
    var loadingView:LoadingTableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl.register(UINib(nibName: "BeerTableViewCell", bundle: nil), forCellReuseIdentifier: "BeerTableViewCell")
        tbl.register(UINib(nibName: "LoadingTableViewCell", bundle: nil), forCellReuseIdentifier: "LoadingTableViewCell")
        tbl.dataSource = self
        tbl.delegate = self
        getBeers()
    }
    
    func getBeers(){
        BeersApi.fetchBeers(numberPage: numberPage) { (error, beers) in
            if let error = error {
                print(error)
            }else if let beers = beers {
                self.beers = beers
                DispatchQueue.main.async {
                    self.tbl.reloadData()
                }
            }
        }
    }
    
    
    //MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == beers.count) {
            let cellLoading = tbl.dequeueReusableCell(withIdentifier: "LoadingTableViewCell", for: indexPath) as! LoadingTableViewCell
            loadingView = cellLoading
            cellLoading.actIndicator.startAnimating()
            return cellLoading
        }else{
            let cell = tbl.dequeueReusableCell(withIdentifier: "BeerTableViewCell", for: indexPath) as! BeerTableViewCell
            cell.beer = beers[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == beers.count - 1 && !finished {
            numberPage += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                BeersApi.fetchBeers(numberPage: self.numberPage) { (error, beers) in
                    if let beers = beers, beers.count > 0 {
                        self.beers.append(contentsOf: beers)
                        self.tbl.reloadData()
                        self.tbl.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                    else {
                        self.loadingView.actIndicator.isHidden = true
                        self.finished = true
                    }
                    self.alertInternet()
                }
            }
        }
    }
    
    func showAlert(message:String){
        
        let refreshAlert = UIAlertController(title: "Alerta", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in }))
        
        present(refreshAlert, animated: true, completion: nil)
    }

    func alertInternet(){
        if Reachability.isConnectedToNetwork(){
            print("internet OK")
        }else{
            showAlert(message: Constants.messageForNoInternet)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        alertInternet()
        if let beerDetailCarroViewController = storyboard?.instantiateViewController(withIdentifier: "BeerDetalheViewController") as? BeerDetalheViewController {
            beerDetailCarroViewController.beer = beers[indexPath.row]
            self.present(beerDetailCarroViewController, animated: true)

        }
}
}
