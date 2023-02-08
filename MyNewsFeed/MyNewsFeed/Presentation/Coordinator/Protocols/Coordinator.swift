//
//  Coordinator.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 03.02.2023.
//

import Foundation

protocol CoordinatorWithFinish: Coordinator, CoordinatorOutput {}

protocol Coordinator: AnyObject {
	func start()
}
