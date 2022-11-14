//
//  File.swift
//  RecipesApp
//
//  Created by mostafa elsanadidy on 27.05.22.
//

import Foundation
import SwiftyJSON

class LARGE{

    var height : Int!
    var url : String!
    var width : Int!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        height = json["height"].intValue
        url = json["url"].stringValue
        width = json["width"].intValue
    }

}
