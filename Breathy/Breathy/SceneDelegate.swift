//
//  SceneDelegate.swift
//  BreathingExercises
//
//  Created by Andrei Olteanu on 26.05.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: - Public Properties
    
    var window: UIWindow?
    var rootCoordinator: RootCoordinator?
    private(set) lazy var appCore = AppCore()
    
    // MARK: - Public Methods
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.overrideUserInterfaceStyle = .dark
        self.window = window
        window.makeKeyAndVisible()

        let rootCoordinator = RootCoordinator(window: window, appCore: appCore)
        self.rootCoordinator = rootCoordinator
        rootCoordinator.start()
    }
}
