//
//  API_Get.swift
//  RecipesApp
//
//  Created by mostafa elsanadidy on 27.05.22.
//

import Foundation
import Alamofire
import SwiftyJSON

extension APIClient{
    // MARK: - Search For Recipes
    static func searchForRecipe(searchKey:String,healthFilters:[String], completionHandler : @escaping (Result<[Hit]? , Result_Error>) -> Void ) {
        ad.isLoading()
        performSwiftyRequest(route: .searchForRecipe(q: searchKey, healthFilters: healthFilters)) { (jsonData) in
            let json = JSON(jsonData)
        //    print("Json is \(json)")
            guard let message = json["message"].string else {
                print("dsfsadfsaf")
                DispatchQueue.main.async {
                    ad.killLoading()
                    let data = Recipes_Root(fromJson: json).hits
                    completionHandler(.success(data))
                }
                return
            }
            print(message)
            ad.killLoading()
//            let sms = getError(json: json)
            ad.CurrentRootVC()?.show_Popup(body: message, type: .single, status: .failure)
            completionHandler(.failure(.status_Failure))
            
        } _: { (error) in
            ad.killLoading()
            DispatchQueue.main.async {
                ad.CurrentRootVC()?.show_Popup(body: error.debugDescription, type: .single, status: .failure)
                completionHandler(.failure(.req_Failure))
            }
        }

    }
}
