//
//  DateSelector.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/04.
//

import Foundation
import UIKit

class DateSelector: DeclarativeView {
    
    // MARK: - Properties
    weak var delegate: DateSelectorDelegate!
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        
        datePicker.calendar = .autoupdatingCurrent
        datePicker.timeZone = .current
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        datePicker.minimumDate = .startDate
        datePicker.maximumDate = .endDate
        datePicker.date = Date()
        
        return datePicker
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("완료", for: .normal)
        button.setTitleColor(Color.accentColor, for: .normal)
        button.addTarget(self,
                         action: #selector(datePickerDone),
                         for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Methods
    init(frame: CGRect = .zero,
         delegate: DateSelectorDelegate) {
        self.delegate = delegate
        super.init(frame: frame)
        
        constructHierarchy()
        activateConstraints()
    }
    
    private func constructHierarchy() {
        addSubview(doneButton)
        addSubview(datePicker)
    }
    
    private func activateConstraints() {
        activateDoneButtonConstraints()
        activateDatePickerConstraints()
    }
    
    private func activateDoneButtonConstraints() {
        doneButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(10)
        }
    }
    
    private func activateDatePickerConstraints() {
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(doneButton.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview().inset(10)
        }
    }
    
    @objc
    func datePickerDone() {
        delegate.dateSelector(self,
                              selectedDate: self.datePicker.date)
    }
}
