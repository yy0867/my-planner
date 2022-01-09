//
//  DatePickerField.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/09.
//

import Foundation
import UIKit

class DatePickerField: ToolbarTextField {
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        
        picker.timeZone = .current
        picker.locale = .init(identifier: "KST")
        picker.calendar = .autoupdatingCurrent
        picker.preferredDatePickerStyle = .wheels
        
        return picker
    }()
    
    init(frame: CGRect = .zero,
         mode: UIDatePicker.Mode) {
        
        super.init(frame: frame)
        self.addDoneButton()
        
        datePicker.datePickerMode = mode
        setInputViewToDatePicker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("DatePickerField.init(coder:) called.")
    }
    
    private func setInputViewToDatePicker() {
        self.inputView = datePicker
    }
    
    public func setInitialDate(to date: Date) {
        datePicker.date = date
    }
}
