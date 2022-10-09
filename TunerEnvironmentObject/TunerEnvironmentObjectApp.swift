//
//  TunerEnvironmentObjectApp.swift
//  TunerEnvironmentObject
//
//  Created by Richard Hardy on 30/09/2022.
//

// To make this run, The following settings are required. For the Target
// Info
// Add:
// Privacy - Microphone Usage Description : « Add a description »

// Packages required:
// AudioKit
// AudioKitEX
// SoundpipeAudioKit

//Under info for the target
//Add

// Application Scene Manifest
// -Enable Multiple Windows : No
// -Scene Configuration
// --Application Session Role
// ---Item 0
// ----Configuration Name : Default Configuration
// ----Delegate Class Name: $(PRODUCT_MODULE_NAME).SceneDelegate

// Remove the other categories

// Build settings:
// Add other linker flags
// -lstdc++

// There must be a microphone for this to work.



import SwiftUI
import AVFoundation
import AudioKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        do {
 
            Settings.bufferLength = .short
            try AVAudioSession.sharedInstance().setPreferredIOBufferDuration(Settings.bufferLength.duration)
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord,
                                                            options: [.defaultToSpeaker, .mixWithOthers, .allowBluetoothA2DP]
            )
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let err {
            print(err)
        }
        return true
    }
}


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
            if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: ContentView())
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
