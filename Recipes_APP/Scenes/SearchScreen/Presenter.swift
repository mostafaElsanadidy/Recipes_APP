//
//  Presenter.swift
//  RecipesApp
//
//  Created by mostafa elsanadidy on 14.11.22.
//

import Foundation
import CoreData
import UIKit
// object
// need protocol
// ref to interactor, router, view


//    update(with
//           loadNewSeparateOrders
//collectionViewDidLoad

protocol AnyPresenter {
    func viewDidLoad()
    func saveMedicines()
    func interactorDidAccessCoreData(with result: Result<[Medicine], Result_Error>,state:coreDataStatus)
    func appendGroupOfMedicines()
//    var arrOfItemsCount:[Int]{get set}
//    var healthParams: [String]{get set}
    var searchKey:String{get set}
//    func changeLanguage()
    func updateCellInfo(medicineIndex:Int,collectionCellHandler:((MedicineContainer)->Void)?)
}


protocol AnyRecipesPresenter:AnyPresenter{
    
    var router: AnyMedicationRouter? {get set}
    var interactor: AnyMedicationInteractor? {get set}
    var view: AnyMedicationView? {get set}
    var separateOrdersContainer:SeparateOrdersContainer<Complaint> {get set}
    var recipeTextsContainer:RecipeTextsContainer {get set}
    var healthFiltersContainer:HealthFiltersContainer {get set}
    var defaultHandler:()->() {get set}
    
    func interactorDidFetchMedicines(with result: Result<[Complaint],Result_Error>)
    
    func updateCellSize(medicineIndex:Int,widthForItem:CGFloat,cellSizeHandler:((CGFloat)->Void)?)
    func routeToNextVC()
    func showRecipes(with searchKey:String, healthParams: [String])
}

struct SeparateOrdersContainer<T>{
    var limit:Int = 0{
        didSet{itemsCountDidSet(limit)}
    }
    var indOfSeparateOrder:Int = 0
    var arrOfSeparateOrders:[T] = []
    var medicines=[T]()
    {
        willSet{
            medicinesWillSet()
        }
        didSet{
            if medicines.count/10 == 0{
                limit = medicines.count
                while indOfSeparateOrder < limit{
                        arrOfSeparateOrders.append(medicines[indOfSeparateOrder])
                           indOfSeparateOrder = indOfSeparateOrder + 1
                       }
            }
            
            if limit < medicines.count{
                limit = arrOfSeparateOrders.count+10
                while indOfSeparateOrder < limit{
                    if indOfSeparateOrder == medicines.count{
                        limit = indOfSeparateOrder
                                break
                            }
                    arrOfSeparateOrders.append(medicines[indOfSeparateOrder])
                    indOfSeparateOrder = indOfSeparateOrder + 1
                               }
                        }
            medicinesDidSet(isScrollToTop, arrOfSeparateOrders)
                    }
    }
    var isScrollToTop = false
    var medicinesDidSet:(Bool,[T])->Void = {_,_  in}
    var medicinesWillSet:()->Void = {}
    var itemsCountDidSet:(Int)->Void = {_ in }
}

enum coreDataStatus{
    case create
    case read
    case update
    case delete
    case search
}


struct RecipeTextsContainer {
    var recipeTitleText:String = ""
    var recipeSourceText:String = ""
    var recipeHealthText:String = ""
}


struct HealthFiltersContainer {
    var searchBarFilters:[String]
    var apiParamsFilters:[String]
    mutating func recipesHitsWillSet(){searchBarFilters.append("")}
}


class RecipesPresenter: AnyRecipesPresenter {

    var router: AnyRecipesRouter?
    
    var interactor: AnyRecipesInteractor?{
        didSet{
        //    interactor?.getRecipes(searchKey: "", healthParams: [""])
        }
    }
    
    var view: AnyRecipesView?
//    var structor = HealthFiltersContainer(searchBarFilters: [], apiParamsFilters: [])
    
    //MARK: - DEFAULT HANDLER
    var defaultHandler: ()->() = {}
    
    
    var recipeTextsContainer = RecipeTextsContainer()
    
    var separateOrdersContainer = SeparateOrdersContainer()
    
 //       var recipeTitleText = "", recipeSourceText = "", recipeHealthText = ""
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
        
        var restaurantTuple:(key:String,name:String)?
    
