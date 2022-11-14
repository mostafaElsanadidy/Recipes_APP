//
//  Interactor.swift
//  RecipesApp
//
//  Created by mostafa elsanadidy on 14.11.22.
//

import Foundation
import CoreData

// object
// need protocol
// ref to presenter

protocol AnyInteractor{
    
    func deleteRecipes(where itemName: String)
    func searchRecipe(with searchTuple:(key:String,text:String))
    func loadMedicines()
    func updateRecipe(at index:Int,with newQuantity:Int)
}

protocol AnyRecipesInteractor:AnyInteractor {

    var presenter: AnyRecipesPresenter?{get set}
    func getRecipes(searchKey:String,healthParams:[String])
    func saveMedicines(medicine:Complaint,quantity:Int)
}


class RecipesInteractor: AnyRecipesInteractor {
   
    typealias ManagedObjectHandler = CoreDataHandler<SelectedRecipe>
    init() {
        managedObjectHandler = ManagedObjectHandler()
      //  managedObjectHandler?.initialRequest = SelectedRecipe.fetchRequest()
    }
    
    func saveRecipes() {
        managedObjectHandler?.saveRecipes(afterSaving: {
            [unowned self]
            recipes in
            self.presenter?.interactorDidAccessCoreData(with: recipes)
        })
    }
    
    func deleteItems(at index: Int) {
          managedObjectHandler?.deleteItems( at: index, afterDelete: {
              [unowned self]
              recipes in
              self.presenter?.interactorDidAccessCoreData(with: recipes)
          })
      }
    
    func searchRecipe(with searchTuple: (key: String, text: String),parentRestaurant restaurantTuple:(key:String,name:String)?) {
        managedObjectHandler?.searchRecipe(with: searchTuple, parentRestaurant: restaurantTuple, initialRequest: SelectedRecipe.fetchRequest(), didEndSearching: {
            [unowned self]
            recipes in
            self.presenter?.interactorDidAccessCoreData(with: recipes)
        })
    }
    
    func loadRecipes(parentRestaurant restaurantTuple:(key:String,name:String)?) {
        
        
        
        managedObjectHandler?.loadRecipes(with: SelectedRecipe.fetchRequest(), parentRestaurant: restaurantTuple){
            [unowned self]
            recipes in
            self.presenter?.interactorDidAccessCoreData(with: recipes)
        }
    }
    
    func updateRecipe(at index:Int,with updateValueKeys:(dueDate:Bool,title:String)) {
        //selectedRecipes[index].dueDate = !selectedRecipes[index].dueDate
        managedObjectHandler?.updateRecipe(didBeginUpdating: {
            recipes in
            recipes[index].dueDate = updateValueKeys.dueDate
            recipes[index].title = updateValueKeys.title
        }, didEndUpdating: {
            [unowned self]
            recipes in
            self.presenter?.interactorDidAccessCoreData(with: recipes)
        })
    }
    
    
    var defaultHandler: ()->() = {}
    var presenter: AnyRecipesPresenter?
    var managedObjectHandler:ManagedObjectHandler?
    
    func getRecipes(searchKey:String,healthParams:[String] = [""]) {
        get_My_Recipes_Data(searchKey: searchKey, healthParams: healthParams)
    }
    
    // MARK: - Get My Recipes Data
    func get_My_Recipes_Data(searchKey:String,healthParams:[String]) {
        APIClient.searchForRecipe(searchKey: searchKey, healthFilters: healthParams) {[unowned self] (result) in
            switch result {
            case .failure(let error) :
                self.presenter?.interactorDidFetchRecipes(with: .failure(error))
            case .success(let value) :
                guard let recipes_data = value else { return  }
                print(recipes_data.count)
                NetworkHelper.lastSuggestion = ["mostafa","bamba","manar"]
                self.presenter?.interactorDidFetchRecipes(with: .success(recipes_data))
                NetworkHelper.lastSuggestion = ["mostafa","bamba","manar"]
            }
        }
    }
    
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
