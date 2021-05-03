//
//  AppDelegate+FB.swift
//  TestDefferedLink
//
//  Created by Julio Cesar on 3/24/21.
//

import UIKit
import FacebookCore
import AppTrackingTransparency
import AdSupport

extension AppDelegate {
    
    
    func setupFB(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        
        Settings.isAdvertiserIDCollectionEnabled = false
        Settings.setAdvertiserTrackingEnabled(false)
        Settings.isAutoLogAppEventsEnabled = false
        
        // Initialize the Facebook SDK
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)

        if #available(iOS 14.5.1, *) {
            
            ATTrackingManager.requestTrackingAuthorization { status in
                
                print(ASIdentifierManager.shared().advertisingIdentifier)
                
                
                switch status {
                case .authorized:
                    
                    DispatchQueue.main.async {
                        self.setupDefferedLink()
                    }
                    // Tracking authorization dialog was shown
                    // and we are authorized
                    print("Authorized")
                    
                    // Now that we are authorized we can get the IDFA
                    print(ASIdentifierManager.shared().advertisingIdentifier)
                case .denied:
                    // Tracking authorization dialog was
                    // shown and permission is denied
                    print("Denied")
                case .notDetermined:
                    // Tracking authorization dialog has not been shown
                    print("Not Determined")
                case .restricted:
                    print("Restricted")
                @unknown default:
                    print("Unknown")
                }
            }
        }
    }
    
    /// Set the trackings to true after the permission has been granted
    private func setupDefferedLink() {
        
        //
        Settings.setAdvertiserTrackingEnabled(true)
        Settings.isAdvertiserIDCollectionEnabled = true
        Settings.isAutoLogAppEventsEnabled = true
        
        AppLinkUtility.fetchDeferredAppLink { (url, error) in
            
            if let url = url { // URL here is always nil
                print(url)
            }
            // Error also is always nil.
            print(error as Any)
        }
        
    }
}