        var selectedRestaurant:Restaurant?{
            didSet{
                self.loadRecipes(parentRestaurant: (key: "parentRestaurant.name", name: selectedRestaurant?.name ?? ""))
            }
        }
        var selectedRecipes:[SelectedRecipe] = []
    
    func updateCellInfo(recipeHitIndex:Int,collectionCellHandler:((RecipeTextsContainer,String)->Void)?){
        guard let recipe = getFromApiData(recipeHitIndex: recipeHitIndex) else{return}
        collectionCellHandler?(recipeTextsContainer, recipe.image ?? "")
    }
    
    func updateCellSize(recipeHitIndex:Int,widthForItem:CGFloat,cellSizeHandler:((CGFloat)->Void)?){
        let _ = getFromApiData(recipeHitIndex: recipeHitIndex)
        cellSizeHandler?(heightFor(using: widthForItem-200))
    }
    
    func viewDidLoad() {
//        structor.recipesHitsWillSet()
        NetworkHelper.lastSuggestion = self.healthFiltersContainer.apiParamsFilters
        print(FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask))
        self.separateOrdersContainer.recipesHitsDidSet = self.view?.collectionViewDidLoad ?? {_ in}
        self.separateOrdersContainer.recipesHitsWillSet = self.view?.collectionViewWillLoad ?? {}
        self.defaultHandler = {
            print("mostafa")
            for item in self.selectedRecipes ?? [] {
                           print(item.title ?? "")
                       }
        }
        
        
        restaurantTuple = (key: "parentRestaurant.name", name: selectedRestaurant?.name ?? "")
     //   self.interactorDidFetchRecipes(with: <#T##Result<[Hit], Result_Error>#>)
//        get_My_Recipes_Data()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()){
            self.loadRecipes(parentRestaurant: self.restaurantTuple)
        }
        
//        deleteRows(at: 0)
//        deleteRows(at: 2)
//        deleteRows(at: selectedRecipes.count-1)
        print("dafsdfsd")
        print("____________________________")
//        let request:NSFetchRequest<SelectedRecipe> = SelectedRecipe.fetchRequest()
//        request.predicate = NSPredicate.init(format: "title CONTAINS[cd] %@","Ro")
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        print(request)
//        print(SelectedRecipe.fetchRequest())
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()){
            self.searchRecipe(with: (key:"title",text:"Ro"), parentRestaurant: self.restaurantTuple)}
//       // searchRecipe(with: "pO", in: &managedObject)
        print("_____________________________-")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()){
            self.loadRecipes(parentRestaurant: self.restaurantTuple)
            
      //      self.presenter?.updateRecipe(at: 4, with: (dueDate:!self.selectedRecipes[4].dueDate,title:"jhghjgjh"))
        }
        
    }

    func loadNewSeparateOrders(){
        self.separateOrdersContainer.isScrollToTop = false
        self.separateOrdersContainer.recipesHits = {self.separateOrdersContainer.recipesHits}()
        
    }
    
    func showRecipes(with searchKey: String, healthParams: [String]) {
        interactor?.getRecipes(searchKey: searchKey, healthParams: healthParams)
//        interactor?.defaultHandler = {
//            print("kl;")
//        }
    }
    
//    func deleteItems(from array:inout [SelectedRecipe],at index:Int,afterDelete executionHandler:(()->())?=nil){
//        interactor?.deleteItems(at: index, afterDelete: executionHandler)
//    }

    
}



extension RecipesPresenter{
    
    //     //MARK: - the C in the word CRUD
        func saveRecipes(at index:Int){
            let selectedRecipe = SelectedRecipe.init(context: viewContext)
            selectedRecipe.title = separateOrdersContainer.arrOfSeparateOrders[index].recipe.label
            selectedRecipe.parentRestaurant = self.selectedRestaurant
            interactor?.saveRecipes()
        }
    //    //MARK: - the R in the word CRUD
        func searchRecipe(with searchTuple:(key:String,text:String),parentRestaurant restaurantTuple:(key:String,name:String)?){
           
            interactor?.searchRecipe(with: searchTuple, parentRestaurant: restaurantTuple )
        }
    //
        func loadRecipes(){
            interactor?.loadRecipes(parentRestaurant: restaurantTuple)
        }
        func loadRecipes(parentRestaurant restaurantTuple:(key:String,name:String)?) {
            interactor?.loadRecipes(parentRestaurant: restaurantTuple)
        }
    //
    //
        //MARK: - the U in the word CRUD
        func updateRecipe(at index:Int,with updateValueKeys:(dueDate:Bool,title:String)){
            
            interactor?.updateRecipe(at: index, with: updateValueKeys)
            
        }
    //    //MARK: - the D in the word CRUD
        
