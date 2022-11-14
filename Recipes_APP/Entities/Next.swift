//
//  File.swift
//  RecipesApp
//
//  Created by mostafa elsanadidy on 27.05.22.
//

import Foundation
import SwiftyJSON

class Next{

    var href : String!
    var title : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        href = json["href"].stringValue
        title = json["title"].stringValue
    }

}
