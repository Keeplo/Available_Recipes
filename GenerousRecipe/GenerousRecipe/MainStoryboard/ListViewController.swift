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
    
    @IBOutlet weak var headTitleL: UILabel!
    
    @IBOutlet weak var sortSC: UISegmentedControl!
    @IBOutlet weak var searchB: UIButton!
    @IBOutlet weak var addingB: UIButton!
    @IBOutlet weak var changeTaskB: UIButton!
    
    @IBOutlet weak var ListTableView: UITableView!
    let recipeListViewModel = RecipeViewModel()
    
    var taskMode: Bool = false
    
    var searchVHeight: CGFloat!
    var resiedHeight: CGFloat!
    
    @IBOutlet weak var searchVBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchVHeightConstraint: NSLayoutConstraint!
    
    lazy var activityIndicator: UIActivityIndicatorView = {
            // Create an indicator.
            let activityIndicator = UIActivityIndicatorView()
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            activityIndicator.center = self.view.center
            activityIndicator.color = UIColor.red
            // Also show the indicator even when the animation is stopped.
            activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
            // Start animation.
            activityIndicator.stopAnimating()
            return activityIndicator }()
         
    // Dummy 생성용
    @IBAction func dummy(_ sender: Any) {
        print("Create Dummy")
        
        recipeListViewModel.saveImage(UIImage(named: "삼계탕")!, "삼계탕")
        recipeListViewModel.saveImage(UIImage(named: "참치김치찌개")!, "참치김치찌개")
        recipeListViewModel.saveImage(UIImage(named: "제육볶음")!, "제육볶음")
        recipeListViewModel.saveImage(UIImage(named: "초밥")!, "광어초밥")
        recipeListViewModel.saveImage(UIImage(named: "스테이크")!, "스테이크")
        
        let rs = [
            Recipe(dishName: "삼계탕", thumbnail: recipeListViewModel.getImagePath("삼계탕"), iIngredients: [Ingredient(name: "닭", amount: 1.000)], oIngredients: [Ingredient(name: "마늘", amount: 0.020), Ingredient(name: "양파", amount: 0.050), Ingredient(name: "인삼", amount: 0.030)], steps: [Step(imageDescription: nil, textInstructions: "one"), Step(imageDescription: nil, textInstructions: "two"), Step(imageDescription: nil, textInstructions: "three")], favorite: false, section: .korean),
            Recipe(dishName: "참치김치찌개", thumbnail: recipeListViewModel.getImagePath("참치김치찌개"), iIngredients: [Ingredient(name: "김치", amount: 0.150), Ingredient(name: "참치", amount: 0.070)], oIngredients: [Ingredient(name: "마늘", amount: 0.020), Ingredient(name: "양파", amount: 0.050)], steps: [Step(imageDescription: nil, textInstructions: "1"), Step(imageDescription: nil, textInstructions: "2"), Step(imageDescription: nil, textInstructions: "3")], favorite: false, section: .korean),
            Recipe(dishName: "제육볶음", thumbnail: recipeListViewModel.getImagePath("제육볶음"), iIngredients: [Ingredient(name: "돼지고기", amount: 0.350)], oIngredients: [Ingredient(name: "마늘", amount: 0.020), Ingredient(name: "양파", amount: 0.050), Ingredient(name: "당근", amount: 0.050)], steps: [Step(imageDescription: nil, textInstructions: "하나"), Step(imageDescription: nil, textInstructions: "둘"), Step(imageDescription: nil, textInstructions: "셋")], favorite: true, section: .korean),
            Recipe(dishName: "광어초밥", thumbnail: recipeListViewModel.getImagePath("광어초밥"), iIngredients: [Ingredient(name: "밥", amount: 0.350)], oIngredients: [Ingredient(name: "겨자", amount: 0.020)], steps: [Step(textInstructions: "원"), Step(textInstructions: "투"), Step(textInstructions: "쓰리")], favorite: true, section: .japanese),
            Recipe(dishName: "스테이크", thumbnail: recipeListViewModel.getImagePath("스테이크"), iIngredients: [Ingredient(name: "소고기", amount: 0.350)], oIngredients: [Ingredient(name: "버터", amount: 0.020), Ingredient(name: "후추", amount: 0.020)], steps: [Step(imageDescription: nil, textInstructions: "이"), Step(imageDescription: nil, textInstructions: "얼"), Step(imageDescription: nil, textInstructions: "싼")], favorite: true, section: .western)
        ]
        let _ = rs.map({ recipeListViewModel.addRecipe($0)})
        tableViewUpadate()
    }
    
    
    // Mark - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeListViewModel.loadTasks()
        
        
        // Delegate
        ListTableView.delegate = self
        
        // SearchBar
        searchVHeight = searchV.bounds.height
        resiedHeight = searchV.bounds.height  - searchVBottomConstraint.constant - searchBar.bounds.height
        
        // Indicator
        self.view.addSubview(self.activityIndicator)
        
        // CollectionView UIUpdate
        
        // Notification
        NotificationCenter.default.addObserver(self, selector: #selector(recommandingRecipes(_:)), name: Notification.Name("getTags"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changedFavorite(_:)), name: Notification.Name("changedFavorite"), object: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        tableViewUpadate()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // 데이터 쓰기
    }

    
