//
//  SearchResultCell.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/13.
//

import UIKit
import SnapKit

class SearchResultCell: UITableViewCell {
    
    // MARK: - Properties
    static let reuseIdentifier = String(describing: SearchResultCell.self)
    
    lazy var colorView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 13)
        
        return label
    }()
    
    lazy var planName: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        
        return label
    }()
    
    lazy var planStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateLabel,
                                                       timeLabel,
                                                       planName])
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        
        return stackView
    }()
    
    // MARK: - Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .white
        self.selectionStyle = .gray
        
        constructHierarchy()
        activateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("DateCell.init(coder:) is called.")
    }
    
    private func constructHierarchy() {
        addSubview(colorView)
        addSubview(planStack)
    }
    
    private func activateConstraints() {
        activateColorViewContraints()
        activatePlanStackConstraints()
    }
    
    private func activateColorViewContraints() {
        
        colorView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.bottom.equalToSuperview().inset(30)
        }
    }
    
    private func activatePlanStackConstraints() {
        
        planStack.snp.makeConstraints { make in
            make.left.equalTo(colorView.snp.right).offset(20)
            make.top.bottom.equalToSuperview().inset(10)
            make.right.equalToSuperview().offset(20)
        }
    }
    
    public func configureCell(color: Plan.Color,
                              date: Date,
                              name: String,
                              achieve: Bool) {
        colorView.tintColor = UIColor(color)
        dateLabel.text = date.toString(format: "YYYY / M / D (EEE)")
        timeLabel.text = date.toString(format: "HH:mm")
        planName.text = name
        
        
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 20,
                                                             weight: .light,
                                                             scale: .large)
        if let image = UIImage(systemName: achieve ? "checkmark.square.fill" : "square.fill",
                               withConfiguration: imageConfiguration) {
            colorView.image = image
        }
        
    }
}
