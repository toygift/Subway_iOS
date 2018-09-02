//
//  Tab2ViewController.swift
//  subway_iOS
//
//  Created by khpark on 2018. 5. 20..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

struct Step {
    var title = ""
    var accessible = false
    
    init(){ /* do nothing */ }
    
    init(title : String) {
        self.title = title
    }
    
    init(title : String, accessible : Bool) {
        self.title = title
        self.accessible = accessible
    }
}

class Tab2ViewController: UIViewController {

    @IBOutlet weak var stepCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var tabLiner: UIView!
    @IBOutlet weak var tabLinerWidth: NSLayoutConstraint!
    
    var scrollableBounds = CGRect.zero
    
    var steps = [
         Step(),
         Step(title: "샌드위치", accessible: true), Step(title: "빵"),
         Step(title: "추가토핑"), Step(title: "치즈"),
         Step(title: "토스팅"), Step(title: "야채"),
         Step(title: "소스"), Step(title: "이름이름"),
         Step()
    ]
    
    let step1Sandwich = Step1SandwichSelectView.initializeFromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabLiner.layer.cornerRadius = 5
        setupCollectionView()
        setupDataCollection()
        setupScrollView()
    }

    fileprivate func setupDataCollection(){
        step1Sandwich.delegate = self
    }
    
    fileprivate func setupCollectionView(){
        stepCollectionView.register(UINib(nibName: "RecipeStepCell", bundle: nil), forCellWithReuseIdentifier: RecipeStepCell.cellId)
        stepCollectionView.delegate = self
        stepCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 1.0, height: 1.0)
    }
    
    fileprivate func setupScrollView(){
        let realSteps = steps.filter { $0.title.count > 0 }
        
        var innerScrollFrame = scrollView.bounds
        var i = 0
        for item in realSteps {
            
            // TODO: - 여기서부터 각 단계별로 뷰 그리기
            if i == 0 {
                step1Sandwich.frame = innerScrollFrame
                scrollView.addSubview(step1Sandwich)
            } else {
                let label = UILabel(frame: innerScrollFrame)
                label.text = item.title
                label.textAlignment = .center
                scrollView.addSubview(label)
            }
            
            if i < realSteps.count-1{
                innerScrollFrame.origin.x = innerScrollFrame.origin.x + innerScrollFrame.size.width
            }
            i = i + 1
        }
        
        scrollableBounds = innerScrollFrame
        
        // initially block scroll
        scrollView.contentSize = CGSize(width: view.frame.width, height: scrollView.bounds.size.height)

        scrollView.delegate = self
    }
    
    fileprivate func goTo(stepIndex : Int){
        let x : CGFloat = (CGFloat(stepIndex) - 1) * view.frame.width
        let rect = CGRect(x: x, y: 0, width: view.frame.width, height: scrollView.frame.height)
        scrollView.scrollRectToVisible(rect, animated: true)
        refreshTabLiner(strLength: steps[stepIndex].title.count)
        stepCollectionView.scrollToItem(at: IndexPath(item: stepIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
}

// MARK: - CollectionView delegation
extension Tab2ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeStepCell.cellId, for: indexPath) as! RecipeStepCell
        cell.data = steps[indexPath.item].title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return steps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = getLabelWidth(strLength: steps[indexPath.item].title.count)
        return CGSize(width: width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        
        if !steps[indexPath.item].accessible {
            print("cannot accessible!!")
            return
        }
        
        if indexPath.item != 0, indexPath.item != steps.count - 1 {
            goTo(stepIndex: indexPath.item)
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
        refreshTabLiner(strLength: steps[currentPage].title.count)
    }
    
}

extension Tab2ViewController : Step1CompleteDelegate {
    func step1Completed(sandwich: Sandwich) {
        steps[2].accessible = true
        
        // 3단계에 아직 가본 상태가 아니라면 2단계까지 갈 수 있도록 열어줌
        if !steps[3].accessible {
            scrollView.contentSize = CGSize(width: view.frame.width * 2, height: scrollView.bounds.size.height)
        }
        goTo(stepIndex: 2)
    }
    
}