//Mark - IBActions
    @IBAction func addRecipeButton(_ sender: Any) {
        let msg = "새로운 레시피를 등록하시겠습니까?"
        let title = "레시피 등록하기"
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "네", style: .default) {(action: UIAlertAction!) -> Void in
            self.tabBarController?.selectedIndex = 1
            
            NSLog(msg)
        }
        let cancelAction = UIAlertAction(title: "아니요", style: .default) {(action: UIAlertAction!) -> Void in
            NSLog(msg)
        }
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion:nil)
    }
    
    @IBAction func startSearching(_ sender: Any) {
        if taskMode {
            changeTaskMode()
            recipeListViewModel.emptySearchedList()
            tableViewUpadate()
        }
        let sb = UIStoryboard(name: "SearchingViewController", bundle: nil)
        guard let vc = sb.instantiateViewController(identifier: "SearchingViewController") as? SearchingViewController else {
            return
        }
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: false, completion: nil)
        
    }
    
    @IBAction func changedSort(_ sender: Any) {
        tableViewUpadate()
    }
    @IBAction func tapNavigatorView(_ sender: Any) {
        dismissKeyboard()
    }
    @IBAction func taskChangeB(_ sender: Any) {
        changeTaskMode()
        recipeListViewModel.emptySearchedList()
        tableViewUpadate()
    }
    
}
// Mark: - 각종 함수
extension ListViewController {
    // ChangeTaskMode
    func changeTaskMode() {
        if taskMode {   // 현재 : 조건 검색 완료 페이지
            changeViewState(current: taskMode)
            taskMode = !taskMode
        } else {        // 현재 : 기본 메인 페이지
            changeViewState(current: taskMode)
            taskMode = !taskMode
        }
    }
    
    // Seaching View UIControll
    func changeViewState(current: Bool) {
        current ?  appearSearchingView() : hideSearchingView()
    }
    func hideSearchingView() {
        searchVHeightConstraint.constant = resiedHeight

        searchBar.isHidden = !searchBar.isHidden
        //searchBar.isEnabled = !searchBar.isEnabled
        changeTaskB.isHidden = !changeTaskB.isHidden
        changeTaskB.isEnabled = !changeTaskB.isEnabled
        
        sortSC.isHidden = !sortSC.isHidden
        sortSC.isEnabled = !sortSC.isEnabled
        
        headTitleL.text = "Recommanded Recipes"
    }
    func appearSearchingView() {
        searchVHeightConstraint.constant = searchVHeight

        searchBar.isHidden = !searchBar.isHidden
        //searchBar.isEnabled = !searchBar.isEnabled
        changeTaskB.isHidden = !changeTaskB.isHidden
        changeTaskB.isEnabled = !changeTaskB.isEnabled
        
        sortSC.isHidden = !sortSC.isHidden
        sortSC.isEnabled = !sortSC.isEnabled
        
        headTitleL.text = "My Recipes"
    }
}
// Mark: - Notification 구현부
extension ListViewController {
    @objc func recommandingRecipes(_ notification: Notification) {
        let tags = notification.object as? [(Int, String)]
        let important:[String] = (tags?.filter({ $0.0 == 0 }).map({$0.1}))!
        let optional:[String] = (tags?.filter({ $0.0 == 1 }).map({$0.1}))!
        
        changeTaskMode()
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            DispatchQueue.main.async {
                activityIndicator.startAnimating()
            }
            self.recipeListViewModel.recommandingRecipe(important, optional)
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
                tableViewUpadate()
            }
        }
    }
    @objc func changedFavorite(_ notification: Notification) {
        let recipe = notification.object as! Recipe
        
        recipeListViewModel.updateRecipe(recipe)
        
        tableViewUpadate()
    }
}

//Mark - TableView DataSource
extension ListViewController: UITableViewDataSource {
    func tableViewUpadate() {
        ListTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if taskMode {
            return recipeListViewModel.searchedAllRecipes.count
        } else {
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
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        
        var recipe: Recipe
        
        recipe = recipeListViewModel.baseAllRecipes[indexPath.row]
        if taskMode {
            recipe = recipeListViewModel.searchedAllRecipes[indexPath.row]
        } else {
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
        
        var recipe: Recipe
        
        if taskMode {
            recipe = recipeListViewModel.searchedAllRecipes[indexPath.row]
        } else {
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
        }

        
        let sb = UIStoryboard(name: "RecipeViewController", bundle: nil)
        guard let vc = sb.instantiateViewController(identifier: "RecipeViewController") as? RecipeViewController else {
            return
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
