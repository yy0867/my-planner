//
//  PlanListCell.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/06.
//

import UIKit
import SnapKit

class PlanListCell: UITableViewCell {
    
    enum TimeLineMode: String {
        case only = "Only"
        case first = "First"
        case last = "Last"
        case middle = "Middle"
        
        func getImage(achieve: Bool) -> UIImage {
            let achievement = achieve ? "Achieve" : ""
            return UIImage(named: self.rawValue + achievement) ?? UIImage()
        }
    }
    
    // MARK: - Properties
    static let reuseIdentifier = String(describing: PlanListCell.self)
    weak var viewModel: PlanListViewModel?
    var toggleAchieveAction: (() -> ()) = { }
    
    lazy var timeLine: UIButton = {
        let button = UIButton()
        
        button.contentMode = .scaleAspectFit
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self,
                         action: #selector(toggleAchieve),
                         for: .touchUpInside)
        
        return button
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = Color.black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        
        return label
    }()
    
    lazy var planTitle: PaddingLabel = {
        let label = PaddingLabel()
        
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.layer.cornerRadius = 25
        label.layer.masksToBounds = true
        
        return label
    }()
    
    // MARK: - Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .white
        self.selectionStyle = .none
        
        constructHierarchy()
        activateConstraints()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("PlanListCell.init(coder:) is called.")
    }
    
    public func configureCell(plan: Plan,
                              mode: TimeLineMode,
                              action: @escaping () -> ()) {
        setTimeLineAction(action)
        setTimeLineMode(mode, achieve: plan.achieve)
        setTimeLabel(of: plan)
        setPlanTitleAndColor(of: plan)
    }
    
    private func setTimeLineAction(_ action: @escaping () -> ()) {
        self.toggleAchieveAction = action
    }
    
    private func setTimeLineMode(_ mode: TimeLineMode,
                                 achieve: Bool) {
        timeLine.setImage(mode.getImage(achieve: achieve),
                          for: .normal)
    }
    
    private func setTimeLabel(of plan: Plan) {
        let time = plan.date.toString(format: "HH:mm")
        timeLabel.text = time
    }
    
    private func setPlanTitleAndColor(of plan: Plan) {
        let title = plan.name
        planTitle.text = title
        planTitle.backgroundColor = UIColor(plan.color)
    }
    
    private func constructHierarchy() {
        self.contentView.addSubview(timeLine)
        self.contentView.addSubview(timeLabel)
        self.contentView.addSubview(planTitle)
    }
    
    private func activateConstraints() {
        activateTimeLineConstraints()
        activateTimeLabelConstraints()
        activatePlanTitleConstraints()
    }
    
    private func addTargets() {
    }
    
    private func activateTimeLineConstraints() {
        timeLine.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalTo(45)
        }
    }
    
    private func activateTimeLabelConstraints() {
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(timeLine.snp.right).offset(5)
            make.centerY.equalToSuperview()
            make.width.equalTo(50)
        }
    }
    
    private func activatePlanTitleConstraints() {
        planTitle.snp.makeConstraints { make in
            make.left.equalTo(timeLabel.snp.right).offset(15)
            make.right.equalToSuperview().inset(15)
            make.top.bottom.equalToSuperview().inset(15)
        }
    }
    
    @objc
    private func toggleAchieve() {
        toggleAchieveAction()
    }
}
