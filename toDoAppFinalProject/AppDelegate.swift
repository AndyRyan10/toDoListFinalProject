//
//  AppDelegate.swift
//  toDoAppFinalProject
//
//  Created by Andrew Ryan on 7/26/17.
//  Copyright © 2017 AndrewRyan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let splitViewController = self.window!.rootViewController as! UISplitViewController
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count - 1] as! UINavigationController
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        splitViewController.delegate = self
        return true
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else {return false}
        
        guard let topAsDetailController = secondaryAsNavController.topViewController as? TimerViewController else {return true } //switch to false once timer view controller is ready
        
        if topAsDetailController.toDo == nil {
            return true

        }
        return false
            
    }

}

