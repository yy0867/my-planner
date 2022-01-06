//
//  PlanListTitleBar.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/04.
//

import UIKit
import SnapKit
import RxSwift

class PlanListTitleBar: UIView {
    
    // MARK: - Properties
    lazy var profileButton: UIButton = {
        let button = UIButton()
        
        if let image = UIImage(named: "DefaultProfile") {
            button.setImage(image, for: .normal)
        }
        return button
    }()
    
    let datePresentor: UIButton = {
        let button = UIButton()
        
        button.setTitle(Date().toString(format: "YYYY년 M월 d일 (E)"),
                        for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        return button
    }()
    
    let dateArrow: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        
        if let image = UIImage(systemName: "arrowtriangle.down.fill") {
            button.setImage(image, for: .normal)
        }
        
        return button
    }()
    
    lazy var dateSelector: UIStackView = {
        let dateSelector = UIStackView(arrangedSubviews: [datePresentor,
                                                          dateArrow])
        
        dateSelector.axis = .horizontal
        dateSelector.spacing = 5
        
        return dateSelector
    }()
    
    lazy var addPlanButton: UIButton = {
        let button = UIButton()
        button.tintColor = Color.buttonNotSelected
        
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .large)
        if let image = UIImage(systemName: "plus",
                               withConfiguration: imageConfiguration) {
            button.setTitleColor(Color.buttonSelected, for: .selected)
            button.setImage(image, for: .normal)
        }
        
        return button
    }()
    
    lazy var searchPlanButton: UIButton = {
        let button = UIButton()
        button.tintColor = Color.buttonNotSelected
        
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .large)
        if let image = UIImage(systemName: "magnifyingglass",
                               withConfiguration: imageConfiguration) {
            button.setTitleColor(Color.buttonSelected, for: .selected)
            button.setImage(image, for: .normal)
        }
        
        return button
    }()
    
    lazy var titleBarStack: UIStackView = {
        let profileAndDateSelector = UIStackView(arrangedSubviews: [profileButton,
                                                                    dateSelector])
        profileAndDateSelector.axis = .horizontal
        profileAndDateSelector.distribution = .fillProportionally
        profileAndDateSelector.spacing = 20
        
        let addAndSearchButton = UIStackView(arrangedSubviews: [addPlanButton,
                                                                searchPlanButton])
        
        addAndSearchButton.axis = .horizontal
        addAndSearchButton.spacing = 17
        
        let titleBar = UIStackView(arrangedSubviews: [profileAndDateSelector,
                                                      addAndSearchButton])
        
        titleBar.axis = .horizontal
        titleBar.distribution = .equalSpacing
        
        return titleBar
    }()
    
    let viewModel: PlanListViewModel
    let disposeBag = DisposeBag()
    
    // MARK: - Methods
    init(frame: CGRect = .zero,
         viewModel: PlanListViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        bind(to: viewModel)
        constructHierarchy()
        activateConstraints()
        addTargets()
    }
    
    override init(frame: CGRect) {
        fatalError(
            "PlanListTitleBar.init(frame:) called.\n" +
            "Call init(frame:viewModel:) instead."
        )
    }
    
    private func bind(to viewModel: PlanListViewModel) {
        viewModel.selectedDate.subscribe(onNext: { [weak self] date in
            guard let strongSelf = self else { return }
            strongSelf.datePresentor.setTitle(date.toString(format: "YYYY년 M월 d일 (E)"),
                                              for: .normal)
        }).disposed(by: disposeBag)
    }
    
    private func constructHierarchy() {
        addSubview(titleBarStack)
    }
    
    private func activateConstraints() {
        activateConstraintsTitleBar()
    }
    
    private func activateConstraintsTitleBar() {
        titleBarStack.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    private func addTargets() {
        addTargetForProfile()
        addTargetForDateSelector()
        addTargetForAddPlan()
        addTargetForSearchPlan()
    }
    
    private func addTargetForProfile() {
        profileButton.addTarget(viewModel,
                                action: #selector(viewModel.presentProfile),
                                for: .touchUpInside)
    }
    
    private func addTargetForDateSelector() {
        datePresentor.addTarget(viewModel,
                                action: #selector(viewModel.presentDateSelector),
                                for: .touchUpInside)
        dateArrow.addTarget(viewModel,
                            action: #selector(viewModel.presentDateSelector),
                            for: .touchUpInside)
    }
    
    private func addTargetForAddPlan() {
        addPlanButton.addTarget(viewModel,
                                action: #selector(viewModel.presentAddPlan),
                                for: .touchUpInside)
    }
    
    private func addTargetForSearchPlan() {
        searchPlanButton.addTarget(viewModel,
                                   action: #selector(viewModel.presentSearchPlan),
                                   for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("PlanListTitleBar.init(coder:) called.")
    }
}
