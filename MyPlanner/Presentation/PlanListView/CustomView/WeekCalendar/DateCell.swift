//
//  DateCell.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/05.
//

import UIKit
import SnapKit
import JTAppleCalendar

class DateCell: JTACDayCell {
    
    // MARK: - Properties
    static let reuseIdentifier: String = "DateCellReuseIdentifier"
    
    lazy var day: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.lineBreakMode = .byClipping
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        
        return label
    }()
    
    lazy var weekOfDay: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        
        return label
    }()
    
    lazy var dayStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [day, weekOfDay])
        
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .center
        
        return stack
    }()
    
    // MARK: - Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 10
        constructHierarchy()
        activateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("DateCell.init(coder:) is called.")
    }
    
    override func prepareForReuse() {
        self.day.textColor = Color.black
        self.weekOfDay.textColor = Color.black
        self.backgroundColor = .white
    }
    
    
    
    public func handleCellState(_ cellState: CellState) {
        setDate(cellState: cellState)
        colorDate(cellState: cellState)
        if cellState.isSelected {
            setSelected()
        } else {
            setDeselected()
        }
    }
    
    private func setDate(cellState: CellState) {
        let day = String(cellState.date.getComponent(of: .day))
        let weekOfDay = cellState.date.toString(format: "EEE")
        
        self.day.text = day
        self.weekOfDay.text = weekOfDay
    }
    
    private func setSelected() {
        self.backgroundColor = Color.accentColor
    }
    
    private func setDeselected() {
        self.backgroundColor = .white
    }
    
    private func colorDate(cellState: CellState) {
        var color: UIColor
        
        if cellState.isSelected {
            color = Color.dateSelected
        } else {
            switch cellState.day {
                case .saturday:
                    color = Color.saturday
                case .sunday:
                    color = Color.sunday
                default:
                    color = Color.black
            }
        }
        
        self.day.textColor = color
        self.weekOfDay.textColor = color
    }
    
    private func constructHierarchy() {
        addSubview(dayStack)
    }
    
    private func activateConstraints() {
        dayStack.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
}
