////
////  Constants.swift
////  MadeInKuwait
////
////  Created by Amir on 1/29/20.
////  Copyright © 2020 Amir. All rights reserved.
////

import Alamofire

struct Constants {
    
    static var deviceID = UIDevice.current.identifierForVendor!.uuidString
    static let randomQueue =  DispatchQueue(label: "randomQueue", qos: .utility)
    
    struct ProductionServer {
        static let baseURL = "https://api.edamam.com/api/recipes/v2"
        static let app_id = "00ffed0e"
        static let app_key = "6b16b316d1d7b893172c23749c1f6081"
        
    }
    
    enum APIParameters :String{
        case message
        case code
        case token
        case status_code
    }
    
    enum QueryType :String{
        case publico = "public"
        case user = "user"
        case any = "any"
    }
    
    enum HTTPHeaderField: String {
        case token = "x-access-token"
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
        case Language = "Accept-Language"
    }
    
    enum ContentType: String {
        case json = "application/json"
    }
}

