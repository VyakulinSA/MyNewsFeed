//
//  CoreDataNewsResponseStorage.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 04.02.2023.
//

import Foundation
import CoreData

final class CoreDataNewsResponseStorage {
	private let coreDataStorage: CoreDataStorage
	
	init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
		self.coreDataStorage = coreDataStorage
	}
	
	private func fetchRequest(for requestDTO: NewsRequestDTO) -> NSFetchRequest<NewsRequestEntity> {
		let request: NSFetchRequest = NewsRequestEntity.fetchRequest()
		request.predicate = NSPredicate(format: "%K = %@ AND %K = %d",
										#keyPath(NewsRequestEntity.country), requestDTO.country,
										#keyPath(NewsRequestEntity.page), requestDTO.page)
		return request
	}
	
	private func deleteResponse(for requestDto: NewsRequestDTO, in context: NSManagedObjectContext) {
		let request = fetchRequest(for: requestDto)

		do {
			if let result = try context.fetch(request).first {
				context.delete(result)
			}
		} catch {
			print(error)
		}
	}
	
}

extension CoreDataNewsResponseStorage: NewsResponseStorage {
	
	func getResponse(for requestDto: NewsRequestDTO, completion: @escaping (Result<NewsResponseDTO?, CoreDataStorageError>) -> Void) {
		coreDataStorage.performBackgroundTask { context in
			do {
				let fetchRequest = self.fetchRequest(for: requestDto)
				let requestEntity = try context.fetch(fetchRequest).first

				completion(.success(requestEntity?.response?.toDTO()))
			} catch {
				completion(.failure(CoreDataStorageError.readError(error)))
			}
		}
	}

	func save(response responseDto: NewsResponseDTO, for requestDto: NewsRequestDTO) {
		coreDataStorage.performBackgroundTask { context in
			do {
				self.deleteResponse(for: requestDto, in: context)

				let requestEntity = requestDto.toEntity(in: context)
				requestEntity.response = responseDto.toEntity(in: context)

				try context.save()
			} catch {
				debugPrint("CoreDataMoviesResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
			}
		}
	}
}