        func deleteItems(at index: Int) {
            interactor?.deleteItems(at: index)
        }
}

extension RecipesPresenter{
    
    func interactorDidAccessCoreData(with recipes: [SelectedRecipe]?) {
        print("mostafa")
        guard let _ = recipes else {
            view?.collectionViewDidLoad(isScrollToTop: true)
            return  }
        let _ = self.selectedRecipes.map{print($0.title ?? "")}
        
//    self.selectedRecipes = recipes
//    for item in self.selectedRecipes{
//                   print(item.title ?? "")
//               }
        view?.collectionViewDidLoad(isScrollToTop: true)
    }
    
    func interactorDidFetchRecipes(with result: Result<[Hit], Result_Error>) {
        switch result {
        case .failure(let error):
            self.view?.update(with: error)
        case .success(let recipes_data):
            self.update(with: recipes_data)
        }
    }
}



extension RecipesPresenter{
    
    func getFromApiData(recipeHitIndex:Int)->Recipe?{
        guard let recipe = separateOrdersContainer.arrOfSeparateOrders[recipeHitIndex].recipe  else{
            return nil
        }
        self.recipeTextsContainer.recipeTitleText = recipe.label
        self.recipeTextsContainer.recipeSourceText = recipe.source
        self.recipeTextsContainer.recipeHealthText = getStringFromArr(strArr: recipe.healthLabels, separator: ",")
        return recipe
    }
    func update(with recipes: [Hit]) {
//        self.recipesHits = recipes
//        self.recipeDetailsCollection.isHidden = true
     //   self.recipeDetailsCollection.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            self.separateOrdersContainer.limit = 0
            self.separateOrdersContainer.indOfSeparateOrder = 0
            self.separateOrdersContainer.isScrollToTop = true
            self.separateOrdersContainer.recipesHits = []
            self.separateOrdersContainer.arrOfSeparateOrders = []
       //     self.loadNewSeparateOrders()
            self.separateOrdersContainer.recipesHits = recipes
            
        }
    }
    
    //CustomLayoutDelegate method
    func heightFor(using width: CGFloat) -> CGFloat {
        //Implement your own logic to return the height for specific cell
        let recipeTitleHeight = self.recipeTextsContainer.recipeTitleText.sizeOfString(constrainedToWidth: width, font: UIFont.systemFont(ofSize: 19, weight: .regular)).height
        let recipeSourceTextHeight = self.recipeTextsContainer.recipeSourceText.sizeOfString(constrainedToWidth: width, font: UIFont.systemFont(ofSize: 17, weight: .bold)).height
        let recipeHealthTextHeight = self.recipeTextsContainer.recipeHealthText.sizeOfString(constrainedToWidth: width, font: UIFont.systemFont(ofSize: 12, weight: .regular)).height
                
              //  print(width)
                print(recipeTitleHeight+recipeSourceTextHeight+recipeHealthTextHeight)
                let height = recipeTitleHeight+recipeSourceTextHeight+recipeHealthTextHeight+120
        print(height)
//        heightFor(using: widthPerItem-200)
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
    
}


//func loadNewSeparateOrders(){
//    //            recipeDetailsCollection.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
//    if separateOrdersContainer.limit < separateOrdersContainer.recipesHits.count{
//    //                showActivityView(isShow: true)
//        separateOrdersContainer.limit = separateOrdersContainer.arrOfSeparateOrders.count+3
//        while separateOrdersContainer.indOfSeparateOrder < separateOrdersContainer.limit{
//            if separateOrdersContainer.indOfSeparateOrder == separateOrdersContainer.recipesHits.count{
//                separateOrdersContainer.limit = separateOrdersContainer.indOfSeparateOrder
//                        break
//                    }
//            separateOrdersContainer.arrOfSeparateOrders.append(separateOrdersContainer.recipesHits[separateOrdersContainer.indOfSeparateOrder])
//            separateOrdersContainer.indOfSeparateOrder = separateOrdersContainer.indOfSeparateOrder + 1
//                       }
////            self.perform(#selector(view?.loadCollectionview), with: nil, afterDelay: 2.0)
//        view?.collectionViewDidLoad()
//                }
//            }
