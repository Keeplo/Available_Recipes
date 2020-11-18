//
//  ListTableViewCell.swift
//  GenerousRecipe
//
//  Created by Yongwoo Marco on 2020/11/06.
//  Copyright © 2020 FastCampus. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeThumbnail: UIImageView!
    @IBOutlet weak var dishName: UILabel!
    
    func updateUI(recipe: Recipe) {
        dishName.text = recipe.dishName
        recipeThumbnail.image = UIImage(contentsOfFile: recipe.thumbnail!)
    }
}
