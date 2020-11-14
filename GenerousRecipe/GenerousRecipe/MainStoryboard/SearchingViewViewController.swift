//
//  IngredientsViewController.swift
//  GenerousRecipe
//
//  Created by Yongwoo Marco on 2020/10/26.
//  Copyright © 2020 FastCampus. All rights reserved.
//

import UIKit

// 3. 추가 제거 만들기

class SearchingViewController: UIViewController {
    @IBOutlet weak var inputTF: UITextField!
    @IBOutlet weak var typeSC: UISegmentedControl!
    
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    
    var tags: [(Int, String)] = []
    
    //Mark - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagsCollectionView.backgroundView = UIImageView(image: UIImage(named: "grocery-bag-512px"))
        tagsCollectionView.backgroundView?.contentMode = .scaleAspectFit
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 태그 남겨보기?!
    }

    // IBActions
    @IBAction func cancelButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion:nil)
    }
    @IBAction func searchingButton(_ sender: Any) {
        if !tags.isEmpty {
            //self.presentingViewController?.dismiss(animated: true, completion:nil)
            let importantStr = tags.filter({ $0.0 == 0 }).isEmpty ? "주재료 없음" : tags.filter({ $0.0 == 0 }).map({ $0.1 }).joined(separator: ", ")
            let optionalStr = tags.filter({ $0.0 == 1 }).isEmpty ? "부재료 없음" : tags.filter({ $0.0 == 1 }).map({ $0.1 }).joined(separator: ", ")
            
            let msg = "주재료 : [\(importantStr)], 부재료 : [\(optionalStr)]"
            let title = "아래 재료로 레시피 추천 받겠습니까?"
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "추천받기", style: .default) { [self](action: UIAlertAction!) -> Void in
                let sb = UIStoryboard(name: "ListViewController", bundle: nil)
                guard let vc = sb.instantiateViewController(identifier: "ListViewController") as? ListViewController else {
                    return
                }
                
                
                vc.modalPresentationStyle = .fullScreen
                
//                self.present(vc, animated: false, completion: nil)
                
                // 메인 페이지 데이터 넘겨주기
                NotificationCenter.default.post(name: Notification.Name("getTags"), object: tags)
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
            let alert = UIAlertController(title: "재료추가 확인", message: "'\(tag)' 검색조건에 추가하겠습니까?", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "추가하기", style: .default) { [self] (action: UIAlertAction!) -> Void in
                self.tags.append( (typeSC.selectedSegmentIndex, tag) )
                
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
    @objc func deleteTag(sender: UIButton) {
        
        let alert = UIAlertController(title: "재료 삭제", message: "재료 '\(tags[sender.tag].1)' 삭제 하시겠습니까?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "삭제하기", style: .default) { [self] (action: UIAlertAction!) -> Void in
            // 태그 삭제

            tagsCollectionView.deleteItems(at: [IndexPath.init(row: sender.tag, section: 0)])
            tags.remove(at: sender.tag)
            
            NSLog("재료 삭제 완료")
        }
        let cancelAction = UIAlertAction(title: "취소", style: .default) {(action: UIAlertAction!) -> Void in
            NSLog("재료삭제 취소")
        }
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion:nil)
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
        
        if tags[indexPath.row].0 == 0 {
            cell.tagL.textColor = .blue
            cell.tagL.text = tags[indexPath.row].1
        } else {
            cell.tagL.textColor = .green
            cell.tagL.text = tags[indexPath.row].1
        }
        cell.deleteB.tag = indexPath.row
        cell.deleteB.addTarget(self, action: #selector(deleteTag(sender:)), for: .touchUpInside)
        
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
