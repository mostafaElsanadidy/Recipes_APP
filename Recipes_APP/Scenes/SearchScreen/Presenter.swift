//
//  Presenter.swift
//  Salamtak
//
//  Created by mostafa elsanadidy on 06.11.22.
//

import Foundation
import UIKit
import MOLH

// object
// need protocol
// ref to interactor, router, view
protocol AnyPresenter {
    var selectedRecipeUrlStr:String{get set}
    func viewDidLoad()
//    func changeLanguage()
    
//    func updateCellInfo(recipeIndex:Int,collectionCellHandler:((RecipeContainer)->Void)?)
    
//    
//    func updateCellSize(recipeIndex:Int,widthForItem:CGFloat,cellSizeHandler:((CGFloat)->Void)?)
//    func routeToNextVC()
    
}


protocol AnyRecipesPresenter:AnyPresenter{
    
    var router: AnyRecipesRouter? {get set}
    var interactor: AnyRecipesInteractor? {get set}
    var view: AnyRecipesView? {get set}
    var recipesRoot:RecipesRoot? {get set}
//    var separateOrdersContainer:SeparateOrdersContainer<RecipeStruct> {get set}
    var healthFiltersContainer:HealthFiltersContainer {get set}
    var scopeButtonIndex:Int{get set}
    var searchKey:String{get set}
    
//    func changeLanguage()
    func filterForSearchTextAndScopeButton(searchText:String,scopeButtonIndex:Int)
       func updateCellInfo(recipeIndex:Int,collectionCellHandler:((RecipeContainer)->Void)?)
       func interactorDidFetchRecipes(with result: Result<Recipes_Root,Result_Error>)
   func dropDownDidSelected(dropDownSelectedItem:String)
    func dropDownDidCancelAction()
    func changeDropDownDataSource()
       func updateCellSize(recipeIndex:Int,widthForItem:CGFloat,cellSizeHandler:((CGFloat)->Void)?)
       func routeToNextVC()
    func recipeCellDidSelected(index:Int)
//    func saveRecipes()
//    func interactorDidAccessCoreData(with result: Result<[ManagedRecipe], Result_Error>,state:coreDataStatus)
    func appendGroupOfRecipes(isScrollToTop:Bool,nextPageTag:String)
//    var arrOfItemsCount:[Int]{get set}
    
}

 struct RecipesRoot {
        var fromIndex:Int
        var toIndex:Int
        var count:Int
        var nextPageUrlStr:String
        var recipes:[RecipeContainer]
    }

struct RecipeContainer {
    var recipeNameText:String
    var recipePicUrl:URL?
    var recipeId:String
    var recipeSourceText:String
    var recipeHealthText:String
    var recipePublisherUrlText:String
    var recipeIngredientsText:String
    
    init(recipeId:String = "",recipeNameText:String,recipePicUrl:URL?,recipeSourceText:String = "",recipeHealthText:String = "",recipePublisherUrlText:String = "",recipeIngredientsText:String = "") {
        self.recipeNameText = recipeNameText
        self.recipePicUrl = recipePicUrl
        self.recipeSourceText = recipeSourceText
        self.recipeHealthText = recipeHealthText
        self.recipePublisherUrlText = recipePublisherUrlText
        self.recipeIngredientsText = recipeIngredientsText
        self.recipeId = recipeId
    }
}

struct SeparateOrdersContainer<T>{
    var limit:Int = 0
//    {
//        didSet{itemsCountDidSet(limit)}
//    }
    
