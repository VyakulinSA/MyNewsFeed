//
//  ModulesFactoryImp.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 03.02.2023.
//

import Foundation

final class ScreensFactoryImp: ScreensFactory{
	
	private let useCasesFactory: UseCasesFactory
	private let repositoriesFactory: RepositoriesFactory
	
	init(useCasesFactory: UseCasesFactory, repositoriesFactory: RepositoriesFactory) {
		self.useCasesFactory = useCasesFactory
		self.repositoriesFactory = repositoriesFactory
	}
	
	func makeNewsFeedScreen(actions: NewsFeedViewModelActions) -> NewsFeedViewController {
		let controller = NewsFeedViewController()
		let viewModel = makeNewsFeedViewModel(actions: actions)
		controller.setViewModel(viewModel)
		controller.setImagesRepository(repositoriesFactory.makeNewsImagesRepository())
		return controller
	}
	
	func makeNewsDetailScreen(news: News, actions: NewsDetailViewModelActions) -> NewsDetailViewController {
		let controller = NewsDetailViewController()
		let viewModel = makeNewsDetailViewModel(news: news, actions: actions)
		controller.setViewModel(viewModel)
		return controller
	}
	
	func makeFullNewsWebScreen(url: String) -> FullNewsWebViewController {
		let controller = FullNewsWebViewController()
		controller.setUrl(url: url)
		return controller
	}
	
	private func makeNewsFeedViewModel(actions: NewsFeedViewModelActions) -> NewsFeedViewModel {
		return NewsFeedViewModelImp(
			fetchNewsUseCase: useCasesFactory.makeFetchNewsUseCase(),
			actions: actions
		)
	}
	
	private func makeNewsDetailViewModel(news: News, actions: NewsDetailViewModelActions) -> NewsDetailViewModel {
		return NewsDetailViewModel(news: news, actions: actions, newsImagesRepository: repositoriesFactory.makeNewsImagesRepository())
	}
	
	
}
