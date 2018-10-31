//
//  BeerApi.swift
//  BeerApi
//
//  Created by André Brilho on 30/10/2018.
//  Copyright © 2018 André Brilho. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class BeersApi {
    static func fetchBeers(numberPage: Int, completion: @escaping (String?, [Beer]?) -> Void) {
        if let networkingRechabilityManager = NetworkReachabilityManager(), networkingRechabilityManager.isReachable{
            if let url = URL(string: Constants.URLBASE + String(numberPage)){
                let request = URLRequest(url: url)
                Alamofire.request(request).responseArray(completionHandler: { (dataResponse: DataResponse<[Beer]>) in
                    if let response = dataResponse.response, response.statusCode == 200 {
                        completion(nil, dataResponse.result.value)
                    }else{
                        completion("", nil)
                    }
                })
            }
        } else {
            completion("Sem conexão com a internet", nil)
        }
    }
    
}
