//
//  NavigationController.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 03.02.2023.
//

import Foundation
import UIKit

protocol NavigationController: AnyObject {
	func pushViewController(_ viewController: UIViewController, animated: Bool)
}