    var indOfSeparateOrder:Int = 0
    var arrOfSeparateOrders:[T] = []
    var recipes=[T]()
    {
        willSet{
            
//                itemsCountDidSet((recipes.count-limit) < 3 && totalCount>recipes.count)
            let count = recipes.count
            recipesWillSet(count, limit)
        }
        didSet{
            if recipes.count/3 == 0{
                limit = recipes.count
                while indOfSeparateOrder < limit{
                        arrOfSeparateOrders.append(recipes[indOfSeparateOrder])
                           indOfSeparateOrder = indOfSeparateOrder + 1
                       }
            }
            let diff = recipes.count-limit
            if (diff < 3) && diff != 0 && (1000>recipes.count) {
                itemsCountDidSet()
            }else
            if limit < recipes.count{
                limit = arrOfSeparateOrders.count+3
                while indOfSeparateOrder < limit{
                    if indOfSeparateOrder == recipes.count{
                        limit = indOfSeparateOrder
                                break
                            }
                    arrOfSeparateOrders.append(recipes[indOfSeparateOrder])
                    indOfSeparateOrder = indOfSeparateOrder + 1
                               }
                        }
            recipesDidSet(isScrollToTop, arrOfSeparateOrders)
                    }
    }
    var isScrollToTop = false
    var recipesDidSet:(Bool,[T])->Void = {_,_  in}
    var recipesWillSet:(Int,Int)->Void = {_,_ in }
    var itemsCountDidSet:()->Void = {}
    var totalCount = 1000
}

struct HealthFiltersContainer {
    var searchBarFilters:[String]
    var apiParamsFilters:[String]
    mutating func recipesHitsWillSet(){searchBarFilters.append("")}
}

enum coreDataStatus{
    case create
    case read
    case update
    case delete
    case search
}


class RecipesPresenter: AnyRecipesPresenter {
  
    
    
    var router: AnyRecipesRouter?
    
    var interactor: AnyRecipesInteractor?
    
    var separateOrdersContainer = SeparateOrdersContainer<Recipe>()
    var recipesRoot:RecipesRoot?
//    var recipes:[Recipe] = []
    var view: AnyRecipesView?
    
//    var indexFrom = 0
//    var indexTo = 3
    var searchKey = ""{
        didSet{
            
            if searchKey != oldValue{
//                indexFrom = 0
//                indexTo = 3
                self.separateOrdersContainer.limit = 0
                self.separateOrdersContainer.indOfSeparateOrder = 0
                self.separateOrdersContainer.recipes = []
                self.separateOrdersContainer.arrOfSeparateOrders = []
            }
        }
    }
    
//    var indeces:[Int] = []
    var isWantToUpdate:Bool = false
    var selectedRecipeUrlStr:String = ""
    var scopeButtonIndex = 0{
        didSet{
            
            if scopeButtonIndex != oldValue{
//                indexFrom = 0
//                indexTo = 3
                self.separateOrdersContainer.limit = 0
                self.separateOrdersContainer.indOfSeparateOrder = 0
                self.separateOrdersContainer.recipes = []
                self.separateOrdersContainer.arrOfSeparateOrders = []
            }
        }
    }
//    var totalPrice:Float = 0
    var healthFiltersContainer = HealthFiltersContainer(searchBarFilters:
                                                            ["All"
                                                             ,"Low Sugar"
                                                             ,"Keto"
                                                             ,"Vegan"]
                                                        , apiParamsFilters:
                                                            [""
                                                             ,"low-sugar"
                                                             ,"keto-friendly"
                                                             ,"vegan"])
    
//    var arrOfItemsCount:[Int] = [] {
//        didSet{
//            let counts = arrOfItemsCount
//            let items = recipes
//            let prices = counts.enumerated()
//    //                .filter{ (tuple.oldValues.count != 0 && abs(tuple.oldValues[$0.offset]-$0.element) != 0)}
//                .filter{$0.element != 0}
//                .map{(index, element) -> Float in
//                    let recipe = items[index]
//                    return Float(element) * (recipe.price ?? 0.0)
//                }
//            self.totalPrice = prices.reduce(0,+)
//            self.view?.updateCountOfSelectedItems(numOfItems: counts.reduce(0,+), totalPrice: strDidShortenPrice(price: totalPrice))
//        }
//    }
    
