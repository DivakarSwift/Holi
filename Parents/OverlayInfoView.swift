//
//  OverlayInfoView.swift
//  Holi
//
//  Created by Кирилл on 10/21/18.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation
class OverlayInfoView: UIView {
    
    private var eyeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.image = UIImage(named: "eye-white")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var totalViewsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var likesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "favorite-border-white")
        imageView.tintColor = .white
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var totalLikesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var downloadsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "down"), for: .normal)
        button.tintColor = .white
        button.isHidden = true
        button.addTarget(self, action: #selector(handleSelectedDownloads(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var totalDownloadsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var totalViewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var totalLikesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let totalDownloadsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var didSelectedDownloadButton: ((_ sender: UIButton) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    public func setTitleTotalViewsLabel(_ text: String?) {
        guard let _ = text else {
            setView(view: totalViewsView, hidden: true)
            return
        }
        setView(view: totalViewsView, hidden: false)
        totalViewsLabel.text = text
    }
    
    public func setTitleTotalLikesLabel(_ text: String?) {
        guard let _ = text else {
            setView(view: totalLikesView, hidden: true)
            return
        }
        setView(view: totalLikesView, hidden: false)
        totalLikesLabel.text = text
    }
    
    public func setTitleTotalDowloadsLabel(_ text: String?) {
        guard let _ = text else {
            setView(view: totalDownloadsView, hidden: true)
            return
        }
        downloadsButton.isHidden = false
        setView(view: totalDownloadsView, hidden: false)
        totalDownloadsLabel.text = text
    }
    
    @objc private func handleSelectedDownloads(_ sender: UIButton) {
        didSelectedDownloadButton?(sender)
    }
    
    private func setupViews() {
        
        let stackView = UIStackView(arrangedSubviews: [totalViewsView, totalLikesView, totalDownloadsView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 40
        
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        addSubview(stackView)
        stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: Constraints.padding3x).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: Constraints.padding).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constraints.padding).isActive = true
        let stackViewWidthAnchorConstants: CGFloat = (CGFloat(stackView.arrangedSubviews.count) * 60) + (CGFloat(stackView.arrangedSubviews.count) * stackView.spacing)
        stackView.widthAnchor.constraint(equalToConstant: stackViewWidthAnchorConstants)
        
//        addSubview(totalViewsView)
//        totalViewsView.leftAnchor.constraint(equalTo: leftAnchor, constant: Constraints.padding3x).isActive = true
//        totalViewsView.topAnchor.constraint(equalTo: topAnchor, constant: Constraints.padding).isActive = true
//        totalViewsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constraints.padding).isActive = true
        totalViewsView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        totalViewsView.addSubview(eyeImageView)
        eyeImageView.topAnchor.constraint(equalTo: totalViewsView.topAnchor).isActive = true
        eyeImageView.leftAnchor.constraint(equalTo: totalViewsView.leftAnchor).isActive = true
        eyeImageView.bottomAnchor.constraint(equalTo: totalViewsView.bottomAnchor).isActive = true
        eyeImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        totalViewsView.addSubview(totalViewsLabel)
        totalViewsLabel.topAnchor.constraint(equalTo: totalViewsView.topAnchor, constant: Constraints.padding).isActive = true
        totalViewsLabel.leftAnchor.constraint(equalTo: eyeImageView.rightAnchor, constant: 2).isActive = true
        totalViewsLabel.bottomAnchor.constraint(equalTo: totalViewsView.bottomAnchor, constant: -Constraints.padding).isActive = true
        
//        addSubview(totalLikesView)
//        totalLikesView.leftAnchor.constraint(equalTo: totalViewsView.rightAnchor, constant: 40).isActive = true
//        totalLikesView.topAnchor.constraint(equalTo: topAnchor, constant: Constraints.padding).isActive = true
//        totalLikesView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constraints.padding).isActive = true
        totalLikesView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        totalLikesView.addSubview(likesImageView)
        likesImageView.topAnchor.constraint(equalTo: totalLikesView.topAnchor).isActive = true
        likesImageView.leftAnchor.constraint(equalTo: totalLikesView.leftAnchor).isActive = true
        likesImageView.bottomAnchor.constraint(equalTo: totalLikesView.bottomAnchor).isActive = true
        likesImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        totalLikesView.addSubview(totalLikesLabel)
        totalLikesLabel.topAnchor.constraint(equalTo: totalViewsView.topAnchor, constant: Constraints.padding).isActive = true
        totalLikesLabel.leftAnchor.constraint(equalTo: likesImageView.rightAnchor, constant: 2).isActive = true
        totalLikesLabel.bottomAnchor.constraint(equalTo: totalViewsView.bottomAnchor, constant: -Constraints.padding).isActive = true
        
//        addSubview(totalDownloadsView)
//        totalDownloadsView.leftAnchor.constraint(equalTo: totalLikesView.rightAnchor, constant: 40).isActive = true
//        totalDownloadsView.topAnchor.constraint(equalTo: topAnchor, constant: Constraints.padding).isActive = true
//        totalDownloadsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constraints.padding).isActive = true
        totalDownloadsView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        totalDownloadsView.addSubview(downloadsButton)
        downloadsButton.topAnchor.constraint(equalTo: totalDownloadsView.topAnchor).isActive = true
        downloadsButton.leftAnchor.constraint(equalTo: totalDownloadsView.leftAnchor).isActive = true
        downloadsButton.bottomAnchor.constraint(equalTo: totalDownloadsView.bottomAnchor).isActive = true
        downloadsButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        totalDownloadsView.addSubview(totalDownloadsLabel)
        totalDownloadsLabel.topAnchor.constraint(equalTo: totalDownloadsView.topAnchor, constant: Constraints.padding).isActive = true
        totalDownloadsLabel.leftAnchor.constraint(equalTo: downloadsButton.rightAnchor, constant: 2).isActive = true
        totalDownloadsLabel.bottomAnchor.constraint(equalTo: totalDownloadsView.bottomAnchor, constant: -Constraints.padding).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
            view.layoutIfNeeded()
        })
        
    }
}
