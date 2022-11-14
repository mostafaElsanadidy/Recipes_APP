//
//  Recipes_Root.swift
//  RecipesApp
//
//  Created by mostafa elsanadidy on 27.05.22.
//

import Foundation
import SwiftyJSON

class Recipes_Root{

    var links : Link!
    var count : Int!
    var from : Int!
    var hits : [Hit]!
    var to : Int!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let linksJson = json["_links"]
        if !linksJson.isEmpty{
            links = Link(fromJson: linksJson)
        }
        count = json["count"].intValue
        from = json["from"].intValue
        hits = [Hit]()
        let hitsArray = json["hits"].arrayValue
        for hitsJson in hitsArray{
            let value = Hit(fromJson: hitsJson)
            hits.append(value)
        }
        to = json["to"].intValue
    }

}
