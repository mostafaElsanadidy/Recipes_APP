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
    func saveRecipes(recipe:Recipe,quantity:Int)
    
    func deleteRecipes(where itemName: String)
    func searchRecipes(with searchTuple:(key:String,text:String))
    func loadRecipes()
    func updateRecipe(at index:Int,with newQuantity:Int)
}

class RecipesInteractor: AnyRecipesInteractor{
    
    
    var defaultHandler: ()->() = {}
    var presenter: AnyRecipesPresenter?
    var managedObjectHandler:ManagedObjectHandler?

    
    init() {
        managedObjectHandler = ManagedObjectHandler()
    }
    
    func getRecipes(searchKey: String, healthFilters:[String], nextPageTag:String) {
        APIClient.searchForRecipe(searchKey: searchKey, healthFilters: healthFilters,nextPageTag: nextPageTag){[unowned self] (result) in
            switch result {
            case .failure(let error) :
                self.presenter?.interactorDidFetchRecipes(with: .failure(error))
            case .success(let value) :
                guard let recipes_data = value else { return  }
                self.presenter?.interactorDidFetchRecipes(with: .success(recipes_data))
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

extension RecipesInteractor{
    
    
    typealias ManagedObjectHandler = CoreDataHandler<ManagedRecipe>
    
    func saveRecipes(recipe:Recipe,quantity:Int) {
        let selectedRecipe = ManagedRecipe.init(context: viewContext)
                    let recipe = recipe
                    selectedRecipe.name = recipe.label
        managedObjectHandler?.saveItems(afterSaving: {
            [unowned self]
            result in
            switch result {
            case .failure(let error) :
                self.presenter?.interactorDidAccessCoreData(with: .failure(error),state: .create)
            case .success(let value) :
                guard let recipes_data = value else { return  }
                self.presenter?.interactorDidAccessCoreData(with: .success(recipes_data), state: .create)

            }
        })
    }

    func deleteRecipes(where itemName: String) {
        let index = managedObjectHandler?.items.firstIndex(where: { $0.name == itemName })
          managedObjectHandler?.deleteItems(at:
                                                index ?? 0
                                                , afterDelete: {
              [unowned self]
              result in
              switch result {
              case .failure(let error) :
                  self.presenter?.interactorDidAccessCoreData(with: .failure(error),state: .delete)
              case .success(let value) :
                  guard let recipes_data = value else { return  }
                  self.presenter?.interactorDidAccessCoreData(with: .success(recipes_data), state: .delete)

              }
          })
      }

    func searchRecipes(with searchTuple: (key: String, text: String)) {
        managedObjectHandler?.searchForItem(with: searchTuple, initialRequest: ManagedRecipe.fetchRequest(), didEndSearching: {
            [unowned self]
            result in
            switch result {
            case .failure(let error) :
                self.presenter?.interactorDidAccessCoreData(with: .failure(error),state: .search)
            case .success(let value) :
                guard let recipes_data = value else { return  }
                self.presenter?.interactorDidAccessCoreData(with: .success(recipes_data), state: .search)

            }
        })
    }

    func loadRecipes() {

        managedObjectHandler?.loadItems(with: ManagedRecipe.fetchRequest()){
            [unowned self]
            result in
            switch result {
            case .failure(let error) :
                self.presenter?.interactorDidAccessCoreData(with: .failure(error),state: .read)
            case .success(let value) :
                guard let recipes_data = value else { return  }
                self.presenter?.interactorDidAccessCoreData(with: .success(recipes_data), state: .read)

            }
        }
    }

    func updateRecipe(at index:Int,with newQuantity:Int) {
      
        managedObjectHandler?.updateItem(didBeginUpdating: {
            recipes in
//            recipes[0].quantity = Int16(newQuantity)
        }, didEndUpdating: {
            [unowned self]
            result in
            
            switch result {
            case .failure(let error) :
                self.presenter?.interactorDidAccessCoreData(with: .failure(error),state: .update)
            case .success(let value) :
                guard let recipes_data = value else { return  }
                self.presenter?.interactorDidAccessCoreData(with: .success(recipes_data), state: .update)

            }
        })
    }

}
