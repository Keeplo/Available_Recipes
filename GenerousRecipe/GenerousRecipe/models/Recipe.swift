//
//  Recipe.swift
//  GenerousRecipe
//
//  Created by James Kim on 8/5/20.
//  Copyright © 2020 FastCampus. All rights reserved.
//

import UIKit

struct Recipe: Codable, Equatable {
    var dishName: String
    let thumbnail: ImageData?
    let IIngredients: [Ingredient] // important ingredients
    let OIngredients: [Ingredient] // optional ingredients
    let steps: [Step]
    var favorite: Bool? = false
    var section: Section? = .nokind
    
    func containsAllIngrdients(_ ingredients: [Ingredient]) -> Bool {
        // TODO: 나중에 필터로 재료로 레시피를 찾을때 이용하면 편할 함수입니다.
        return true
    }
    mutating func update() {
        
    }
    
    
    // TODO: json에 저장할떄 이용해주세요.
    var toJSON: [String:Any] {
        return [
            "dishName": String(),
            "thumbnail": (Any).self,
            "important": [Any](),
            "optional": [Any](),
            "steps": [Any](),
            "favorite": Bool(),
            "section": Any.self
        ]
    }
    
//    static func instance(from json: [String:Any]) -> Recipe {
//        // JSON에서 객체를 만들떄 써주세요.
//        return Recipe(dishName: json["dishName"], thumbnail: json["thumbnail"], IIngredients: json["important"], OIngredients: json["optional"], steps: json["steps"], favorite: json["favorite"], section: json["section"])
//    }
    
    static func == (leftRecipeName: Self, rightRecipeName: Self) -> Bool {
        // ++TODO: 동등 조건 추가
        return leftRecipeName.dishName == rightRecipeName.dishName
    }
}

class RecipeManager {
    static let shared = RecipeManager()
    static var lastDishName: String = ""
    
    var baseRecipes: [Recipe] = []
    var searchedRecipes: [Recipe] = []
    
    func createRecipe(dishName: String, thumbnail: ImageData?, IIngredients: [Ingredient], OIngredients: [Ingredient], steps: [Step], favorite: Bool?, section: Section) -> Recipe {
        return Recipe(dishName: dishName, thumbnail: thumbnail, IIngredients: IIngredients, OIngredients: OIngredients, steps: steps, favorite: favorite, section: nil)
    }
    
    func addRecipe(_ recipe: Recipe) {
        baseRecipes.append(recipe)
        saveRecipe()
    }

    func deleteRecipe(_ recipe: Recipe) {
        /*if let index = recipes.firstIndex(of recipe) {
            recipes.remove(at: index)
        }
        */
        Storage.store(baseRecipes, to: .documents, as: "recipes.json")
    }
    
    func updateRecipe(_ recipe: Recipe) {
        guard let index = baseRecipes.firstIndex(of: recipe) else { return }
        baseRecipes[index].update()

        saveRecipe()
    }
    
    func saveRecipe() {
        Storage.store(baseRecipes, to: .documents, as: "recipes.json")
    }
    
    func retrieveRecipe(){
        baseRecipes = Storage.retrive("recipes.json", from: .documents, as: [Recipe].self) ?? []

//        let lastDishName = recipes.last?.dishName ?? ""
//        RecipeManager.lastDishName = lastDishName
    }
    func searchingDishName(_ name: String) {
        let foundRecipes = baseRecipes.filter({ $0.dishName.contains(name) })
        searchedRecipes = foundRecipes
    }
    func searchingImportantRecipe(_ tags: [String]) {
        var checkRecipes: [Recipe] = []
        for tag in tags {
        }
    }
    func searchingOptionalRecipe(_ tags: [String]) {
        var checkRecipes: [Recipe] = []
        for tag in tags {
        }
    }
    func emptySearchedList() {
        searchedRecipes.removeAll()
    }
}


class RecipeViewModel {
    enum Section: Int, CaseIterable {
        case korean
        case japanese
        case chinese
        case western
        
        var title: String {
            switch self {
            case .korean: return "한식"
            case .japanese: return "일식"
            case .chinese: return "중식"
            case .western: return "양식"
            default: return ""
            }
        }
    }
    
    private let manager = RecipeManager.shared // 상글톤
    
    var baseRecipes: [Recipe] {
        return manager.baseRecipes
    }
    var searchedRecipes: [Recipe] {
        return manager.searchedRecipes
    }
    
    var baseAllRecipes: [Recipe] {
        return baseRecipes
    }
    var baseFavoriteRecipes: [Recipe] {
        return baseRecipes.filter { $0.favorite == true }
    }
    
    var searchedAllRecipes: [Recipe] {
        return searchedRecipes
    }
    var searchedFavoriteRecipes: [Recipe] {
        return searchedRecipes.filter { $0.favorite == true }
    }
    
    var numOfSection: Int {
        return Section.allCases.count
    }
    
    func addRecipe(_ recipe: Recipe) {
        manager.addRecipe(recipe)
    }
    
    func deleteRecipe(_ recipe: Recipe) {
        manager.deleteRecipe(recipe)
    }
    
    func updateRecipe(_ recipe: Recipe) {
        manager.updateRecipe(recipe)
    }
    
    func loadTasks() {
        manager.retrieveRecipe()
    }
    func searchingDishName(name: String) {
        manager.searchingDishName(name)
    }
    func searchingImportantRecipe(ingredients tags: [String]) {
        manager.searchingImportantRecipe(tags)
    }
    func searchingOptionalRecipe(ingredients tags: [String]) {
        manager.searchingOptionalRecipe(tags)
    }
    func emptySearchedList() {
        manager.emptySearchedList()
    }
}

