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
            [weak self] in
                guard let strongSelf = self else{return}
            strongSelf.recipeContainer = RecipeContainer(recipeNameText: recipe.label ?? "", recipePicUrl: URL(string: recipe.image ?? ""),recipePublisherUrlText: recipe.url, recipeIngredientsText: recipe.ingredientLines.joined(separator: "\n"))
            strongSelf.view?.update(with: strongSelf.recipeContainer!)
        }
    }
}
