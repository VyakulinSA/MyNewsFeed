//
//  BaseCoordinator.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 03.02.2023.
//

import Foundation

class BaseCoordinator<T>: Coordinator{

	let router: Router
	let coordinatorsFactory: CoordinatorsFactory
	let startParam: T?
	
	var childCoordinators: [Coordinator]
	
	internal init(router: Router, coordinatorsFactory: CoordinatorsFactory, startParam: T? = nil) {
		self.router = router
		self.coordinatorsFactory = coordinatorsFactory
		self.childCoordinators = []
		self.startParam = startParam
	}
	
	func addDependency(_ coordinator: Coordinator) {
		for element in childCoordinators where element === coordinator {
			return
		}
		childCoordinators.append(coordinator)
	}
	
	func removeDependency(_ coordinator: Coordinator?) {
		guard !childCoordinators.isEmpty,
			  let coordinator = coordinator,
			  let index = childCoordinators.firstIndex(where: {$0 === coordinator})
		else { return }
		childCoordinators.remove(at: index)
	}
	
	func start() {}
}
