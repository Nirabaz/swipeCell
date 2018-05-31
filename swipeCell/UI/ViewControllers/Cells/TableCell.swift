//
//  TableCell.swift
//  swipeCell
//
//  Created by Mykhailo Zabarin on 5/30/18.
//  Copyright © 2018 Selecto. All rights reserved.
//

import UIKit

class TableCell: BaseTableViewCell {
    
    //MARK: - IBOutlets

    @IBOutlet weak var cellMenuViewLeading: NSLayoutConstraint!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var menuView: UIView!
    
    //MARK: - Private variables
    
    private var isMenuShown = false
    private var leftSwipe: UISwipeGestureRecognizer?
    private var rightSwipe: UISwipeGestureRecognizer?
    
    //MARK: - Iternal variables
    
    var cellIndex: Int?
    
    override class var cellIdentifier: String {
        return "TableCell"
    }
    
    //MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupSwipeRecognizers()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - IBActions
    
    @IBAction func onMenuBtnPress(_ sender: Any) {
        animateMenuView(isNeedToShow: false)
    }
    
    //MARK: - Private methods
    
    @objc private func onSwipe(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left, isMenuShown{
            animateMenuView(isNeedToShow: false)
        }else if gesture.direction == .right, !isMenuShown{
            NotificationCenter.default.post(name: .CellMenuWasShown, object: nil, userInfo: ["cellIndex": cellIndex])
            animateMenuView(isNeedToShow: true)
        }
    }
    
    private func setupSwipeRecognizers() {
        if leftSwipe != nil {
            removeGestureRecognizer(leftSwipe!)
            leftSwipe = nil
        }
        if rightSwipe != nil {
            removeGestureRecognizer(rightSwipe!)
            rightSwipe = nil
        }
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe))
        swipeLeft.direction = .left
        self.addGestureRecognizer(swipeLeft)
        leftSwipe = swipeLeft
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe))
        swipeRight.direction = .right
        self.addGestureRecognizer(swipeRight)
        rightSwipe = swipeRight
    }
    
    //MARK: - Internal methods
    
    func animateMenuView(isNeedToShow: Bool){
        if isMenuShown != isNeedToShow {
            UIView.animate(withDuration: Constants.DEFAULT_ANIMATION_DURATION) {[weak self] in
                guard let strongSelf = self else { return }
                strongSelf.cellMenuViewLeading.constant = isNeedToShow ? 0 : -strongSelf.menuView.frame.width
                strongSelf.layoutIfNeeded()
                strongSelf.isMenuShown = isNeedToShow
            }
        }
    }
    
    func configureCell(title: String, index: Int){
        cellTitle.text = title
        cellIndex = index
        cellMenuViewLeading.constant = -menuView.frame.width
        layoutIfNeeded()
    }
}
