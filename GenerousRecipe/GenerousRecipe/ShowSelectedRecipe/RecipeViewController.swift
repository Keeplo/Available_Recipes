//
//  RecipeViewController.swift
//  Generous_Recipe
//
//  Created by Yongwoo Marco on 2020/10/20.
//

import UIKit

class RecipeViewController: UIViewController {
    @IBOutlet weak var dishName: UILabel!
//    @IBOutlet weak var thumbNail: UIImageView!
    
    enum Sections {
        case thumnail
        case section
        case importtant
        case optional
        case steps
        case favorite
    }
    
    private let sections: [Sections] = [ .thumnail, .section, .importtant, .optional, .steps, .favorite]
    var currentRecipe: Recipe? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        upadateUI()
//        thumbNail.image = image
    }
    
    func updateRecipe(_ recipe: Recipe) {
        currentRecipe = recipe
    }
    func upadateUI() {
        guard let recipe = currentRecipe else {
            return print("currentRecipe nil")
        }
        dishName.text = recipe.dishName
    }

    @IBAction func backToList(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion:nil)
    }
    
//    func createRecipe(, IIngredients: [Ingredient], OIngredients: [Ingredient], steps: [Step], favorite: Bool, section: Section)
//    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RecipeViewController: UITableViewDataSource {
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
        guard let recipe = currentRecipe else {
            print("currentRecipe nil")
            return 0
        }
        
        switch sections[section] {
        case .thumnail:
            return 1
        case .section:
            return 1
        case .importtant:
            return recipe.IIngredients.count
        case .optional:
            return recipe.OIngredients.count
        case .steps:
            return recipe.steps.count
        case .favorite:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let recipe = currentRecipe else { return UITableViewCell()}
        
        switch sections[indexPath.section] {
        case .thumnail:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "thumbnailCell", for: indexPath) as? RecipeCell else {
                print("RecipeCell Error")
                return UITableViewCell()
            }
            cell.updateThumbnail((recipe.thumbnail?.getPhoto())!)
            return cell
        case .section:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath) as? RecipeCell else {
                print("RecipeCell Error")
                return UITableViewCell()
            }
            cell.updateSection(recipe.section)
            return cell
        case .importtant:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell", for: indexPath) as? RecipeCell else {
                print("RecipeCell Error")
                return UITableViewCell()
            }
            cell.updateIngredient(recipe.IIngredients[indexPath.row])
            return cell
        case .optional:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell", for: indexPath) as? RecipeCell else {
                print("RecipeCell Error")
                return UITableViewCell()
            }
            cell.updateIngredient(recipe.OIngredients[indexPath.row])
            return cell
        case .steps:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "stepsCell", for: indexPath) as? RecipeCell else {
                print("RecipeCell Error")
                return UITableViewCell()
            }
            cell.updateSteps(recipe.steps[indexPath.row], indexPath.row)
            return cell
        case .favorite:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? RecipeCell else {
                print("RecipeCell Error")
                return UITableViewCell()
            }
            cell.updateFavorite(recipe.favorite)
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
}

extension RecipeViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        //print(tableView.rowHeight)
//        return 0
//    }
}
