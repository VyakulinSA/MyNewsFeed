//
//  NewsFeedCollectionView.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 03.02.2023.
//

import Foundation
import UIKit

final class NewsFeedCollectionView: UICollectionView {
	
	var viewModel: NewsFeedViewModel!
	var newsImagesRepository: NewsImagesRepository?
	
	let refresher: UIRefreshControl = UIRefreshControl()
	
	private let layout = with(UICollectionViewFlowLayout()) {
		$0.scrollDirection = .vertical
	}
	
	init(){
		super.init(frame: .zero, collectionViewLayout: layout)
		setupRefresher()
		setupView()
		setupAppearance()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupRefresher() {
		refreshControl = refresher
		refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
	}
	
	@objc func loadData() {
		refreshControl?.beginRefreshing()
		viewModel.update(newsQuery: .init(country: "ru"))
		refreshControl?.endRefreshing()
	}
}

// MARK: - Setup views and appearance

extension NewsFeedCollectionView {
	
	private func setupView() {
		translatesAutoresizingMaskIntoConstraints = false
		dataSource = self
		delegate = self
		register(NewsFeedItemCell.self, forCellWithReuseIdentifier: NewsFeedItemCell.reuseIdentifier)
	}
	
	private func setupAppearance() {
		backgroundColor = .systemGray5
	}
}

// MARK: - DataSource

extension NewsFeedCollectionView: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(for: indexPath) as NewsFeedItemCell
		cell.fill(with: viewModel.items.value[indexPath.item], newsImagesRepository: newsImagesRepository)
		if indexPath.row == viewModel.items.value.count - 1 {
			viewModel.didLoadNextPage()
		}
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.items.value.count
	}
	
}

// MARK: - Delegate

extension NewsFeedCollectionView: UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		viewModel.didSelectItem(at: indexPath.item)
	}
}

// MARK: - DelegateFlowLayout

extension NewsFeedCollectionView: UICollectionViewDelegateFlowLayout{
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = viewModel.cellSettings.getCellWidth(collectionViewWidth: frame.width)
		let height = viewModel.cellSettings.height
		return CGSize(width: width, height: height)
	}

	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return viewModel.cellSettings.insetForSection
	}
	
	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return viewModel.cellSettings.minimumLineSpacingForSection
	}
	
}
