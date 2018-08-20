//
//  Tab2ViewController.swift
//  subway_iOS
//
//  Created by khpark on 2018. 5. 20..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

class Tab2ViewController: UIViewController {

    @IBOutlet weak var stepCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var tabLiner: UIView!
    @IBOutlet weak var tabLinerWidth: NSLayoutConstraint!
    
    let steps = ["", "샌드위치", "빵", "추가토핑", "치즈", "토스팅", "야채", "소스", "이름이름", ""]
    
    let step1Sandwich = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupScrollView()
    }

    // MARK: - 현재 안 쓰고 있음.. tabLiner.bounds에 따라서 BezierPath가 정해지는데 width constant만 바꾸면 path가 왔다갔다하는 상황이 있기 때문에 이건 좀 봐야됨..
    fileprivate func roundTabLiner(){
        
        // tabliner corner radius 설정
        let path = UIBezierPath(roundedRect:tabLiner.bounds,
                                byRoundingCorners:[.topRight, .topLeft],
                                cornerRadii: CGSize(width: 8, height:  8))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        tabLiner.layer.mask = maskLayer
    }
    
    
    fileprivate func setupCollectionView(){
        stepCollectionView.register(UINib(nibName: "RecipeStepCell", bundle: nil), forCellWithReuseIdentifier: RecipeStepCell.cellId)
        stepCollectionView.delegate = self
        stepCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 1.0, height: 1.0)
    }
    
    fileprivate func setupScrollView(){
        let realSteps = steps.filter { $0.count > 0 }
        
        var innerScrollFrame = scrollView.bounds
        var i = 0
        for item in realSteps {
            
            // TODO: - 여기서부터 각 단계별로 뷰 그리기
            if i == 0 {
                step1Sandwich.frame = innerScrollFrame
                scrollView.addSubview(step1Sandwich)
            } else {
                let label = UILabel(frame: innerScrollFrame)
                label.text = item
                label.textAlignment = .center
                scrollView.addSubview(label)
            }
            
            if i < realSteps.count-1{
                innerScrollFrame.origin.x = innerScrollFrame.origin.x + innerScrollFrame.size.width
            }
            i = i + 1
        }
        scrollView.contentSize = CGSize(width: innerScrollFrame.origin.x+innerScrollFrame.size.width, height: scrollView.bounds.size.height)

        scrollView.delegate = self
    }
    
}

// MARK: - CollectionView delegation
extension Tab2ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeStepCell.cellId, for: indexPath) as! RecipeStepCell
        cell.data = steps[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return steps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = getLabelWidth(strLength: steps[indexPath.item].count)
        return CGSize(width: width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        if indexPath.item != 0, indexPath.item != steps.count - 1 {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
            let rect = CGRect(x: CGFloat(indexPath.item - 1) * view.frame.width, y: 0, width: view.frame.width, height: scrollView.frame.height)
            scrollView.scrollRectToVisible(rect, animated: true)
            
            refreshTabLiner(strLength: steps[indexPath.item].count)
        }
    }
    
    fileprivate func getLabelWidth(strLength : Int) -> CGFloat{
        var width : CGFloat = 0
        let labelWidth = CGFloat(strLength * 10 + 35)
        if strLength == 0 {
            width = (view.frame.width - 95) / 2
        } else {
            width = labelWidth
        }
        return width
    }
    
    fileprivate func refreshTabLiner(strLength: Int){
        // TODO: - debug this!!
        tabLinerWidth.constant = getLabelWidth(strLength: strLength)
    }
    
    
}

// MARK: - ScrollView Delegation
extension Tab2ViewController : UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = scrollView.currentPage
        stepCollectionView.scrollToItem(at: IndexPath(item: currentPage, section: 0), at: .centeredHorizontally, animated: true)
        refreshTabLiner(strLength: steps[currentPage].count)
    }

}
