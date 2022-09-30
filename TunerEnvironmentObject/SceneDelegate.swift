import SwiftUI

struct ColorManager {
    static let accentColor = Color("AccentColor")
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        //let splashView = SplashView()
        let splashView = ContentView() // To go directly to content view
        
        
            .accentColor(ColorManager.accentColor)
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: splashView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
