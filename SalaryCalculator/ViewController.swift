//
//  ViewController.swift
//  SalaryCalculator
//
//  Created by Kyaw Lin on 16/6/60 BE.
//  Copyright © 2560 BE Kyaw Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dateTF: UITextField!{
        didSet{
            let date = Date()
            dateTF.text = Format.formatDate(date: date, format: "dd/MM/yyyy")
        }
    }
    @IBOutlet weak var startTF: UITextField!
    @IBOutlet weak var endTF: UITextField!
    
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    let timePicker2 = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatepickers()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    private func setupDatepickers(){
        //set up datePicker
        datePicker.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dateDonePressed))
        toolbar.setItems([doneButton], animated: false)
        dateTF.inputAccessoryView = toolbar
        dateTF.inputView = datePicker
        
        //set up timePickers
        timePicker.datePickerMode = .time
        timePicker2.datePickerMode = .time
        timePicker.date = Format.formatDate(string: startTF.text!,format: "hh:mm aa")
        timePicker2.date = Format.formatDate(string: endTF.text!,format: "hh:mm aa")
        let toolbar2 = UIToolbar()
        toolbar2.sizeToFit()
        let timeDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(timeDonePressed))
        toolbar2.setItems([timeDoneButton], animated: false)
        startTF.inputAccessoryView = toolbar2
        startTF.inputView = timePicker
        
        let toolbar3 = UIToolbar()
        toolbar3.sizeToFit()
        let timeDoneButton2 = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(timeDonePressed2))
        toolbar3.setItems([timeDoneButton2], animated: false)
        endTF.inputAccessoryView = toolbar3
        endTF.inputView = timePicker2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveButton(_ sender: UIButton) {
    }
    
    @IBAction func showDataButton(_ sender: UIButton) {
    }
    
    @objc func dateDonePressed(){
        dateTF.text = Format.formatDate(date: datePicker.date, format: "dd/MM/yyyy")
        view.endEditing(true)
    }
    
    @objc func timeDonePressed(){
        startTF.text = Format.formatDate(date: timePicker.date, format: "hh:mm aa")
        view.endEditing(true)
    }
    
    @objc func timeDonePressed2(){
        endTF.text = Format.formatDate(date: timePicker2.date, format: "hh:mm aa")
        view.endEditing(true)
    }
    
}

class Format{
    
    static func formatDate(date:Date,format:String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    static func formatDate(string:String,format:String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: string)!
    }
    
}

