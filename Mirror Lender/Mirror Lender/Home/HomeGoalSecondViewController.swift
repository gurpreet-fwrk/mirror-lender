//
//  HomeGoalSecondViewController.swift
//  Mirror Lender
//
//  Created by Waheguru on 07/08/18.
//  Copyright © 2018 Pollysys. All rights reserved.
//

import Foundation
import UIKit
import EventKit
import VACalendar


class HomeGoalSecondViewController: UIViewController
{
    
    @IBOutlet var weekDaysView: VAWeekDaysView!
        {
        didSet {
            let appereance = VAWeekDaysViewAppearance(symbolsType: .veryShort, calendar: defaultCalendar)
            weekDaysView.appearance = appereance
        }
    }
    
    @IBOutlet var viewCalendar: UIView!
    
     var calendarView: VACalendarView!
    
    @IBOutlet var svMain: UIScrollView!
    
    let defaultCalendar: Calendar = {
        var calendar = Calendar.current
        calendar.firstWeekday = 1
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar
    }()
    
    override func viewDidLoad()
    {
        
        let calendar = VACalendar(calendar: defaultCalendar)
        calendarView = VACalendarView(frame: .zero, calendar: calendar)
        print(calendarView.frame)
        calendarView.showDaysOut = false
        calendarView.selectionStyle = .single
//        calendarView.monthDelegate = monthHeaderView
        calendarView.dayViewAppearanceDelegate = self
        calendarView.monthViewAppearanceDelegate = self
        calendarView.calendarDelegate = self
        calendarView.scrollDirection = .horizontal
        calendarView.isScrollEnabled = false
        //        calendarView.setSupplementaries([
        //            (Date().addingTimeInterval(-(60 * 60 * 70)), [VADaySupplementary.bottomDots([.red, .magenta])]),
        //            (Date().addingTimeInterval((60 * 60 * 110)), [VADaySupplementary.bottomDots([.red])]),
        //            (Date().addingTimeInterval((60 * 60 * 370)), [VADaySupplementary.bottomDots([.blue, .darkGray])]),
        //            (Date().addingTimeInterval((60 * 60 * 430)), [VADaySupplementary.bottomDots([.orange, .purple, .cyan])])
        //            ])
        viewCalendar.addSubview(calendarView)
    }
    
    override func viewDidLayoutSubviews()
    {
        svMain.contentSize = CGSize(width: self.view.frame.size.width, height: 420)
        
        if calendarView.frame == .zero
        {
            calendarView.frame = CGRect(
                x: 0,
                y: 20,
                width: view.frame.width-50,
                height: viewCalendar.frame.height - 20
            )
            calendarView.setup()
        }
    }
        
    @IBAction func moveBack(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("changePage"), object: "2")
    }
    
    @IBAction func moveToNextView(_ sender: Any)
    {
        NotificationCenter.default.post(name: Notification.Name("changePage"), object: "1")
    }
    
    @IBAction func EditProfilePic(_ sender: Any)
    {
    }
}

extension HomeGoalSecondViewController: VAMonthViewAppearanceDelegate {
    
    func leftInset() -> CGFloat {
        return 10.0
    }
    
    func rightInset() -> CGFloat {
        return 10.0
    }
    
    func verticalMonthTitleFont() -> UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    func verticalMonthTitleColor() -> UIColor {
        return .black
    }
    
    func verticalCurrentMonthTitleColor() -> UIColor {
        return .red
    }
    
}

extension HomeGoalSecondViewController: VADayViewAppearanceDelegate {
    
    func textColor(for state: VADayState) -> UIColor {
        switch state {
        case .out:
            return UIColor(red: 214 / 255, green: 214 / 255, blue: 219 / 255, alpha: 1.0)
        case .selected:
            return .white
        case .unavailable:
            return .lightGray
        default:
            return .white
        }
    }
    
    func textBackgroundColor(for state: VADayState) -> UIColor {
        switch state {
        case .selected:
            return UIColor(red: 60/255, green: 203/255, blue: 62/255, alpha: 1.0)
        default:
            return .clear
        }
    }
    
    func shape() -> VADayShape {
        return .circle
    }
    
    func dotBottomVerticalOffset(for state: VADayState) -> CGFloat {
        switch state {
        case .selected:
            return 2
        default:
            return -7
        }
    }
    
}

extension HomeGoalSecondViewController: VACalendarViewDelegate {
    
    func selectedDates(_ dates: [Date]) {
        calendarView.startDate = dates.last ?? Date()
        print(dates)
    }
    
}
