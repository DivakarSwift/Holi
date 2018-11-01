//
//  ItemsCollectionViewCell.swift
//  Holi
//
//  Created by Кирилл on 22.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import UIKit
import SDWebImage
import Nuke
import Photos

protocol SelectableTableViewCell: class {
    func tableViewCell(didSelectAt indexPaht: IndexPath)
}

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var fullNameLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var postedTimeLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var downloadButton: UIButton!
    @IBOutlet var likesNumberLabel: UILabel!
    @IBOutlet var collectPhotoButton: UIButton!
    @IBOutlet var photoHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topView: UIView!
    @IBOutlet var bottomView: UIView!

    
    weak var delegate: SelectableTableViewCell?
    private let nukeManager = ImagePipeline()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let radius = Double(userImageView.frame.height / 2)
        userImageView.rounded(withRadius: radius)
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        
        let gesturePhotoImageView = UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto))
        photoImageView.addGestureRecognizer(gesturePhotoImageView)
        
        downloadButton.addTarget(self, action: #selector(handleDownloadButton(_:)), for: .touchUpInside)
        bottomView.layer.addBorder(edge: UIRectEdge.top, color: UIColor(white: 0.667, alpha: 0.5), thickness: 0.5)
        topView.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor(white: 0.667, alpha: 0.5), thickness: 0.5)
    }
    
    override func prepareForReuse() {
        userImageView.image = nil
        photoImageView.image = nil
    }
     
    var photoCellModel: PhotoCellModelOutput? {
        didSet {
            guard let photoCellModel = photoCellModel else {
                return
            }
            setupViewModel(photoCellModel)
        }
    }
    
    func setupViewModel(_ photoCellModel: PhotoCellModelOutput) {
        usernameLabel.text = photoCellModel.username
        fullNameLabel.text = photoCellModel.fullname
        likesNumberLabel.text = photoCellModel.totalLikes
        postedTimeLabel.text = photoCellModel.updated
        downloadButton.isSelected = photoCellModel.isDownloaded
        
        photoHeightConstraint.constant = CGFloat(photoCellModel.photoSizeCoef)
        loadPhoto(photoCellModel)
        
    }
    
    private func loadPhoto(_ photoCellModel: PhotoCellModelOutput) {
        
        nukeManager.loadImage(with: photoCellModel.regularPhoto!) {[weak self] (imageResponce, _) in
            self?.photoImageView.image = imageResponce?.image
        }
        nukeManager.loadImage(with: photoCellModel.userProfileImage!) { [weak self] (imageResponce, _) in
            self?.userImageView.image = imageResponce?.image
        }
        
//        let task = ImagePipeline.shared.loadImage(
//            with: URL(string: imageURLs?.full ?? "")!,
//            progress: { response, completed, total in
//                //self.photoImageView.image = response?.image
//                DispatchQueue.main.async {
//                    self.usernameLabel.text = "\(completed) from \(total)"
//                    if completed > 0, total > 0 {
//                        self.progressBar.isHidden = false
//                        self.progressBar.progress = ((Float(completed) / Float(total)))
//                    }
//                }
//        },
//            completion: { response, _ in
//                self.photoImageView.image = response?.image
//                self.progressBar.isHidden = true
//        })
    
        
//        photoImageView.sd_setImage(with: URL(string: imageURLs?.thumb ?? "")) { [weak self] (_, _, _, _) in
//            self?.photoImageView.addBlurEffect()
//            self?.photoImageView.sd_setImage(with: URL(string: imageURLs?.regular ?? "")) { [weak self] (_, _, _, _) in
//                self?.photoImageView.removeBlurEffect()
//            }
//        }
//        photoImageView.sd_setHighlightedImage(with: URL(string: imageURLs?.regular ?? ""), options: .retryFailed, progress: { (receivedSize, expectedSize, _) in
//            DispatchQueue.main.async {
//                self.usernameLabel.text = "\(receivedSize) from \(expectedSize)"
//            }
//        })
//        photoImageView.sd_setImage(with: URL(string: imageURLs?.full ?? ""), placeholderImage: nil, options: .lowPriority, progress: { (receivedSize, expectedSize, _) in
//            DispatchQueue.main.async {
//                self.usernameLabel.text = "\(receivedSize) from \(expectedSize)"
//                if receivedSize > 0, expectedSize > 0 {
//                    self.progressBar.isHidden = false
//                    self.progressBar.progress = ((Float(receivedSize) / Float(expectedSize)))
//                }
//            }
//
//        }) { (_, _, _, _) in
//            self.progressBar.isHidden = true
//        }
        
//        SDWebImageDownloader.shared().downloadImage(with: URL(string: imageURLs?.full ?? ""), options: .lowPriority, progress: { (receivedSize, expectedSize, _) in
//            DispatchQueue.main.async {
//                self.usernameLabel.text = "\(receivedSize) from \(expectedSize)"
//                if receivedSize > 0, expectedSize > 0 {
//                    self.progressBar.isHidden = false
//                    self.progressBar.progress = ((Float(receivedSize) / Float(expectedSize)))
//                }
//            }
//        })
        
    }
    
    private func photoSizeCoef(_ photo: PhotoProtocol) {
        let width = Double(photo.width ?? 0)
        let height = Double(photo.height ?? 0)
        photoHeightConstraint.constant = CGFloat(height * Double(UIScreen.main.bounds.width) / width)
    }
    
    @objc private func handleSelectPhoto() {
        guard let indexPath = indexPath else { return }
        delegate?.tableViewCell(didSelectAt: indexPath)
    }
    
    @objc func handleDownloadButton(_ sender: UIButton) {
        guard !(photoCellModel?.isDownloaded ?? true) else { return }
        photoCellModel?.isDownloaded = true
        sender.isSelected = true
        //UIImageWriteToSavedPhotosAlbum(photoImageView.image!, nil, nil, nil)
        
        //photo?.location?.position.map { print($0)}
        //let loaction = CLLocation(latitude: , longitude: )
        //addAsset(image: photoImageView.image!, location: <#T##CLLocation?#>)
        
    }
    
    func addAsset(image: UIImage, location: CLLocation? = nil) {
        PHPhotoLibrary.shared().performChanges({
            // Request creating an asset from the image.
            let creationRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
            // Set metadata location
            if let location = location {
                creationRequest.location = location
            }
        }, completionHandler: { success, error in
            if !success { NSLog("error creating asset: \(error)") }
        })
    }
    
}
