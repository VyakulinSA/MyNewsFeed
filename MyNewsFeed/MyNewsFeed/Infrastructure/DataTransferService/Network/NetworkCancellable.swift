//
//  NetworkCancellable.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 08.02.2023.
//

import Foundation

public protocol NetworkCancellable {
	func cancel()
}

extension URLSessionTask: NetworkCancellable { }
