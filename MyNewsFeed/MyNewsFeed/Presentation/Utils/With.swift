//
//  With.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 03.02.2023.
//

import Foundation

@inlinable
@discardableResult
public func with<T: AnyObject>(_ obj: T, _ closure: (T) -> Void) -> T {
	closure(obj)
	return obj
}
