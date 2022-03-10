//
//  PhotoCell.swift
//  NasaPhotoApp
//
//  Created by Yuliya Martsenko on 10.02.2022.
//

import UIKit

final class PhotoCell: UICollectionViewCell {
    
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    var delegate: PhotoCellDelegate?
    
    var url: URL? {
        didSet {
            let photoLoadService = PhotoLoadService()
            activityIndicator.startAnimating()
            photoLoadService.loadPhoto(from: url, completion: { [weak self] result in
                guard let self = self else {
                    return
                }
                switch result {
                case .success(let image):
                    self.activityIndicator.stopAnimating()
                    self.photo.image = image
                case .failure(let error):
                    self.activityIndicator.stopAnimating()
                    self.delegate?.showAllert(error: error)
                    print(error)
                }
            })
        }
    }
    
    var photo:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemOrange
        photo.frame = CGRect(x: self.bounds.minX,
                             y: self.bounds.minY,
                             width: self.bounds.width,
                             height: self.bounds.height)
        activityIndicator.frame = CGRect(x: self.bounds.minX,
                                         y: self.bounds.minY,
                                         width: self.bounds.width,
                                         height: self.bounds.height)
        contentView.addSubview(photo)
        contentView.addSubview(activityIndicator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
