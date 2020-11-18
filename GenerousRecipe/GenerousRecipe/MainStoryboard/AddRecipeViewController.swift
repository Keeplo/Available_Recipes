//
//  AddRecipeViewController.swift
//  Generous_Recipe
//
//  Created by Yongwoo Marco on 2020/10/19.
//

import UIKit

class AddRecipeViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var storeB: UIButton!
    @IBOutlet weak var initB: UIButton!
    
    @IBOutlet weak var inputDishNameTF: UITextField!
    
    @IBOutlet weak var inputThumbnailView: UIView!
    @IBOutlet weak var inputThumbnailImageView: UIImageView!
    @IBOutlet weak var changePhotoB: UIButton!
    @IBOutlet weak var deletePhotoB: UIButton!
    
    @IBOutlet weak var dishStyleTF: UITextField!
    
    @IBOutlet weak var importantSV: UIStackView!
    @IBOutlet weak var importantV: UIView!
    
    @IBOutlet weak var optionalSV: UIStackView!
    @IBOutlet weak var optionalV: UIView!
    
    @IBOutlet weak var stepsSV: UIStackView!
    @IBOutlet weak var stepV: UIView!
    
    @IBOutlet weak var favoriteSwitch: UISwitch!
    
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    let basicStandardHeight: CGFloat = 45
    var importantStackViewHeight: CGFloat {
        print("importantStackViewHeight \(CGFloat(basedRecipe.iIngredients.count+1) * basicStandardHeight)")
        return CGFloat(basedRecipe.iIngredients.count+1) * basicStandardHeight
    }
    var optionalStackViewHeight: CGFloat {
        print("optionalStackViewHeight \(CGFloat(basedRecipe.oIngredients.count+1) * basicStandardHeight)")
        return CGFloat(basedRecipe.oIngredients.count+1) * basicStandardHeight
    }
    var stepsStackViewHeight:CGFloat {
        print("stepsStackViewHeight \(CGFloat(basedRecipe.steps.count+1) * stepV.bounds.height)")
        return CGFloat(basedRecipe.steps.count+1) * stepV.bounds.height
    }
    
    enum Sections {
        case recipename
        case thumnail
        case section
        case importtant
        case optional
        case steps
        case favorite
    }
    
    private let styles: [(Styles,String)] = [(.korean, "한식"), (.japanese, "일식"), (.chinese, "중식"), (.western, "양식"), (.nokind, "기타")]
    private let sections: [(Sections,String)] = [ (.recipename,"Dish Name"), (.thumnail, "Dish Thumbnail"), (.section, "Dish Style"), (.importtant, "Important Ingredients"), (.optional, "Optional Ingredients"), (.steps, "Cooking Steps"), (.favorite, "Favorite")]
    
    
    var basedRecipe = Recipe(dishName: "", thumbnail: nil, iIngredients: [], oIngredients: [], steps: [], favorite: false, section: .nokind)

    override func viewDidLoad() {
        super.viewDidLoad()
                
        let stylePicker = UIPickerView()
        stylePicker.delegate = self
        dishStyleTF.inputView = stylePicker
    }

    @IBAction func initializationButton(_ sender: Any) {
        let alert = UIAlertController(title: "초기화", message: "입력 중인 내용을 모두 초기화 하시겠습니까? 삭제된 자료는 복구 되지 않습니다.", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "초기화", style: .default) { [self] (action: UIAlertAction!) -> Void in
            // 초기화 하기
            inputDishNameTF.text = ""
            inputThumbnailImageView.image = nil
            dishStyleTF.text = ""
            
            basedRecipe.iIngredients = []
            basedRecipe.oIngredients = []
            basedRecipe.steps = []
            
            
            NSLog("초기화 완료")
        }
        let cancelAction = UIAlertAction(title: "취소", style: .default) {(action: UIAlertAction!) -> Void in
            NSLog("초기화 취소")
        }
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion:nil)
    }
    
    @IBAction func addingNewRecipe(_ sender: Any) {
        let alert = UIAlertController(title: "레시피 추가", message: "입력하신 레시피를 등록 하시겠습니까?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "추가하기", style: .default) { [self] (action: UIAlertAction!) -> Void in
            // 추가 하기
            do {
                if let text = dishStyleTF.text {
                    basedRecipe.dishName = text
                } else { print("입력된 요리이름 없음") }
                //basedRecipe.thumbnail =
                
            }
            
            catch {
                
            }
            NSLog("레시피추가 완료")
        }
        let cancelAction = UIAlertAction(title: "취소", style: .default) {(action: UIAlertAction!) -> Void in
            NSLog("레시피추가 취소")
        }
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion:nil)
    }
    
}

// Mark: - 각종 메소드
extension AddRecipeViewController {
    func resizingMainStackView() {
        let width:CGFloat = self.view.bounds.width
        let height:CGFloat = basicStandardHeight * 10 + importantStackViewHeight + optionalStackViewHeight + stepsStackViewHeight + inputThumbnailView.bounds.height
        print("mainScrollView width: \(width) / height: \(height)")
        
        mainScrollView.contentSize = CGSize(width: width, height: height)
    }
}


// Mark: - PickerView
extension AddRecipeViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return styles.count
    }
}
extension AddRecipeViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return styles[row].1
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        dishStyleTF.text = styles[row].1
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
