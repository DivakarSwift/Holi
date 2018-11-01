//
//  ArticleDetailController.swift
//  Holi
//
//  Created by Кирилл on 04.06.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation
import Nuke

class PhotoDetailController: BaseViewController, PhotoDetailView {

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let overlayInfoView: OverlayInfoView = {
        let overlayInfoView = OverlayInfoView(frame: .zero)
        overlayInfoView.translatesAutoresizingMaskIntoConstraints = false
        return overlayInfoView
    }()
    
    var viewModel: PhotoDetailModelProtocol!
    
    private var isTouched = true {
        didSet {
            navigationController?.navigationBar.tintColor =  isTouched ? .clear : UINavigationBar.appearance().tintColor
            navigationController?.navigationBar.isUserInteractionEnabled = !isTouched
        }
    }
    
    private var currentScaleFactor: CGFloat = 1
    private var statsContainerViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
        setupOverlayInfoView()
        setupGestureRecognizer()
        showHideOverlays()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.tintColor = UINavigationBar.appearance().tintColor
    }
    
    override func bindViewModel() {
        overlayInfoView.didSelectedDownloadButton = {[weak self] _ in
            self?.viewModel.saveFullImageIntoPhotoLibrary()
            HUDService.show()
        }
        
        viewModel.didUpdate = {[weak self] in
            self?.setupOverlayInfoView()
        }
        
        viewModel.handleError = { error in
            HUDService.showError(withStatus: error.localizedDescription)
        }
        
        viewModel.didSuccesfullySavedImage = {
            HUDService.showSuccess(message: "Saved")
        }
        
        photoImageView.sd_setImage(with: viewModel.photoRegularUrl) { [weak self] (image, _, _, _) in
            guard let image = image, let strongSelf = self else { return }
            strongSelf.view.layoutIfNeeded()
            strongSelf.photoImageView.image = image
            strongSelf.photoImageView.sizeToFit()
            strongSelf.setZoomScale()
            strongSelf.scrollViewDidZoom(strongSelf.scrollView)
        }
    }
    
    private func setupOverlayInfoView() {
        overlayInfoView.setTitleTotalViewsLabel(viewModel.totalViews)
        overlayInfoView.setTitleTotalLikesLabel(viewModel.totalLikes)
        overlayInfoView.setTitleTotalDowloadsLabel(viewModel.totalDownloads)
    }
    
    private func setupViews() {
        view.backgroundColor = .black
        navigationController?.navigationBar.tintColor =  isTouched ? .clear : UINavigationBar.appearance().tintColor
        
        view.addSubview(overlayInfoView)
        overlayInfoView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        overlayInfoView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        statsContainerViewBottomConstraint = overlayInfoView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 50)
        statsContainerViewBottomConstraint.isActive = true
        
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.safeLeftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.safeRightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: overlayInfoView.topAnchor).isActive = true
        
        scrollView.addSubview(photoImageView)
        photoImageView.fillSuperview()
        
    }
    
    @objc public func doubleTapAction(recognizer: UITapGestureRecognizer) {
        let factor: CGFloat = 2.0
        showHideOverlays(withDuration: 0.1)
        if currentScaleFactor == 1 {
            scrollView.setZoomScale(scrollView.zoomScale * factor , animated: true)
            currentScaleFactor *= factor
        } else {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
            currentScaleFactor = 1
        }
    }
    
    private func setupGestureRecognizer() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapAction(recognizer:)))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showHideOverlays))
        tapGesture.numberOfTapsRequired = 1
        scrollView.addGestureRecognizer(tapGesture)
        
        tapGesture.require(toFail: doubleTap)
    }
    
    @objc private func showHideOverlays(withDelay delay: Double = 0.0, withDuration duration: Double = 0.5) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            UIView.animate(withDuration: duration, animations: {
                if self.isTouched {
                    self.statsContainerViewBottomConstraint.constant = 0
                    self.isTouched = false
                } else {
                    self.statsContainerViewBottomConstraint.constant = 50
                    self.isTouched = true
                }
                self.view.layoutIfNeeded()
            })
        }
    }
    
    private func setZoomScale() {
        let imageViewSize = photoImageView.bounds.size
        let scrollViewSize = scrollView.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        
        scrollView.minimumZoomScale = min(widthScale, heightScale)
        scrollView.maximumZoomScale = min(widthScale * 4, heightScale * 4)
        scrollView.setZoomScale(scrollView.minimumZoomScale, animated: false)
    }
}

extension PhotoDetailController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
        let imageViewSize = photoImageView.frame.size
        let scrollViewSize = scrollView.bounds.size
        
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
        
        if verticalPadding >= 0 {
            // Center the image on screen
            scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
        } else {
            // Limit the image panning to the screen bounds
            scrollView.contentSize = imageViewSize
        }
    }
}
