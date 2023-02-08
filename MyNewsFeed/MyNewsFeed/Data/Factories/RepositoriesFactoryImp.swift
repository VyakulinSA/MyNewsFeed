//
//  RepositoriesFactory.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 04.02.2023.
//

import Foundation

final class RepositoriesFactoryImp: RepositoriesFactory {

	struct Dependencies {
		let apiDataTransferService: DataTransferService
		let imageDataTransferService: DataTransferService
	}
	
	private let dependencies: Dependencies
	private let newsResponseCache: NewsResponseStorage
	
	init(dependencies: Dependencies, newsResponseCache: NewsResponseStorage) {
		self.dependencies = dependencies
		self.newsResponseCache = newsResponseCache
	}
	
	func makeNewsRepository() -> NewsRepository {
		return NewsRepositoryImp(dataTransferService: dependencies.apiDataTransferService, cache: newsResponseCache)
	}
	
	func makeNewsImagesRepository() -> NewsImagesRepository {
		return NewsImagesRepositoryImp(dataTransferService: dependencies.imageDataTransferService)
	}
}

