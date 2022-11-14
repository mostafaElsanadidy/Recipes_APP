//
//  Router.swift
//  RecipesApp
//
//  Created by mostafa elsanadidy on 14.11.22.
//

import Foundation
import UIKit

// object
// Entry point


typealias EntryRecipesPoint = UIViewController&AnyRecipesView
protocol AnyRecipesRouter{
    
    
    var entry:EntryRecipesPoint? {get}
    var navigationController: UINavigationController? {set get}
    
     static func start() -> AnyRecipesRouter
    
//    func stop()
//    func route(to destination:AnyRouter)
//    that's why the presenter holds on to router
}

class RecipesRouter: AnyRecipesRouter {
 
    var entry: EntryRecipesPoint?
    
    var navigationController: UINavigationController?
    
     static func start() -> AnyRecipesRouter {
         let recipeRouter = RecipesRouter()
        // assign viper
         let searchVC = SearchVC()
        var view:AnyRecipesView = searchVC
        var presenter:AnyRecipesPresenter = RecipesPresenter()
        var interactor:AnyRecipesInteractor = RecipesInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = recipeRouter
        interactor.presenter = presenter
        recipeRouter.entry = view as? EntryRecipesPoint
     //    recipeRouter.navigationController = searchVC.navigationController
        
        return recipeRouter
    }
    
   
}
