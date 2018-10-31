//
//  BeerDetalheViewController.swift
//  BeerApi
//
//  Created by André Brilho on 30/10/2018.
//  Copyright © 2018 André Brilho. All rights reserved.
//

import UIKit
import AlamofireImage

class BeerDetalheViewController: UIViewController {
    
    var beer:Beer!
    
    @IBOutlet weak var imgBeer: UIImageView!
    @IBOutlet weak var txtDesc: UITextView!
    @IBOutlet weak var nameBeer: UILabel!
    @IBOutlet weak var info1Beer: UILabel!
    @IBOutlet weak var info2Beer: UILabel!
    @IBOutlet weak var info3Beer: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.contentSize = CGSize(width: scrollView.contentSize.width,height:0);
        txtDesc.text = beer.description
        nameBeer.text = beer.name
        info1Beer.text = ("ABV: ") + String(beer.abv)
        info2Beer.text = ("TAG: ") + beer.tagline
        info3Beer.text = ("LVL: ") + String(beer.attenuation_level)
        
        imgBeer.image = nil
        imgBeer.af_cancelImageRequest()
        activityIndicator.startAnimating()
        imgBeer.af_setImage(withURL: URL(string:beer.image_url)!, filter: AspectScaledToFitSizeFilter(size: CGSize(width: imgBeer.frame.size.width, height: imgBeer.frame.size.height)), imageTransition: .crossDissolve(0.7), runImageTransitionIfCached: true, completion: { (_) in
            self.activityIndicator.stopAnimating()
        }
        )}
    
    @IBAction func voltarBtn(_ sender: Any) {
            dismiss(animated: true)
    }
    
        
}

