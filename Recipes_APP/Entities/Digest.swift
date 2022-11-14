//
//  File.swift
//  RecipesApp
//
//  Created by mostafa elsanadidy on 27.05.22.
//

import Foundation
import SwiftyJSON

class Digest{

    var daily : Float!
    var hasRDI : Bool!
    var label : String!
    var schemaOrgTag : AnyObject!
    var sub : [Sub]!
    var tag : String!
    var total : Float!
    var unit : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        daily = json["daily"].floatValue
        hasRDI = json["hasRDI"].boolValue
        label = json["label"].stringValue
        schemaOrgTag = json["schemaOrgTag"].stringValue as AnyObject
        sub = [Sub]()
        let subArray = json["sub"].arrayValue
        for subJson in subArray{
            let value = Sub(fromJson: subJson)
            sub.append(value)
        }
        tag = json["tag"].stringValue
        total = json["total"].floatValue
        unit = json["unit"].stringValue
    }

}
