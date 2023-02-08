//
//  NewsResponseStorage.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 04.02.2023.
//

import Foundation

protocol NewsResponseStorage {
	func getResponse(for request: NewsRequestDTO, completion: @escaping (Result<NewsResponseDTO?, CoreDataStorageError>) -> Void)
	func save(response: NewsResponseDTO, for requestDTO: NewsRequestDTO)
}
