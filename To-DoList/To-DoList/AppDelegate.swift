//Nothing in this file was changed by our group. This was all generated when the project was created and we have had no reason to touch it since






import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //added------
        
        if let encoded = UserDefaults.standard.object(forKey: "array") as? Data {
            let storedPlayer = try! PropertyListDecoder().decode([save_task].self, from: encoded)
            tasks_save_global = storedPlayer
            if tasks_save_global.count > 0 {
                print(tasks_save_global.count)
                print(tasks_save_global[0].task)
            }
            UserDefaults.standard.removeObject(forKey: "array")
        }
        //----
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    //added
    func application(_ application: UIApplication, shouldSaveSecureApplicationState coder: NSCoder) -> Bool {
        print("AppDelegate shouldSaveApplicationState")
        return true
    }
    func application(_ application: UIApplication, shouldRestoreSecureApplicationState coder: NSCoder) -> Bool {
        print("AppDelegate shouldRestoreApplicationState")
        return true
    }
    //
    func applicationWillTerminate(_ application: UIApplication) {
        var t: [save_task]
        if tasks_global.count != 0 {
            t = savedata(tasks: tasks_global)

            try? UserDefaults.standard.set(PropertyListEncoder().encode(t), forKey: "array")
        }
    }
    
}

