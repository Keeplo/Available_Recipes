//
//  RecipeViewController.swift
//  Generous_Recipe
//
//  Created by Yongwoo Marco on 2020/10/20.
//

import UIKit

class RecipeViewController: UIViewController {
    @IBOutlet weak var dishName: UILabel!
    @IBOutlet weak var thumbNail: UIImageView!
    
    var name: String = ""
    var image: UIImage? = nil
    var important: [Ingredient] = []
    var optional: [Ingredient] = []
    var steps: [Step] = []
    var favorite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dishName.text = name
        thumbNail.image = image
    }
    
    func update(_ recipe: Recipe) {
        name = recipe.dishName
        image = recipe.thumbnail?.getPhoto()
        important = recipe.IIngredients
        optional = recipe.OIngredients
        steps = recipe.steps
        favorite = recipe.favorite
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
