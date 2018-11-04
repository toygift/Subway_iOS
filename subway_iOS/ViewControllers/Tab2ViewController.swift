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
    var selected = false
    var completed = false
    
    init(){ /* do nothing */ }
    
    init(title : String) {
        self.title = title
    }
    
    init(title : String, accessible : Bool) {
        self.title = title
        self.accessible = accessible
        self.selected = true
    }
}

class Tab2ViewController: UIViewController {

    @IBOutlet weak var stepCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var tabLiner: UIView!
    @IBOutlet weak var tabLinerWidth: NSLayoutConstraint!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
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
    
    var step7Cache = [Bread]()
    
    // MARK: - subviews
    let step1Sandwich = Step1SandwichSelectView.initializeFromNib()
    let step2Bread = Step2BreadSelectView()
    let step3Topping = Step3Or7SelectView.initializeFromNib()
    let step4Cheese = Step4Or5SelectView()
    let step5Toasting = Step4Or5SelectView()
    let step6Vegetable = Step6VegetableSelectView.initializeFromNib()
    let step7Sauce = Step3Or7SelectView.initializeFromNib()
    let step8Name = Step8NameSelectView.initializeFromNib()
    
    @IBAction func refreshButtonClicked(_ sender: UIBarButtonItem) {
        showAlertPopup(alertType: .refresh)
    }
    
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
        step6Vegetable.completeDelegate = self
        step7Sauce.completeDelegate = self
        step8Name.completeDelegate = self
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
        for _ in realSteps {
            
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
                step3Topping.step = 3
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
            } else if i == 6 {
                step7Sauce.frame = innerScrollFrame
                scrollView.addSubview(step7Sauce)
                step7Sauce.step = 7
            } else {
                step8Name.frame = innerScrollFrame
                scrollView.addSubview(step8Name)
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
        guard stepIndex > 0 else {
            print("no way!!")
            return
        }
        
        // step collectionview
        steps[stepIndex].selected = true
        steps[stepIndex - 1].selected = false
        steps[stepIndex - 1].completed = true
        stepCollectionView.reloadData()
        
        // scrollview
        let x : CGFloat = (CGFloat(stepIndex) - 1) * view.frame.width
        let rect = CGRect(x: x, y: 0, width: view.frame.width, height: scrollView.frame.height)
        scrollView.scrollRectToVisible(rect, animated: true)
        refreshTabLiner(strLength: steps[stepIndex].title.count)
        stepCollectionView.scrollToItem(at: IndexPath(item: stepIndex, section: 0), at: .centeredHorizontally, animated: true)
        
        if stepIndex == 8 {
            refreshButton.tintColor = .clear
        }
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
        let width = getLabelWidth(strLength: steps[indexPath.item].title.count)
        return CGSize(width: width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if !steps[indexPath.item].accessible {
            print("cannot accessible!! indexPath.item:", indexPath.item)
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
    
    @objc fileprivate func refreshSelections(){
        
        for i in 0..<steps.count {
            steps[i].completed = false
            if i != 1 {
                steps[i].accessible = false
            }
        }
        goTo(stepIndex: 1)
        step1Sandwich.initializeSelection()
        step2Bread.initializeSelection()
        step3Topping.initializeSelection()
        step4Cheese.initializeSelection()
        step5Toasting.initializeSelection()
        step6Vegetable.initializeSelection()
        step7Sauce.initializeSelection()
        
    }
    
    fileprivate func showAlertPopup(alertType: AlertType){
        let alert = UIStoryboard(name: "Tab2", bundle: nil).instantiateViewController(withIdentifier: AlertPopupViewController.identifier) as! AlertPopupViewController
        alert.modalPresentationStyle = .overCurrentContext
        alert.modalTransitionStyle = .crossDissolve
        alert.alertType = alertType
        alert.delegate = self
        
        present(alert, animated: true, completion: nil)
    }
    
    fileprivate func createRecipe(){
        RecipeCreateValidation(method: .post, parameters: recipe).requestAPIencoded { [weak self] (response) in
            
            guard let statusCode = response.response?.statusCode else {
                print("cannot get status code")
                return
            }
            
            if statusCode == 200 {
                // good to go
                self?.goTo(stepIndex: 8)
                self?.disableScroll()
            } else if statusCode == 400 {
                if let pk = response.value?.pk {
                    print("hello \(pk)")
                }
            }
        }
    }
    
    fileprivate func disableScroll(){
        // scroll 기능 해제!
        scrollView.isScrollEnabled = false
        for i in 0..<steps.count {
            steps[i].accessible = false
        }
    }
    
}

// MARK: - ScrollView Delegation
extension Tab2ViewController : UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = scrollView.currentPage
        
        for i in 0..<steps.count {
            if i > 0 && i < steps.count - 1 {
                if i == currentPage {
                    steps[i].selected = true
                } else {
                    steps[i].selected = false
                }
            }
        }
        stepCollectionView.reloadData()
        
        stepCollectionView.scrollToItem(at: IndexPath(item: currentPage, section: 0), at: .centeredHorizontally, animated: true)
        refreshTabLiner(strLength: steps[currentPage].title.count)
    }
    
}

extension Tab2ViewController: AlertPopupDelegate {
    func positiveButtonSelected(alertType: AlertType) {
        if alertType == .refresh {
            refreshSelections()
        } else if alertType == .irreversible || alertType == .nosauce {
            steps[8].accessible = true

            if !steps[9].accessible {
                scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(8), height: scrollView.bounds.size.height)
            }
            
            recipe["sauces"] = step7Cache.map{ ["name": $0.name] }
            // TODO: - add logic for create recipe
            createRecipe()
            
        }
    }
}


