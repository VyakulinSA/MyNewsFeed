//
//  NewsFeedItemCellSettings.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 03.02.2023.
//

import Foundation
import UIKit

enum NewsFeedItemCellSettings {
	case strip
	
	var height: CGFloat {
		switch self {
		case .strip:
			return 300
		}
	}

	var insetForSection: UIEdgeInsets {
		return UIEdgeInsets(top: 30, left: 16, bottom: 10, right: 16)
	}
	
	var minimumLineSpacingForSection: CGFloat {
		return 20
	}
	
	var backGroundColor: UIColor {
		return .systemGray6
	}

	func getCellWidth(collectionViewWidth: CGFloat) -> CGFloat {
		switch self {
		case .strip:
			return collectionViewWidth
		}
	}
}
