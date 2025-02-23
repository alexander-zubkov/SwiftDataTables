//
//  DataHeaderFooter.swift
//  SwiftDataTables
//
//  Created by Pavan Kataria on 22/02/2017.
//  Copyright © 2017 Pavan Kataria. All rights reserved.
//

import UIKit

class DataHeaderFooter: UICollectionReusableView {

    //MARK: - Properties
    private enum Properties {
        static let labelHorizontalMargin: CGFloat = 15
        static let labelVerticalMargin: CGFloat = 5
        static let separator: CGFloat = 5
        static let imageViewHorizontalMargin: CGFloat = 5
        static let labelWidthConstant: CGFloat = 20
        static let imageViewWidthConstant: CGFloat = 20
        static let imageViewAspectRatio: CGFloat = 0.75
    }
    
    let titleLabel = UILabel()
    let sortingImageView = UIImageView()


    //MARK: - Events
    var didTapEvent: (() -> Void)? = nil

    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont.systemFont(ofSize: UIFont.labelFontSize, weight: .heavy)
        addSubview(titleLabel)
        addSubview(sortingImageView)
        
        let metrics = ["width" : NSNumber(value: 1)]
        
        let topLine = UIView()
        if #available(iOS 13.0, *) {
            topLine.backgroundColor = UIColor.systemGray4
        } else {
            topLine.backgroundColor = UIColor.lightGray
        }
        topLine.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(topLine)

        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[border]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views:["border" : topLine]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[border(width)]", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["border" : topLine]))
        
        let bottomLine = UIView()
        if #available(iOS 13.0, *) {
            bottomLine.backgroundColor = UIColor.systemGray4
        } else {
            bottomLine.backgroundColor = UIColor.lightGray
        }
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomLine)

        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[border]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views:["border" : bottomLine]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[border(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["border" : bottomLine]))

        let rightLine = UIView()
        if #available(iOS 13.0, *) {
            rightLine.backgroundColor = UIColor.systemGray4
        } else {
            rightLine.backgroundColor = UIColor.lightGray
        }
        rightLine.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(rightLine)
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[border(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views:["border" : rightLine]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[border]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["border" : rightLine]))
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(DataHeaderFooter.didTapView))
        addGestureRecognizer(tapGesture)
    }
    
    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        sortingImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: Properties.labelWidthConstant),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Properties.labelVerticalMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Properties.labelHorizontalMargin),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Properties.labelVerticalMargin),
            sortingImageView.widthAnchor.constraint(equalToConstant: Properties.imageViewWidthConstant),
            sortingImageView.widthAnchor.constraint(equalTo: sortingImageView.heightAnchor, multiplier: Properties.imageViewAspectRatio),
            sortingImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            sortingImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Properties.imageViewHorizontalMargin),
            sortingImageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: Properties.separator),
        ])
    }
    
    func configure(viewModel: DataHeaderFooterViewModel) {
        self.titleLabel.text = viewModel.data
        self.sortingImageView.image = viewModel.imageForSortingElement
        self.sortingImageView.tintColor = viewModel.tintColorForSortingElement
        self.backgroundColor = .white
    }
    
    @objc func didTapView() {
        self.didTapEvent?()
    }
}
