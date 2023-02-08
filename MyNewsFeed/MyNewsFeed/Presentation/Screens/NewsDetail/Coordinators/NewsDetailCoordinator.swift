//
//  NewsDetailCoordinator.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 04.02.2023.
//

import Foundation

final class NewsDetailCoordinator: BaseCoordinator<News>, CoordinatorWithFinish {
	var finishFlow: (() -> Void)?
	
	private let screensFactory: ScreensFactory
	
	init(screensFactory: ScreensFactory, router: Router, coordinatorsFactory: CoordinatorsFactory, startParam: News) {
		self.screensFactory = screensFactory
		super.init(router: router, coordinatorsFactory: coordinatorsFactory, startParam: startParam)
	}
	
	override func start() {
		let actions = NewsDetailViewModelActions(showFullNews: showFullNews, backBattonTapped: finishFlow!)
		guard let news = startParam else { return }
		let screen = screensFactory.makeNewsDetailScreen(news: news, actions: actions)
		router.push(screen, animated: true)
	}
	
}

private extension NewsDetailCoordinator {
	func showFullNews(url: String) {
		let screen = screensFactory.makeFullNewsWebScreen(url: url)
		router.push(screen, animated: true)
	}

}
