//
//  NewsImagesRepositoryImp.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 05.02.2023.
//

import Foundation

final class NewsImagesRepositoryImp {
	
	private let dataTransferService: DataTransferService

	init(dataTransferService: DataTransferService) {
		self.dataTransferService = dataTransferService
	}
}

extension NewsImagesRepositoryImp: NewsImagesRepository {
	
	func fetchImage(with imagePath: String, isFullPath: Bool, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable? {
		
		let endpoint = APIEndpoints.getNewsImge(path: imagePath, isFullPath: isFullPath)
		let task = RepositoryTask()
		task.networkTask = dataTransferService.request(with: endpoint) { (result: Result<Data, DataTransferError>) in
			let result = result.mapError { $0 as Error }
			DispatchQueue.main.async { completion(result) }
		}
		return task
	}
}
