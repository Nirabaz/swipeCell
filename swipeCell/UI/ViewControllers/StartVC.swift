//
//  ViewController.swift
//  swipeCell
//
//  Created by Mykhailo Zabarin on 5/30/18.
//  Copyright © 2018 Selecto. All rights reserved.
//

import UIKit
import Foundation

class StartVC: BaseVC {

    private var selectedCellIndex: Int?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableCell.registerForTableView(aTableView: tableView)
    }
    
    //MARK: - Notification
    
    @objc override func onCellMenuWasShown(notification: NSNotification) {
        guard let userInfo = notification.userInfo, let index = userInfo["cellIndex"] as? Int else { return }
        selectedCellIndex = index
        let cells = tableView.visibleCells as! [TableCell]
        for cell in cells {
            cell.animateMenuView(isNeedToShow: false)
        }
    }
}

//MARK: - TabelView

extension StartVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.cellIdentifier) as! TableCell
        cell.configureCell(title: "Cell \(indexPath.row + 1)", index: indexPath.row)
        if indexPath.row == selectedCellIndex{
            cell.cellMenuViewLeading.constant = 0
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
