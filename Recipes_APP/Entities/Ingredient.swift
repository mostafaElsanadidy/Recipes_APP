//
//  File.swift
//  RecipesApp
//
//  Created by mostafa elsanadidy on 27.05.22.
//

import Foundation
import SwiftyJSON

class Ingredient{

    var food : String!
    var foodCategory : String!
    var foodId : String!
    var image : String!
    var measure : String!
    var quantity : Float!
    var text : String!
    var weight : Float!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        food = json["food"].stringValue
        foodCategory = json["foodCategory"].stringValue
        foodId = json["foodId"].stringValue
        image = json["image"].stringValue
        measure = json["measure"].stringValue
        quantity = json["quantity"].floatValue
        text = json["text"].stringValue
        weight = json["weight"].floatValue
    }

}
