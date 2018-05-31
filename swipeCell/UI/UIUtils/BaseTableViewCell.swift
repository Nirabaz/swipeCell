//
//  BaseTableViewCell.swift
//  swipeCell
//
//  Created by Mykhailo Zabarin on 5/30/18.
//  Copyright © 2018 Selecto. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    //MARK: - Luifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Class Methods
    
    class var className: String {
        return String(describing: self)
    }
    
    class var cellIdentifier: String {
        assertionFailure("Method 'cellIdentifier' need to be overriden in SELBaseTableViewCell subclass")
        return ""
    }
    
    class func nibName() -> String {
        return String(describing: className).components(separatedBy: ".").last!
    }
    
    class func registerForTableView(aTableView: UITableView) {
        let nib = UINib(nibName: className, bundle:nil)
        aTableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }

    @objc func anotherMenuWasShown(notification: NSNotification) {
        //override in child class
    }
    
}
