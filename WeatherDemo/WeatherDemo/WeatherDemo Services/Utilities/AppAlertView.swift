//
//  AppAlertView.swift
//  WeatherDemo
//
//  Created by Mohammed Rizwan on 10/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import UIKit

class AppAlertView: NSObject {
    public static let sharedInstance = AppAlertView()
    private override init() {
    }
    
    func showAppAlert(vc:UIViewController, msg: String) {
        let actionSheetController:UIAlertController = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel) { action ->
            Void in
        }
        actionSheetController.addAction(cancelAction)
        vc.present(actionSheetController, animated: true, completion: nil)
    }
    
    func showAppAlertWithTitle(vc:UIViewController, msg: String, title: String) {
        let actionSheetController:UIAlertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel) { action ->
            Void in
        }
        actionSheetController.addAction(cancelAction)
        vc.present(actionSheetController, animated: true, completion: nil)
    }
}