    func viewDidLoad() {
        self.separateOrdersContainer.recipesDidSet = {
            [weak self]
            isScrollToTop,recipes in
            guard let strongSelf = self else{return}
            print(recipes.map{$0.label})
//            self.recipes = recipes.map{$0.recipe}
            
            strongSelf.recipesRoot?.recipes = recipes.map{RecipeContainer(recipeId: $0.uri.split{$0 == "_"}.map(String.init)[1], recipeNameText: $0.label ?? "" , recipePicUrl: URL(string: $0.image ?? ""), recipeSourceText: $0.source ?? "", recipeHealthText: strongSelf.getStringFromArr(strArr: $0.healthLabels, separator: ","))}
            
            strongSelf.view?.collectionViewDidLoad(isScrollToTop: isScrollToTop,recipesCount: strongSelf.recipesRoot?.recipes.count ?? 0)
        }
        self.separateOrdersContainer.recipesWillSet =
        {
                [weak self]
                recipesCount,limito
                in
            guard let strongSelf = self else{return}
            strongSelf.view?.collectionViewWillLoad()
        }
        
        self.separateOrdersContainer.itemsCountDidSet = {
            [weak self]
            in
        guard let strongSelf = self else{return}
//        strongSelf.view?.collectionViewWillLoad()
           guard let recipesRoot = strongSelf.recipesRoot else { return }
//                let diff = recipesCount-limito
//            guard (diff < 3) && diff != 0 && (1000>recipesCount) else{return}
              
        
//            strongSelf.interactor?.getRecipes(searchKey: strongSelf.searchKey,healthFilters: [strongSelf.healthFiltersContainer.apiParamsFilters[strongSelf.scopeButtonIndex]].filter{!$0.isEmpty}, nextPageTag: (recipesRoot.nextPageUrlStr.slice(from: "_cont=", to: "&")) ?? "")
                strongSelf.appendGroupOfRecipes(isScrollToTop: false, nextPageTag:(recipesRoot.nextPageUrlStr.slice(from: "_cont=", to: "&")) ?? "")
        
    
        
        
        
    }
        
        
        
        appendGroupOfRecipes(isScrollToTop: true, nextPageTag: "")
        
        view?.loadRecipes()
        
        
    }
    func changeDropDownDataSource() {
        view?.updateDropDown(lastSuggestion: NetworkHelper.getLastSuggestion() ?? [])
    }
    
    func dropDownDidSelected(dropDownSelectedItem:String) {
        view?.refreshSearchBar(dropDownSelectedItem: dropDownSelectedItem)
    }
    
    func dropDownDidCancelAction() {
        view?.disappearDropDown()
        
    }
    func routeToNextVC() {
        router?.route(to: RecipeDetailsRouter.start(), selectedRecipeUrlStr: selectedRecipeUrlStr)
    }
    func appendGroupOfRecipes(isScrollToTop:Bool = false,nextPageTag:String) {
        if isScrollToTop || nextPageTag != ""{
            interactor?.getRecipes(searchKey: searchKey,healthFilters: [healthFiltersContainer.apiParamsFilters[scopeButtonIndex]].filter{!$0.isEmpty}, nextPageTag: nextPageTag)}else{
                separateOrdersContainer.isScrollToTop = isScrollToTop
                separateOrdersContainer.recipes = {separateOrdersContainer.recipes}()
            }
    }
    func changeLanguage() {
//        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
//
//        isValidName
//        MOLH.reset()
    }
    
}

extension RecipesPresenter{
    
    func filterForSearchTextAndScopeButton(searchText:String,scopeButtonIndex:Int = 0){
        guard searchText.isValidSearchKey else {
            view?.refreshView(isValidSearchKey: searchText.isValidSearchKey)
            return }
    
        view?.refreshView(isValidSearchKey: searchText.isValidSearchKey)
        let scopeButtonIndex = scopeButtonIndex
        let searchText = searchText.lowercased()
       
        self.searchKey = searchText
        self.scopeButtonIndex = scopeButtonIndex
//            presenter.showRecipes(with: searchText, healthParams: [presenter.healthFiltersContainer.apiParamsFilters[scopeButtonIndex]])
        self.appendGroupOfRecipes(isScrollToTop: true,nextPageTag: "")
    
    var lastSuggestion:[String] = []
    if let suggestion = NetworkHelper.getLastSuggestion(){
        lastSuggestion = suggestion.filter{!($0==searchText)}
        if lastSuggestion.count >= 10{
            lastSuggestion.remove(at: 0)
        }
    }
    lastSuggestion.append(searchText)
    NetworkHelper.lastSuggestion = lastSuggestion
//                return scopeMatch && searchTextMatch
        
    }
    func interactorDidFetchRecipes(with result: Result<Recipes_Root, Result_Error>) {
        switch result {
        case .failure(let error):
            self.view?.update(with: error)
        case .success(let recipes_data):
            self.update(with: recipes_data)
        }
    }
    func update(with recipesRoot: Recipes_Root) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            print(recipesRoot.hits.map{$0.recipe.label})
//            let numOfItemsPerAppending = 3
            print(recipesRoot)
            self.recipesRoot = RecipesRoot(fromIndex: recipesRoot.from ?? 0, toIndex: recipesRoot.to ?? 0, count: recipesRoot.count ?? 0, nextPageUrlStr: recipesRoot.links?.next.href ?? "", recipes: [])
            self.separateOrdersContainer.recipes += recipesRoot.hits.map{$0.recipe}
            print(self.separateOrdersContainer.recipes.count)
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

extension RecipesPresenter{
    
