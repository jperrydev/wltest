//
//  ProductListViewController+UICollectionView.swift
//  WLTest
//
//  Created by Jordan Perry on 8/20/17.
//  Copyright © 2017 Jordan Perry. All rights reserved.
//

import UIKit

extension ProductListViewController: UICollectionViewDataSource, UICollectionViewDataSourcePrefetching, UICollectionViewDelegate {
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard pageModel != nil else {
            return 0
        }
        
        if products.count < maxProducts {
            return 2
        }
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard pageModel != nil else {
            return 0
        }
        
        if section == 1 {
            return 1
        }
        
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.productItemCell.rawValue, for: indexPath) as? ProductItemCollectionViewCell {
                
                let model = products[indexPath.item]
                let viewModel = model.productItemViewModel ?? ProductItemViewModel(with: model)
                cell.productItemView.update(with: viewModel)
                
                return cell
            }
        }
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.loadingCell.rawValue, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? LoadingCollectionViewCell {
            cell.activityIndicator.startAnimating()
            
            loadingDisplaying = true
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) { [weak self] in
                guard let strongSelf = self, strongSelf.loadingDisplaying else {
                    return
                }
                
                strongSelf.loadPage(strongSelf.currentPage + 1)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? LoadingCollectionViewCell {
            cell.activityIndicator.stopAnimating()
            
            loadingDisplaying = false
        }
        
        if indexPath.section == 0 {
            let model = products[indexPath.item]
            guard let viewModel = model.productItemViewModel else {
                return
            }
            
            viewModel.cancelImageDownload()
        }
    }
    
    // MARK: UICollectionViewDataSourcePrefetching
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let product = products[indexPath.item]
            let viewModel = ProductItemViewModel(with: product)
            viewModel.displayImage(completion: { (image, error) in
                // do nothing, just prefetch to cache
            })
        }
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = products[indexPath.item]
        
        if traitCollection.userInterfaceIdiom == .phone {
            if let navigationController = navigationController {
                if let selectedCell = collectionView.cellForItem(at: indexPath) {
                    zoomView = selectedCell
                }
                
                let detail = ProductDetailViewController(productItemModel: product, selectedProductIndex: indexPath.item, productItemModels: products)
                detail.updatedSelectedIndex = { [weak self] (index) in
                    guard let strongSelf = self else {
                        return
                    }
                    
                    let indexPath = IndexPath(item: index, section: 0)
                    strongSelf.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: false)
                    strongSelf.collectionView.layoutIfNeeded()
                    if let selectedCell = strongSelf.collectionView.cellForItem(at: indexPath) {
                        strongSelf.zoomView = selectedCell
                    }
                }
                navigationController.pushViewController(detail, animated: true)
            }
        } else if traitCollection.userInterfaceIdiom == .pad {
            let detail = ProductDetailViewController(productItemModel: product)
            
            if presentedViewController != nil {
                dismiss(animated: true, completion: nil)
            }
            
            detail.modalPresentationStyle = .popover
            
            if let selectedCell = collectionView.cellForItem(at: indexPath) {
                detail.popoverPresentationController?.passthroughViews = [view]
                detail.popoverPresentationController?.sourceView = view
                detail.popoverPresentationController?.sourceRect = view.convert(selectedCell.bounds, from: selectedCell)
            }
            
            present(detail, animated: true, completion: nil)
        }
    }
}
