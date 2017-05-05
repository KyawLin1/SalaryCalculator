//
//  SalaryCalculatorBrain.swift
//  SalaryCalculator
//
//  Created by Kyaw Lin on 20/4/60 BE.
//  Copyright © 2560 BE Kyaw Lin. All rights reserved.
//

import Foundation

class SalaryCalculatorBrain{
    
    private var totalTime = 0.0
    private var holiday = 0.0
    private var weekday = 0.0
    private var salary = 0.0
    let dateFormatter = DateFormatter()
    
    public func formatDate(date:Date,dateFormat:String) -> String{
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }
    
    public func calculate(){
        
        if items.startTime.count > 0{
            for i in 1...items.startTime.count{
                dateFormatter.dateStyle = .none
                dateFormatter.timeStyle = .short
                dateFormatter.dateFormat = "hh:mm aa"
                let sTime = dateFormatter.date(from: items.startTime[i-1])!
                let eTime = dateFormatter.date(from: items.endTime[i-1])!
                let timeInterval = eTime.timeIntervalSince(sTime)/3600
                switch items.workDay[i-1]{
                    case "Saturday","Sunday":
                        items.holidayWorkTime.append(String(timeInterval))
                    default:
                        items.weekdayWorkTime.append(String(timeInterval))
                }
            }
            
            if items.holidayWorkTime.count > 0{
                for i in 1...items.holidayWorkTime.count{
                    holiday += Double(items.holidayWorkTime[i-1])!
                }
            }
            
            if items.weekdayWorkTime.count > 0{
                for i in 1...items.weekdayWorkTime.count{
                    weekday += Double(items.weekdayWorkTime[i-1])!
                }
            }
            
            totalTime = holiday + weekday
            salary = holiday*8.5 + weekday*7
            print(salary)
        }
    }
}
