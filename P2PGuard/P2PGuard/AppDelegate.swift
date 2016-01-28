

import UIKit
import CoreData
import QJLink

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{

    var window: UIWindow?
    var _netDao:NetDao=NetDao()
    var _constant:Constant=Constant()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //set view controllers
        let oneVC=OneViewController();
        let nav1=UINavigationController(rootViewController:oneVC);
        nav1.tabBarItem=UITabBarItem(title:"舆情监控",image: nil,tag:1);
        nav1.tabBarItem.tag=1
        
        let twoVC=TwoViewController();
        let nav2=UINavigationController(rootViewController:twoVC);
        nav2.tabBarItem=UITabBarItem(title:"我的通知",image:nil,tag:2);
        
        let threeVC=ThreeViewController();
        let nav3=UINavigationController(rootViewController:threeVC);
        nav3.tabBarItem=UITabBarItem(title:"设置",image:nil,tag:3);
        
        let navArr=[nav1,nav2,nav3];
        let tabBarController=UITabBarController();
        tabBarController.viewControllers=navArr;
        self.window!.rootViewController=tabBarController
        tabBarController.tabBar.backgroundColor=UIColor.whiteColor()
        
        //设置一个tabbaritem上的imageView...
        var tab1ImageView=UIImageView()
        tab1ImageView.tag=101
        tab1ImageView.image=UIImage(named: "Bell")
        tab1ImageView.sizeToFit()
        tab1ImageView.frame.origin=CGPoint(x:UIScreen.mainScreen().bounds.width*1/6-tab1ImageView.frame.width/2,y:5)
        nav1.tabBarController?.tabBar.addSubview(tab1ImageView)
        
        var tab1ImageView2=UIImageView()
        tab1ImageView2.tag=102
        tab1ImageView2.image=UIImage(named: "Light")
        tab1ImageView2.sizeToFit()
        tab1ImageView2.frame.origin=CGPoint(x:UIScreen.mainScreen().bounds.width*1/2-tab1ImageView2.frame.width/2,y:5)
        nav2.tabBarController?.tabBar.addSubview(tab1ImageView2)
        
        var label=UILabel()
        label.tag=102
        label.text="We"
        label.textAlignment=NSTextAlignment.Center
        label.textColor=_constant._redColor
        label.sizeToFit()
        label.frame.origin=CGPoint(x:UIScreen.mainScreen().bounds.width*5/6-tab1ImageView2.frame.width/2,y:5)
        nav3.tabBarController?.tabBar.addSubview(label)
        
        //JQLink
        QJLinkManager.shareManager.setAppClientId("ciivfogr102yc53vii4edxbbs")

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "lemontree.P2PGuard" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("P2PGuard", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

}

