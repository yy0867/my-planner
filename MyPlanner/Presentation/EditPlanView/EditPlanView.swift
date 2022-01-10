//
//  EditPlanView.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/10.
//

import UIKit
import RxSwift
import SnapKit

class EditPlanView: DeclarativeView {
    
    // MARK: - Properties
    let viewModel: EditPlanViewModel
    let disposeBag = DisposeBag()
    
    lazy var titleTextField: ToolbarTextField = {
        let textField = ToolbarTextField()
        
        textField.borderStyle = .none
        textField.font = UIFont.boldSystemFont(ofSize: 24)
        textField.placeholder = "제목을 입력하세요."
        textField.addDoneButton()
        
        return textField
    }()
    
    lazy var colorLabel: UILabel = {
        let label = UILabel()
        label.text = "컬러 선택"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        label.isUserInteractionEnabled = false
        return label
    }()
    
    lazy var colorAccessoryArrow: UIImageView = {
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 17,
                                                             weight: .medium,
                                                             scale: .small)
        let accessoryArrow = UIImageView()
        if let image = UIImage(systemName: "arrowtriangle.right.fill",
                               withConfiguration: imageConfiguration) {
            accessoryArrow.image = image
            accessoryArrow.tintColor = .white
        }
        accessoryArrow.isUserInteractionEnabled = false
        return accessoryArrow
    }()
    
    lazy var selectColorStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [colorLabel,
                                                   colorAccessoryArrow])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.isUserInteractionEnabled = false
        return stack
    }()
    
    lazy var selectColorButton: UIButton = {
        let button = UIButton()
        button.tintColor = Color.accentColor
        button.configuration = .filled()
        button.configuration?.cornerStyle = .large
        
        button.addSubview(selectColorStack)
        selectColorStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.bottom.equalToSuperview().inset(10)
        }
        button.addTarget(self,
                         action: #selector(presentSelectColor),
                         for: .touchUpInside)
        
        return button
    }()
    
    lazy var selectDateField: DatePickerField = {
        let field = DatePickerField(mode: .date)
        
        field.datePicker.date = viewModel.getSelectedDate()
        field.textColor = Color.black
        field.font = UIFont.systemFont(ofSize: 19)
        field.addTarget(self,
                        action: #selector(dateSelected),
                        for: .editingDidEnd)
        
        return field
    }()
    
    lazy var selectTimeField: DatePickerField = {
        let field = DatePickerField(mode: .time)
        
        field.textColor = Color.black
        field.datePicker.date = viewModel.getSelectedDate()
        field.font = UIFont.systemFont(ofSize: 19)
        field.textAlignment = .right
        field.addTarget(self,
                        action: #selector(timeSelected),
                        for: .editingDidEnd)
        
        return field
    }()
    
    lazy var dateStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [selectDateField,
                                                   selectTimeField])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    lazy var notificationButton: UIButton = {
        let button = UIButton()
        
        button.setTitle(" 알림", for: .normal)
        button.setTitleColor(Color.black, for: .normal)
        button.tintColor = Color.accentColor
        if let deselect = UIImage(systemName: "square") {
            button.setImage(deselect, for: .normal)
        }
        if let select = UIImage(systemName: "checkmark.square.fill") {
            button.setImage(select, for: .selected)
        }
        button.addTarget(self,
                         action: #selector(toggleNotification),
                         for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Methods
    init(frame: CGRect = .zero,
         viewModel: EditPlanViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        self.backgroundColor = Color.background
        constructHierarchy()
        activateConstraints()
        bind(to: viewModel)
    }
    
    private func constructHierarchy() {
        addSubview(titleTextField)
        addSubview(selectColorButton)
        addSubview(dateStack)
        addSubview(notificationButton)
    }
    
    private func activateConstraints() {
        activateTitleTextFieldConstraints()
        activateSelectColorButtonConstraints()
        activateDateStackConstraints()
        activateNotificationButtonConstraints()
    }
    
    private func bind(to viewModel: EditPlanViewModel) {
//        viewModel.inputDate
//            .subscribe(onNext: { [weak self] selectedDate in
//                guard let strongSelf = self else { return }
//                strongSelf.setSelectedDateFieldText(to: selectedDate)
//            }).disposed(by: disposeBag)
//
//        viewModel.inputTime
//            .subscribe(onNext: { [weak self] time in
//                guard let strongSelf = self else { return }
//                strongSelf.setSelectedTimeFieldText(to: time)
//            }).disposed(by: disposeBag)
//
        viewModel.inputNotification
            .bind(to: notificationButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        viewModel.inputColor
            .map { UIColor($0) }
            .bind(to: selectColorButton.rx.tintColor,
                  notificationButton.rx.tintColor)
            .disposed(by: disposeBag)
        
        viewModel.inputTitle
            .map { $0 }
            .bind(to: titleTextField.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.inputDate
            .map { $0.toString(format: "YYYY.M.d (EEE)") }
            .bind(to: selectDateField.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.inputTime
            .map { $0.toString(format: "HH:mm") }
            .bind(to: selectTimeField.rx.text)
            .disposed(by: disposeBag)
        
        selectDateField.datePicker.rx.date
            .bind(to: viewModel.inputDate)
            .disposed(by: disposeBag)
        
        selectTimeField.datePicker.rx.date
            .bind(to: viewModel.inputTime)
            .disposed(by: disposeBag)
        
        titleTextField.rx.text.orEmpty
            .bind(to: viewModel.inputTitle)
            .disposed(by: disposeBag)
    }
    
    private func activateTitleTextFieldConstraints() {
        titleTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(20)
        }
    }
    
    private func activateSelectColorButtonConstraints() {
        selectColorButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.top.equalTo(titleTextField.snp.bottom).offset(30)
        }
    }
    
    private func activateDateStackConstraints() {
        dateStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.top.equalTo(selectColorButton.snp.bottom).offset(30)
        }
    }
    
    private func activateNotificationButtonConstraints() {
        notificationButton.snp.makeConstraints { make in
            make.top.equalTo(dateStack.snp.bottom).offset(20)
            make.right.equalTo(dateStack.snp.right)
        }
    }
    
    private func setSelectedDateFieldText(to date: Date) {
        let selectedDate = date.toString(format: "YYYY.M.d (EEE)")
        selectDateField.text = selectedDate
    }
    
    private func setSelectedTimeFieldText(to time: Date) {
        let selectedTime = time.toString(format: "HH:mm")
        selectTimeField.text = selectedTime
    }
    
    @objc
    func presentSelectColor() {
        viewModel.presentColorSelector()
    }
    
    @objc
    func dateSelected() {
        let selectedDate = selectDateField.datePicker.date
        
        setSelectedDateFieldText(to: selectedDate)
    }
    
    @objc
    func timeSelected() {
        let selectedTime = selectTimeField.datePicker.date
        
        setSelectedTimeFieldText(to: selectedTime)
    }
    
    @objc
    func toggleNotification() {
        viewModel.toggleNotification()
    }
}
