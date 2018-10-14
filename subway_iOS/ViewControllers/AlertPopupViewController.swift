//
//  AlertPopupViewController.swift
//  subway_iOS
//
//  Created by khpark on 2018. 10. 7..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit

enum AlertType {
    case refresh, irreversible, samerecipe, watchad, nosauce
}

protocol AlertPopupDelegate {
    func positiveButtonSelected(alertType: AlertType)
}

class AlertPopupViewController: UIViewController {

    static let identifier = "AlertPopupViewController"
    
    @IBOutlet var backdrop: UIView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var alertType : AlertType = .refresh
    var delegate: AlertPopupDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupEvents()
    }
    
    fileprivate func setupViews(){
        container.layer.cornerRadius = 10
        okButton.layer.cornerRadius = 10
        cancelButton.layer.cornerRadius = 10
        
        switch alertType {
        case .refresh:
            messageLabel.text = "현재 진행중인 레시피 만들기를\n정말 초기화 하시겠어요?"
            break
        case .irreversible:
            messageLabel.text = "다음 단계로 넘어가면\n레시피를 더 이상 바꿀 수 없어요!\n계속 진행할까요?"
            break
        case .samerecipe:
            messageLabel.text = "당신과 같은 취향을 가진 사람이 있어요!\n레시피를 확인하러 갈까요?"
            break
        case .watchad:
            messageLabel.text = "마음에 드는 이름이 없으면\n광고를 시청 후 3번의 기회를 줄게요. \n어때요?"
            break
        case .nosauce:
            messageLabel.text = "아직 소스를 선택하지 않았어요.\n정말 다음 단계로 넘어 가시겠어요?"
            break
        }
    }
    
    fileprivate func setupEvents(){
        let backdropTap = UITapGestureRecognizer(target: self, action: #selector(exit))
        backdrop.addGestureRecognizer(backdropTap)
        
        okButton.addTarget(self, action: #selector(ok), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(exit), for: .touchUpInside)
    }
    
    @objc fileprivate func ok(){
        delegate?.positiveButtonSelected(alertType: alertType)
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func exit(){
        dismiss(animated: true, completion: nil)
    }
}
