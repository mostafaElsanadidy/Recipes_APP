//
//  File.swift
//  RecipesApp
//
//  Created by mostafa elsanadidy on 27.05.22.
//

import Foundation
import SwiftyJSON

class Link{

    
//    enum CodingKeys: String, CodingKey {
//            case Selfo = "self"
//        }

    var next : Next!
    var Selfo : Next!

    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let nextJson = json["next"]
        if !nextJson.isEmpty{
            next = Next(fromJson: nextJson)
        }
        let selfJson = json["self"]
        if !selfJson.isEmpty{
            Selfo = Next(fromJson: selfJson)
        }
       // print(Selfo?.title)
    }

}
