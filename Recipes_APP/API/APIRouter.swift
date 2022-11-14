////
////  APIRouter.swift
////  MadeInKuwait
////
////  Created by Amir on 1/29/20.
////  Copyright © 2020 Amir. All rights reserved.
////
//
//
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case searchForRecipe(q:String,healthFilters:[String])
//    /movie?api_key=18f1dd9d9a6779af535c45513bd22779&query=The%20Avengers
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
//            el vend details fel post man get request w hena maktop .post ?
        case .searchForRecipe:
            return .get
            
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .searchForRecipe(let q,let healthFilters): return "/recipes/v2?type=public&q=\(q)&app_id=\(Constants.ProductionServer.app_id)&app_key=\(Constants.ProductionServer.app_key)\(getPostString(strArr: healthFilters, separator: "&"))"
        }
    }
    
    
    // MARK: - Parameters
//    why get api calls has no parameters and directly inserted within the url or if path == ta7t
    private var parameters: Parameters? {
        switch self {
            
//        case.login(let username,let password):
//            let parameters: [String:Any] = [
//            "password" : password ,
//            "username" : username
//            ]
//            return parameters
            
        case   .searchForRecipe :
            return nil
       
        }
    }
    
    func getPostString(strArr:[String],separator:String) -> String
      {
          var dataStr = ""
        
          for value in strArr
          {
              if value == "" {
                  continue
              }
              dataStr += "\(separator)health=\(value)"
//              if key < strArr.count-1 {
//                  dataStr += separator
//              }                                  
          }
          return dataStr
      }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        var main_api_url = ""
        main_api_url = Constants.ProductionServer.baseURL + path
        print(main_api_url)
        let urlComponents = URLComponents(string: main_api_url)!
        let url = urlComponents.url!
        var urlRequest = URLRequest(url: url)
        
        print("URLS REQUEST :\(urlRequest)")
        
        // HTTP Method
//        urlRequest.httpMethod = method.rawValue
//        let credentialData = "ck_37baea2e07c8960059930bf348d286c7e48eb325:cs_0d74440eb12ac4726080563a4ceb0363ad5a0112".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
//        let base64Credentials = credentialData.base64EncodedString()
//        let headers = "Basic \(base64Credentials)"
//
//        urlRequest.setValue(headers, forHTTPHeaderField: Constants.HTTPHeaderField.authentication.rawValue)
        
        
        // Parameters
        if let parameters = parameters {
            do {
                print(parameters)
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])

            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }


        }
        


//        if path == "login.php" || path == "edit_profile.php" || path == "edit_avatar.php" || path == "insertorder.php" || path == "add_customer_adrs.php" || path == "insert_order_cart.php"{
//            return try URLEncoding.default.encode(urlRequest, with: parameters)
//        }
        

        
        return urlRequest as URLRequest
        

    }
}
