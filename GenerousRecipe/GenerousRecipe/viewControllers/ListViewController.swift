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
    
    @IBOutlet weak var collectionView: UICollectionView!
    let recipeListViewModel = RecipeViewModel()
    
//Mark - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // SearchingView Control
        searchVIsHidden = true
        searchVHeight = searchV.bounds.height
        resiedHeight = searchV.bounds.height  - searchVBottomConstraint.constant - searchTF.bounds.height
        
        changeViewState(isHidden: searchVIsHidden)
        
        // CollectionView UIUpdate
        
        // 더미 파일 입력
        let rs =
        [
            Recipe(dishName: "삼계탕", thumbnail: ImageData(photo: UIImage(named: "삼계탕")!), IIngredients: [Ingredient(name: "닭", amount: 1.000)], OIngredients: [Ingredient(name: "마늘", amount: 0.020), Ingredient(name: "양파", amount: 0.050), Ingredient(name: "인삼", amount: 0.030)], steps: [Step(textInstructions: "one"), Step(textInstructions: "two"), Step(textInstructions: "three")], favorite: false),
            Recipe(dishName: "참치김치찌개", thumbnail: ImageData(photo: UIImage(named: "참치김치찌개")!), IIngredients: [Ingredient(name: "김치", amount: 0.150), Ingredient(name: "참치", amount: 0.070)], OIngredients: [Ingredient(name: "마늘", amount: 0.020), Ingredient(name: "양파", amount: 0.050)], steps: [Step(textInstructions: "1"), Step(textInstructions: "2"), Step(textInstructions: "3")], favorite: false),
            Recipe(dishName: "제육볶음", thumbnail: ImageData(photo: UIImage(named: "제육볶음")!), IIngredients: [Ingredient(name: "돼지고기", amount: 0.350)], OIngredients: [Ingredient(name: "마늘", amount: 0.020), Ingredient(name: "양파", amount: 0.050), Ingredient(name: "당근", amount: 0.050)], steps: [Step(textInstructions: "하나"), Step(textInstructions: "둘"), Step(textInstructions: "셋")], favorite: true)
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
    // BG 탭했을때, 키보드 내려오게 하기
    @IBAction func tapBG(_ sender: Any) {
        searchTF.resignFirstResponder() // 최고의 관심사가 아니게 된다.
        
        if(!searchVIsHidden) {
            searchVIsHidden = !searchVIsHidden
            changeViewState(isHidden: searchVIsHidden)
        }
    }
    @IBAction func changedSort(_ sender: Any) {
        print(sortSC.selectedSegmentIndex)
        collectionView.reloadData()
    }
}


//Mark - CollectionView DataSource
extension ListViewController: UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        print("numberOfSection \(recipeListViewModel.numOfSection)")
//        return recipeListViewModel.numOfSection
//    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print("favorite \(recipeListViewModel.favoriteRecipes.count)")
//        print("All \(recipeListViewModel.allRecipes.count)")
        return sortSC.selectedSegmentIndex == 0 ? recipeListViewModel.allRecipes.count : recipeListViewModel.favoriteRecipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipesCollectionViewCell", for: indexPath) as? RecipesCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        var recipe: Recipe
        
        if sortSC.selectedSegmentIndex == 0 {
            recipe = recipeListViewModel.allRecipes[indexPath.row]

        } else {
            recipe = recipeListViewModel.favoriteRecipes[indexPath.row]
        }
        
        // ++TODO: todo 를 이용해서 updateUI
        cell.updateUI(recipe: recipe)
        
        return cell
    }
}

