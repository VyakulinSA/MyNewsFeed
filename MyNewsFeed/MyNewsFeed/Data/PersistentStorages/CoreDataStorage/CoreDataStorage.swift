//
//  CoreDataStorage.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 04.02.2023.
//

import Foundation
import CoreData

enum CoreDataStorageError: Error {
	case readError(Error)
	case saveError(Error)
	case deleteError(Error)
}

final class CoreDataStorage {
	
	static let shared = CoreDataStorage()
	
	private init(){}
	
	// MARK: - Core Data stack
	private lazy var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "MyNewsFeed")
		container.loadPersistentStores { _, error in
			if let error = error as NSError? {
				assertionFailure("CoreDataStorage Unresolved error \(error), \(error.userInfo)")
			}
		}
		return container
	}()
	
	// MARK: - Core Data Saving support
	func saveContext() {
		let context = persistentContainer.viewContext
		if context.hasChanges {
			do {
				try context.save()
			} catch {
				assertionFailure("CoreDataStorage Unresolved error \(error), \((error as NSError).userInfo)")
			}
		}
	}

	func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
		persistentContainer.performBackgroundTask(block)
	}
	
}
