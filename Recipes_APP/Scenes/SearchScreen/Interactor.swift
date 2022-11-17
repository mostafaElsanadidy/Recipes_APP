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
    
//    func deleteRecipes(where itemName: String)
//    func searchRecipes(with searchTuple:(key:String,text:String))
//    func loadRecipes()
//    func updateRecipe(at index:Int,with newQuantity:Int)
}

protocol AnyRecipesInteractor:AnyInteractor {

    var presenter: AnyRecipesPresenter?{get set}
    func getRecipes(searchKey: String, healthFilters:[String], nextPageTag:String)
//    func saveRecipes(recipe:Recipe,quantity:Int)
//
//    func deleteRecipes(where itemName: String)
//    func searchRecipes(with searchTuple:(key:String,text:String))
//    func loadRecipes()
//    func updateRecipe(at index:Int,with newQuantity:Int)
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
    
    
    //MARK: - the R in the word CRUD
    
    
    //MARK: - the U in the word CRUD
}


