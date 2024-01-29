//
//  AppDelegate.swift
//  Notes
//
//  Created by Дмитрий Скок
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = UINavigationController(rootViewController: ViewController())
        window?.makeKeyAndVisible()
        window?.rootViewController = rootViewController
        return true
    }
}
