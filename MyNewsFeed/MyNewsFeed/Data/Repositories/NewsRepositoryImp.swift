//
//  NewsRepositoryImp.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 04.02.2023.
//

import Foundation

final class NewsRepositoryImp {
	private let dataTransferService: DataTransferService
	private let cache: NewsResponseStorage
	
	init(dataTransferService: DataTransferService, cache: NewsResponseStorage) {
		self.dataTransferService = dataTransferService
		self.cache = cache
	}
}

extension NewsRepositoryImp: NewsRepository {
	func fetchNewsFeed(query: NewsQuery, page: Int,
					   cached: @escaping (NewsPage) -> Void,
					   completion: @escaping (Result<NewsPage, Error>) -> Void) -> Cancellable? {
		
		let requestDTO = NewsRequestDTO(country: query.country, page: page, pageSize: query.pageSize)
		let task = RepositoryTask()
		
		cache.getResponse(for: requestDTO) { result in
			
			if case let .success(responseDTO?) = result {
				cached(responseDTO.toDomain(page: page))
			}
			guard !task.isCancelled else { return }
			
			let endpoint = APIEndpoints.getNews(with: requestDTO)
			
			task.networkTask = self.dataTransferService.request(with: endpoint, completion: { result in
				switch result{
				case .success(let responseDTO):
					self.cache.save(response: responseDTO, for: requestDTO)
					completion(.success(responseDTO.toDomain(page: page)))
				case .failure(let error):
					completion(.failure(error))
				}
			})
		}
		return task
	}
}
