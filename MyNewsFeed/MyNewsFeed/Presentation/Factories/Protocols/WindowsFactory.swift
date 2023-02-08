//
//  WindowsFactory.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 03.02.2023.
//

import Foundation
import UIKit

enum SceneNumber: Int {
	case firstScene
}

protocol WindowsFactory: AnyObject {
	func makeWindow(with sceneNumber: SceneNumber) -> UIWindow
}
