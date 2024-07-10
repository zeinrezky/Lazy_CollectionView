//
//  CustomCollectionViewCell.swift
//  CustomCollectionView
//
//  Created by zein rezky chandra on 10/07/24.
//

import UIKit

public class CustomCollectionViewCell: UICollectionViewCell {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        // Add your custom cell setup code here
        backgroundColor = .lightGray
    }
}
