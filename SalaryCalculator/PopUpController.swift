//
//  PopUpController.swift
//  SalaryCalculator
//
//  Created by Kyaw Lin on 22/6/60 BE.
//  Copyright © 2560 BE Kyaw Lin. All rights reserved.
//

import UIKit
import NotificationCenter

class PopUpController: UIViewController {

    @IBOutlet weak var monthTF: UITextField!{
        didSet{
            let date = Date()
            monthTF.text = Format.formatDate(date: date, format: "MM yyyy")
        }
    }
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAnimate()
        setupDatePicker()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showButton(_ sender: UIButton) {
        items.thisMonth = monthTF.text!
        let nc = NotificationCenter.default
        nc.post(name: NSNotification.Name(rawValue: "updateTableView"), object: nil)
        removeAnimate()
    }
    
    private func setupDatePicker(){
        datePicker.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dateDonePressed))
        toolbar.setItems([doneButton], animated: false)
        monthTF.inputAccessoryView = toolbar
        monthTF.inputView = datePicker
    }
    
    @objc private func dateDonePressed(){
        monthTF.text = Format.formatDate(date: datePicker.date, format: "MM yyyy")
        view.endEditing(true)
    }
    
    private func showAnimate(){
        
        self.view.transform = CGAffineTransform(scaleX: 1.3,y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25) { 
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        
    }
    
    private func removeAnimate(){
        
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }) { (finished:Bool) in
            if finished{
                self.view.removeFromSuperview()
            }
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
