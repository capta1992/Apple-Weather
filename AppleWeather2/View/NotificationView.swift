//
//  NotificationView.swift
//  AppleWeather2
//
//  Created by Lawson Falomo on 11/8/23.
//

import UIKit

class NotificationView: UIView {
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.darkGray.cgColor
        layer.cornerRadius = 10
        backgroundColor = .darkGray
        
        let imageView = createImageView()
        let label = createLabel()
        let subtitleLabel = createSubtitleLabel()
        let button = createButton()
        let dividerLine = createDividerLine()
        let closeButton = createCloseButton()
        
        addSubview(
            imageView,
            label,
            subtitleLabel,
            button,
            dividerLine,
            closeButton
        )
        setupConstraints(
            imageView,
            label,
            subtitleLabel,
            button,
            dividerLine,
            closeButton
        )
    }
    
    // MARK: - View Creation Functions
    private func createImageView() -> UIImageView {
        let imageView = UIImageView(image: UIImage(systemName: "exclamationmark.triangle"))
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.text = "Stay Informed"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }
    
    private func createSubtitleLabel() -> UILabel {
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Get notifications for severe weather, rain, and snow near you."
        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.textColor = .lightGray
        subtitleLabel.numberOfLines = 0
        return subtitleLabel
    }
    
    private func createButton() -> UIButton {
        let button = UIButton(type: .system)
        button.contentHorizontalAlignment = .left
        button.setTitle("Enable Notifications" + "  \u{203A}", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }
    
    private func createDividerLine() -> UIView {
        let dividerLine = UIView()
        dividerLine.backgroundColor = .lightGray
        return dividerLine
    }
    
    private func createCloseButton() -> UIButton {
        let closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .lightGray
        closeButton.setTitleColor(.lightGray, for: .normal)
        return closeButton
    }
    
    private func addSubview(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    private func setupConstraints(_ imageView: UIImageView, _ label: UILabel, _ subtitleLabel: UILabel, _ button: UIButton, _ dividerLine: UIView, _ closeButton: UIButton) {
        // ImageView Constraints
        imageView.anchor(
            top: topAnchor,
            left: leftAnchor,
            paddingTop: 16,
            paddingLeft: 16,
            width: 40,
            height: 40
        )
        
        // Label Constraints
        label.anchor(
            top: imageView.topAnchor,
            left: imageView.rightAnchor,
            right: closeButton.leftAnchor,
            paddingLeft: 10,
            paddingRight: 10
        )
        
        // Subtitlelabel Constraints
        subtitleLabel.anchor(
            top: label.bottomAnchor,
            left: label.leftAnchor,
            right: closeButton.leftAnchor,
            paddingTop: 5,
            paddingRight: 10
        )
        
        // DividerLine Constraints
        dividerLine.anchor(
            top: subtitleLabel.bottomAnchor,
            left: subtitleLabel.leftAnchor,
            right: rightAnchor,
            paddingTop: 10,
            height: 1
        )
        
        // Button Constraints
        button.anchor(
            top: dividerLine.bottomAnchor,
            left: subtitleLabel.leftAnchor,
            right: subtitleLabel.rightAnchor,
            paddingTop: 10
        )
        
        // CloseButton Constraints
        closeButton.anchor(
            top: topAnchor,
            right: rightAnchor,
            paddingTop: 10,
            paddingRight: 10,
            width: 15,
            height: 15
        )
    }
}
