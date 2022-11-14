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

protocol AnyRecipesView{
    
    var presenter: AnyRecipesPresenter? {get set}
//    func update(with recipes:[Hit])
    func collectionViewDidLoad(isScrollToTop:Bool)
    func collectionViewWillLoad()
    func update(with error:Result_Error)
  //  func updateSelectedRecipes(with recipes:[SelectedRecipe]?)
    
}

class SearchVC: UIViewController,AnyRecipesView {
   
//    func updateSelectedRecipes(with recipes:[SelectedRecipe]?) {
//
//        self.recipeDetailsCollection.reloadData()
//    }
    
    
    var dropDown = DropDown(){
        didSet{
            if dropDown.isHidden{
                searchBar.endEditing(true)
            }
        }
    }
    

    
    @IBOutlet weak var optionsCollectionView: UICollectionView!
    @IBOutlet weak var recipeDetailsCollection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var presenter: AnyRecipesPresenter?

    let searchBarController = UISearchController()
//    var restaurantTuple:(key:String,name:String)?
    
   // let context = ad.persistentContainer.viewContext
//    var recipesHits:[Hit] = []{
//        didSet{
//            self.recipeDetailsCollection.reloadData()
////            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+10, execute: {
////           //     self.killLoading()
////
////              //  self.get_My_Recipes_Data()
////            })
//            print(NetworkHelper.getLastSuggestion())
//
//        }
//    }

//    var filteredRecipesHits = [Hit]()
//

//    var managedObject:[NSManagedObject]{
//        get{
//            return selectedRecipes as [NSManagedObject]
//        }
//        set{
//            if let selectedRecipes = newValue as? [SelectedRecipe] {
//                self.selectedRecipes = selectedRecipes
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter?.viewDidLoad()
//        coreDataHandler = CoreDataHandler<SelectedRecipe>()
//        coreDataHandler?.items = selectedRecipes
       setup_Collection()
//        
//       
        initSearchBar()
        
//        print(UUID().uuidString)
       //  restaurantTuple = (key: "parentRestaurant.name", name: selectedRestaurant?.name ?? "")
        
        addItemAlert()
      //  self.hideKeyboardWhenTappedAround()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
       
     //   self.loading()
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+5, execute: {
//       //     self.killLoading()
//            self.recipeDetailsCollection.reloadData()
//       //     self.get_My_Recipes_Data()
//        })
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
//        optionsCollectionView.transform = CGAffineTransform(scaleX: -1, y: 1)
        optionsCollectionView.register(UINib(nibName: "OptionCell", bundle: nil), forCellWithReuseIdentifier: "OptionCell")
   //     recipeDetailsCollection.isUserInteractionEnabled = false
        recipeDetailsCollection.delegate = self
        recipeDetailsCollection.dataSource = self
        recipeDetailsCollection.register(UINib(nibName: "RecipeDetailsCell", bundle: nil), forCellWithReuseIdentifier: "RecipeDetailsCell")
      //  recipeDetailsCollection.isHidden = true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideDropDown))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func hideDropDown() {
        if dropDown != nil && dropDown.anchorView?.plainView != nil {
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
        
        //definesPresentationContext = true
        
    }
    
   
    
    func update(with error: Result_Error) {
        print(error.error_Desc)
    }
    
        
    func setupDropDown(with viewTag:Int){


        guard let searchBar = searchBar
        else{
            return
        }
//       // searchBar.showsScopeBar = true
//        DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
        
            self.dropDown.anchorView = searchBar // UIView or UIBarButtonItem
            self.dropDown.dataSource = ["ذكر","انثى","chicken","salt"]
            self.dropDown.bottomOffset = CGPoint(x: 0, y:(self.dropDown.anchorView?.plainView.bounds.height)!)
            self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            searchBar.text = item
            searchBar.showsCancelButton = false
            searchBar.showsScopeBar = true
        //    self.delegate?.changeProgressBar(textField: self.genderTextField, isValidValue: true)
            
           // genderTextField.endEditing(true)
            searchBar.endEditing(true)
                let scopeButtonIndex = searchBar.selectedScopeButtonIndex
                let searchText = searchBar.text!
                filterForSearchTextAndScopeButton(searchText:searchText,scopeButtonIndex: scopeButtonIndex)
        }
            self.dropDown.cancelAction = {
                [unowned self] in
                self.dropDown.anchorView?.plainView.endEditing(true)
                self.searchBar.showsCancelButton = false
            }
            self.dropDown.show()
        //}
    }
    
    func collectionViewDidLoad(isScrollToTop:Bool){
            
//            recipesHitsTableView.tableFooterView!.hideProgressHUD(hud: hud!)
            
            showActivityView(isShow: false)
            recipeDetailsCollection.reloadData()
        if isScrollToTop{
            recipeDetailsCollection.setContentOffset(CGPoint(x: 0, y: 0), animated: true)}
        }
    
    func collectionViewWillLoad(){
//        if isScrollToTop{
//            recipeDetailsCollection.setContentOffset(CGPoint(x: 0, y: 0), animated: true)}
            showActivityView(isShow: true)
    }
}
