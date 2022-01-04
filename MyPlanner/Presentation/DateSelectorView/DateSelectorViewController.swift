//
//  DateSelectorView.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/04.
//

import Foundation
import SnapKit
import UIKit

class DateSelectorViewController: DeclarativeViewController {
    
    // MARK: - Property
    lazy var dateSelector: DateSelector = {
        let selector = DateSelector(delegate: self)
        return selector
    }()
    
    let viewModel: PlanListViewModel
    
    // MARK: - Methods
    init(viewModel: PlanListViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color.background
        self.view.addSubview(dateSelector)
        dateSelector.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview().inset(10)
        }
    }
}

extension DateSelectorViewController: DateSelectorDelegate {
    
    func dateSelector(_ dateSelector: DateSelector, selectedDate: Date) {
        print(selectedDate.toString())
        viewModel.changeDate(date: selectedDate)
        self.dismiss(animated: true)
    }
}
