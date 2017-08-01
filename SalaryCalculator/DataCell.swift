//
//  DataCell.swift
//  SalaryCalculator
//
//  Created by Kyaw Lin on 21/6/60 BE.
//  Copyright © 2560 BE Kyaw Lin. All rights reserved.
//

import UIKit

class DataCell: UITableViewCell {
    
    var workDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    var workDay: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    var startTime: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    var endTime: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    var dailySalary: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupContainerView()
        // Configure the view for the selected state
    }
    
    fileprivate func setupContainerView(){
        let containerView = UIView()
        contentView.addSubview(containerView)
        contentView.addConstraintsWithFormat("H:|[v0]|", views: containerView)
        contentView.addConstraintsWithFormat("V:[v0(100)]", views: containerView)
        //contentView.addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1, constant: 0))
        
        containerView.addSubview(workDate)
        containerView.addSubview(workDay)
        containerView.addSubview(startTime)
        containerView.addSubview(endTime)
        containerView.addSubview(dailySalary)
        
        containerView.addConstraintsWithFormat("H:|-20-[v0]-15-[v1]", views: workDate,workDay)
        containerView.addConstraintsWithFormat("H:[v0]-15-[v1]-80-|", views: startTime,endTime)
        containerView.addConstraintsWithFormat("H:|-310-[v0]", views: dailySalary)
        containerView.addConstraintsWithFormat("V:|-15-[v0]", views: workDate)
        containerView.addConstraintsWithFormat("V:|-15-[v0]", views: workDay)
        containerView.addConstraintsWithFormat("V:|-15-[v0]", views: startTime)
        containerView.addConstraintsWithFormat("V:|-15-[v0]", views: endTime)
        containerView.addConstraintsWithFormat("V:|-15-[v0]", views: dailySalary)
    }

}
extension UIView {
    
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
}
