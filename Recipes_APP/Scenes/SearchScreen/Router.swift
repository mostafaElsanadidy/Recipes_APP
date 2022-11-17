//
//  Router.swift
//  Salamtak
//
//  Created by mostafa elsanadidy on 06.11.22.
//

import Foundation
import UIKit
// object
// Entry point


typealias EntryMedicationPoint = UIViewController&AnyRecipesView
protocol AnyRouter{
    var navigationController: UINavigationController? {set get}
}

protocol AnyRecipesRouter:AnyRouter{
    
    var entry:EntryMedicationPoint? {get}
     static func start() -> AnyRecipesRouter
//    func stop()
    func route(to destination:AnyRecipeDetailsRouter,selectedRecipeUrlStr:String)
//    that's why the presenter holds on to router
}

class RecipesRouter: AnyRecipesRouter {
    
//    func route(to destination: AnyCartRouter) {
//        var router = destination
//        let initialVC = router.entry
//        let viewController = initialVC
//        navigationController?.pushViewController(viewController ?? ShoppingCartVC(), animated: true)
//        router.navigationController = navigationController
//    }
    
    
    var entry: EntryMedicationPoint?
    
    var navigationController: UINavigationController?
    
     static func start() -> AnyRecipesRouter {
         let recipeRouter = RecipesRouter()
        // assign viper
         let searchVC = HomeVC()
        var view:AnyRecipesView = searchVC
        var presenter:AnyRecipesPresenter = RecipesPresenter()
        var interactor:AnyRecipesInteractor = RecipesInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = recipeRouter
        interactor.presenter = presenter
        recipeRouter.entry = view as? EntryMedicationPoint
        return recipeRouter
    }
    
    func route(to destination: AnyRecipeDetailsRouter,selectedRecipeUrlStr:String) {
        var router = destination
        var viewController = router.entry
        viewController?.presenter?.selectedRecipeUrlStr = selectedRecipeUrlStr
        navigationController?.pushViewController(viewController ?? RecipeDetailsVC(), animated: true)
        router.navigationController = navigationController
    }
   
}
