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
        
        presenter?.filterForSearchTextAndScopeButton(searchText: searchText, scopeButtonIndex: scopeButtonIndex)
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        let scopeButtonIndex = searchBar.selectedScopeButtonIndex
//        let searchText = searchBar.text!.lowercased()
        dropDown.hide()
        filterForSearchTextAndScopeButton(searchText: searchBar.text!, scopeButtonIndex: scopeButtonIndex)
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
//        let searchText = searchBar.text!.lowercased()
        dropDown.hide()
        filterForSearchTextAndScopeButton(searchText: searchBar.text!, scopeButtonIndex: scopeButtonIndex)
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if dropDown.isHidden{
            presenter?.changeDropDownDataSource()
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
