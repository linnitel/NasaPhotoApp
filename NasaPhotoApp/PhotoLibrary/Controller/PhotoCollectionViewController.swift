//
//  PhotoCollectionViewController.swift
//  NasaPhotoApp
//
//  Created by Yuliya Martsenko on 10.02.2022.
//

import UIKit

class PhotoCollectionViewController: UIViewController {
    
    var links: [String] = ["https://apod.nasa.gov/apod/image/0809/falsekiva_pacholka.jpg", "https://apod.nasa.gov/apod/image/0607/j1655_ill_disk78.jpg", "https://apod.nasa.gov/apod/image/0801/16500feetmilkywaykc2_brunier800.jpg", "https://apod.nasa.gov/apod/image/0804/moon15h_laveder800.jpg", "https://apod.nasa.gov/BrokenLink", "https://apod.nasa.gov/apod/image/1401/ngc2207_hubble_960.jpg"]
    
    var photos = [UIImage]()
    
    var photoService: PhotoLoadServiceProtocol?
    
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        let size = self.view.frame.width / 2 - 20
        layout.itemSize = CGSize(width: size, height: size)
        let view = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        view.backgroundColor = UIColor.black
        view.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .systemOrange
        navigationController?.navigationBar.isTranslucent = false
        title = "NASA Mars Photos"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }
    
    private func setupView() {
        collection.dataSource = self
        collection.delegate = self
        view.addSubview(collection)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    override func viewDidLayoutSubviews() {
        collection.setNeedsLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        photoService = PhotoLoadService()
        setupNavigationBar()
        setupView()
        setupConstraints()
    }

}

extension PhotoCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
        let photoViewController = PhotoDetailViewController()
        guard let cell = collectionView.visibleCells[indexPath.row] as? PhotoCell,
              let image = cell.photo.image else {
            showAllert(error: NasaPhotosAppError.wrongUrl)
            return
        }
        photoViewController.image.image = image
        navigationController?.pushViewController(photoViewController, animated: true)
    }
    
}

extension PhotoCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        links.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell",
                                                            for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        cell.url = photoService?.createURL(from: links[indexPath.row], using: [:], with: KEY)
        cell.delegate = self
        return cell
    }
    
}

extension PhotoCollectionViewController: PhotoCellDelegate {
    func showAllert(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

