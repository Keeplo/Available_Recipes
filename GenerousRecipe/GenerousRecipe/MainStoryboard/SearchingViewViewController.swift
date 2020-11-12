//
//  IngredientsViewController.swift
//  GenerousRecipe
//
//  Created by Yongwoo Marco on 2020/10/26.
//  Copyright © 2020 FastCampus. All rights reserved.
//

import UIKit

class SearchingViewController: UIViewController {
    @IBOutlet weak var inputTF: UITextField!
    @IBOutlet weak var typeSC: UISegmentedControl!
    
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    
    var tags: [String:String] = [:]
    
    //Mark - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func cancelButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion:nil)
    }
    @IBAction func searchingButton(_ sender: Any) {
        if !tags.isEmpty {
            //self.presentingViewController?.dismiss(animated: true, completion:nil)
            let msg = "주재료 : [\(!tags["important"]!.isEmpty ? tags["important"]!.map({String($0)}).joined(separator: ", ") : "주재료 없음")], 부재료 : [\(!tags["optional"]!.isEmpty ? tags["optional"]!.map({String($0)}).joined(separator: ", ") : "부재료 없음")]"
            let title = "아래 재료로 레시피 추천 받겠습니까?"
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "추천받기", style: .default) {(action: UIAlertAction!) -> Void in
                let sb = UIStoryboard(name: "ListViewController", bundle: nil)
                guard let vc = sb.instantiateViewController(identifier: "ListViewController") as? ListViewController else {
                    return
                }
                
                
                vc.modalPresentationStyle = .fullScreen
//                vc.currentRecipe = recipe
                
                self.present(vc, animated: false, completion: nil)
                
                
                
                self.presentingViewController?.dismiss(animated: true, completion:nil)
                NSLog(msg)
            }
            let cancelAction = UIAlertAction(title: "수정하기", style: .default) {(action: UIAlertAction!) -> Void in
                NSLog(msg)
            }
            
            alert.addAction(confirmAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion:nil)
        } else {
            let alert = UIAlertController(title: "재료 입력 필요", message: "검색할 조건을 입력해주세요", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "확인", style: .default) {(action: UIAlertAction!) -> Void in
                NSLog("조건입력필요에러")
            }
            
            alert.addAction(confirmAction)
            
            present(alert, animated: true, completion:nil)
        }
    }
    @IBAction func addATag(_ sender: Any) {
        addTag()
    }
    
    func addTag() {
        let tag = inputTF.text!
        if !tag.isEmpty {
            let alert = UIAlertController(title: "재료추가 확인", message: tag+" 를 검색조건에 추가하겠습니까?", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "추가하기", style: .default) { [self] (action: UIAlertAction!) -> Void in
                self.tags.append(tag)
                updateCollectionView()
                NSLog("\(tag) 재료추가 완료")
            }
            let cancelAction = UIAlertAction(title: "취소하기", style: .default) {(action: UIAlertAction!) -> Void in
                NSLog("재료추가 취소")
            }
            alert.addAction(confirmAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion:nil)
        } else {
            let alert = UIAlertController(title: "재료 입력 필요", message: "추가 재료를 입력해주세요", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "확인", style: .default) {(action: UIAlertAction!) -> Void in
                NSLog("재료입력 필요")
            }
            
            alert.addAction(confirmAction)
            
            present(alert, animated: true, completion:nil)
        }
    }
}

extension SearchingViewController: UICollectionViewDataSource {
    func updateCollectionView() {
        tagsCollectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tag", for: indexPath) as? TagsCollectionViewCell else { return UICollectionViewCell() }
        
        cell.tagL.text = tags[indexPath.row]
        
        return cell
    }
    
    
}
extension SearchingViewController: UICollectionViewDelegate {
    
}

extension SearchingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !textField.text!.isEmpty {
            addTag()
        } else {
            print("조건 없음")
        }
        return true
    }
}
