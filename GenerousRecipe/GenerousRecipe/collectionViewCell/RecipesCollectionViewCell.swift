//
//  ListCollectionViewCell.swift
//  GenerousRecipe
//
//  Created by Yongwoo Marco on 2020/10/26.
//  Copyright © 2020 FastCampus. All rights reserved.
//

import UIKit

class RecipesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var recipeThumbnail: UIImageView!
    @IBOutlet weak var dishName: UILabel!
    
    func updateUI(recipe: Recipe) {
        dishName.text = recipe.dishName
        recipeThumbnail.image = recipe.thumbnail?.getPhoto()
    }
}
