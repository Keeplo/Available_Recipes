//
//  Todo.swift
//  TodoList
//
//  Created by joonwon lee on 2020/03/19.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit
/*

// ++TODO: Codable과 Equatable 추가
struct Recipe: Codable, Equatable {
    let id: Int
    var globalId: Int?              // 외부
    var isMyFavorite: Bool
    var recipeName: String          // ex: "김치찌개" / "된장찌개"
    var group: String
    var stepsDetail: [String]       // index 순서 = 요리 순서
    var date: DateFormatter
    
    mutating func update(isDone: Bool, detail: String, isToday: Bool) {
        
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        // ++TODO: 동등 조건 추가
        return lhs.id == rhs.id
    }
}

class RecipeManager {
    
    static let shared = RecipeManager()
    
    static var lastId: Int = 0
    
    var recipes: [Recipe] = []
    
    func createRecipe(detail: String, isToday: Bool) -> Recipe {
        // ++TODO: create로직 추가
        let nextId = RecipeManager.lastId + 1
        RecipeManager.lastId = nextId
        return Todo(id: nextId, isDone: false, detail: detail, isToday: isToday)
    }
    
    func addRecipe(_ recipe: Recipe) {
        // ++TODO: add로직 추가
        recipes.append(recipe)
        saveTodo()
    }
    
    func deleteRecipe(_ recipe: Recipe) {
        // ++TODO: delete 로직 추가
        recipes = recipes.filter({ existingTodo in // { $0.id != todo.id }
            print("filter 작동")
            print("existingTodo.id  \(existingTodo.id )")
            print("todo.id  \(recipe.id )")
            return existingTodo.id != recipe.id
        }) // 방대한 데이터가 아니기에 사용
        
        /*if let index = todos.firstIndex(of: todo) {
            todos.remove(at: index)
        }*/
        
        Storage.store(recipes, to: .documents, as: "todos.json")
    }
    
    func updateRecipe(_ recipe: Recipe) {
        // ++TODO: updatee 로직 추가
        guard  let index = recipes.firstIndex(of: recipe) else { return }
        recipes[index].update(isDone: recipe.isDone, detail: recipe.detail, isToday: recipe.isToday)
        saveTodo()
    }
    
    func saveTodo() {
        Storage.store(recipes, to: .documents, as: "todos.json")
    }
    
    func retrieveTodo() {
        recipes = Storage.retrive("todos.json", from: .documents, as: [Recipe].self) ?? []
        
        let lastId = recipes.last?.id ?? 0
        RecipeManager.lastId = lastId
    }
}

class TodoViewModel {
    
    enum Section: Int, CaseIterable {
        case today
        case upcoming
        
        var title: String {
            switch self {
            case .today: return "Today"
            default: return "Upcoming"
            }
        }
    }
    
    private let manager = RecipeManager.shared // 상글톤
    
    var recipes: [Recipe] {
        return manager.recipes
    }
    
    var localRecipes: [Recipe] {
        return recipes.filter { $0.isToday == true }
    }
    
//    var globalRecipes: [Recipe] {
//        return todos.filter { $0.isToday == false }
//    }
    
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
}

*/
