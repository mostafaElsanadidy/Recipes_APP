//
//  RecipeDetailsCell.swift
//  RecipesApp
//
//  Created by Mustafa Sanadidy on 10/05/2022.
//

import UIKit

class RecipeDetailsCell: UICollectionViewCell {

    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeSourceLabel: UILabel!
    @IBOutlet weak var recipeHealthLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    
    override func awakeFromNib() {
          super.awakeFromNib()
          // Initialization code
      }
    
}
