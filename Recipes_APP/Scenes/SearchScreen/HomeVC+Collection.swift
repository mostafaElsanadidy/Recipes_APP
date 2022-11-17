//
//  SearchVC+Collection.swift
//  RecipesApp
//
//  Created by mostafa elsanadidy on 14.11.22.
//

import Foundation
import UIKit
import CoreData

extension HomeVC:UICollectionViewDataSource{
    
    // MARK: - Number OF Items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let presenter = self.presenter else { return 0 }
        if collectionView.tag == 100{
            return presenter.healthFiltersContainer.searchBarFilters.count
        }else{
            return presenter.recipesRoot?.recipes.count ?? 0
        }
    }
    // MARK: - Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cellIdentifier = ""
        var cell = UICollectionViewCell()
        
        switch collectionView.tag{
        case 100:
            cellIdentifier = "OptionCell"
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
            if let cell = cell as? OptionCell {
                cell.optionNameLabel.text = self.presenter?.healthFiltersContainer.searchBarFilters[indexPath.row]
            }
        default:
            cellIdentifier = "RecipeDetailsCell"
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
            if let cell = cell as? RecipeDetailsCell {
                
                self.presenter?.updateCellInfo(recipeIndex: indexPath.row){
                    recipeContainer  in
                    cell.recipeTitleLabel.text = recipeContainer.recipeNameText
                    cell.recipeSourceLabel.text = recipeContainer.recipeSourceText
                    cell.recipeHealthLabel.text = recipeContainer.recipeHealthText
                    if let sp_url = recipeContainer.recipePicUrl {
                    cell.recipeImageView.kf.indicatorType = .activity
                    cell.recipeImageView.kf.setImage(with: sp_url)
               //     cell.recipeImageView.isHidden = true
                }}
            }
        }
         
        return cell
    }
    
}


extension HomeVC:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

    // MARK: - Cell Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        
        var numberOfItemsInRow,edgeInset:CGFloat
        var heightPerItem:CGFloat = 0
        
        if collectionView.tag == 100{
          //   height = 100
             edgeInset = 10
             numberOfItemsInRow = 3
            heightPerItem = 120
        }else{
        //    height = 300
            edgeInset = 10
            numberOfItemsInRow = 1
          //  getFromApiData(recipeHit: arrOfSeparateOrders[indexPath.row])
        }
        let paddingSpace = edgeInset*(numberOfItemsInRow+1)
        let availableWidth = collectionView.frame.size.width-paddingSpace
        let widthPerItem = availableWidth/numberOfItemsInRow
        
        if collectionView.tag != 100{
            presenter?.updateCellSize(recipeIndex: indexPath.row, widthForItem: widthPerItem, cellSizeHandler: {
                height in
                heightPerItem = height
            })
        }
       // CGSize(width: sourse.Ingredients[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]).width + 25, height: 30)
//        var widthh:CGFloat = 0.0
//        if let cell = collectionView.cellForItem(at: indexPath) as? RecipeDetailsCell{
//            widthh = cell.recipeImageView.frame.width
//            print(widthh)
//        }
//        print(heightFor(using: widthPerItem-widthh))
        return CGSize(width: widthPerItem,height: heightPerItem)
      }


    // MARK: - Insets
    func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

//
//    func collectionView(_ collectionView: UICollectionView,
//                      layout collectionViewLayout: UICollectionViewLayout,
//                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 20
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//
//        return 20
//    }
    
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        presenter?.saveRecipes(at: indexPath.row)
        collectionView.deselectItem(at: indexPath, animated: true)
        presenter?.recipeCellDidSelected(index: indexPath.row)
//        collectionView.indexpath
    }
    
   
    
}

extension HomeVC{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let  height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if Int(distanceFromBottom) <= Int(height) { // when you reach the bottom
//            let numOfItemsPerAppending =
            if recipeDetailsCollection == scrollView{
                self.presenter?.appendGroupOfRecipes(isScrollToTop: false,nextPageTag: "")
            }
        }
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
    
    func addItemAlert() {
        let alert = UIAlertController.init(title: "Add New Restaurant", message: "", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Add", style: .default){
            (action) in
            print("Add New Restaurant")
        }
        alert.addAction(action)
        alert.addTextField{
            (field) in
            field.placeholder = "Add New Restaurant"
        }
        
        present(alert, animated: true, completion: nil)
    }
}


