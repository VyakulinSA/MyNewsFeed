//
//  NewsResponsEntity+Mapping.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 04.02.2023.
//

import Foundation
import CoreData

extension NewsResponseEntity {
	func toDTO() -> NewsResponseDTO {
		return .init(totalResults: Int(totalResults),
					 articles: newsSet?.allObjects.map { ($0 as! OneNewsResponseEntity).toDTO() } ?? [])
	}
}

extension OneNewsResponseEntity {
	func toDTO() -> NewsResponseDTO.NewsDTO {
		return .init(source: NewsResponseDTO.Source.init(name: sourceName ?? ""),
					 title: title ?? "",
					 description: descript,
					 url: url ?? "",
					 urlToImage: urlToImage,
					 publishedAt: publishedAt ?? "")
	}
}

extension NewsRequestDTO {
	func toEntity(in context: NSManagedObjectContext) -> NewsRequestEntity {
		let entity: NewsRequestEntity = .init(context: context)
		entity.country = country
		entity.page = Int32(page)
		return entity
	}
}

extension NewsResponseDTO {
	func toEntity(in context: NSManagedObjectContext) -> NewsResponseEntity {
		let entity: NewsResponseEntity = .init(context: context)
		entity.totalResults = Int32(totalResults)
		articles.forEach {
			entity.addToNewsSet($0.toEntity(in: context))
		}
		return entity
	}
}

extension NewsResponseDTO.NewsDTO {
	func toEntity(in context: NSManagedObjectContext) -> OneNewsResponseEntity {
		let entity: OneNewsResponseEntity = .init(context: context)
		entity.sourceName = source.name
		entity.title = title
		entity.descript = description
		entity.url = url
		entity.urlToImage = urlToImage
		entity.publishedAt = publishedAt
		return entity
	}
}
