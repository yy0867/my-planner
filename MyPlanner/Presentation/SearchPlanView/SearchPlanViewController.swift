//
//  SearchPlanViewController.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/13.
//

import UIKit
import RxSwift
import RxRelay

class SearchPlanViewController: DeclarativeViewController {
    
    // MARK: - Properties
    let viewModel: SearchPlanViewModel
    let disposeBag = DisposeBag()
    
    // MARK: - Methods
    init(viewModel: SearchPlanViewModel) {
        self.viewModel = viewModel
        super.init()
        
        bind(to: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = SearchPlanView(viewModel: viewModel)
    }
    
    func bind(to viewModel: SearchPlanViewModel) {
        
        viewModel.actionRelay.subscribe(onNext: { [weak self] action in
            switch action {
                case .cancel:
                    self?.dismiss(animated: true, completion: nil)
                case .select:
                    break
            }
        }).disposed(by: disposeBag)
    }
}
