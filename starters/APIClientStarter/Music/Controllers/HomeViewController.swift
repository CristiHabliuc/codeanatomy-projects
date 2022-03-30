//
//  ViewController.swift
//  Images
//
//  Created by Cristi Habliuc on 16.03.2022.
//

import UIKit

class HomeViewController: UIViewController {
	
	private let viewModel = ViewModel()
	private let searchController = UISearchController()
	private let columns = 3
	private let coverAspectRatio = CGFloat(1)
	private let coverSpace: CGFloat = 10
	private var cellSize: CGSize = .zero

	@IBOutlet weak var booksCollection: UICollectionView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		bindToModel()
		configureView()
		configureSearch()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		updateViewDependencies()
		configureCollection()
	}
	
	private func bindToModel() {
		viewModel.onError = { [weak self] message in
			self?.showError(message: message)
		}
		viewModel.onResultsReceived = { [weak self] in
			self?.booksCollection.reloadData()
		}
	}
	
	private func configureView() {
		title = "Music"
	}

	private func configureSearch() {
		searchController.searchBar.placeholder = "Search an artist"
		searchController.searchBar.delegate = self
		searchController.hidesNavigationBarDuringPresentation = false
		definesPresentationContext = true
		navigationItem.searchController = searchController
	}
	
	private func configureCollection() {
	}
	
	private func updateViewDependencies() {
		let coverWidth = round((view.bounds.width - coverSpace * (CGFloat(columns))) / CGFloat(columns))
		let coverHeight = round(coverWidth / coverAspectRatio)
		cellSize = CGSize(width: coverWidth, height: coverHeight)
		viewModel.coverSize = cellSize
	}
	
	private func showError(message: String) {
		let alert = UIAlertController(
			title: "Error",
			message: message,
			preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
		present(alert, animated: true, completion: nil)
	}
	
}

extension HomeViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		viewModel.handleReleaseSelection(at: indexPath)
	}
}

extension HomeViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.numberOfResults()
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: ImageCVCell.reuseIdentifier,
			for: indexPath) as! ImageCVCell
		if let bookCoverUrl = viewModel.coverURL(for: indexPath) {
			cell.updateImage(with: bookCoverUrl)
		}
		return cell
	}
	
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return cellSize
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return .init(top: 0, left: coverSpace/2, bottom: 0, right: coverSpace/2)
	}
}

extension HomeViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		var text = searchController.searchBar.text ?? ""
		text = text.trimmingCharacters(in: .whitespacesAndNewlines)
		if !text.isEmpty {
			viewModel.fetchResults(withQuery: text)
		}
		searchController.resignFirstResponder()
	}
}
