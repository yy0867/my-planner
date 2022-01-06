//
//  WeekCalander.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/05.
//

import UIKit
import RxSwift
import SnapKit
import JTAppleCalendar

class WeekCalendar: DeclarativeView {
    
    // MARK: - Properties
    let viewModel: PlanListViewModel
    let disposeBag = DisposeBag()
    
    lazy var calendar: JTACMonthView = {
        let monthView = JTACMonthView()
        
        monthView.allowsMultipleSelection = false
        monthView.scrollingMode = .stopAtEachCalendarFrame
        monthView.scrollDirection = .horizontal
        monthView.showsHorizontalScrollIndicator = false
        monthView.calendarDataSource = self
        monthView.calendarDelegate = self
        monthView.minimumInteritemSpacing = 3
        monthView.scrollToDate(Date(), animateScroll: false)
        monthView.selectDates([.now])
        
        monthView.register(DateCell.self, forCellWithReuseIdentifier: DateCell.reuseIdentifier)
        
        return monthView
    }()
    
    // MARK: - Methods
    init(frame: CGRect = .zero,
         viewModel: PlanListViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        constructHierarchy()
        activateConstraints()
        bind(to: viewModel)
    }
    
    private func constructHierarchy() {
        addSubview(calendar)
    }
    
    private func activateConstraints() {
        activateCalendarConstraints()
    }
    
    private func activateCalendarConstraints() {
        calendar.snp.makeConstraints { make in
            make.right.left.top.bottom.equalToSuperview()
        }
    }
    
    private func bind(to viewModel: PlanListViewModel) {
        
        viewModel.selectedDate
            .distinctUntilChanged()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] date in
                guard let strongSelf = self else { return }
                strongSelf.calendar.scrollToDate(date, animateScroll: true)
                strongSelf.calendar.selectDates([date])
            }).disposed(by: disposeBag)
    }
}

extension WeekCalendar: JTACMonthViewDelegate {
    func calendar(_ calendar: JTACMonthView,
                  willDisplay cell: JTACDayCell,
                  forItemAt date: Date,
                  cellState: CellState,
                  indexPath: IndexPath) {
        print(date.toString())
    }
    
    func calendar(_ calendar: JTACMonthView,
                  cellForItemAt date: Date,
                  cellState: CellState,
                  indexPath: IndexPath) -> JTACDayCell {
        guard let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: DateCell.reuseIdentifier,
                                                             for: indexPath) as? DateCell else {
            return JTACDayCell()
        }
        
        cell.handleCellState(cellState)
        
        return cell
    }
    
    func calendar(_ calendar: JTACMonthView,
                  didSelectDate date: Date,
                  cell: JTACDayCell?,
                  cellState: CellState,
                  indexPath: IndexPath) {
        guard let cell = cell as? DateCell else { return }
        cell.handleCellState(cellState)
        viewModel.changeDate(date: date)
    }
    
    func calendar(_ calendar: JTACMonthView,
                  didDeselectDate date: Date,
                  cell: JTACDayCell?,
                  cellState: CellState,
                  indexPath: IndexPath) {
        guard let cell = cell as? DateCell else { return }
        cell.handleCellState(cellState)
    }
}

extension WeekCalendar: JTACMonthViewDataSource {
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        
        return .init(startDate: .startDate,
                     endDate: .endDate,
                     numberOfRows: 1,
                     calendar: .autoupdatingCurrent,
                     generateInDates: .forFirstMonthOnly,
                     generateOutDates: .off,
                     firstDayOfWeek: .sunday,
                     hasStrictBoundaries: false)
    }
}