    func updateCellInfo(recipeIndex:Int,collectionCellHandler:((RecipeContainer)->Void)?){
        if let recipes = recipesRoot?.recipes {
            collectionCellHandler?(recipes[recipeIndex])
        }
    }
    
    func updateCellSize(recipeIndex:Int,widthForItem:CGFloat,cellSizeHandler:((CGFloat)->Void)?){
//        let _ = getFromApiData(recipeIndex: recipeIndex)
        cellSizeHandler?(heightFor(using: widthForItem-200, recipeIndex: recipeIndex))
    }
    
//    func getFromApiData(recipeIndex:Int)->RecipeStruct{
//        let recipeStrct = separateOrdersContainer.arrOfSeparateOrders[recipeIndex]
////        self.recipeContainer.recipeNameText = "lang".localized == "en" ? (recipe.englishName ?? "") : (recipe.arabicName ?? "")
//        self.recipeContainer.recipeNameText = recipeStrct.recipe.label ?? ""
//        self.recipeContainer.recipeSourceText = recipeStrct.recipe.source ?? ""
//        self.recipeContainer.recipeHealthText = getStringFromArr(strArr: recipeStrct.recipe.healthLabels, separator: ",")
////        self.recipeContainer.recipePriceText = strDidShortenPrice(price: recipe.)
//        return recipeStrct
//    }
    
    
    //CustomLayoutDelegate method
    func heightFor(using width: CGFloat,recipeIndex: Int) -> CGFloat {
        //Implement your own logic to return the height for specific cell
        guard let recipes = recipesRoot?.recipes else{return 0}
        let recipeTitleHeight = recipes[recipeIndex].recipeNameText.sizeOfString(constrainedToWidth: width, font: UIFont.systemFont(ofSize: 19, weight: .regular)).height
        let recipeSourceTextHeight = recipes[recipeIndex].recipeSourceText.sizeOfString(constrainedToWidth: width, font: UIFont.systemFont(ofSize: 17, weight: .bold)).height
        let recipeHealthTextHeight = recipes[recipeIndex].recipeHealthText.sizeOfString(constrainedToWidth: width, font: UIFont.systemFont(ofSize: 12, weight: .regular)).height
        let height = recipeTitleHeight+recipeSourceTextHeight+recipeHealthTextHeight+250
        
        return height
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
    
    
    func strDidShortenPrice(price:Float?) -> String{
        let fullPrice = "\(price ?? 0)"
        let fullPriceArr = fullPrice.split{$0 == "."}.map(String.init)
        let updatedPriceStr = (fullPriceArr.count > 1 && fullPriceArr[1] == "0" ? fullPriceArr[0] : fullPrice).localized+" "+"pounds".localized
        return updatedPriceStr
    }
    
    func recipeCellDidSelected(index:Int){
        guard let recipes = recipesRoot?.recipes else{return }
        self.selectedRecipeUrlStr = recipes[index].recipeId
        routeToNextVC()
    }
    
    
}

extension RecipesPresenter{
    
}

extension RecipesPresenter{
    
   
    
}

extension String {
    
    func slice(from: String, to: String) -> String? {
        guard let rangeFrom = range(of: from)?.upperBound else { return nil }
        guard let rangeTo = self[rangeFrom...].range(of: to)?.lowerBound else { return nil }
        return String(self[rangeFrom..<rangeTo])
    }
    
}
