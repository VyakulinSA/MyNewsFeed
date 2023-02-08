//
//  NewsImagesRepository.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 05.02.2023.
//

import Foundation

protocol NewsImagesRepository {
	func fetchImage(with imagePath: String, isFullPath: Bool, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable?
}
