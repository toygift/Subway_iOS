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
         Step(title: "소스"), Step(title: "이름 정하기"),
         Step()
    ]
    
    var recipe : [String : Any] = [:] {
        didSet {
            print("========== RECIPE =========")
            print(recipe)
        }
    }
    
    // MARK: - subviews
    let step1Sandwich = Step1SandwichSelectView.initializeFromNib()
    let step2Bread = Step2BreadSelectView()
    let step3Topping = Step3ToppingSelectView.initializeFromNib()
    let step4Cheese = Step4Or5SelectView()
    let step5Toasting = Step4Or5SelectView()
    let step6Vegetable = Step6VegetableSelectView.initializeFromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabLiner.layer.cornerRadius = 5
        setupCollectionView()
        setupDataCollection()
        setupScrollView()
    }

    fileprivate func setupDataCollection(){
        step1Sandwich.completeDelegate = self
        step2Bread.completeDelegate = self
        step3Topping.completeDelegate = self
        step4Cheese.completeDelegate = self
        step5Toasting.completeDelegate = self
        
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
            
            // TODO: - 이 로직을 다이나믹하게 넣는 방식으로도 할 수 있겠다
            if i == 0 {
                step1Sandwich.frame = innerScrollFrame
                scrollView.addSubview(step1Sandwich)
            } else if i == 1 {
                step2Bread.frame = innerScrollFrame
                scrollView.addSubview(step2Bread)
                step2Bread.setupTableView() // TODO: - 이거 나중에 리팩토링 가능한지?? init안에 넣고 싶음
            } else if i == 2 {
                step3Topping.frame = innerScrollFrame
                scrollView.addSubview(step3Topping)
            } else if i == 3 {
                step4Cheese.frame = innerScrollFrame
                step4Cheese.step = 4
                scrollView.addSubview(step4Cheese)
                step4Cheese.setupTableView()
            } else if i == 4 {
                step5Toasting.frame = innerScrollFrame
                step5Toasting.step = 5
                scrollView.addSubview(step5Toasting)
                step5Toasting.setupTableView()
            } else if i == 5 {
                step6Vegetable.frame = innerScrollFrame
                scrollView.addSubview(step6Vegetable)
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
        
        recipe["sandwich"] = sandwich
        step2Bread.fetchData()
        goTo(stepIndex: 2)
    }
    
}

extension Tab2ViewController : Step2CompleteDelegate {
    func step2Completed(bread: Bread) {
        steps[3].accessible = true
        
        // 4단계에 아직 가본 상태가 아니라면 3단계까지 갈 수 있도록
        if !steps[4].accessible {
            scrollView.contentSize = CGSize(width: view.frame.width * 3, height: scrollView.bounds.size.height)
        }
        
        recipe["bread"] = bread
        step3Topping.fetchData()
        goTo(stepIndex: 3)
    }
}

extension Tab2ViewController : Step3CompleteDelegate {
    func step3Completed(toppings: [Bread]) {
        steps[4].accessible = true
        
        // 5단계에 아직 가본 상태가 아니라면 4단계까지 갈 수 있도록
        if !steps[5].accessible {
            scrollView.contentSize = CGSize(width: view.frame.width * 4, height: scrollView.bounds.size.height)
        }
        
        recipe["toppings"] = toppings
        step4Cheese.fetchData()
        goTo(stepIndex: 4)
    }
}

extension Tab2ViewController : Step4Or5CompleteDelegate {
    func step4Or5Completed(ingredient: Bread, nextStep: Int) {
        steps[nextStep].accessible = true
        
        // 6단계에 아직 가본 상태가 아니라면 5단계까지 갈 수 있도록
        if !steps[nextStep + 1].accessible {
            scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(nextStep), height: scrollView.bounds.size.height)
        }
        
        
        
        // MARK: - fetch data
        if nextStep == 5 {
            recipe["cheese"] = ingredient
            step5Toasting.fetchData()
        } else if nextStep == 6 {
            recipe["toasting"] = ingredient
            step6Vegetable.fetchData()
        }
        
        goTo(stepIndex: nextStep)
    }
}
