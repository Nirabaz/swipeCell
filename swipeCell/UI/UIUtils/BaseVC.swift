//
//  BaseVC.swift
//  swipeCell
//
//  Created by Mykhailo Zabarin on 5/30/18.
//  Copyright © 2018 Selecto. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var onDissmissCompletion: (() -> Void)?
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listenNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    deinit {
        removeNotifications()
    }
    
    //MARK: - Internal Functions
    
  
    
    @objc func respondToSwipeGesture() {
        onBtnBack(UIButton())
    }
    
    func listenNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(onCellMenuWasShown(notification:)), name: .CellMenuWasShown, object: nil)
    }
    
    func removeNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: .CellMenuWasShown, object: nil)
    }
    
    //MARK: - IBActions
    
    @IBAction func onBtnBack(_ sender: Any) {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: onDissmissCompletion)
        }
    }
    
    // MARK: - NSNotifications
    
    @objc func onCellMenuWasShown(notification: NSNotification) {
        //override in child class
    }

}
