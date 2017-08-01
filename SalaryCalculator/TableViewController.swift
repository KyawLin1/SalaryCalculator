//
//  TableViewController.swift
//  SalaryCalculator
//
//  Created by Kyaw Lin on 18/6/60 BE.
//  Copyright © 2560 BE Kyaw Lin. All rights reserved.
//

import UIKit
import FirebaseDatabase
import NotificationCenter

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    let salaryCalculatorBrain = SalaryCalculatorBrain()
    
    var databaseRef: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        databaseRef = FIRDatabase.database().reference()
        showData()
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(updateTableView), name: NSNotification.Name(rawValue: "updateTableView"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    @objc private func updateTableView(){
        self.showData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Month(_ sender: UIBarButtonItem) {
        
        let popupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopUp") as! PopUpController
        self.addChildViewController(popupVC)
        popupVC.view.frame = self.view.frame
        self.view.addSubview(popupVC.view)
        popupVC.didMove(toParentViewController: self)
        
    }
    
    private func showData(){
        if items.thisMonth.isEmpty{
            let date = Date()
            items.thisMonth.append(Format.formatDate(date: date, format: "MM yyyy"))
        }
        self.title = Format.formatDate(date: Format.formatDate(string: items.thisMonth, format: "MM yyyy"), format: "MMMM")
        let userUID = UserDefaults.standard.string(forKey: "uid")
        databaseRef.child("users").child(userUID!).child("schedule").child(items.thisMonth).observeSingleEvent(of: .value, with: {(snapshot) in
            
            self.clearData()
            if let data = snapshot.children.allObjects as? [FIRDataSnapshot]{
                for child in data{
                    var start = ""
                    var end = ""
                    var brk = ""
                    var workDay = ""
                    /*let dateFormatter2 = DateFormatter()
                     dateFormatter2.dateStyle = .full
                     let dateFormatter = DateFormatter()
                     dateFormatter.dateFormat = "EEEE"*/
                    let string = Format.formatDate(date: Format.formatDate(string: child.key, format: "dd-MM-yyyy"), format: "EEE")
                    //dateFormatter.string(from: dateFormatter2.date(from: child.key)!)
                    items.workDay.append(string)
                    //dateFormatter.dateStyle = .short
                    let date = Format.formatDate(date: Format.formatDate(string: child.key, format: "dd-MM-yyyy"), format: "dd-MM")
                    items.workDate.append(date)
                    workDay = string
                    if let childData = child.children.allObjects as? [FIRDataSnapshot]{
                        for child2 in childData{
                            let dataString = child2.value as! String
                            if child2.key == "start"{
                                start = dataString
                                items.startTime.append(dataString)
                            }else if child2.key == "end"{
                                end = dataString
                                items.endTime.append(dataString)
                            }else if child2.key == "break"{
                                brk = dataString
                                items.breakBool.append(dataString)
                            }
                        }
                    }
                    self.salaryCalculatorBrain.calculateDaily(start: start,end: end,brk: brk,workDay: workDay)
                }
            }
            self.tableView.reloadData()
            self.salaryCalculatorBrain.calculate()
            self.hourLabel.text = "Hours: " + String(GlobalData.totalWorkingHour)
            if GlobalData.actSalary > 0.0{
                self.salaryLabel.text = "Salary: " + String(GlobalData.salary) + " * 12% = " + String(GlobalData.actSalary)
            }
            else{
                self.salaryLabel.text = "Salary: " + String(GlobalData.salary)
            }
        })
    }
    
    private func clearData(){
        items.startTime.removeAll()
        items.endTime.removeAll()
        items.workDate.removeAll()
        items.breakBool.removeAll()
        items.holidayWorkTime.removeAll()
        items.weekdayWorkTime.removeAll()
        items.workDay.removeAll()
        items.dailySalary.removeAll()
        GlobalData.actSalary = 0.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? DataCell)!
        cell.workDate.text = items.workDate[indexPath.row]
        cell.workDay.text = items.workDay[indexPath.row]
        cell.startTime.text = items.startTime[indexPath.row]
        cell.endTime.text = items.endTime[indexPath.row]
        cell.dailySalary.text = "$" + items.dailySalary[indexPath.row]
        /*let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = items.workDate[indexPath.row]+" "+items.workDay[indexPath.row]+"\t\t"+items.startTime[indexPath.row]+"\t"+items.endTime[indexPath.row]*/
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.startTime.count
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
