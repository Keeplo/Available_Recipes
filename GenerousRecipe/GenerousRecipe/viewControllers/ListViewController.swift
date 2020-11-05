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
    @IBOutlet weak var searchTF: UITextField!
        
    @IBOutlet weak var searchVBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchVHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sortSC: UISegmentedControl!
    @IBOutlet weak var searchB: UIButton!
    @IBOutlet weak var addingB: UIButton!
    
    var searchVIsHidden: Bool!
    var searchVHeight: CGFloat!
    var resiedHeight: CGFloat!
    
    
    @IBOutlet weak var ListTableView: UITableView!
    let recipeListViewModel = RecipeViewModel()
    
// Mark - Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showRecipe" {
//            let vc = segue.destination as? RecipeViewController
//            if let index = sender as? Int {
//                vc?.name = nameList[index]
//                vc?.bounty = bountyList[index]
//            }
//        }
//    }
    
// Mark - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegate
        ListTableView.delegate = self
        searchTF.delegate = self
        
        // SearchingView Control
        searchVIsHidden = true
        searchVHeight = searchV.bounds.height
        resiedHeight = searchV.bounds.height  - searchVBottomConstraint.constant - searchTF.bounds.height
        
        changeViewState(isHidden: searchVIsHidden)
        
        // CollectionView UIUpdate
        
        // 더미 파일 입력
        let rs =
        [
            Recipe(dishName: "삼계탕", thumbnail: ImageData(photo: UIImage(named: "삼계탕")!), IIngredients: [Ingredient(name: "닭", amount: 1.000)], OIngredients: [Ingredient(name: "마늘", amount: 0.020), Ingredient(name: "양파", amount: 0.050), Ingredient(name: "인삼", amount: 0.030)], steps: [Step(textInstructions: "one"), Step(textInstructions: "two"), Step(textInstructions: "three")], favorite: false, section: .korean),
            Recipe(dishName: "참치김치찌개", thumbnail: ImageData(photo: UIImage(named: "참치김치찌개")!), IIngredients: [Ingredient(name: "김치", amount: 0.150), Ingredient(name: "참치", amount: 0.070)], OIngredients: [Ingredient(name: "마늘", amount: 0.020), Ingredient(name: "양파", amount: 0.050)], steps: [Step(textInstructions: "1"), Step(textInstructions: "2"), Step(textInstructions: "3")], favorite: false, section: .korean),
            Recipe(dishName: "제육볶음", thumbnail: ImageData(photo: UIImage(named: "제육볶음")!), IIngredients: [Ingredient(name: "돼지고기", amount: 0.350)], OIngredients: [Ingredient(name: "마늘", amount: 0.020), Ingredient(name: "양파", amount: 0.050), Ingredient(name: "당근", amount: 0.050)], steps: [Step(textInstructions: "하나"), Step(textInstructions: "둘"), Step(textInstructions: "셋")], favorite: true, section: .korean),
            Recipe(dishName: "광어초밥", thumbnail: ImageData(photo: UIImage(named: "초밥")!), IIngredients: [Ingredient(name: "밥", amount: 0.350)], OIngredients: [Ingredient(name: "겨자", amount: 0.020)], steps: [Step(textInstructions: "원"), Step(textInstructions: "투"), Step(textInstructions: "쓰리")], favorite: true, section: .japanese),
            Recipe(dishName: "스테이크", thumbnail: ImageData(photo: UIImage(named: "스테이크")!), IIngredients: [Ingredient(name: "소고기", amount: 0.350)], OIngredients: [Ingredient(name: "버터", amount: 0.020), Ingredient(name: "후추", amount: 0.020)], steps: [Step(textInstructions: "이"), Step(textInstructions: "얼"), Step(textInstructions: "싼")], favorite: true, section: .chinese)
        ]
        let _ = rs.map({ recipeListViewModel.addRecipe($0)})
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        recipeListViewModel.loadTasks()
    }
    
    // Seaching View UIControll
    func changeViewState(isHidden: Bool) {
        isHidden ? hideSearchingView() : AppearSearchingView() }
    func hideSearchingView() {
        //print("before : \(searchV.bounds.height) / resize : \(resiedHeight)")
        searchVHeightConstraint.constant = resiedHeight
        
        searchTF.isHidden = !searchTF.isHidden
        searchTF.isEnabled = !searchTF.isEnabled }
    func AppearSearchingView() {
        searchVHeightConstraint.constant = searchVHeight
        
        searchTF.isHidden = !searchTF.isHidden
        searchTF.isEnabled = !searchTF.isEnabled
    }

    
//Mark - IBActions
    @IBAction func addRecipeButton(_ sender: Any) {
        print("func addRecipeButton / press AddingRecipeButton")
    }
    @IBAction func searchingRecipeButton(_ sender: Any) {
        searchVIsHidden = !searchVIsHidden
        changeViewState(isHidden: searchVIsHidden)
    }
    // BG 탭했을때, 키보드 내려오게 하기 + searching View 비활성화
//    @IBAction func tapBG(_ sender: Any) {
//        searchTF.resignFirstResponder() // 최고의 관심사가 아니게 된다.
//
//        if !searchVIsHidden, searchTF.text == "" {
//            searchVIsHidden = !searchVIsHidden
//            changeViewState(isHidden: searchVIsHidden)
//            recipeListViewModel.emptySearchedList()
//            tableViewUpadate()
//        }
//    }
    @IBAction func changedSort(_ sender: Any) {
        tableViewUpadate()
    }
}


//Mark - TableView DataSource
extension ListViewController: UITableViewDataSource {
    func tableViewUpadate() {
        ListTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !recipeListViewModel.searchedRecipes.isEmpty || !searchTF.text!.isEmpty {           // 검색중
            if sortSC.selectedSegmentIndex == 0 {
                print("all 1 \(recipeListViewModel.searchedAllRecipes.count)")
                return recipeListViewModel.searchedAllRecipes.count
            } else {
                print("fab 1 \(recipeListViewModel.searchedFavoriteRecipes.count)")
                return recipeListViewModel.searchedFavoriteRecipes.count
            }
        } else {                                                    // 검색중 x
            if sortSC.selectedSegmentIndex == 0 {
                print("all 2 \(recipeListViewModel.baseAllRecipes.count)")
                return recipeListViewModel.baseAllRecipes.count
            } else {
                print("fav 2 \(recipeListViewModel.baseFavoriteRecipes.count)")
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
        } else if !searchTF.text!.isEmpty {                      // 검색 결과없음
            recipe = recipeListViewModel.baseAllRecipes[indexPath.row]
            return cell
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
        performSegue(withIdentifier: "showRecipe", sender: indexPath.row)
    }
}

// Mark: Delegate Part
extension ListViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        resetList()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resetList()
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchTF.text = ""
        resetList()
        return true
    }
    
    func resetList() { // 컬렉션 뷰 띄우기 변경
        guard let input = searchTF.text else { return }
        if !input.isEmpty {
            recipeListViewModel.searchingDishName(name: input)
        } else {
            recipeListViewModel.emptySearchedList()
        }
        tableViewUpadate()
    }
}

/*
 let alert = UIAlertController(title: "접수불가", message: msg, preferredStyle: .alert)
 let confirmAction = UIAlertAction(title: "확인", style: .default) {(action: UIAlertAction!) -> Void in
     NSLog(msg)
 }
 
 alert.addAction(confirmAction)
 
 present(alert, animated: true, completion:nil)
 */

