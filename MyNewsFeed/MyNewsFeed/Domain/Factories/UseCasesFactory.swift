//
//  UseCasesFactory.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 03.02.2023.
//

import Foundation

protocol UseCasesFactory {
	func makeFetchNewsUseCase() -> FetchNewsUseCase
}

final class UseCasesFactoryImp: UseCasesFactory {
	
	private let repositoriesFactory: RepositoriesFactory
	
	init(repositoriesFactory: RepositoriesFactory) {
		self.repositoriesFactory = repositoriesFactory
	}
	
	func makeFetchNewsUseCase() -> FetchNewsUseCase {
		return FetchNewsUseCaseImp(newsRepository: repositoriesFactory.makeNewsRepository())
	}
}
