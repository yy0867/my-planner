//
//  WeekCalander.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/05.
//

import UIKit
import RxSwift
import SnapKit

class WeekCalendar: DeclarativeView {
    
    // MARK: - Properties
    let viewModel: PlanListViewModel
    
    lazy var prevWeekButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        
        if let image = UIImage(systemName: "arrowtriangle.left.fill") {
            button.setImage(image, for: .normal)
        }
        
        return button
    }()
    
    lazy var nextWeekButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        
        if let image = UIImage(systemName: "arrowtriangle.right.fill") {
            button.setImage(image, for: .normal)
        }
        
        return button
    }()
    
    lazy var calendar: UIStackView = {
        let stack = UIStackView()
        
        return stack
    }()
    
    // MARK: - Methods
    init(frame: CGRect = .zero,
         viewModel: PlanListViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        constructHierarchy()
        activateConstraints()
    }
    
    private func constructHierarchy() {
        addSubview(prevWeekButton)
        addSubview(calendar)
        addSubview(nextWeekButton)
    }
    
    private func activateConstraints() {
        activatePrevWeekButtonConstraints()
        activateCalendarConstraints()
        activateNextWeekButtonConstraints()
    }
    
    private func activatePrevWeekButtonConstraints() {
        prevWeekButton.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }
    
    private func activateCalendarConstraints() {
        calendar.snp.makeConstraints { make in
            make.left.equalTo(prevWeekButton.snp.right).offset(15)
            make.top.bottom.equalToSuperview()
        }
    }
    
    private func activateNextWeekButtonConstraints() {
        nextWeekButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.left.equalTo(calendar.snp.right).offset(15)
            make.top.bottom.equalToSuperview()
        }
    }
}
