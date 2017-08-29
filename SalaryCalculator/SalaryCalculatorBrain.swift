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
    
    public func calculate() -> Double{
        
        reset()
        if items.startTime.count > 0{
            for i in 1...items.startTime.count{
                dateFormatter.dateStyle = .none
                dateFormatter.timeStyle = .short
                dateFormatter.dateFormat = "hh:mm aa"
                let sTime = dateFormatter.date(from: items.startTime[i-1])!
                let eTime = dateFormatter.date(from: items.endTime[i-1])!
                var timeInterval = eTime.timeIntervalSince(sTime)/3600
                let latestTime = formatTime(format: "hh:mm aa", string: "04:00 PM")
                if sTime < latestTime{
                    timeInterval = timeInterval - 1.0
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
            items.totalTime.append(String(totalTime))
            salary = holiday*8.5 + weekday*7
            if totalTime > 60 {
                salary = salary * 1.12
            }
            
        }
        return salary
    }
    
    private func reset(){
        items.holidayWorkTime.removeAll()
        items.weekdayWorkTime.removeAll()
        items.totalTime.removeAll()
    }
    
    public func calculateDaily(index:Int) -> Double{
        var salary = 0.0
        
        let sTime = formatTime(format: "hh:mm aa", string: items.startTime[index])
        let eTime = formatTime(format: "hh:mm aa", string: items.endTime[index])
        var timeInterval = eTime.timeIntervalSince(sTime)/3600
        let latestTime = formatTime(format: "hh:mm aa", string: "04:00 PM")
        if sTime < latestTime{
            timeInterval = timeInterval - 1.0
        }
        switch items.workDay[index]{
        case "Sat","Sun":
            salary = timeInterval * 8.5
        default:
            salary = timeInterval * 7
        }
        return salary
    }
}

extension SalaryCalculatorBrain{
    func formatTime(format:String,string:String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: string)!
        
    }
    
    func formatDate(format:String,date:Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}



