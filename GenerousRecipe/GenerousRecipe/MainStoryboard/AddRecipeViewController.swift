//
//  AddRecipeViewController.swift
//  Generous_Recipe
//
//  Created by Yongwoo Marco on 2020/10/19.
//

import UIKit

class AddRecipeViewController: UIViewController {
    @IBOutlet weak var storeB: UIButton!
    @IBOutlet weak var initB: UIButton!
    
    @IBOutlet weak var addTableView: UITableView!
    
    
    


    enum Sections {
        case recipename
        case thumnail
        case section
        case importtant
        case optional
        case steps
        case favorite
    }
    
    private let sections: [(Sections,String)] = [ (.recipename,"Dish Name"), (.thumnail, "Dish Thumbnail"), (.section, "Dish Style"), (.importtant, "Important Ingredients"), (.optional, "Optional Ingredients"), (.steps, "Cooking Steps"), (.favorite, "Favorite")]
    private let styles: [(Styles,String)] = [(.nokind, "Etc"), (.korean, "한식"), (.japanese, "일식"), (.chinese, "중식"), (.western, "양식")]
    
    
    var basedRecipe = Recipe(dishName: "", thumbnail: nil, IIngredients: [], OIngredients: [], steps: [], favorite: false, section: .nokind)
    
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
        return sections[section].1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section].0 {
        case .recipename:
            return 1
        case .thumnail:
            return 1
        case .section:
            return 1
        case .importtant:
            return 1+basedRecipe.IIngredients.count
        case .optional:
            return 1+basedRecipe.OIngredients.count
        case .steps:
            return 1+basedRecipe.steps.count
        case .favorite:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section].0 {
        case .recipename:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "dishNameCell", for: indexPath) as? AddRecipeCell else {
                print("addRecipeCell Error")
                return UITableViewCell()
            }
            return cell
        case .thumnail:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "addThumbnailCell", for: indexPath) as? AddRecipeCell else {
                print("addRecipeCell Error")
                return UITableViewCell()
            }
            
            return cell
        case .section:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "addSectionCell", for: indexPath) as? AddRecipeCell else {
                print("addRecipeCell Error")
                return UITableViewCell()
            }
            return cell
        case .importtant:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "addIngredientsCell", for: indexPath) as? AddRecipeCell else {
                print("addRecipeCell Error")
                return UITableViewCell()
            }
            return cell
        case .optional:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "addIngredientsCell", for: indexPath) as? AddRecipeCell else {
                print("addRecipeCell Error")
                return UITableViewCell()
            }
            return cell
        case .steps:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "addStepsCell", for: indexPath) as? AddRecipeCell else {
                print("addRecipeCell Error")
                return UITableViewCell()
            }
            return cell
        case .favorite:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "addFavoriteCell", for: indexPath) as? AddRecipeCell else {
                print("addRecipeCell Error")
                return UITableViewCell()
            }
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



