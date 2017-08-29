//
//  ViewController.swift
//  SalaryCalculator
//
//  Created by Kyaw Lin on 2/4/60 BE.
//  Copyright © 2560 BE Kyaw Lin. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    private var breakTxt:String!
    @IBOutlet var datePickerTxt: UITextField!
    @IBOutlet var timePickerTxt: UITextField!
    @IBOutlet var timePickerTxt2: UITextField!
    @IBOutlet var `break`: UISwitch!{
        didSet{
            breakTxt = "yes"
        }
    }
    
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    let timePicker2 = UIDatePicker()
    
    var ref: FIRDatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createDatePicker()
        createTimePicker()
        datePickerTxt.text = formatDate()
        self.title = FIRAuth.auth()?.currentUser?.displayName
        ref = FIRDatabase.database().reference()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func breakSwitchChanged(_ sender: UISwitch) {
        if sender.isOn{
            breakTxt = "yes"
        }
        else{
            breakTxt = "no"
        }
    }
    
    //write data to database
    @IBAction func saveButtonClicked(_ sender: Any) {
        let date = formatDate(format: "dd-MM-yyyy", date: datePicker.date)
        let month = formatDate(format: "MM yyyy", date: datePicker.date)
        let uid =  FIRAuth.auth()?.currentUser?.uid
        self.ref?.child("users").child(uid!).child("schedule").child(month).child(date).setValue(["start":timePickerTxt.text!,"end":timePickerTxt2.text!,"break":breakTxt])
    }
    
    //create datePicker and timePicker
    private func createDatePicker(){
        
        datePicker.datePickerMode = .date
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        datePickerTxt.inputAccessoryView = toolbar
        datePickerTxt.inputView = datePicker
    }
    
    private func createTimePicker(){
        
        timePicker.datePickerMode = .time
        timePicker2.datePickerMode = .time
        
        let toolbar = UIToolbar()
        let toolbar2 = UIToolbar()
        toolbar.sizeToFit()
        toolbar2.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(timeDonePressed))
        let doneButton2 = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(timeDonePressed2))
        toolbar.setItems([doneButton], animated: false)
        toolbar2.setItems([doneButton2], animated: false)
        
        timePickerTxt.inputAccessoryView = toolbar
        timePickerTxt2.inputAccessoryView = toolbar2
        timePicker.date = formatTime(format: "hh:mm aa", time: timePickerTxt.text!)
        timePicker2.date = formatTime(format: "hh:mm aa", time: timePickerTxt2.text!)
        timePickerTxt.inputView = timePicker
        timePickerTxt2.inputView = timePicker2
    }
    
    private func formatTime(anyPicker: UIDatePicker) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: anyPicker.date)
    }
    
    private func formatDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: datePicker.date)
    }
    
    @objc private func timeDonePressed(){
        timePickerTxt.text = formatTime(anyPicker: timePicker)
        self.view.endEditing(true)
    }
    
    @objc private func timeDonePressed2(){
        timePickerTxt2.text = formatTime(anyPicker: timePicker2)
        self.view.endEditing(true)
    }
    @objc private func donePressed(){
        datePickerTxt.text = formatDate()
        self.view.endEditing(true)
    }
}

extension UIViewController{
    
    func formatTime(format:String,time:String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: time)!
        
    }
    
    func formatDate(format:String,date:Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
}

