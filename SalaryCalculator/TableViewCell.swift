//
//  TableViewCell.swift
//  SalaryCalculator
//
//  Created by Kyaw Lin on 27/8/60 BE.
//  Copyright © 2560 BE Kyaw Lin. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    let dateLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let dayLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let startLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let endLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let salaryLabel:UILabel = {
        let label = UILabel()
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
        
        contentView.addConstraintsWithFormat("H:|[v0]|", views: containerView)
        contentView.addConstraintsWithFormat("V:[v0(90)]", views: containerView)
        contentView.addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1, constant: 0))
        
        containerView.addSubview(dateLabel)
        containerView.addSubview(dayLabel)
        containerView.addSubview(startLabel)
        containerView.addSubview(endLabel)
        //containerView.addSubview(salaryLabel)
        
        containerView.addConstraintsWithFormat("H:|-10-[v0]", views: dateLabel)
        containerView.addConstraintsWithFormat("H:|-60-[v0]", views: dayLabel)
        containerView.addConstraintsWithFormat("H:|-140-[v0]-20-[v1]", views: startLabel,endLabel)
        //containerView.addConstraintsWithFormat("H:|-200-[v0]", views: endLabel)
        
        containerView.addConstraintsWithFormat("V:|-5-[v0]", views: dateLabel)
        containerView.addConstraintsWithFormat("V:|-5-[v0]", views: dayLabel)
        containerView.addConstraintsWithFormat("V:|-5-[v0]", views: startLabel)
        containerView.addConstraintsWithFormat("V:|-5-[v0]", views: endLabel)
        
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

