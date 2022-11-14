//
//  File.swift
//  RecipesApp
//
//  Created by mostafa elsanadidy on 27.05.22.
//

import Foundation
import SwiftyJSON

class TotalDaily{

    var cA : CA!
    var cHOCDF : CA!
    var cHOLE : CA!
    var eNERCKCAL : CA!
    var fASAT : CA!
    var fAT : CA!
    var fE : CA!
    var fIBTG : CA!
    var fOLDFE : CA!
    var k : CA!
    var mG : CA!
    var nA : CA!
    var nIA : CA!
    var p : CA!
    var pROCNT : CA!
    var rIBF : CA!
    var tHIA : CA!
    var tOCPHA : CA!
    var vITARAE : CA!
    var vITB12 : CA!
    var vITB6A : CA!
    var vITC : CA!
    var vITD : CA!
    var vITK1 : CA!
    var zN : CA!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let cAJson = json["CA"]
        if !cAJson.isEmpty{
            cA = CA(fromJson: cAJson)
        }
        let cHOCDFJson = json["CHOCDF"]
        if !cHOCDFJson.isEmpty{
            cHOCDF = CA(fromJson: cHOCDFJson)
        }
        let cHOLEJson = json["CHOLE"]
        if !cHOLEJson.isEmpty{
            cHOLE = CA(fromJson: cHOLEJson)
        }
        let eNERCKCALJson = json["ENERC_KCAL"]
        if !eNERCKCALJson.isEmpty{
            eNERCKCAL = CA(fromJson: eNERCKCALJson)
        }
        let fASATJson = json["FASAT"]
        if !fASATJson.isEmpty{
            fASAT = CA(fromJson: fASATJson)
        }
        let fATJson = json["FAT"]
        if !fATJson.isEmpty{
            fAT = CA(fromJson: fATJson)
        }
        let fEJson = json["FE"]
        if !fEJson.isEmpty{
            fE = CA(fromJson: fEJson)
        }
        let fIBTGJson = json["FIBTG"]
        if !fIBTGJson.isEmpty{
            fIBTG = CA(fromJson: fIBTGJson)
        }
        let fOLDFEJson = json["FOLDFE"]
        if !fOLDFEJson.isEmpty{
            fOLDFE = CA(fromJson: fOLDFEJson)
        }
        let kJson = json["K"]
        if !kJson.isEmpty{
            k = CA(fromJson: kJson)
        }
        let mGJson = json["MG"]
        if !mGJson.isEmpty{
            mG = CA(fromJson: mGJson)
        }
        let nAJson = json["NA"]
        if !nAJson.isEmpty{
            nA = CA(fromJson: nAJson)
        }
        let nIAJson = json["NIA"]
        if !nIAJson.isEmpty{
            nIA = CA(fromJson: nIAJson)
        }
        let pJson = json["P"]
        if !pJson.isEmpty{
            p = CA(fromJson: pJson)
        }
        let pROCNTJson = json["PROCNT"]
        if !pROCNTJson.isEmpty{
            pROCNT = CA(fromJson: pROCNTJson)
        }
        let rIBFJson = json["RIBF"]
        if !rIBFJson.isEmpty{
            rIBF = CA(fromJson: rIBFJson)
        }
        let tHIAJson = json["THIA"]
        if !tHIAJson.isEmpty{
            tHIA = CA(fromJson: tHIAJson)
        }
        let tOCPHAJson = json["TOCPHA"]
        if !tOCPHAJson.isEmpty{
            tOCPHA = CA(fromJson: tOCPHAJson)
        }
        let vITARAEJson = json["VITA_RAE"]
        if !vITARAEJson.isEmpty{
            vITARAE = CA(fromJson: vITARAEJson)
        }
        let vITB12Json = json["VITB12"]
        if !vITB12Json.isEmpty{
            vITB12 = CA(fromJson: vITB12Json)
        }
        let vITB6AJson = json["VITB6A"]
        if !vITB6AJson.isEmpty{
            vITB6A = CA(fromJson: vITB6AJson)
        }
        let vITCJson = json["VITC"]
        if !vITCJson.isEmpty{
            vITC = CA(fromJson: vITCJson)
        }
        let vITDJson = json["VITD"]
        if !vITDJson.isEmpty{
            vITD = CA(fromJson: vITDJson)
        }
        let vITK1Json = json["VITK1"]
        if !vITK1Json.isEmpty{
            vITK1 = CA(fromJson: vITK1Json)
        }
        let zNJson = json["ZN"]
        if !zNJson.isEmpty{
            zN = CA(fromJson: zNJson)
        }
    }

}
