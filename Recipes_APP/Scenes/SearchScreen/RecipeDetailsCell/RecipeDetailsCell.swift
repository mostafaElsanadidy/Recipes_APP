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
    
//    override func sizeThatFits(_ size: CGSize) -> CGSize {
//        print("jnuij")
//        let height = recipeTitleLabel.frame.size.height +
//           recipeSourceLabel.frame.size.height + recipeHealthLabel.frame.size.height
//        return CGSize.init(width: size.width, height: height)
//    }
//
    override func awakeFromNib() {
          super.awakeFromNib()
          // Initialization code
     
//     contentView.translatesAutoresizingMaskIntoConstraints = false
//
//     NSLayoutConstraint.activate(
//         [contentView.leftAnchor.constraint(equalTo: leftAnchor),
//         contentView.rightAnchor.constraint(equalTo: rightAnchor),
//         contentView.topAnchor.constraint(equalTo: topAnchor),
//         contentView.bottomAnchor.constraint(equalTo: bottomAnchor)]
//     )
     
      }

//override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//
// setNeedsLayout()
// layoutIfNeeded()
//
////   let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
//
// var frame = layoutAttributes.frame
// let height = recipeTitleLabel.frame.size.height +
//    recipeSourceLabel.frame.size.height + recipeHealthLabel.frame.size.height
// 
// frame.size.height = height + 420
////  frame.size.height = ceil(size.height)
// layoutAttributes.frame = frame
//
// print(layoutAttributes.frame.size.height)
// return layoutAttributes
// 
//}

}
