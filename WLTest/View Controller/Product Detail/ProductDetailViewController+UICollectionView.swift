//
//  ProductDetailViewController+UICollectionView.swift
//  WLTest
//
//  Created by Jordan Perry on 8/22/17.
//  Copyright © 2017 Jordan Perry. All rights reserved.
//

import UIKit

extension ProductDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.productDetailCell.rawValue, for: indexPath) as? ProductDetailInfoCollectionViewCell {
                let viewModel = productItemModel.productItemViewModel ?? ProductItemViewModel(with: productItemModel)
                cell.productDetailInfoView.update(with: viewModel)
                
                return cell
            }
        }
        
        if indexPath.row == 1 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.productDescriptionCell.rawValue, for: indexPath) as? ProductDetailDescriptionCollectionViewCell {
                
                let viewModel = productItemModel.productDescriptionViewModel ?? ProductDescriptionViewModel(with: productItemModel)
                cell.productDetailDescriptionView.update(with: viewModel)
                
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
}
