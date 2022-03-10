//
//  PhotoDetailViewController.swift
//  NasaPhotoApp
//
//  Created by Yuliya Martsenko on 10.02.2022.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    let scrollView = UIScrollView()
    
    let image = UIImageView()
    
//    private var imageView = UIImageView()
//
//    private lazy var scrollView: UIScrollView  = {
//        let view = UIScrollView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }() {
//        didSet {
//            scrollView.contentSize = imageView.frame.size
//            scrollView.delegate = self
//            scrollView.minimumZoomScale = 0.5
//            scrollView.maximumZoomScale = 10.0
//        }
//    }
//
//    var image: UIImage? {
//        get {
//            return imageView.image
//        }
//        set {
//            imageView.image = newValue
//            imageView.sizeToFit()
//            scrollView.contentSize = imageView.frame.size
//            view.setNeedsDisplay()
//        }
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//    }
//
    override func viewDidLoad() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(image)
        
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 10
        scrollView.delegate = self
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            image.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            image.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor),
            image.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
//        super.viewDidLoad()
//        view.backgroundColor = .black
//        scrollView.backgroundColor = .black
//        scrollView.frame = view.bounds
//        view.addSubview(scrollView)
//        scrollView.addSubview(imageView)
////        setConstraints()
    }
//
//    override func viewDidLayoutSubviews() {
//        view.setNeedsDisplay()
//    }
//
//    private func setConstraints() {
//        NSLayoutConstraint.activate([
//            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
}
//
extension PhotoDetailViewController: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return image
    }
//
////    func scrollViewDidZoom(_ scrollView: UIScrollView) {
////        if scrollView.zoomScale > 1 {
////            guard let image = image else {
////                return
////            }
////            let ratioWidth = imageView.frame.width / image.size.width
////            let ratioHeight = imageView.frame.height / image.size.height
////            let ratio = ratioWidth < ratioHeight ? ratioWidth : ratioHeight
////            let newWidth = image.size.width * ratio
////            let newHeight = image.size.height * ratio
////        }
////    }
////    @objc func changeScale(_ recognizer: UIPinchGestureRecognizer) {
////        switch recognizer.state {
////        case .ended, .changed:
////            scale *= recognizer.scale
////            recognizer.scale = 1.0
////        default:
////            break
////        }
////    }
//}
}
