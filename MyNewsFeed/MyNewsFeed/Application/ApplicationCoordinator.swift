//
//  ApplicationCoordinator.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 03.02.2023.
//

final class ApplicationCoordinator: BaseCoordinator<Void> {

	lazy private var window = windowsFactory.makeWindow(with: .firstScene)
	
	private let windowsFactory: WindowsFactory
	
	init(windowsFactory: WindowsFactory, router: Router, coordinatorsFactory: CoordinatorsFactory) {
		self.windowsFactory = windowsFactory
		super.init(router: router, coordinatorsFactory: coordinatorsFactory)
	}
	
	override func start() {
		window.makeKeyAndVisible()
		runNewsFeedFlow()
	}
}

private extension ApplicationCoordinator {
	func runNewsFeedFlow() {
		let coordinator = coordinatorsFactory.makeNewsFeedCoordinator()
		addDependency(coordinator)
		coordinator.start()
	}
}
