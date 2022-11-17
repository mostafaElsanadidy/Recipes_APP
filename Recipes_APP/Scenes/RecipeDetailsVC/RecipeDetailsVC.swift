//
//  RecipeDetailsVC.swift
//  RecipesApp
//
//  Created by Mustafa Sanadidy on 11/05/2022.
//

import UIKit
import SafariServices

protocol AnyRecipeDetailsView:AnyView{
    var presenter: AnyRecipeDetailsPresenter? {get set}
    func update(with recipe: RecipeContainer)
    func setupScreenInitialState()
}

class RecipeDetailsVC: UIViewController {

    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeIngredientsLabel: UILabel!
    @IBOutlet weak var navBarView: HeadView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    var presenter: AnyRecipeDetailsPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presenter?.viewDidLoad()
    }

    @IBAction func showPublisherWebsite(_ sender: UIButtonX) {
        presenter?.showPublisherWebsite()
    }
    func showTutorial(_ which: Int) {
        if let url = URL(string: "https://www.hackingwithswift.com/read/\(which + 1)") {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RecipeDetailsVC:AnyRecipeDetailsView{
    
    func setupScreenInitialState() {
        navBarView.backBttn.isHidden = false
        navBarView.shareBttn.isHidden = false
    }
    func update(with error: Result_Error) {
        print(error.error_Desc)
    }
    func update(with recipe: RecipeContainer){
        recipeTitleLabel.text = recipe.recipeNameText
        
        if let sp_url = recipe.recipePicUrl {
        recipeImageView.kf.indicatorType = .activity
        recipeImageView.kf.setImage(with: sp_url)
   //     cell.recipeImageView.isHidden = true
    }
        recipeIngredientsLabel.text = recipe.recipeIngredientsText
        navBarView.sharedUrlString = recipe.recipePublisherUrlText
    }
}
