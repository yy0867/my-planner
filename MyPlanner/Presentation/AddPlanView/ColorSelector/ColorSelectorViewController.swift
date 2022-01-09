//
//  ColorSelectorViewController.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/09.
//

import UIKit
import RxSwift

class ColorSelectorViewController: DeclarativeViewController {
    
    // MARK: - Properties
    let viewModel: ColorSelectorViewModel
    let disposeBag = DisposeBag()
    
    lazy var doneButton: UIBarButtonItem = {
        let button = UIButton()
        
        button.setTitle("선택", for: .normal)
        button.tintColor = Color.accentColor
        button.configuration = .filled()
        button.configuration?.cornerStyle = .capsule
        button.addTarget(self,
                         action: #selector(doneSelect),
                         for: .touchUpInside)
        
        return UIBarButtonItem(customView: button)
    }()
    
    // MARK: - Methods
    init(viewModel: ColorSelectorViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        navigationController?.navigationBar.tintColor = Color.black
        self.view = ColorSelectorView(viewModel: viewModel)
        bind(to: viewModel)
    }
    
    private func bind(to viewModel: ColorSelectorViewModel) {
        
        viewModel.colorSelectorAction.subscribe(onNext: { [weak self] action in
            guard let strongSelf = self else { return }
            switch action {
                case .select:
                    strongSelf.doneSelect()
                case .none:
                    break
            }
        }).disposed(by: disposeBag)
        
        viewModel.selectedColor.subscribe(onNext: { [weak self] color in
            guard let strongSelf = self else { return }
            strongSelf.doneButton.customView?.tintColor = UIColor(color)
        }).disposed(by: disposeBag)
    }
    
    private func configureNavigationBar() {
        navigationItem.setRightBarButton(doneButton,
                                         animated: false)
    }
    
    @objc
    private func doneSelect() {
        navigationController?.popViewController(animated: true)
    }
}
