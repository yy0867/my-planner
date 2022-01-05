//
//  PlanListView.swift
//  MyPlanner
//
//  Created by 김세영 on 2021/12/31.
//

import UIKit
import RxSwift
import SnapKit

// (ProfileImage) (DateSelector)            (+) (Search)
// (PrevWeekButton) (Date Sun ~ Sat)    (NextWeekButton)
class PlanListView: DeclarativeView {

    // MARK: - Properties
    lazy var titleBar: PlanListTitleBar = {
        return PlanListTitleBar(viewModel: viewModel)
    }()
    
    lazy var weekCalendar: WeekCalendar = {
        return WeekCalendar(viewModel: viewModel)
    }()
    
    let viewModel: PlanListViewModel

    // MARK: - Methods
    init(frame: CGRect = .zero,
         viewModel: PlanListViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        self.backgroundColor = Color.background
        constructHierarchy()
        activateConstraints()
        
        bind(to: viewModel)
    }
    
    private func constructHierarchy() {
        addSubview(titleBar)
        addSubview(weekCalendar)
    }
    
    private func activateConstraints() {
        activateTitleBarConstraints()
        activateWeekCalendarConstraints()
    }
    
    private func activateTitleBarConstraints() {
        titleBar.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(20)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(10)
        }
    }
    
    private func activateWeekCalendarConstraints() {
        weekCalendar.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(20)
            make.top.equalTo(titleBar.snp.bottom).offset(10)
            make.height.equalTo(100)
        }
    }
    
    private func bind(to viewModel: PlanListViewModelOutput) {
        
    }
}
