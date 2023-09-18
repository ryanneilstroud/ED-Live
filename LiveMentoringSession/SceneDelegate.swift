//
//  SceneDelegate.swift
//  LiveMentoringSession
//
//  Created by Ryan Neil Stroud on 16/9/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        window?.rootViewController = TransactionsFlow().getListView()
        window?.makeKeyAndVisible()        
    }
}

