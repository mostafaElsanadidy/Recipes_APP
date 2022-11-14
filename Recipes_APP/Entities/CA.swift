//
//  File.swift
//  RecipesApp
//
//  Created by mostafa elsanadidy on 27.05.22.
//

import Foundation
import SwiftyJSON

class CA{

    var label : String!
    var quantity : Float!
    var unit : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        label = json["label"].stringValue
        quantity = json["quantity"].floatValue
        unit = json["unit"].stringValue
    }

}
