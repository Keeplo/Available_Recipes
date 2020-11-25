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
    @IBOutlet weak var scrollViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var inputDishNameTF: UITextField!
    
    @IBOutlet weak var inputThumbnailView: UIView!
    @IBOutlet weak var inputThumbnailImageView: UIImageView!
    @IBOutlet weak var changePhotoB: UIButton!
    @IBOutlet weak var deletePhotoB: UIButton!
    
    @IBOutlet weak var dishStyleTF: UITextField!
    
    
    @IBOutlet weak var importantViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var importantSV: UIStackView!
    @IBOutlet weak var importantV: UIView!
    
    @IBOutlet weak var importantTFsSV: UIStackView!
    @IBOutlet weak var importantNameTF: UITextField!
    @IBOutlet weak var importantAmountTF: UITextField!
    @IBOutlet weak var importantDeleteB: UIButton!
    
    
    @IBOutlet weak var optionalSV: UIStackView!
    @IBOutlet weak var optionalV: UIView!
    
    @IBOutlet weak var stepsSV: UIStackView!
    @IBOutlet weak var stepV: UIView!
    
    @IBOutlet weak var favoriteSwitch: UISwitch!
    
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    // 이미지 처리
    let imageFileManager = ImageFileManager()
    
    
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
    
    let stylePicker = UIPickerView()
    let photoPicker = UIImagePickerController()
    
    var currentImageView = UIImageView()
    
    enum Sections {
        case recipename
        case thumnail
        case section
        case importtant
        case optional
        case steps
        case favorite
    }
    enum ViewStyles {
        case important
        case optional
        case step
    }
    
    private let styles: [(Styles,String)] = [(.korean, "한식"), (.japanese, "일식"), (.chinese, "중식"), (.western, "양식"), (.nokind, "기타")]
    private let sections: [(Sections,String)] = [ (.recipename,"Dish Name"), (.thumnail, "Dish Thumbnail"), (.section, "Dish Style"), (.importtant, "Important Ingredients"), (.optional, "Optional Ingredients"), (.steps, "Cooking Steps"), (.favorite, "Favorite")]
    
    
    var basedRecipe = Recipe(dishName: "", thumbnail: nil, iIngredients: [], oIngredients: [], steps: [], favorite: false, section: .nokind)

    override func viewDidLoad() {
        super.viewDidLoad()
                
        stylePicker.delegate = self
        photoPicker.delegate = self
        
        dishStyleTF.inputView = stylePicker
    }

    
    // Mark: - IBActions
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
//        if !dishStyleTF.text!.isEmpty, inputThumbnailImageView.image != nil, !dishStyleTF.text!.isEmpty,  {
//            
//        } else {
//            let alert = UIAlertController(title: "레시피 추가", message: "입력하신 레시피를 등록 하시겠습니까?", preferredStyle: .alert)
//            let confirmAction = UIAlertAction(title: "추가하기", style: .default) { [self] (action: UIAlertAction!) -> Void in
//                
//                
//                NSLog("레시피추가 완료")
//            }
//            let cancelAction = UIAlertAction(title: "취소", style: .default) {(action: UIAlertAction!) -> Void in
//                NSLog("레시피추가 취소")
//            }
//            alert.addAction(confirmAction)
//            alert.addAction(cancelAction)
//
//            present(alert, animated: true, completion:nil)
//        }
    }
    @IBAction func addThumbnail(_ sender: Any) {
        let alert =  UIAlertController(title: "썸네일 추가", message: "추가할 사진을 선택해주세요", preferredStyle: .actionSheet)

        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in
            self.currentImageView = self.inputThumbnailImageView
            self.openLibrary()
        }

        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
            self.currentImageView = self.inputThumbnailImageView
            self.openCamera()
        }

        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func deleteThumbnail(_ sender: Any) {
        self.currentImageView = self.inputThumbnailImageView
        if currentImageView.image == nil {
            print("사진이 없습니다.")
        } else {
            let alert = UIAlertController(title: "썸네일 삭제", message: "추가된 썸네일을 삭제 하시겠습니까?", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "삭제하기", style: .default) { [self] (action: UIAlertAction!) -> Void in
                // 삭제하기
                currentImageView.image = nil
                
                NSLog("썸네일삭제 완료")
            }
            let cancelAction = UIAlertAction(title: "취소", style: .default) {(action: UIAlertAction!) -> Void in
                NSLog("썸네일삭제 취소")
            }
            alert.addAction(confirmAction)
            alert.addAction(cancelAction)

            present(alert, animated: true, completion:nil)
        }
    }
    @IBAction func addImportant(_ sender: Any) {
        addViewResizing(.important)
                
        let stack = importantSV
        let index = stack!.arrangedSubviews.count
        
        let newView = createEntry(index)
        newView.isHidden = true
        
        stack!.insertArrangedSubview(newView, at: index)
        
        print("stack Subviews count \(String(describing: stack?.subviews.count))")
        print("newView index \(newView.tag)")
        print("index \(index)")
        
        UIView.animate(withDuration: 0.25) { () -> Void in
            newView.isHidden = false
        }
    }
    @IBAction func deleteImportant(_ sender: Any) {
        print("importantSV.subview.count \(importantSV.subviews.count)")
        if importantSV.subviews.count > 1 {
            deleteStackView(.important)
            deleteViewResizing(.important)
        } else {
            print("입력 뷰 마지막 1개")
        }
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
    private func createEntry(_ index: Int) -> UIView {
        let newView = UIStackView()
        newView.tag = index

        let secondStack = UIStackView()
        
        var nameTF = UITextField()
        var amountTF = UITextField()
        
        nameTF. = importantNameTF.copy()
        amountTF = importantAmountTF.copy() as! UITextField
        
        secondStack.addArrangedSubview(nameTF)
        secondStack.addArrangedSubview(amountTF)
        
//        secondStack.frame(forAlignmentRect: CGRect(x: importantTFsSV.frame.minX, y: importantTFsSV.frame.minY, width: importantTFsSV.frame.width, height: importantTFsSV.frame.height))
//
//        secondStack.sizeToFit()
        secondStack.spacing = 8
        secondStack.distribution = .fillEqually
        
        newView.addArrangedSubview(secondStack)
        
        NSLayoutConstraint.init(item: secondStack, attribute: .top, relatedBy: .equal, toItem: secondStack.superview, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint.init(item: secondStack, attribute: .bottom, relatedBy: .equal, toItem: secondStack.superview, attribute: .bottom, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint.init(item: secondStack, attribute: .leading, relatedBy: .equal, toItem: secondStack.superview, attribute: .leading, multiplier: 1.0, constant: 8.0).isActive = true
        NSLayoutConstraint.init(item: secondStack, attribute: .trailing, relatedBy: .equal, toItem: secondStack.superview, attribute: .trailing, multiplier: 1.0, constant: 8.0).isActive = true

        newView.frame(forAlignmentRect: CGRect(x: importantV.frame.minX, y: importantV.frame.minY, width: importantV.frame.width, height: importantV.frame.height))
        
        return newView
    }
    func deleteStackView(_ style: ViewStyles) {
        switch style {
        case .important:
            if let view = importantSV.subviews.last {
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    view.isHidden = true
                }, completion: { (success) -> Void in
                    view.removeFromSuperview()
                })
            }
        case .optional:
            break
        case .step:
            break
        }
    }
    func addViewResizing(_ style: ViewStyles) {
        switch style {
        case .important :
            let newHeight = importantSV.bounds.height + basicStandardHeight
            importantViewConstraint.constant = newHeight
            scrollViewConstraint.constant += basicStandardHeight
        case .optional :
            break
        case .step :
            break
        }
    }
    func deleteViewResizing(_ style: ViewStyles) {
        switch style {
        case .important :
            let newHeight = importantSV.bounds.height - basicStandardHeight
            importantViewConstraint.constant = newHeight
            scrollViewConstraint.constant -= basicStandardHeight
        case .optional :
            break
        case .step :
            break
        }
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

// Mark: - UIImagePickerControllerDelegate
extension AddRecipeViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // Mark: - Camera 접근
    func openLibrary() {
        photoPicker.sourceType = .photoLibrary
        present(photoPicker, animated: false, completion: nil)
    }
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            photoPicker.sourceType = .camera
            present(photoPicker, animated: false, completion: nil)
        } else {
            print("Camera not available")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            currentImageView.image = image
        } else {
            print("사진불러오기 실패")
        }
        
        dismiss(animated: true, completion: nil)
    }
}
