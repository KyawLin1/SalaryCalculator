//
//  DateTimePicker.swift
//  SalaryCalculator
//
//  Created by Kyaw Lin on 17/4/60 BE.
//  Copyright © 2560 BE Kyaw Lin. All rights reserved.
//

import Foundation
import UIKit

class DateTimePicker{
    
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    
    var datePickerTxt = UITextField()
    var timePickerTxt = UITextField()
    var timePickerTxt2 = UITextField()
    
    var viewController = ViewController()
    
    public func createDatePicker(textField:UITextField, view:ViewController){
        
        viewController = view
        datePickerTxt = textField
        datePicker.datePickerMode = .date
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        textField.inputAccessoryView = toolbar
        textField.inputView = datePicker
        
    }
    
    public func createTimePicker(textField:UITextField, textField2:UITextField){
        timePickerTxt = textField
        timePickerTxt2 = textField2
        timePicker.datePickerMode = .time
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let toolbar2 = UIToolbar()
        toolbar2.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(timeDonePressed))
        
        let doneButton2 = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(timeDonePressed2))
        
        toolbar.setItems([doneButton], animated: false)
        toolbar2.setItems([doneButton2], animated: false)
        
        textField.inputAccessoryView = toolbar
        textField2.inputAccessoryView = toolbar2
        
        textField.inputView = timePicker
        textField2.inputView = timePicker
    }
    
    public func formatDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: datePicker.date)
    }
    
    public func formatTime() -> String{
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short
        return timeFormatter.string(from: timePicker.date)
    }
    @objc private func timeDonePressed(){
        timePickerTxt.text = formatTime()
        viewController.view.endEditing(true)
    }
    
    @objc private func timeDonePressed2(){
        timePickerTxt2.text = formatTime()
        viewController.view.endEditing(true)
    }
    @objc private func donePressed(){
        datePickerTxt.text = formatDate()
        viewController.view.endEditing(true)
    }

}
