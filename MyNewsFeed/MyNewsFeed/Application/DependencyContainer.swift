//
//  DependencyContainer.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 03.02.2023.
//

import Foundation
import UIKit

final class DependencyContainer{
	private var sceneArray: [UIWindowScene]
	private var rootViewController = NewsFeedNavigationController()
	
	private lazy var router = RouterImp(rootViewController: rootViewController)
	private lazy var windowsFactory = WindowsFactoryImp(rootViewController: rootViewController,scene: sceneArray)
	
	private lazy var appConfig = AppConfiguration()
	
	private lazy var apiDataTransferService: DataTransferService = {
		let config = ApiDataNetworkConfig(baseURL: URL(string: appConfig.apiBaseURL)!,
										  queryParameters: ["apiKey": appConfig.apiKey])
		
		let apiDataNetwork = NetworkServiceImp(config: config)
		return DataTransferServiceImp(with: apiDataNetwork)
	}()
	
	private lazy var imageDataTransferService: DataTransferService = {
		let config = ApiDataNetworkConfig(baseURL: URL(string: appConfig.apiBaseURL)!)
		let imagesDataNetwork = NetworkServiceImp(config: config)
		return DataTransferServiceImp(with: imagesDataNetwork)
	}()
	
	private lazy var newsResponseCache = CoreDataNewsResponseStorage()
	private lazy var repositoriesFactory = RepositoriesFactoryImp(
		dependencies:.init(apiDataTransferService: apiDataTransferService,
						   imageDataTransferService: imageDataTransferService),
		newsResponseCache: newsResponseCache
	)
	private lazy var useCasesFactory = UseCasesFactoryImp(repositoriesFactory: repositoriesFactory)
	private lazy var screensFactory = ScreensFactoryImp(useCasesFactory: useCasesFactory, repositoriesFactory: repositoriesFactory)
	private lazy var coordinatorsFactory = CoordinatorsFactoryImp(router: router, modulesFactory: screensFactory)
	
	public lazy var applicationCoordinator = coordinatorsFactory.makeApplicationCoordinator(windowsFactory: windowsFactory)
	
	init(sceneArray: [UIWindowScene]) {
		self.sceneArray = sceneArray
	}
}
