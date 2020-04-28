//Nothing in this file was changed by our group. This was all generated when the project was created and we have had no reason to touch it since






import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var app: UIApplication?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        app = application
        
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
        
        if let encoded = UserDefaults.standard.object(forKey: "name_segs") as? Data {
            let storedPlayer = try! PropertyListDecoder().decode([String].self, from: encoded)
            name_segs = storedPlayer
            UserDefaults.standard.removeObject(forKey: "name_segs")
        }
        //----
        
        if #available(iOS 13.0, *) {
            NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: UIScene.willDeactivateNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(willGoActive), name: UIScene.willEnterForegroundNotification, object: nil)
        } else {
            NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: UIApplication.willResignActiveNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(willGoActive), name: UIApplication.willEnterForegroundNotification, object: nil)
        }
        
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

    @objc func willResignActive(_ notification: Notification) {
        savetheData(app!)
    }
    
    @objc func willGoActive(_ application: Notification) {
        //can be used to detect when app goes active from background
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
    func savetheData(_ application: UIApplication) {
        //if (1) {
            var t: [save_task]
            if tasks_global.count != 0 {
                t = savedata(tasks: tasks_global)

                try? UserDefaults.standard.set(PropertyListEncoder().encode(t), forKey: "array")
            }
            if name_segs.count > 0 {
                try? UserDefaults.standard.set(PropertyListEncoder().encode(name_segs), forKey: "name_segs")
            }
        //}
    }

    
}

