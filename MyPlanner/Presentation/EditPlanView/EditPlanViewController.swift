//
//  EditPlanViewController.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/10.
//

import UIKit
import RxSwift

class EditPlanViewController: DeclarativeViewController {
    
    // MARK: - Properties
    let viewModel: EditPlanViewModel
    let colorSelectorViewController: ColorSelectorViewController
    let disposeBag = DisposeBag()
    
    lazy var deleteButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "trash")!,
                                     style: .plain,
                                     target: self,
                                     action: #selector(deletePlan))
        
        button.tintColor = Color.black
        
        return button
    }()
    
    lazy var doneButton: UIBarButtonItem = {
        let button = UIButton()
        
        button.setTitle("완료", for: .normal)
        button.tintColor = Color.accentColor
        button.configuration = .filled()
        button.configuration?.cornerStyle = .capsule
        button.addTarget(self,
                         action: #selector(updatePlan),
                         for: .touchUpInside)
        
        return UIBarButtonItem(customView: button)
    }()
    
    
    // MARK: - Methods
    init(viewModel: EditPlanViewModel,
         colorSelectorViewController: ColorSelectorViewController) {
        self.viewModel = viewModel
        self.colorSelectorViewController = colorSelectorViewController
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = EditPlanView(viewModel: viewModel)
        configureNavigationBar()
        bind(to: viewModel)
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "일정 관리"
        navigationItem.setLeftBarButton(deleteButton,
                                        animated: false)
        navigationItem.setRightBarButton(doneButton,
                                         animated: false)
    }
    
    private func bind(to viewModel: EditPlanViewModel) {
        
        viewModel.allFieldValid()
            .bind(to: doneButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.inputColor.subscribe(onNext: { [weak self] selectedColor in
            guard let strongSelf = self else { return }
            strongSelf.doneButton.customView?.tintColor = UIColor(selectedColor)
        }).disposed(by: disposeBag)
        
        viewModel.colorSelectableAction.subscribe(onNext: { [weak self] action in
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
        colorSelectorViewController.dataSource = self
        
        navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(colorSelectorViewController,
                                                 animated: true)
    }
    
    private func askDelete(handler: @escaping () -> ()) {
        let alert = UIAlertController(title: "일정을 삭제합니다.",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        
        let delete = UIAlertAction(title: "삭제", style: .destructive) { _ in handler() }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(delete)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc
    func deletePlan() {
        
        askDelete { [weak self] in
            self?.viewModel.deletePlan()
            
            guard let pvc = self?.presentingViewController as? PlanListViewController else { return }
            self?.dismiss(animated: true) {
                pvc.reloadData()
            }
        }
    }
    
    @objc
    func updatePlan() {
        viewModel.updatePlan()
        
        guard let pvc = self.presentingViewController as? PlanListViewController else { return }
        dismiss(animated: true) {
            pvc.reloadData()
        }
    }
}

extension EditPlanViewController: ColorSelectorDelegate, ColorSelectorDataSource {
    
    func colorSelector(didSelectColor selectedColor: Plan.Color) {
        viewModel.changeColor(selectedColor)
    }
    
    func setInitialColor() -> Plan.Color {
        return viewModel.inputColor.value
    }
}
