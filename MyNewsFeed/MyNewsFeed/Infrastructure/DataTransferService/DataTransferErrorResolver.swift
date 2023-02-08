//
//  DataTransferErrorResolver.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 08.02.2023.
//

import Foundation

public protocol DataTransferErrorResolver {
	func resolve(error: NetworkError) -> Error
}

public class DataTransferErrorResolverImp: DataTransferErrorResolver {
	public init() { }
	public func resolve(error: NetworkError) -> Error {
		return error
	}
}

