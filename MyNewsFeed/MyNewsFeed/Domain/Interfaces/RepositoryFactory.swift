//
//  RepositoryFactory.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 04.02.2023.
//

import Foundation

protocol RepositoriesFactory {
	func makeNewsRepository() -> NewsRepository
	func makeNewsImagesRepository() -> NewsImagesRepository
}
