//
//  Interactor.swift
//  Salamtak
//
//  Created by mostafa elsanadidy on 06.11.22.
//

import Foundation

// object
// need protocol
// ref to presenter


protocol AnyInteractor{
 
}

protocol AnyRecipesInteractor:AnyInteractor {

    var presenter: AnyRecipesPresenter?{get set}
    func getRecipes(searchKey: String, healthFilters:[String], nextPageTag:String)
}

class RecipesInteractor: AnyRecipesInteractor{
    
    
    var defaultHandler: ()->() = {}
    var presenter: AnyRecipesPresenter?
    
    func getRecipes(searchKey: String, healthFilters:[String], nextPageTag:String) {
        APIClient.searchForRecipe(searchKey: searchKey, healthFilters: healthFilters,nextPageTag: nextPageTag){[weak self] (result) in
            guard let strongSelf = self else{return}
            
            switch result {
            case .failure(let error) :
                strongSelf.presenter?.interactorDidFetchRecipes(with: .failure(error))
            case .success(let value) :
                guard let recipes_data = value else { return  }
                strongSelf.presenter?.interactorDidFetchRecipes(with: .success(recipes_data))
            }
        }
    }
    
    
    // MARK: - Get My Recipes Data
    func getStringFromArr(strArr:[String],separator:String) -> String
      {
          var dataStr = ""
        
          for (key,value) in strArr.enumerated()
          {
              dataStr += "\(value)"
              if key < strArr.count-1 {
                  dataStr += separator
              }
          }
          return dataStr
      }
    
}


