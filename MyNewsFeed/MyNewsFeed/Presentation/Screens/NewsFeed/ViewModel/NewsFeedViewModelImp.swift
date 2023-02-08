//
//  NewsFeedViewModel.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 03.02.2023.
//

import Foundation

struct NewsFeedViewModelActions {
	let showNewsDetails: (News) -> Void
}

enum NewsFeedViewModelLoading {
	case fullScreen
	case nextPage
}

protocol NewsFeedViewModelInput {
	func viewDidLoad()
	func didLoadNextPage()
	func didSelectItem(at index: Int)
	func update(newsQuery: NewsQuery)
}

protocol NewsFeedViewModelOutput {
	var cellSettings: NewsFeedItemCellSettings { get }
	var items: Observable<[NewsFeedItemViewModel]> { get }
	var loading: Observable<NewsFeedViewModelLoading?> { get }
	var error: Observable<String> { get }
	var errorTitle: String { get }
}

protocol NewsFeedViewModel: NewsFeedViewModelInput, NewsFeedViewModelOutput {}

final class NewsFeedViewModelImp: NewsFeedViewModel {

	private let fetchNewsUseCase: FetchNewsUseCase
	private let actions: NewsFeedViewModelActions?
	private let defaults: UserDefaults
	
	var currentPage: Int = 0
	var totalPageCount: Int = 1
	var hasMorePages: Bool { currentPage < totalPageCount }
	var nextPage: Int { hasMorePages ? currentPage + 1 : currentPage }

	private var pages: [NewsPage] = []
	private var newsLoadTask: Cancellable? { willSet { newsLoadTask?.cancel() } }
	
	// MARK: - OUTPUT
	let cellSettings: NewsFeedItemCellSettings = .strip
	var items: Observable<[NewsFeedItemViewModel]> = Observable([])
	let loading: Observable<NewsFeedViewModelLoading?> = Observable(.none)
	let error: Observable<String> = Observable("")
	let errorTitle = NSLocalizedString("Error", comment: "")
	
	// MARK: - init
	
	init(fetchNewsUseCase: FetchNewsUseCase, actions: NewsFeedViewModelActions? = nil){
		self.fetchNewsUseCase = fetchNewsUseCase
		self.actions = actions
		self.defaults = UserDefaults.standard
	}
	
	// MARK: - Private
	
	private func appendPage(_ newsPage: NewsPage) {
		currentPage = newsPage.page
		totalPageCount = Int(round(Double(newsPage.totalResults) / Double(20)))
		pages = pages.filter { $0.page != newsPage.page } + [newsPage]
		setItemsValue()
	}
	
	private func setItemsValue() {
		let sortedNews = pages.news.sorted { x, y in
			guard let xDate = x.publishedAt, let yDate = y.publishedAt else { return false}
			return xDate > yDate
		}
		items.value = sortedNews.map({ news in
			let viewsCounter = defaults.integer(forKey: news.url)
			return NewsFeedItemViewModel(news: news, viewsCounter: viewsCounter)
		})
	}
	
	private func resetPages() {
		currentPage = 0
		totalPageCount = 1
		pages.removeAll()
		items.value.removeAll()
	}
	
	private func load(newsQuery: NewsQuery, loading: NewsFeedViewModelLoading) {
		self.loading.value = loading

		newsLoadTask = fetchNewsUseCase.execute(
			requestValue: .init(query: newsQuery, page: nextPage),
			cached: appendPage,
			completion: { result in
				switch result {
				case .success(let page):
					self.appendPage(page)
				case .failure(let error):
					self.handle(error: error)
				}
				self.loading.value = .none
		})
	}
	
	private func handle(error: Error) {
		self.error.value = error.isInternetConnectionError ?
			NSLocalizedString("No internet connection", comment: "") :
			NSLocalizedString("Failed loading news", comment: "")
	}
}

// MARK: - INPUT. View event methods

extension NewsFeedViewModelImp {
	
	func viewDidLoad() {
		load(newsQuery: .init(), loading: .fullScreen)
	}
	
	func didLoadNextPage() {
		guard hasMorePages, loading.value == .none else { return }
		load(newsQuery: .init(), loading: .nextPage)
	}
	
	func didSelectItem(at index: Int) {
		let addedViews = defaults.integer(forKey: pages.news[index].url) + 1
		defaults.set(addedViews, forKey: pages.news[index].url)
		
		items.value[index].viewsCounter = addedViews
		actions?.showNewsDetails(pages.news[index])
	}
	
	func update(newsQuery: NewsQuery) {
		resetPages()
		load(newsQuery: newsQuery, loading: .fullScreen)
	}
}

private extension Array where Element == NewsPage {
	var news: [News] { flatMap { $0.news } }
}
