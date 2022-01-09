//
//  AddPlanViewController.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/07.
//

import UIKit
import RxSwift

class AddPlanViewController: DeclarativeViewController {
    
    // MARK: - Properties
    let viewModel: AddPlanViewModel
    let disposeBag = DisposeBag()
    
    lazy var dismissButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "xmark")!,
                                     style: .plain,
                                     target: self,
                                     action: #selector(dismissViewController))
        
        button.tintColor = Color.black
        
        return button
    }()
    
    lazy var doneButton: UIBarButtonItem = {
        let button = UIButton()
        
        button.setTitle("추가", for: .normal)
        button.tintColor = Color.accentColor
        button.configuration = .filled()
        button.configuration?.cornerStyle = .capsule
        button.addTarget(self,
                         action: #selector(addPlan),
                         for: .touchUpInside)
        
        return UIBarButtonItem(customView: button)
    }()
    
    // MARK: - Methods
    init(viewModel: AddPlanViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = AddPlanView(viewModel: viewModel)
        configureNavigationBar()
        bind(to: viewModel)
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "일정 추가"
        navigationItem.setLeftBarButton(dismissButton,
                                        animated: false)
        navigationItem.setRightBarButton(doneButton,
                                         animated: false)
    }
    
    private func bind(to viewModel: AddPlanViewModel) {
        
        viewModel.inputColor.subscribe(onNext: { [weak self] selectedColor in
            guard let strongSelf = self else { return }
            strongSelf.doneButton.tintColor = UIColor(selectedColor)
        }).disposed(by: disposeBag)
        
        viewModel.addPlanAction.subscribe(onNext: { [weak self] action in
            switch action {
                case .colorSelector:
                    self?.navigationController?.pushViewController(ColorSelectViewController(),
                                                                   animated: true)
                case .none:
                    break
            }
        }).disposed(by: disposeBag)
    }
    
    @objc
    private func dismissViewController() {
        self.dismiss(animated: true,
                     completion: nil)
    }
    
    @objc
    private func addPlan() {
        dismissViewController()
    }
}
