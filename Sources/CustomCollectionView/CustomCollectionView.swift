//
//  CustomCollectionView.swift
//  CustomCollectionView
//
//  Created by zein rezky chandra on 10/07/24.
//

import UIKit

public protocol CustomCollectionViewDelegate: AnyObject {
    func loadMoreData()
    func refreshData()
}

public class CustomCollectionView: UICollectionView {
    public weak var customDelegate: CustomCollectionViewDelegate?

    private var isLoadingMore = false
    private let customRefreshControl = UIRefreshControl()

    public init() {
        let layout = CustomCollectionViewLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        // Register custom cell
        register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        // Set any default properties
        backgroundColor = .white
        delegate = self
        
        // Setup refresh control
        customRefreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        addSubview(customRefreshControl)
    }
    
    @objc private func refreshData() {
        customDelegate?.refreshData()
    }

    public func finishLoadingMore() {
        isLoadingMore = false
    }
    
    public func finishRefreshing() {
        customRefreshControl.endRefreshing()
    }
}

extension CustomCollectionView: UICollectionViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height {
            if !isLoadingMore {
                isLoadingMore = true
                customDelegate?.loadMoreData()
            }
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            UIView.animate(withDuration: 0.2,
                           animations: {
                               cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                           },
                           completion: { _ in
                               UIView.animate(withDuration: 0.2) {
                                   cell.transform = CGAffineTransform.identity
                               }
                           })
        }
    }
}
