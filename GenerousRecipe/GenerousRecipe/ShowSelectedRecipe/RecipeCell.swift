//
//  Textcell.swift
//  GenerousRecipe
//
//  Created by Yongwoo Marco on 2020/11/11.
//  Copyright © 2020 FastCampus. All rights reserved.
//

import UIKit
import Foundation

class RecipeCell: UITableViewCell {
    @IBOutlet weak var thumbnail: UIImageView!
    
    @IBOutlet weak var sectionName: UILabel!
    
    @IBOutlet weak var ingredientsName: UILabel!
    @IBOutlet weak var ingredientsAmount: UILabel!
    
    @IBOutlet weak var stepsImage: UIImageView!
    @IBOutlet weak var stepsNumber: UILabel!
    @IBOutlet weak var detailOfSteps: UILabel!
    
    @IBOutlet weak var favorite: UISwitch!
    
    func updateThumbnail(_ image: UIImage) {
        thumbnail.image = image
    }
    func updateSection(_ section: Section) {
        var title: String {
                switch section {
                case .nokind: return "기타"
                case .korean: return "한식"
                case .japanese: return "일식"
                case .chinese: return "중식"
                case .western: return "양식"
                default: return ""
            }
        }
        sectionName.text = title
    }
    func updateIngredient(_ ingredient: Ingredient) {
        ingredientsName.text = ingredient.name
        ingredientsAmount.text = "\(ingredient.amount)g"
    }
    func updateSteps(_ step: Step, _ index: Int) {
        if let image = (step.imageDescription?.getPhoto())! {
            stepsImage.image = image
        } else {
            print("이미지 없음")
        }
        stepsNumber.text = "Step \(index+1)."
        detailOfSteps.text = step.textInstructions
    }
    func updateFavorite(_ select: Bool) {
        favorite.isOn = select
    }
    
    @IBAction func changedFavoriteState(_ sender: Any) {
        if favorite.isOn {
            // 던지기
        } else {
            
        }
        favorite.isOn = !favorite.isOn
    }
    
}
