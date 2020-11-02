//
//  ListCollectionViewCell.swift
//  GenerousRecipe
//
//  Created by Yongwoo Marco on 2020/10/26.
//  Copyright © 2020 FastCampus. All rights reserved.
//

import UIKit

class RecipesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var dishName: UILabel!
    
    func updateUI(recipe: Recipe) {
        //recipeImage.image = UIImage(named: "")
        dishName.text = recipe.dishName
    }
}
