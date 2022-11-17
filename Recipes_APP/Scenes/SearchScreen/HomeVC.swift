//
//  SearchVC.swift
//  RecipeSearchApp
//
//  Created by Mustafa Sanadidy on 14/11/2022.
//

import UIKit
import NVActivityIndicatorView
import DropDown
import CoreData
import Alamofire

// ViewController
// we need protocol for it
// ref to presenter
// if you tap on button on your view and you want to show a ui alert controller like a pop-up alert you wouldn't reallywant to do that here you would want to tell the presenter hey go head and present this alert

protocol AnyView{
    func update(with error:Result_Error)
}
protocol AnyRecipesView:AnyView{
    
    var presenter: AnyRecipesPresenter? {get set}
    func collectionViewDidLoad(isScrollToTop:Bool,recipesCount:Int)
    func collectionViewWillLoad()
    func refreshSearchBar(dropDownSelectedItem:String)
    func disappearDropDown()
    func loadRecipes()
    func refreshView(isValidSearchKey:Bool)
    func updateDropDown(lastSuggestion:[String])
    
}

class HomeVC: UIViewController,AnyRecipesView {
   
    @IBOutlet weak var noResultsView: UIView!
    @IBOutlet weak var optionsCollectionView: UICollectionView!
    @IBOutlet weak var recipeDetailsCollection: UICollectionView!
    @IBOutlet weak var collectionsStackView: UIStackView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var presenter: AnyRecipesPresenter?

    
    var dropDown = DropDown(){
        didSet{
            if dropDown.isHidden{
                searchBar.endEditing(true)
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Setup Collections
    private func setup_Collection() {
        optionsCollectionView.dataSource = self
        optionsCollectionView.delegate = self
        optionsCollectionView.register(UINib(nibName: "OptionCell", bundle: nil), forCellWithReuseIdentifier: "OptionCell")
        recipeDetailsCollection.delegate = self
        recipeDetailsCollection.dataSource = self
        recipeDetailsCollection.register(UINib(nibName: "RecipeDetailsCell", bundle: nil), forCellWithReuseIdentifier: "RecipeDetailsCell")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideDropDown))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func hideDropDown() {
        if dropDown.anchorView?.plainView != nil {
            dropDown.anchorView?.plainView.removeFromSuperview()
        }
    }
    
    func initSearchBar() {

        searchBar.enablesReturnKeyAutomatically = false
        searchBar.returnKeyType = UIReturnKeyType.done
        searchBar.showsCancelButton = false
        searchBar.showsScopeBar = false
        searchBar.scopeButtonTitles = self.presenter?.healthFiltersContainer.searchBarFilters
        searchBar.delegate = self
    }
    
   
    
    func update(with error: Result_Error) {
        print(error.error_Desc)
    }
    
        
    func setupDropDown(with viewTag:Int){

        guard let searchBar = searchBar
        else{
            return
        }
        self.dropDown.anchorView = searchBar // UIView or UIBarButtonItem
        presenter?.changeDropDownDataSource()
            self.dropDown.bottomOffset = CGPoint(x: 0, y:(self.dropDown.anchorView?.plainView.bounds.height)!)
            self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
                presenter?.dropDownDidSelected(dropDownSelectedItem: item)
        }
            self.dropDown.cancelAction = {
                [unowned self] in
                presenter?.dropDownDidCancelAction()
            }
            self.dropDown.show()
    }
    
}

extension HomeVC{
    func loadRecipes() {
        setup_Collection()
         initSearchBar()
         
    }
    func refreshView(isValidSearchKey: Bool) {
        noResultsView.isHidden = !isValidSearchKey
        collectionsStackView.isHidden = isValidSearchKey
        if !isValidSearchKey{
            self.show_Popup(body: "search key is not valid", type: .single, status: .failure)}
        else{
            dropDown.hide()
            recipeDetailsCollection.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
    func refreshSearchBar(dropDownSelectedItem:String) {
        searchBar.text = dropDownSelectedItem
        searchBar.showsCancelButton = false
        searchBar.showsScopeBar = true
        searchBar.endEditing(true)
            let scopeButtonIndex = searchBar.selectedScopeButtonIndex
            let searchText = searchBar.text!
            filterForSearchTextAndScopeButton(searchText:searchText,scopeButtonIndex: scopeButtonIndex)
    }
    
    func disappearDropDown() {
        self.dropDown.anchorView?.plainView.endEditing(true)
        self.searchBar.showsCancelButton = false
    }
    
    func updateDropDown(lastSuggestion:[String]) {
        self.dropDown.dataSource = lastSuggestion
    }
    
    func collectionViewDidLoad(isScrollToTop:Bool,recipesCount:Int){
            
            noResultsView.isHidden = recipesCount != 0
            collectionsStackView.isHidden = recipesCount == 0
            showActivityView(isShow: false)
            recipeDetailsCollection.reloadData()
        if isScrollToTop{
            recipeDetailsCollection.setContentOffset(CGPoint(x: 0, y: 0), animated: true)}
        }
    
    func collectionViewWillLoad(){
            showActivityView(isShow: true)
    }
}
