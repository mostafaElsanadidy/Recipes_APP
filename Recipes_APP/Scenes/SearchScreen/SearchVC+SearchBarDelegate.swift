//
//  SearchVC+SearchBarDelegate.swift
//  RecipesApp
//
//  Created by mostafa elsanadidy on 14.11.22.
//

import Foundation
import UIKit
import DropDown

extension HomeVC:UISearchBarDelegate{
    
    
    func filterForSearchTextAndScopeButton(searchText:String,scopeButtonIndex:Int = 0) {
        
            guard searchBar.text!.isValidSearchKey else {
                noResultsView.isHidden = false
                collectionsStackView.isHidden = true
                self.show_Popup(body: "search key is not valid", type: .single, status: .failure)
                return }
        noResultsView.isHidden = true
        collectionsStackView.isHidden = false
            let scopeButtonIndex = searchBar.selectedScopeButtonIndex
            let searchText = searchBar.text!.lowercased()
            dropDown.hide()
//            guard let presenter = presenter else { return }
            recipeDetailsCollection.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            presenter?.searchKey = searchText
            presenter?.scopeButtonIndex = scopeButtonIndex
//            presenter.showRecipes(with: searchText, healthParams: [presenter.healthFiltersContainer.apiParamsFilters[scopeButtonIndex]])
            presenter?.appendGroupOfRecipes(isScrollToTop: true,nextPageTag: "")
//                return scopeMatch && searchTextMatch
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        let scopeButtonIndex = searchBar.selectedScopeButtonIndex
        let searchText = searchBar.text!.lowercased()
        dropDown.hide()
        filterForSearchTextAndScopeButton(searchText: searchText, scopeButtonIndex: scopeButtonIndex)
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        searchBar.showsScopeBar = true
        setupDropDown(with: 0)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
       
        let scopeButtonIndex = searchBar.selectedScopeButtonIndex
        let searchText = searchBar.text!.lowercased()
        dropDown.hide()
        filterForSearchTextAndScopeButton(searchText: searchText, scopeButtonIndex: scopeButtonIndex)
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if dropDown.isHidden{
                    dropDown.show()
                }
        return true
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.showsScopeBar = false
        searchBar.endEditing(true)
        dropDown.hide()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
//            self.presenter?.loadRecipes()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
}
