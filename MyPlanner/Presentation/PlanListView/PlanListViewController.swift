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
    
    init(viewModel: PlanListViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = PlanListView(viewModel: viewModel)
        bind(to: viewModel)
    }
    
    func bind(to viewModel: PlanListViewModel) {
        viewModel.touchAction.subscribe(onNext: { [weak self] action in
            guard let strongSelf = self else { return }
            strongSelf.handleAction(of: action)
        }).disposed(by: disposeBag)
    }
    
    func handleAction(of action: PlanListTitleBarAction) {
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
        }
    }
    
    func presentProfile() {
        
    }
    
    func presentDateSelector() {
        let vc = DateSelectorViewController(viewModel: viewModel)
        
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .popover
        
        present(vc, animated: true, completion: nil)
    }
    
    func presentAddPlan() {
        
    }
    
    func presentSearchPlan() {
        
    }
}

