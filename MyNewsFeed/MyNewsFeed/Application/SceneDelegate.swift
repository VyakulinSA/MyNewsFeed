//
//  SceneDelegate.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 03.02.2023.
//

import UIKit

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	private var dependencyContainer: DependencyContainer?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		
		guard let scene = (scene as? UIWindowScene) else { return }
		
		dependencyContainer = DependencyContainer(sceneArray: [scene])
		dependencyContainer?.applicationCoordinator.start()
	}
}

