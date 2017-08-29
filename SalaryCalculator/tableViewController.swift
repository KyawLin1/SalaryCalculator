//
//  tableViewController.swift
//  SalaryCalculator
//
//  Created by Kyaw Lin on 18/4/60 BE.
//  Copyright © 2560 BE Kyaw Lin. All rights reserved.
//

import UIKit
import Firebase

class tableViewController: UIViewController
, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var salaryLabel: UILabel!
    
    var ref: FIRDatabaseReference?
    let salaryCalculatorBrain = SalaryCalculatorBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        ref = FIRDatabase.database().reference()
        
        showData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.startTime.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! HistoryCell
        
        cell.dateLabel.text = items.workDate[indexPath.row]
        cell.dayLabel.text = items.workDay[indexPath.row]
        cell.startLabel.text = items.startTime[indexPath.row]
        cell.endLabel.text = items.endTime[indexPath.row]
        let brain = SalaryCalculatorBrain()
        cell.salaryLabel.text = String(brain.calculateDaily(index: indexPath.row))
        //cell.textLabel?.text = items.workDate[indexPath.row]+" "+items.workDay[indexPath.row]+"\t\t"+items.startTime[indexPath.row]+"\t"+items.endTime[indexPath.row] + "\t\(brain.calculateDaily(index: indexPath.row))"
        return cell
    }
    
    private func showData(){
        if items.today.isEmpty{
            let date = Date()
            items.today.append(salaryCalculatorBrain.formatDate(date: date, dateFormat: "dd-MM-yyyy"))
            items.thisMonth.append(salaryCalculatorBrain.formatDate(date: date, dateFormat: "MM yyyy"))
        }
        self.title = formatDate(format: "MMMM", date: formatTime(format: "MM yyyy", time: items.thisMonth))
        let uid = FIRAuth.auth()?.currentUser?.uid
        ref?.child("users").child(uid!).child("schedule").child(items.thisMonth).observeSingleEvent(of: .value, with: { (snapshot) in
            self.clearData()
            // Get user value
            if let data = snapshot.children.allObjects as? [FIRDataSnapshot]{
                for child in data{
                    let dateFormatter2 = DateFormatter()
                    dateFormatter2.dateFormat = "dd-MM-yyyy"
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "EEE"
                    let string = dateFormatter.string(from: dateFormatter2.date(from: child.key)!)
                    items.workDay.append(string)
                    dateFormatter.dateStyle = .short
                    items.workDate.append(dateFormatter.string(from: dateFormatter2.date(from: child.key)!))
                    if let childData = child.children.allObjects as? [FIRDataSnapshot]{
                        for child2 in childData{
                            let dataString = child2.value as! String
                            if child2.key == "start"{
                                items.startTime.append(dataString)
                            }else if child2.key == "end"{
                                items.endTime.append(dataString)
                            }else if child2.key == "break"{
                                items.breakBool.append(dataString)
                            }
                        }
                    }
                }
            }
            self.tableView.reloadData()
            let salary = String(self.salaryCalculatorBrain.calculate())
            self.salaryLabel.text = items.totalTime + " hours >> S$ " + salary
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    private class time: NSObject{
        var startTime: String?
        var endTime: String?
    }
    
    private func clearData(){
        items.startTime.removeAll()
        items.endTime.removeAll()
        items.workDate.removeAll()
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
