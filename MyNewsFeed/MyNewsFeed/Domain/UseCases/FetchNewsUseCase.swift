//
//  FetchNewsUseCase.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 03.02.2023.
//

import Foundation

protocol FetchNewsUseCase {
	func execute(requestValue: FetchNewsUseCaseRequestValue,
				 cached: @escaping (NewsPage) -> Void,
				 completion: @escaping (Result<NewsPage,Error>) -> Void) -> Cancellable?
}

final class FetchNewsUseCaseImp: FetchNewsUseCase {
	
	private let newsRepository: NewsRepository
	
	init(newsRepository: NewsRepository) {
		self.newsRepository = newsRepository
	}
	
	func execute(requestValue: FetchNewsUseCaseRequestValue,
				 cached: @escaping (NewsPage) -> Void,
				 completion: @escaping (Result<NewsPage, Error>) -> Void
	) -> Cancellable? {
		return newsRepository.fetchNewsFeed(query: requestValue.query,
											page: requestValue.page,
											cached: cached) { result in
			
			completion(result)
		}
	}
}

struct FetchNewsUseCaseRequestValue {
	let query: NewsQuery
	let page: Int
}
