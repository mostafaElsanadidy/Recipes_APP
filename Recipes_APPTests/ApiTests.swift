//
//  ApiTests.swift
//  Recipes_APPTests
//
//  Created by mostafa elsanadidy on 17.11.22.
//

import Foundation
import XCTest

@testable import Recipes_APP

class ApiTests:XCTestCase{
    
    let timeOut : TimeInterval = 600
    var expectation : XCTestExpectation!
    
    var recipes : [Recipe]!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        expectation = XCTestExpectation.init(description: "Server Respond in time")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        recipes = nil
    }
    
    func testSearchForRecipes(){
        
//        {[weak self] (result) in
//            guard let strongSelf = self else{return}
//
//            switch result {
//            case .failure(let error) :
//                strongSelf.presenter?.interactorDidFetchRecipes(with: .failure(error))
//            case .success(let value) :
//                guard let recipes_data = value else { return  }
//                strongSelf.presenter?.interactorDidFetchRecipes(with: .success(recipes_data))
//            }
//        }
        APIClient.searchForRecipe(searchKey: "chicken", healthFilters: ["vegan"], nextPageTag: "", completionHandler: {
            result in
            
            switch result{
                            case .failure(let error) :
//                                strongSelf.presenter?.interactorDidFetchRecipes(with: .failure(error))
                                defer { self.expectation.fulfill() }
                                XCTAssertNil(error)
                            case .success(let value) :
//                                guard let recipes_data = value else { return  }
                defer { self.expectation.fulfill() }
                print(value!.hits!.map{$0.recipe.label})
                XCTAssertNotEqual(value!.hits!.map{$0.recipe.label}, nil)
                XCTAssertNotEqual(value!.hits!.map{$0.recipe.label}, [])
                            }
        })
        wait(for: [expectation], timeout: timeOut)
    }
    
    func testShowRecipeDetails(){
        
        APIClient.appearRecipeInfo(recipeId: "9a0836a4cb31c249d8bf0621d5e222ac", completionHandler:{
            result in
            
            switch result{
                            case .failure(let error) :
//                                strongSelf.presenter?.interactorDidFetchRecipes(with: .failure(error))
                                defer { self.expectation.fulfill() }
                                XCTAssertNil(error)
                            case .success(let value) :
//                                guard let recipes_data = value else { return  }
                defer { self.expectation.fulfill() }
                print(value!.recipe.label!)
                XCTAssertNotEqual(value!.recipe.label, nil)
                XCTAssertEqual(value!.recipe.label, "Chicken and Broccoli Stir-Fry")
                            }
        })
    }
    
    
    func testSearchForNextPageRecipes(){
        
//        {[weak self] (result) in
//            guard let strongSelf = self else{return}
//
//            switch result {
//            case .failure(let error) :
//                strongSelf.presenter?.interactorDidFetchRecipes(with: .failure(error))
//            case .success(let value) :
//                guard let recipes_data = value else { return  }
//                strongSelf.presenter?.interactorDidFetchRecipes(with: .success(recipes_data))
//            }
//        }
        
        APIClient.searchForRecipe(searchKey: "chicken", healthFilters: ["vegan"], nextPageTag: "CHcVQBtNNQphDmgVQ3tAEX4BYlVtAgsFQ2xDAmEaZVF7AAAAUXlSV2oXNwF7DQUHS2cTUTNAMQMhBQsAQGNEBWASMVVzAgcVLnlSVSBMPkd5BgMbUSYRVTdgMgksRlpSAAcRXTVGcV84SU4%3D", completionHandler: {
            result in
            
            switch result{
                            case .failure(let error) :
//                                strongSelf.presenter?.interactorDidFetchRecipes(with: .failure(error))
                                defer { self.expectation.fulfill() }
                                XCTAssertNil(error)
                            case .success(let value) :
//                                guard let recipes_data = value else { return  }
                defer { self.expectation.fulfill() }
                print(value!.hits!.map{$0.recipe.label})
                XCTAssertNotEqual(value!.to, nil)
//                XCTAssertNotEqual(value!.hits!.map{$0.recipe.label}, [])
                XCTAssertGreaterThan(value!.to, 20)
                
                            }
        })
        wait(for: [expectation], timeout: timeOut)
    }
    
    func testPerformanceExample() throws {
           // This is an example of a performance test case.
           self.measure {
               // Put the code you want to measure the time of here.
           }
       }
//    func testVaildLastName(){
//
//        let student = Student.init(firstName: "AJ", lastName: "Styler")
//        //        XCTAssertTrue(student.validFirstName())
//                XCTAssertTrue(student.validLastName())
//    }
//
//    func testAddFriends(){
//         let student = Student.init(firstName: "AJ", lastName: "Styler")
//        let friend = Student.init(firstName: "CM", lastName: "Punk")
//
//        XCTAssertTrue(student.friends.count == 0)
//
//
//    }
   

}
