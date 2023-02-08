//
//  CoordinatorsFactoryImp.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 03.02.2023.
//

import Foundation

final class CoordinatorsFactoryImp: CoordinatorsFactory {

	private let router: Router
	private let screensFactory: ScreensFactory
	
	internal init(router: Router, modulesFactory: ScreensFactory) {
		self.router = router
		self.screensFactory = modulesFactory
	}
	
	func makeApplicationCoordinator(windowsFactory: WindowsFactory) -> Coordinator {
		return ApplicationCoordinator(windowsFactory: windowsFactory, router: router, coordinatorsFactory: self)
	}
	
	func makeNewsFeedCoordinator() -> Coordinator {
		return NewsFeedCoordinator(screensFactory: screensFactory, router: router, coordinatorsFactory: self)
	}
	
	func makeNewsDetailCoordinator(news: News) -> CoordinatorWithFinish {
		return NewsDetailCoordinator(screensFactory: screensFactory, router: router, coordinatorsFactory: self, startParam: news)
	}
}
