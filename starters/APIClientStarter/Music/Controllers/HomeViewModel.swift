//
//  ViewModel.swift
//  Images
//
//  Created by Cristi Habliuc on 16.03.2022.
//

import UIKit

extension HomeViewController {

	class ViewModel {
		private var results: [Release] = []
		
		var coverSize: CGSize = CGSize(width: 100, height: 100)
		
		var onResultsReceived: (() -> Void)?
		
		var onError: ((String) -> Void)?
		
		// MARK: Actions
		
		func fetchResults(withQuery query: String) {
			// TODO: add API call
			print("Search not implemented yet")
		}
		
		func handleReleaseSelection(at indexPath: IndexPath) {
			guard indexPath.row >= 0 && indexPath.row < results.count else {
				return
			}
			print("Selection not implemented yet")
		}
		
		// MARK: Data source
		
		func coverURL(for indexPath: IndexPath) -> URL? {
			guard indexPath.row >= 0 && indexPath.row < results.count else {
				return nil
			}
			return results[indexPath.row].imageUrl
		}
		
		func numberOfResults() -> Int {
			return results.count
		}
	}

}

extension HomeViewController.ViewModel {
	struct Release {
		var id: Int
		var imageUrl: URL
		var title: String
		var artistId: Int
	}
}
