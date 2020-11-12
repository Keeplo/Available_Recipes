//
//  ViewController.swift
//  GenerousRecipe
//
//  Created by James Kim on 8/5/20.
//  Copyright © 2020 FastCampus. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var searchV: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var sortSC: UISegmentedControl!
    @IBOutlet weak var searchB: UIButton!
    @IBOutlet weak var addingB: UIButton!
    
    @IBOutlet weak var ListTableView: UITableView!
    let recipeListViewModel = RecipeViewModel()
    
// Mark - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegate
        ListTableView.delegate = self
        
        // CollectionView UIUpdate
        
        // 더미 파일 입력
        let rs =
        [
            Recipe(dishName: "삼계탕", thumbnail: ImageData(photo: UIImage(named: "삼계탕")!), IIngredients: [Ingredient(name: "닭", amount: 1.000)], OIngredients: [Ingredient(name: "마늘", amount: 0.020), Ingredient(name: "양파", amount: 0.050), Ingredient(name: "인삼", amount: 0.030)], steps: [Step(textInstructions: "one"), Step(textInstructions: "two"), Step(textInstructions: "three")], favorite: false, section: .korean),
            Recipe(dishName: "참치김치찌개", thumbnail: ImageData(photo: UIImage(named: "참치김치찌개")!), IIngredients: [Ingredient(name: "김치", amount: 0.150), Ingredient(name: "참치", amount: 0.070)], OIngredients: [Ingredient(name: "마늘", amount: 0.020), Ingredient(name: "양파", amount: 0.050)], steps: [Step(textInstructions: "1"), Step(textInstructions: "2"), Step(textInstructions: "3")], favorite: false, section: .korean),
            Recipe(dishName: "제육볶음", thumbnail: ImageData(photo: UIImage(named: "제육볶음")!), IIngredients: [Ingredient(name: "돼지고기", amount: 0.350)], OIngredients: [Ingredient(name: "마늘", amount: 0.020), Ingredient(name: "양파", amount: 0.050), Ingredient(name: "당근", amount: 0.050)], steps: [Step(textInstructions: "하나"), Step(textInstructions: "둘"), Step(textInstructions: "셋")], favorite: true, section: .korean),
            Recipe(dishName: "광어초밥", thumbnail: ImageData(photo: UIImage(named: "초밥")!), IIngredients: [Ingredient(name: "밥", amount: 0.350)], OIngredients: [Ingredient(name: "겨자", amount: 0.020)], steps: [Step(textInstructions: "원"), Step(textInstructions: "투"), Step(textInstructions: "쓰리")], favorite: true, section: .japanese),
            Recipe(dishName: "스테이크", thumbnail: ImageData(photo: UIImage(named: "스테이크")!), IIngredients: [Ingredient(name: "소고기", amount: 0.350)], OIngredients: [Ingredient(name: "버터", amount: 0.020), Ingredient(name: "후추", amount: 0.020)], steps: [Step(textInstructions: "이"), Step(textInstructions: "얼"), Step(textInstructions: "싼")], favorite: true, section: .western)
        ]
        let _ = rs.map({ recipeListViewModel.addRecipe($0)})
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        recipeListViewModel.loadTasks()
    }

    
//Mark - IBActions
    @IBAction func addRecipeButton(_ sender: Any) {
        let msg = "새로운 레시피를 등록하시겠습니까?"
        let title = "레시피 등록하기"
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Yes", style: .default) {(action: UIAlertAction!) -> Void in
            self.tabBarController?.selectedIndex = 1
            
            NSLog(msg)
        }
        let cancelAction = UIAlertAction(title: "No", style: .default) {(action: UIAlertAction!) -> Void in
            NSLog(msg)
        }
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion:nil)
    }
    @IBAction func changedSort(_ sender: Any) {
        tableViewUpadate()
    }
    @IBAction func tapNavigatorView(_ sender: Any) {
        dismissKeyboard()
    }
}

//Mark - TableView DataSource
extension ListViewController: UITableViewDataSource {
    func tableViewUpadate() {
        ListTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !recipeListViewModel.searchedRecipes.isEmpty {           // 검색중
            if sortSC.selectedSegmentIndex == 0 {
                return recipeListViewModel.searchedAllRecipes.count
            } else {
                return recipeListViewModel.searchedFavoriteRecipes.count
            }
        } else {                                                    // 검색중 x
            if sortSC.selectedSegmentIndex == 0 {
                return recipeListViewModel.baseAllRecipes.count
            } else {
                return recipeListViewModel.baseFavoriteRecipes.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell else {return UITableViewCell() }
        
        var recipe: Recipe
        
        recipe = recipeListViewModel.baseAllRecipes[indexPath.row]
        if !recipeListViewModel.searchedRecipes.isEmpty {        // 검색중
            if sortSC.selectedSegmentIndex == 0 {
                recipe = recipeListViewModel.searchedAllRecipes[indexPath.row]
            } else {
                recipe = recipeListViewModel.searchedFavoriteRecipes[indexPath.row]
            }
        } else {                                                 // 검색중 x
            if sortSC.selectedSegmentIndex == 0 {
                recipe = recipeListViewModel.baseAllRecipes[indexPath.row]
            } else {
                recipe = recipeListViewModel.baseFavoriteRecipes[indexPath.row]
            }
        }
        cell.updateUI(recipe: recipe)
        
        return cell
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = CGFloat(150)
        return height
    }
    
}
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("--> \(indexPath.row)")
        
        let sb = UIStoryboard(name: "RecipeViewController", bundle: nil)
        guard let vc = sb.instantiateViewController(identifier: "RecipeViewController") as? RecipeViewController else {
            return
        }
        
        var recipe: Recipe
        
        if !recipeListViewModel.searchedRecipes.isEmpty {        // 검색중
            if sortSC.selectedSegmentIndex == 0 {
                recipe = recipeListViewModel.searchedAllRecipes[indexPath.row]
            } else {
                recipe = recipeListViewModel.searchedFavoriteRecipes[indexPath.row]
            }
        } else {                                                 // 검색중 x
            if sortSC.selectedSegmentIndex == 0 {
                recipe = recipeListViewModel.baseAllRecipes[indexPath.row]
            } else {
                recipe = recipeListViewModel.baseFavoriteRecipes[indexPath.row]
            }
        }

        vc.modalPresentationStyle = .fullScreen
        vc.currentRecipe = recipe
        
        self.present(vc, animated: false, completion: nil)
        
        //performSegue(withIdentifier: "showRecipe", sender: indexPath.row)
    }
}
extension ListViewController: UISearchBarDelegate {
    private func dismissKeyboard() {
        searchBar.resignFirstResponder() //
        print("dismissKeyboard")
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard() // 키보드가 올라와 있을때, 내려가게 처리
        guard let searchTerm = searchBar.text, searchTerm.isEmpty == false else {
            return recipeListViewModel.emptySearchedList() } // 검색어가 있는지 확인 비어 있을경우 검색x
        recipeListViewModel.searchingDishName(name: searchTerm)
        tableViewUpadate()
         
        print("--> 검색어: \(searchTerm)")
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            recipeListViewModel.emptySearchedList()
        }
        tableViewUpadate()
    }
}
