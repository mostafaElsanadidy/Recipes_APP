//
//  File.swift
//  RecipesApp
//
//  Created by mostafa elsanadidy on 27.05.22.
//

import Foundation
import SwiftyJSON

class Image{

    var lARGE : LARGE!
    var rEGULAR : LARGE!
    var sMALL : LARGE!
    var tHUMBNAIL : LARGE!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let lARGEJson = json["LARGE"]
        if !lARGEJson.isEmpty{
            lARGE = LARGE(fromJson: lARGEJson)
        }
        let rEGULARJson = json["REGULAR"]
        if !rEGULARJson.isEmpty{
            rEGULAR = LARGE(fromJson: rEGULARJson)
        }
        let sMALLJson = json["SMALL"]
        if !sMALLJson.isEmpty{
            sMALL = LARGE(fromJson: sMALLJson)
        }
        let tHUMBNAILJson = json["THUMBNAIL"]
        if !tHUMBNAILJson.isEmpty{
            tHUMBNAIL = LARGE(fromJson: tHUMBNAILJson)
        }
    }

}
