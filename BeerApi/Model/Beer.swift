//
//  Beer.swift
//  BeerApi
//
//  Created by André Brilho on 30/10/2018.
//  Copyright © 2018 André Brilho. All rights reserved.
//

import UIKit
import ObjectMapper

class Beer: Mappable {
    
    var id: Int!
    var name: String!
    var tagline: String!
    var description: String!
    var image_url: String!
    var attenuation_level : Float!
    var abv : Float!
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        tagline <- map["tagline"]
        image_url <- map["image_url"]
        description <- map["description"]
        attenuation_level <- map["attenuation_level"]
        abv <- map["abv"]
    }
    
    
}
