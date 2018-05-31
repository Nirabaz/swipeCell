//
//  NetworkManager.swift
//  swipeCell
//
//  Created by Mykhailo Zabarin on 5/30/18.
//  Copyright © 2018 Selecto. All rights reserved.
//

import Foundation
import Reachability
import NotificationBannerSwift

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let reachability = Reachability()!
    
    private init() {
        listenNotifications()
    }
    
    @objc private func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .wifi:
            let banner = StatusBarNotificationBanner(title: "Reachable via WiFi", style: .success)
            banner.show()
            print("Reachable via WiFi")
        case .none:
            let banner = StatusBarNotificationBanner(title: "Network is not reachable", style: .warning)
            banner.show()
            print("Network is not reachable")
        default: return
        }
    }
    
    private func listenNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
    private func removeNotifications() {
        let notificationCenter = NotificationCenter.default
        reachability.stopNotifier()
        notificationCenter.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
}
