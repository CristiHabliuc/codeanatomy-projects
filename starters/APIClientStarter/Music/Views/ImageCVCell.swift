//
//  ImageCVCell.swift
//  Images
//
//  Created by Cristi Habliuc on 16.03.2022.
//

import UIKit

class ImageCVCell: UICollectionViewCell {
	static let reuseIdentifier: String = "ImageCVCell"
	
	private var currentTask: URLSessionDataTask?
	private var currentImageURL: URL?
	
	@IBOutlet weak var imageView: UIImageView!
	
	
	override func awakeFromNib() {
		super.awakeFromNib()
		imageView.backgroundColor = .lightGray
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 5
		imageView.contentMode = .scaleAspectFill
	}
	
	func updateImage(with url: URL) {
		guard currentImageURL != url else {
			// don't re-download
			return
		}
		
		currentImageURL = url
		imageView.image = nil
		if currentTask?.state == .running {
			currentTask?.cancel()
		}
		currentTask = URLSession.shared.dataTask(
			with: url) { data, response, error in
				if let data = data {
					let image = UIImage(data: data, scale: UIScreen.main.scale)
					DispatchQueue.main.async {
						UIView.animate(withDuration: 0.5, delay: 0, options: []) {
							self.imageView.image = image
						} completion: { _ in
						}

					}
				}
			}
		currentTask?.resume()
	}
}
