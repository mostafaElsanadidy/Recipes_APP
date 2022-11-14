//
//  Hit.swift
//  RecipesApp
//
//  Created by mostafa elsanadidy on 27.05.22.
//

import Foundation
import SwiftyJSON

class Hit{

    var links : Link!
    var recipe : Recipe!


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
        let recipeJson = json["recipe"]
        if !recipeJson.isEmpty{
            recipe = Recipe(fromJson: recipeJson)
        }
    }

}
