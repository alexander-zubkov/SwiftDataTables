//
//  DataCell.swift
//  SwiftDataTables
//
//  Created by Pavan Kataria on 22/02/2017.
//  Copyright © 2017 Pavan Kataria. All rights reserved.
//

import UIKit

class DataCell: UICollectionViewCell {

    //MARK: - Properties
    private enum Properties {
        static let verticalMargin: CGFloat = 5
        static let horizontalMargin: CGFloat = 15
        static let widthConstant: CGFloat = 20
    }
    
    let dataLabel = UILabel()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        dataLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dataLabel)
        NSLayoutConstraint.activate([
            dataLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: Properties.widthConstant),
            dataLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Properties.verticalMargin),
            dataLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Properties.verticalMargin),
            dataLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Properties.horizontalMargin),
            dataLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Properties.horizontalMargin),
        ])
        
        let metrics = ["width" : NSNumber(value: 1)]
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.gray
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomLine)

        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[border]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views:["border" : bottomLine]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[border(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["border" : bottomLine]))

        let rightLine = UIView()
        rightLine.backgroundColor = UIColor.gray
        rightLine.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(rightLine)
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[border(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views:["border" : rightLine]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[border]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["border" : rightLine]))
    }
    
    func configure(_ viewModel: DataCellViewModel) {
        self.dataLabel.text = viewModel.data.stringRepresentation
    }
}