extension Tab2ViewController : Step1CompleteDelegate {
    func step1Completed(sandwich: Sandwich) {
        steps[2].accessible = true
        
        // 3단계에 아직 가본 상태가 아니라면 2단계까지 갈 수 있도록 열어줌
        if !steps[3].accessible {
            scrollView.contentSize = CGSize(width: view.frame.width * 2, height: scrollView.bounds.size.height)
        }
        
        recipe["sandwich"] = ["name" : sandwich.name]
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
        
        recipe["bread"] = ["name" : bread.name]
        step3Topping.fetchData()
        step8Name.setSandwichName(with: bread.name)
        goTo(stepIndex: 3)
    }
}

extension Tab2ViewController : Step3Or7CompleteDelegate {
    
    func step3Or7Completed(ingredients: [Bread], nextStep: Int) {
        
        if nextStep == 4 {
            steps[nextStep].accessible = true
            
            if !steps[nextStep + 1].accessible {
                scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(nextStep), height: scrollView.bounds.size.height)
            }
            
            recipe["toppings"] = ingredients.map{ ["name": $0.name] }
            step4Cheese.fetchData()
            goTo(stepIndex: nextStep)
        } else if nextStep == 8 {
            step7Cache = ingredients
            if ingredients.count > 0 {
                showAlertPopup(alertType: .irreversible)
            } else {
                showAlertPopup(alertType: .nosauce)
            }
        }
    }
}

extension Tab2ViewController : Step4Or5CompleteDelegate {
    func step4Or5Completed(ingredient: Bread, nextStep: Int) {
        steps[nextStep].accessible = true
        
        if !steps[nextStep + 1].accessible {
            scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(nextStep), height: scrollView.bounds.size.height)
        }
        
        // MARK: - fetch data
        if nextStep == 5 {
            recipe["cheese"] = ["name" : ingredient.name]
            step5Toasting.fetchData()
        } else if nextStep == 6 {
            recipe["toasting"] = ["name" : ingredient.name]
            step6Vegetable.fetchData()
        }
        
        goTo(stepIndex: nextStep)
    }
}

extension Tab2ViewController: Step6CompleteDelegate {
    func step6Completed(vegetableSelection: [Vegetable]) {
        steps[7].accessible = true
        
        // 5단계에 아직 가본 상태가 아니라면 4단계까지 갈 수 있도록
        if !steps[8].accessible {
            scrollView.contentSize = CGSize(width: view.frame.width * 7, height: scrollView.bounds.size.height)
        }
        
        recipe["vegetables"] = vegetableSelection .map{ ["name":$0.name, "quantity":$0.quantity] }
        step7Sauce.fetchData()
        goTo(stepIndex: 7)
    }
}

extension Tab2ViewController: Step8CompleteDelegate {
    func step8Completed(name: String) {
        recipe["name"] = name
        
        // TODO: - call make recipe request
        
    }
}
