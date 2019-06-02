/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The app delegate class of this sample.
*/

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
    
    var window: UIWindow?
    
    lazy var coreDataStack: CoreDataStack = { return CoreDataStack() }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // The view controller hierarchy is defined in the main storyboard.
        guard let splitViewController = window?.rootViewController as? UISplitViewController,
            let navController = splitViewController.viewControllers[splitViewController.viewControllers.count - 1] as? UINavigationController,
            let topViewController = navController.topViewController else {
                return false
        }
        // Configure the splitViewController.
        topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        splitViewController.delegate = self
        splitViewController.preferredDisplayMode = .allVisible
        return true
    }

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        // The SplitViewController is about to collapse and only the master view will be shown, so clear any selection.
        if let navController = splitViewController.viewControllers[0] as? UINavigationController,
            let masterViewController = navController.viewControllers[0] as? MasterViewController,
            let selectedRow = masterViewController.tableView.indexPathForSelectedRow {
            masterViewController.tableView.deselectRow(at: selectedRow, animated: true)
        }
        return true // Return true to always show the master view.
    }
}
