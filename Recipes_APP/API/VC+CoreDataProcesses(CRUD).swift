////
////  SearchVC+CoreDataProcesses(CRUD).swift
////  RecipesApp
////
////  Created by mostafa elsanadidy on 25.06.22.
////
//
import Foundation
import CoreData
import UIKit
//
protocol AnyCoreDataHandler {
  //  var defaultHandler:()->(){get set}
   // var items:[T]{get set}
    associatedtype U
    associatedtype T
    func saveRecipes(afterSaving executionHandler:((_:[T])->()))
    func searchRecipe(with searchTuple:(key:String,text:String), parentRestaurant restaurant:(key:String,name:String)?, initialRequest: U,didEndSearching handler:((_:[T])->()))
    func loadRecipes(with request: U, parentRestaurant restaurant:(key:String,name:String)?, didEndLoading handler:((_:[T])->()))
    func updateRecipe(didBeginUpdating updateHandler:([T])->(), didEndUpdating afterUpdateHandler:((_:[T])->()))
    func deleteItems(at index:Int,afterDelete executionHandler:((_:[T])->()))
}
//
class CoreDataHandler<T:NSManagedObject>:AnyCoreDataHandler {
    var defaultHandler: () -> () = {}
    
    
    
    var items: [T] = []
    
    typealias U = NSFetchRequest<T>
   // var initialRequest:NSFetchRequest<T>?
    
   
    //MARK: - DEFAULT HANDLER
//    var defaultHandler: ()->() {
//        get {
//            return self.defaultHandler
//        }
//        set {
//            self.defaultHandler = newValue
//        }
//    }
    
   
    //MARK: - the D in the word CRUD
    func deleteItems(at index:Int,afterDelete executionHandler:((_:[T])->())) {
        viewContext.delete(items[index])
        items.remove(at: index)
       // print(localArray)
        
//        guard let handler = executionHandler
//        else{
//            defaultHandler()
//            return
//        }
        saveRecipes(afterSaving: executionHandler)
    }
    
    //MARK: - the C in the word CRUD
    func saveRecipes(afterSaving executionHandler:((_:[T])->())){
        do {
            try viewContext.save()
        } catch {
            print("Error Savinng Context \(error)")
        }
        
//        guard let handler = executionHandler
//        else{
//            defaultHandler()
//            return
//        }
        executionHandler(items)
    }
    
    //MARK: - the R in the word CRUD
    func searchRecipe(with searchTuple:(key:String,text:String), parentRestaurant restaurant:(key:String,name:String)?=nil, initialRequest:NSFetchRequest<T>, didEndSearching handler: ((_:[T]) -> ())){
        
         let request:NSFetchRequest<T> = initialRequest
        
        let predicate = NSPredicate.init(format: "\(searchTuple.key) CONTAINS[cd] %@",searchTuple.text)
        if restaurant == nil{
            request.predicate = predicate
        }else{
            let parentRestaurantPredicate = NSPredicate(format: "\(restaurant?.key ?? "") MATCHES %@",restaurant?.name ?? "")
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate,parentRestaurantPredicate])
        }
       
        
        request.sortDescriptors = [NSSortDescriptor(key: "\(searchTuple.key)", ascending: true)]
        
//        guard let handler = handler
//        else{
//            loadRecipes(with: request, in: &localArray, didEndLoading: defaultHandler)
//
//            return
//        }
        print(request)
        loadRecipes(with: request, parentRestaurant: nil, didEndLoading: handler)
    }
    
    func loadRecipes(with request: NSFetchRequest<T>, parentRestaurant restaurant:(key:String,name:String)?=nil, didEndLoading handler: ((_:[T]) -> ())) {
        do {
         //   request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
            
            if restaurant == nil{
              //  request.predicate = predicate
            }else{
                let parentRestaurantPredicate = NSPredicate(format: "\(restaurant?.key ?? "") MATCHES %@",restaurant?.name ?? "")
                request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [parentRestaurantPredicate])
            }
//           guard let request = request ?? initialRequest
//            else{return}
            print(request)
            items = try viewContext.fetch(request)
//            for item in localArray {
//                print(item.title ?? "")
//            }
////            print(recipes)
        //    print(localArray)
           
//            guard let handler = handler
//            else{
//                defaultHandler()
//
//                return
//            }
            
            handler(items)
        } catch {
            print("Error Loading Data From Context \(error)")
        }
    }
    
    //MARK: - the U in the word CRUD
    func updateRecipe(didBeginUpdating updateHandler:([T])->(), didEndUpdating afterUpdateHandler:((_:[T])->())) {
        
        //selectedRecipes[index].dueDate = !selectedRecipes[index].dueDate
        updateHandler(items)
        
//        guard let handler = afterUpdateHandler
//        else{
//            defaultHandler()
//            return
//        }
        saveRecipes(afterSaving: afterUpdateHandler)
    }
}
