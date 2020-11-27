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
    
    // DishName Properties tag : 100
    @IBOutlet weak var inputDishNameTF: UITextField!
    
    // Thumbnail Properties tag : 200
    @IBOutlet weak var inputThumbnailView: UIView!
    @IBOutlet weak var inputThumbnailImageView: UIImageView!
    @IBOutlet weak var changePhotoB: UIButton!
    @IBOutlet weak var deletePhotoB: UIButton!
    
    // Category Properties tag : 300
    @IBOutlet weak var dishStyleTF: UITextField!
    
    // Importants Properties tag : 300
    @IBOutlet weak var importantViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var importantSV: UIStackView!
    @IBOutlet weak var importantV: UIView!
    
    @IBOutlet weak var importantTFsSV: UIStackView!
    @IBOutlet weak var importantNameTF: UITextField!
    @IBOutlet weak var importantAmountTF: UITextField!
    
    // Optionals Properties tag : 400
    @IBOutlet weak var optionalViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var optionalSV: UIStackView!
    @IBOutlet weak var optionalV: UIView!
    
    // Steps Properties tag : 500
    @IBOutlet weak var stepViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var stepsSV: UIStackView!
    @IBOutlet weak var stepV: UIView!
    
    @IBOutlet weak var stepImageView: UIView!
    @IBOutlet weak var imageWarningLabel: UILabel!
    @IBOutlet weak var stepImage: UIImageView!
    
    @IBOutlet weak var addStepImageB: UIButton!
    @IBOutlet weak var deleteStepImageB: UIButton!
    
    @IBOutlet weak var stepStack: UIStackView!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var stepTextView: UITextView!
    
    
    @IBOutlet weak var favoriteSwitch: UISwitch!
    
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    // 이미지 처리
    let imageFileManager = ImageFileManager()

    // 유동적인 UI조절
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
    var currentTag = 0

    override func viewDidLoad() {
        super.viewDidLoad()
                
        stylePicker.delegate = self
        photoPicker.delegate = self
        
        dishStyleTF.inputView = stylePicker
        
        // Add Target
        addStepImageB.tag = 510
        addStepImageB.addTarget(self, action: #selector(addStepPhoto(sender:)), for: .touchUpInside)
        deleteStepImageB.tag = 520
        deleteStepImageB.addTarget(self, action: #selector(deleteStepPhoto(sender:)), for: .touchUpInside)
        
        // Add Tag
        stepImage.tag = 500
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
        appendDatas()
    }
    @IBAction func addThumbnail(_ sender: Any) {
        self.currentImageView = self.inputThumbnailImageView
        addImage(title: "썸네일 추가", msg: "추가할 썸네일을 선택해주세요")
    }
    @IBAction func deleteThumbnail(_ sender: Any) {
        self.currentImageView = self.inputThumbnailImageView
        deleteImage(title: "썸네일 삭제", msg: "추가된 썸네일을 삭제 하시겠습니까?")
    }
    @IBAction func addImportant(_ sender: Any) {
        addViewResizing(.important)
                
        let index = importantSV.arrangedSubviews.count
        
        let newView = createEntry(index, .important)
        newView.isHidden = true

        importantSV.insertArrangedSubview(newView, at: index)
        
//        print("stack Subviews count \(String(describing: importantSV.subviews.count))")
//        print("newView index \(newView.tag)")
//        print("index \(index)")
//
        UIView.animate(withDuration: 0.25) { () -> Void in
            newView.isHidden = false
        }
    }
    @IBAction func deleteImportant(_ sender: Any) {
        if importantSV.subviews.count > 1 {
            deleteStackView(.important)
            deleteViewResizing(.important)
        } else {
            print("입력 뷰 마지막 1개")
        }
    }
    @IBAction func addOptional(_ sender: Any) {
        addViewResizing(.optional)
        
        let index = optionalSV.arrangedSubviews.count
        
        let newView = createEntry(index, .optional)
        newView.isHidden = true

        optionalSV.insertArrangedSubview(newView, at: index)

        UIView.animate(withDuration: 0.25) { () -> Void in
            newView.isHidden = false
        }
    }
    @IBAction func deleteOptional(_ sender: Any) {
        if optionalSV.subviews.count > 1 {
            deleteStackView(.optional)
            deleteViewResizing(.optional)
        } else {
            print("입력 뷰 마지막 1개")
        }
    }
    @objc func addStepPhoto(sender: UIButton) {
        currentTag = sender.tag-10
        if let selectedImageView = self.view.viewWithTag(sender.tag-10) as? UIImageView {
            self.currentImageView = selectedImageView
        } else {
            print("\(sender.tag-10) 객체 못찾음")
        }
        addImage(title: "단계 사진 추가", msg: "추가할 사진을 선택해주세요")
    }
    @objc func deleteStepPhoto(sender: UIButton) {
        currentTag = sender.tag-20
        if let selectedImageView = self.view.viewWithTag(sender.tag-20) as? UIImageView {
            self.currentImageView = selectedImageView
        } else {
            print("\(sender.tag-20) 객체 못찾음")
        }
        deleteImage(title: "단계 사진 삭제", msg: "추가된 사진을 삭제 하시겠습니까?")
    }

    @IBAction func addStep(_ sender: Any) {
        addViewResizing(.step)
        
        let index = stepsSV.arrangedSubviews.count
        
        let newView = createEntry(index, .step)
        newView.isHidden = true

        stepsSV.insertArrangedSubview(newView, at: index)

        UIView.animate(withDuration: 0.25) { () -> Void in
            newView.isHidden = false
        }
    }
    @IBAction func deleteStep(_ sender: Any) {
        if stepsSV.subviews.count > 1 {
            deleteStackView(.step)
            deleteViewResizing(.step)
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
    private func createEntry(_ index: Int, _ style: ViewStyles) -> UIView {
        switch style {
        case .step:
            let newView = UIStackView()
            
            let newImageView = UIView()
            let newImage = UIImageView()
            let newWarning = UILabel()
            
            let secondStack = UIStackView()
            let newStepNum = UILabel()
            let newStepDetail = UITextView()
            
            // newImageView Constraint
            // height 119 / aspect 1:1 / top 8 / leading 8
        
            newWarning.text = "사진을 추가해주세요"
            newWarning.font = .systemFont(ofSize: 20, weight: .bold)
            newWarning.textAlignment = .center
            newWarning.numberOfLines = 0
            newWarning.textColor = #colorLiteral(red: 1, green: 0.5741140246, blue: 0.4397957921, alpha: 1)
            
            newImageView.addSubview(newWarning)
            newImageView.addSubview(newImage)
            
            newImageView.translatesAutoresizingMaskIntoConstraints = false
            
            // newWarning Constraint
            // every 0 superview
            // newImage
            // every 0 superview
            
            secondStack.distribution = .fill
            secondStack.spacing = 8
            secondStack.backgroundColor = #colorLiteral(red: 1, green: 0.5741140246, blue: 0.4397957921, alpha: 1)
            
            newStepNum.text = "Step \(index+1)."
            newStepNum.textColor = .white
            newStepNum.font = .systemFont(ofSize: 17, weight: .bold)
            newStepNum.textAlignment = .center
            
            newStepDetail.text = "설명을 작성하세요"
            
            secondStack.backgroundColor = #colorLiteral(red: 1, green: 0.5742712021, blue: 0.4398984909, alpha: 1)
            secondStack.axis = .vertical
            secondStack.addArrangedSubview(newStepNum)
            secondStack.addArrangedSubview(newStepDetail)
            
            // secondStack Constraint
            // newImageView Leading 8
            // superview top trailing bottom 8
            
            newView.alignment = .fill
            newView.spacing = 8
            
            newView.addArrangedSubview(newImageView)
            newView.addArrangedSubview(secondStack)
            
            return newView
            
        default:
            let newView = UIStackView()
    //        newView.tag = index
            let secondStack = UIStackView()
    //        secondStack.tag = index+100
            let nameTF = UITextField()
            let amountTF = UITextField()
            
            nameTF.borderStyle = .roundedRect
            nameTF.textAlignment = .center
            nameTF.font = .systemFont(ofSize: 14, weight: .regular)
            nameTF.placeholder = "재료이름을 입력하세요"
    //        nameTF.tag = index+200
            amountTF.borderStyle = .roundedRect
            amountTF.textAlignment = .center
            amountTF.font = .systemFont(ofSize: 14, weight: .regular)
            amountTF.placeholder = "수량을 입력하세요 (단위 g)"
    //        amountTF.tag = index+300
            secondStack.addArrangedSubview(nameTF)
            secondStack.addArrangedSubview(amountTF)

            secondStack.spacing = 8
            secondStack.distribution = .fillEqually
            
            newView.addArrangedSubview(secondStack)

    //        secondStack.translatesAutoresizingMaskIntoConstraints = false
    //        newView.translatesAutoresizingMaskIntoConstraints = false
            
    //        let leadingCons = NSLayoutConstraint(item: secondStack, attribute: .leading, relatedBy: .equal, toItem: newView, attribute: .leading, multiplier: 1.0, constant: 8.0)
    //        let trailingCons = NSLayoutConstraint(item: secondStack, attribute: .trailing, relatedBy: .equal, toItem: newView, attribute: .trailing, multiplier: 1.0, constant: 8.0)
    //
    //        let topCons = secondStack.topAnchor.constraint(equalTo: newView.topAnchor)
    //        let bottomCons = secondStack.bottomAnchor.constraint(equalTo: newView.bottomAnchor)
    //
    ////        let ConsArray = [leadingCons, trailingCons, topCons, bottomCons]
    //        let ConsArray = [trailingCons, topCons, bottomCons]
    //        NSLayoutConstraint.activate(ConsArray)
        
            return newView
        }
    }
    func appendDatas() {
        var importants: [Ingredient] = []
        var optionals: [Ingredient] = []
        var steps: [Step] = []
        
        for index in 0..<importantSV.subviews.count {

            guard let nameTF = importantSV.subviews[index].subviews[0].subviews[0] as? UITextField else {
                print("error 1-1"); return
            }
            guard let amountTF = importantSV.subviews[index].subviews[0].subviews[1] as? UITextField else {
                print("error 2-1"); return
            }

            importants.append(Ingredient(name: nameTF.text!, amount: Float(amountTF.text!)!))
        }
        for index in 0..<optionalSV.subviews.count {
            guard let nameTF = optionalSV.subviews[index].subviews[0].subviews[0] as? UITextField  else {
                print("error 2-1"); return
            }
            guard let amountTF = optionalSV.subviews[index].subviews[0].subviews[1] as? UITextField else {
                print("error 2-2"); return
            }

            optionals.append(Ingredient(name: nameTF.text!, amount: Float(amountTF.text!)!))
        }
        for index in 0..<importantSV.subviews.count {
//            guard let stepImage = stepsSV.subviews[index].subviews[0].subviews[0] as? UIImageView  else {
//                print("error 3-1"); return
//            }
//            guard let detail = stepsSV.subviews[index].subviews[0].subviews[1] as? UITextFieldView else {
//                print("error 3-2"); return
//            }
//
//
//            importants.append(Step(imageDescription: , textInstructions: <#T##String#>))
        }

        
//        let thumbnail = inputThumbnailImageView.image
//        let
        print("--> importants : \(importants)")
        print("--> optionals : \(optionals)")
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
            if let view = optionalSV.subviews.last {
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    view.isHidden = true
                }, completion: { (success) -> Void in
                    view.removeFromSuperview()
                })
            }
        case .step:
            if let view = stepsSV.subviews.last {
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    view.isHidden = true
                }, completion: { (success) -> Void in
                    view.removeFromSuperview()
                })
            }
        }
    }
    func addViewResizing(_ style: ViewStyles) {
        switch style {
        case .important :
            let newHeight = importantSV.bounds.height + basicStandardHeight
            importantViewConstraint.constant = newHeight
            scrollViewConstraint.constant += basicStandardHeight
        case .optional :
            let newHeight = optionalSV.bounds.height + basicStandardHeight
            optionalViewConstraint.constant = newHeight
            scrollViewConstraint.constant += basicStandardHeight
        case .step :
            let newHeight = stepsSV.bounds.height + basicStandardHeight*3
            stepViewConstraint.constant = newHeight
            scrollViewConstraint.constant += basicStandardHeight*3
        }
    }
    func deleteViewResizing(_ style: ViewStyles) {
        switch style {
        case .important :
            let newHeight = importantSV.bounds.height - basicStandardHeight
            importantViewConstraint.constant = newHeight
            scrollViewConstraint.constant -= basicStandardHeight
        case .optional :
            let newHeight = optionalSV.bounds.height - basicStandardHeight
            optionalViewConstraint.constant = newHeight
            scrollViewConstraint.constant -= basicStandardHeight
        case .step :
            let newHeight = stepsSV.bounds.height - basicStandardHeight*3
            stepViewConstraint.constant = newHeight
            scrollViewConstraint.constant -= basicStandardHeight*3
        }
    }
    func addImage(title: String, msg: String) {
        let alert =  UIAlertController(title: title, message: msg, preferredStyle: .actionSheet)
        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in
            self.openLibrary()
            NSLog("사진추가 완료")
        }
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
            self.openCamera()
            NSLog("사진추가 완료")
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    func deleteImage(title: String, msg: String) {
        if currentImageView.image == nil {
            print("사진이 없습니다.")
        } else {
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "삭제하기", style: .default) { [self] (action: UIAlertAction!) -> Void in
                currentImageView.image = nil
                NSLog("사진삭제 완료")
                if currentTag >= 500 {
                    self.splitStepBottonsState(tag: currentTag)
                }
            }
            let cancelAction = UIAlertAction(title: "취소", style: .default) {(action: UIAlertAction!) -> Void in
                NSLog("사진삭제 취소")
            }
            alert.addAction(confirmAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion:nil)
        }
    }
    func splitStepBottonsState(tag: Int) {
        print("tag : \(tag)")
        
        guard let addButton = self.view.viewWithTag(tag+10) as? UIButton else {
            print("UIButton 못찾음 1"); return
        }
        guard let deleteButton = self.view.viewWithTag(tag+20) as? UIButton else {
            print("UIButton 못찾음 2"); return
        }
        guard let imageView = self.view.viewWithTag(tag) as? UIImageView else {
            print("UIImageView 못찾음"); return
        }
        
        if imageView.image == nil { // 사진없음
            addButton.isHidden = false
            addButton.isEnabled = true
            
            deleteButton.isHidden = true
            deleteButton.isEnabled = false
        } else {
            addButton.isHidden = true
            addButton.isEnabled = false
            
            deleteButton.isHidden = false
            deleteButton.isEnabled = true
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
            if currentTag >= 500 {
                self.splitStepBottonsState(tag: currentTag)
            }
        } else {
            print("사진불러오기 실패")
        }
        
        dismiss(animated: true, completion: nil)
    }
}
