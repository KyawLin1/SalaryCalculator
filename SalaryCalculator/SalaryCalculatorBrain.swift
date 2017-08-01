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
    let dateFormatter = DateFormatter()
    
    public func formatDate(date:Date,dateFormat:String) -> String{
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }
    
    public func calculate(){
        totalTime = 0.0
        holiday = 0.0
        weekday = 0.0
        GlobalData.salary = 0.0
        if items.startTime.count > 0{
            for i in 1...items.startTime.count{
                let sTime = Format.formatDate(string: items.startTime[i-1], format: "hh:mm aa")
                let eTime = Format.formatDate(string: items.endTime[i-1], format: "hh:mm aa")
                var timeInterval = eTime.timeIntervalSince(sTime)/3600
                let latestTime = Format.formatDate(string: "04:00 PM", format: "hh:mm aa")
                if sTime < latestTime{
                    timeInterval = timeInterval - 1
                }
                switch items.workDay[i-1]{
                    case "Sat","Sun":
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
            GlobalData.totalWorkingHour = totalTime
            GlobalData.salary = holiday*8.5 + weekday*7
            if totalTime >= 60 {
                GlobalData.actSalary = GlobalData.salary * 1.12
            }
        }
    }
    
    public func calculateDaily(start:String,end:String,brk:String,workDay:String){
        
        var salary = 0.0
        let sTime = Format.formatDate(string: start, format: "hh:mm aa")
        let eTime = Format.formatDate(string: end, format: "hh:mm aa")
        var timeInterval = eTime.timeIntervalSince(sTime)/3600
        let latestTime = Format.formatDate(string: "04:00 PM", format: "hh:mm aa")
        if sTime < latestTime{
            timeInterval = timeInterval - 1
        }
        switch workDay{
        case "Sat","Sun":
            salary = 8.5
        default:
            salary = 7.0
        }
        items.dailySalary.append(String(timeInterval * salary))
        
    }
}
