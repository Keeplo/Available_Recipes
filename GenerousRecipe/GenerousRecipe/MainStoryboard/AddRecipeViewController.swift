//
//  AddRecipeViewController.swift
//  Generous_Recipe
//
//  Created by Yongwoo Marco on 2020/10/19.
//

import UIKit

class AddRecipeViewController: UIViewController {
    @IBOutlet weak var storeB: UIButton!
    
    @IBOutlet weak var addTableView: UITableView!
    
    
    


    enum Sections {
        case thumnail
        case section
        case importtant
        case optional
        case steps
        case favorite
    }
    
    private let sections: [Sections] = [ .thumnail, .section, .importtant, .optional, .steps, .favorite]
    
    var basedRecipe = Recipe(dishName: "", thumbnail: nil, IIngredients: [Ingredient(name: "", amount: 0)], OIngredients: [Ingredient(name: "", amount: 0)], steps: [Step(imageDescription: nil, textInstructions: "")], favorite: false, section: .nokind)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func initializationButton(_ sender: Any) {
        
    }
}

extension AddRecipeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch sections[section] {
        case .thumnail:
            return "Dish Thumbnail"
        case .section:
            return "Dish Style"
        case .importtant:
            return "Important Ingredients"
        case .optional:
            return "Optional Ingredients"
        case .steps:
            return "Cooking Steps"
        case .favorite:
            return "Favorite"
        default:
            return "error"
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .thumnail:
            return 1
        case .section:
            return 1
        case .importtant:
            return basedRecipe.IIngredients.count
        case .optional:
            return basedRecipe.OIngredients.count
        case .steps:
            return basedRecipe.steps.count
        case .favorite:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .thumnail:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "thumbnailCell", for: indexPath) as? RecipeCell else {
                print("RecipeCell Error")
                return UITableViewCell()
            }
            
            return cell
        case .section:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath) as? RecipeCell else {
                print("RecipeCell Error")
                return UITableViewCell()
            }
            return cell
        case .importtant:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell", for: indexPath) as? RecipeCell else {
                print("RecipeCell Error")
                return UITableViewCell()
            }
            return cell
        case .optional:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell", for: indexPath) as? RecipeCell else {
                print("RecipeCell Error")
                return UITableViewCell()
            }
            return cell
        case .steps:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "stepsCell", for: indexPath) as? RecipeCell else {
                print("RecipeCell Error")
                return UITableViewCell()
            }
            return cell
        case .favorite:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? RecipeCell else {
                print("RecipeCell Error")
                return UITableViewCell()
            }
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
}

extension AddRecipeViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        //print(tableView.rowHeight)
//        return 0
//    }
}



