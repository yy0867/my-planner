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
    let colorSelectorViewController: ColorSelectorViewController
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
    init(viewModel: AddPlanViewModel,
         colorSelectorViewController: ColorSelectorViewController) {
        self.viewModel = viewModel
        self.colorSelectorViewController = colorSelectorViewController
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
        
        viewModel.allFieldValid()
            .bind(to: doneButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.inputColor.subscribe(onNext: { [weak self] selectedColor in
            guard let strongSelf = self else { return }
            strongSelf.doneButton.customView?.tintColor = UIColor(selectedColor)
        }).disposed(by: disposeBag)
        
        viewModel.addPlanAction.subscribe(onNext: { [weak self] action in
            guard let strongSelf = self else { return }
            
            switch action {
                case .colorSelector:
                    strongSelf.pushColorSelectorViewController()
                case .none:
                    break
            }
        }).disposed(by: disposeBag)
    }
    
    private func pushColorSelectorViewController() {        
        colorSelectorViewController.delegate = self
        navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(colorSelectorViewController,
                                                 animated: true)
    }
    
    @objc
    private func dismissViewController() {
        self.dismiss(animated: true,
                     completion: nil)
    }
    
    @objc
    private func addPlan() {
        viewModel.addPlan()
        guard let pvc = self.presentingViewController as? PlanListViewController else { return }
        self.dismiss(animated: true) {
            pvc.viewModel.reloadData()
        }
    }
}

extension AddPlanViewController: ColorSelectorDelegate {
    
    func colorSelector(didSelectColor selectedColor: Plan.Color) {
        viewModel.changeColor(selectedColor)
    }
}
