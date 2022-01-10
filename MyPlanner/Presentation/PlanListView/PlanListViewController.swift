//
//  ViewController.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/29.
//

import UIKit
import RxSwift
import RxCocoa

class PlanListViewController: DeclarativeViewController {

    let viewModel: PlanListViewModel
    let disposeBag: DisposeBag = DisposeBag()
    
    let addPlanViewControllerFactory: AddPlanViewControllerFactory
    let editPlanViewControllerFactory: EditPlanViewControllerFactory
    
    init(viewModel: PlanListViewModel,
         addPlanViewControllerFactory: AddPlanViewControllerFactory,
         editPlanViewControllerFactory: EditPlanViewControllerFactory) {
        
        self.viewModel = viewModel
        self.addPlanViewControllerFactory = addPlanViewControllerFactory
        self.editPlanViewControllerFactory = editPlanViewControllerFactory
        
        super.init()
        viewModel.changeDate(date: Date())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = PlanListView(viewModel: viewModel)
        bind(to: viewModel)
    }
    
    func bind(to viewModel: PlanListViewModel) {
        viewModel.planListViewAction.subscribe(onNext: { [weak self] action in
            guard let strongSelf = self else { return }
            strongSelf.handleAction(of: action)
        }).disposed(by: disposeBag)
        
        viewModel.selectedPlan.subscribe(onNext: { [weak self] plan in
            guard let strongSelf = self else { return }
            strongSelf.presentEditPlan()
        }).disposed(by: disposeBag)
    }
    
    func handleAction(of action: PlanListViewAction) {
        switch action {
            case .profile:
                print("Profile clicked.")
                presentProfile()
            case .dateSelector:
                print("date selector clicked.")
                presentDateSelector()
            case .addPlan:
                print("add plan clicked.")
                presentAddPlan()
            case .searchPlan:
                print("search plan clicked.")
                presentSearchPlan()
            default:
                break
        }
    }
    
    func presentProfile() {
        
    }
    
    func presentDateSelector() {
        let vc = DateSelectorViewController(viewModel: viewModel)
        
        present(vc, animated: true, completion: nil)
    }
    
    func presentAddPlan() {
        let addPlanViewController = addPlanViewControllerFactory
            .makeAddPlanViewController(planListViewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: addPlanViewController)
        
        navigationController.modalTransitionStyle = .coverVertical
        navigationController.modalPresentationStyle = .currentContext
        
        present(navigationController, animated: true)
    }
    
    func presentEditPlan() {
        let editPlanViewController = editPlanViewControllerFactory
            .makeEditPlanViewController(planListViewModel: viewModel)
        
        let navigationController = UINavigationController(rootViewController: editPlanViewController)
        
//        navigationController.modalTransitionStyle = .coverVertical
//        navigationController.modalPresentationStyle = .currentContext
        
        present(navigationController, animated: true)
    }
    
    func presentSearchPlan() {
        
    }
    
    func reloadData() {
        viewModel.reloadData()
    }
}

protocol AddPlanViewControllerFactory {
    
    func makeAddPlanViewController(planListViewModel: PlanListViewModel) -> AddPlanViewController
}

protocol EditPlanViewControllerFactory {
    
    func makeEditPlanViewController(planListViewModel: PlanListViewModel) -> EditPlanViewController
}
