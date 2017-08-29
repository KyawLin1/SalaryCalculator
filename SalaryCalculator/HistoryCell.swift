//
//  LessonCell.swift
//  Attandance Taking System
//
//  Created by KyawLin on 5/21/17.
//  Copyright © 2017 KyawLin. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {
    
    
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "date"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let dayLabel:UILabel = {
        let label = UILabel()
        label.text = "day"
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let startLabel:UILabel = {
        let label = UILabel()
        label.text = "start"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let endLabel:UILabel = {
        let label = UILabel()
        label.text = "end"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let salaryLabel:UILabel = {
        let label = UILabel()
        label.text = "salary"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupContainerView()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func setupContainerView(){
        let containerView = UIView()
        contentView.addSubview(containerView)
        
        contentView.addConstraintsWithFormat("H:|[v0]|",views: containerView)
        contentView.addConstraintsWithFormat("V:[v0(90)]", views: containerView)
        contentView.addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1, constant: 0))
        
        containerView.addSubview(dateLabel)
        containerView.addSubview(dayLabel)
        containerView.addSubview(startLabel)
        containerView.addSubview(endLabel)
        containerView.addSubview(salaryLabel)
        
        containerView.addConstraintsWithFormat("H:|-20-[v0]", views: dateLabel)
        containerView.addConstraintsWithFormat("H:|-90-[v0]", views: dayLabel)
        containerView.addConstraintsWithFormat("H:|-130-[v0]", views: startLabel)
        containerView.addConstraintsWithFormat("H:|-210-[v0]", views: endLabel)
        containerView.addConstraintsWithFormat("H:|-290-[v0]", views: salaryLabel)
        
        containerView.addConstraintsWithFormat("V:|-25-[v0]", views: dateLabel)
        containerView.addConstraintsWithFormat("V:|-25-[v0]", views: dayLabel)
        containerView.addConstraintsWithFormat("V:|-25-[v0]", views: startLabel)
        containerView.addConstraintsWithFormat("V:|-25-[v0]", views: endLabel)
        containerView.addConstraintsWithFormat("V:|-25-[v0]", views: salaryLabel)
    }
    
}

extension UIView{
    
    func addConstraintsWithFormat(_ format: String, views: UIView...){
        
        var viewsDictionary = [String: UIView]()
        for(index,view) in views.enumerated(){
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
