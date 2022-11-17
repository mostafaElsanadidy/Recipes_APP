//
//  CartRouter.swift
//  Salamtak_App
//
//  Created by mostafa elsanadidy on 09.11.22.
//

import Foundation
import UIKit
import SafariServices

typealias EntryRecipeDetailsPoint = UIViewController&AnyRecipeDetailsView
protocol AnyRecipeDetailsRouter:AnyRouter {
    var entry:EntryRecipeDetailsPoint? {get}
    var navigationController: UINavigationController? {set get}
    
     static func start() -> AnyRecipeDetailsRouter
    func routeToPublisherWebsite(urlStr:String)
    
}
class RecipeDetailsRouter: AnyRecipeDetailsRouter {
    
    static var recipeDetailsVC = RecipeDetailsVC()
    func routeToPublisherWebsite(urlStr: String) {
        if let url = URL(string: urlStr) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let vc = SFSafariViewController(url: url, configuration: config)
            RecipeDetailsRouter.recipeDetailsVC.present(vc, animated: true)
        }
    }
    
    var entry: EntryRecipeDetailsPoint?
    
    var navigationController: UINavigationController?
    
     static func start() -> AnyRecipeDetailsRouter {
         let recipeRouter = RecipeDetailsRouter()
        // assign viper
        recipeDetailsVC = RecipeDetailsVC()
        var view:AnyRecipeDetailsView = recipeDetailsVC
        var presenter:AnyRecipeDetailsPresenter = RecipeDetailsPresenter()
        var interactor:AnyRecipeDetailsInteractor = RecipeDetailsInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = recipeRouter
        interactor.presenter = presenter
        recipeRouter.entry = view as? EntryRecipeDetailsPoint
        
        return recipeRouter
    }
}
