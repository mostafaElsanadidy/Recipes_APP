//
//  API_Get.swift
//  RecipesApp
//
//  Created by mostafa elsanadidy on 27.05.22.
//

import Foundation
import Alamofire
import SwiftyJSON

//struct RecipesRoot {
//    var fromIndex:Int
//    var toIndex:Int
//    var count:Int
//    var nextPageUrlStr:String
//    var recipes:[RecipeStruct]
//}
//struct RecipeStruct{
//    var recipe:Recipe
//    var id:String
//}

extension APIClient{
    // MARK: - Search For Recipes
    static func searchForRecipe(searchKey:String,healthFilters:[String],nextPageTag:String, completionHandler : @escaping (Result<Recipes_Root? , Result_Error>) -> Void ) {
        ad.isLoading()
        performSwiftyRequest(route: .searchForRecipe(q: searchKey, healthFilters: healthFilters, nextPageCount: nextPageTag)) { (jsonData) in
            let json = JSON(jsonData)
        //    print("Json is \(json)")
            guard let message = json["message"].string else {
                print("dsfsadfsaf")
                DispatchQueue.main.async {
                    ad.killLoading()
                    
                    let data = Recipes_Root(fromJson: json)
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
    
    
    // MARK: - Specific Recipe Info
    static func appearRecipeInfo(recipeId:String, completionHandler : @escaping (Result<Hit? , Result_Error>) -> Void ) {
        ad.isLoading()
        performSwiftyRequest(route: .specificRecipeInfo(id: recipeId)) { (jsonData) in
            let json = JSON(jsonData)
        //    print("Json is \(json)")
            guard let message = json["message"].string else {
                print("dsfsadfsaf")
                DispatchQueue.main.async {
                    ad.killLoading()
                    let data = Hit(fromJson: json)
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
