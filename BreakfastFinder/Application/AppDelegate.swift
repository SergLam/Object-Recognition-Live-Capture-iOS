/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Contains the app delegate for the Breakfast Finder.
*/

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = VisionObjectRecognitionViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.title = "Vision Object Detection"
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }

}
