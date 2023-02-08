//
//  NewsFeedCoordinator.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 03.02.2023.
//

import Foundation

final class NewsFeedCoordinator: BaseCoordinator<Void> {
	private let screensFactory: ScreensFactory
	
	init(screensFactory: ScreensFactory, router: Router, coordinatorsFactory: CoordinatorsFactory) {
		self.screensFactory = screensFactory
		super.init(router: router, coordinatorsFactory: coordinatorsFactory)
	}
	
	override func start() {
		let actions = NewsFeedViewModelActions(showNewsDetails: showNewsDetails)
		let screen = screensFactory.makeNewsFeedScreen(actions: actions)
		router.push(screen, animated: true)
	}
}

private extension NewsFeedCoordinator {
	func showNewsDetails(news: News){
		let coordinator = coordinatorsFactory.makeNewsDetailCoordinator(news: news)
		coordinator.finishFlow = { [unowned self, unowned coordinator] in
			removeDependency(coordinator)
		}
		addDependency(coordinator)
		coordinator.start()
	}
}
