//
//  RecipeDetailsInteractor.swift
//  Recipes_APP
//
//  Created by mostafa elsanadidy on 16.11.22.
//

import Foundation
protocol AnyRecipeDetailsInteractor:AnyInteractor{
    var presenter: AnyRecipeDetailsPresenter?{get set}
    func getRecipeDetails(id: String)
    
}

class RecipeDetailsInteractor: AnyRecipeDetailsInteractor {
    var presenter: AnyRecipeDetailsPresenter?
    
    
    func getRecipeDetails(id: String) {
        APIClient.appearRecipeInfo(recipeId: id){[unowned self] (result) in
            switch result {
            case .failure(let error) :
                self.presenter?.interactorDidFetchRecipes(with: .failure(error))
            case .success(let value) :
                guard let recipes_data = value else { return  }
                self.presenter?.interactorDidFetchRecipes(with: .success(recipes_data.recipe))
            }
        }
    }
}
