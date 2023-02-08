//
//  NetworkSessionManager.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 08.02.2023.
//

import Foundation

public protocol NetworkSessionManager {
	typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
	
	func request(_ request: URLRequest,
				 completion: @escaping CompletionHandler) -> NetworkCancellable
}


public class NetworkSessionManagerImp: NetworkSessionManager {
	public init() {}
	public func request(_ request: URLRequest,
						completion: @escaping CompletionHandler) -> NetworkCancellable {
		let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
		task.resume()
		return task
	}
}
