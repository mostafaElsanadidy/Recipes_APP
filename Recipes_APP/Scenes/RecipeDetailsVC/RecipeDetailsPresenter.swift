//
//  RecipeDetailsPresenter.swift
//  Recipes_APP
//
//  Created by mostafa elsanadidy on 16.11.22.
//

import Foundation
protocol AnyRecipeDetailsPresenter:AnyPresenter{
    var router: AnyRecipeDetailsRouter? {get set}
    var interactor: AnyRecipeDetailsInteractor? {get set}
    var view: AnyRecipeDetailsView? {get set}
    var recipeContainer:RecipeContainer? {get set}
    func showPublisherWebsite()
    func interactorDidFetchRecipes(with result: Result<Recipe,Result_Error>)
}


class RecipeDetailsPresenter: AnyRecipeDetailsPresenter {
    
    
    func showPublisherWebsite() {
        router?.routeToPublisherWebsite(urlStr: recipeContainer?.recipePublisherUrlText ?? "")
    }
    
  
    var selectedRecipeUrlStr: String = ""
    var shareAsUrlStr = ""
    var recipeContainer:RecipeContainer?
    var router: AnyRecipeDetailsRouter?
    
    var interactor: AnyRecipeDetailsInteractor?
    
    var view: AnyRecipeDetailsView?
    
    func viewDidLoad() {
        print("sdfsd")
        view?.setupScreenInitialState()
        interactor?.getRecipeDetails(id: selectedRecipeUrlStr)
    }
    
    
    
    
}


extension RecipeDetailsPresenter{
    
    func interactorDidFetchRecipes(with result: Result<Recipe, Result_Error>) {
        switch result {
        case .failure(let error):
            self.view?.update(with: error)
        case .success(let recipes_data):
            self.update(with: recipes_data)
        }
    }
    func update(with recipe: Recipe) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
//            print(recipes.map{$0.recipe.label})
//            let numOfItemsPerAppending = 3
            
            self.recipeContainer = RecipeContainer(recipeNameText: recipe.label ?? "", recipePicUrl: URL(string: recipe.image ?? ""),recipePublisherUrlText: recipe.url, recipeIngredientsText: recipe.ingredientLines.joined(separator: "\n"))
            self.view?.update(with: self.recipeContainer!)
//            if recipes.count > numOfItemsPerAppending{
//                for index in 0..<numOfItemsPerAppending{
//                    self.separateOrdersContainer.recipes.append(recipes[index])
//                }
//            }else{
//                self.separateOrdersContainer.recipes.append(contentsOf: recipes)}
//            self.indexFrom += 3
//            self.indexTo += 3
            
//            self.interactor?.loadRecipes()
        }
        
    }
}
