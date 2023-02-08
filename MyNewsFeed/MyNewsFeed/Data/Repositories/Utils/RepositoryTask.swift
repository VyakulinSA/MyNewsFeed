//
//  RepositoryTask.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 04.02.2023.
//

import Foundation

class RepositoryTask: Cancellable {
	var networkTask: NetworkCancellable?
	var isCancelled: Bool = false
	
	func cancel() {
		networkTask?.cancel()
		isCancelled = true
	}
}
