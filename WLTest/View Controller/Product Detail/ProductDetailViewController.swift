//
//  ProductDetailViewController.swift
//  WLTest
//
//  Created by Jordan Perry on 8/22/17.
//  Copyright © 2017 Jordan Perry. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController, ZoomInteractiveTransitionProtocol {
    enum ReuseIdentifier: String {
        case productDetailCell = "ProductDetailInfoCollectionViewCell"
        case productDescriptionCell = "ProductDetailDescriptionCollectionViewCell"
    }
    
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let productItemModel: ProductItemModel
    let selectedProductIndex: Int
    let productItemModels: [ProductItemModel]
    
    var updatedSelectedIndex: ((Int) -> Swift.Void)?
    
    func viewForType(_ type: ZoomInteractiveTransitionViewType) -> UIView {
        guard let cell = self.collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) else {
            return view
        }
        
        return cell
    }
    
    var zoomInteractiveTransitionEnabled: Bool = true
    
    init(productItemModel: ProductItemModel, selectedProductIndex: Int = 0, productItemModels: [ProductItemModel] = []) {
        self.productItemModel = productItemModel
        self.selectedProductIndex = selectedProductIndex
        self.productItemModels = productItemModels
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.productItemModel = ProductItemModel(with: [:])
        self.selectedProductIndex = 0
        self.productItemModels = []
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        }
        
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(ProductDetailInfoCollectionViewCell.self, forCellWithReuseIdentifier: ReuseIdentifier.productDetailCell.rawValue)
        collectionView.register(ProductDetailDescriptionCollectionViewCell.self, forCellWithReuseIdentifier: ReuseIdentifier.productDescriptionCell.rawValue)
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
        if traitCollection.userInterfaceIdiom == .phone {
            let left = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipe))
            left.direction = .left
            view.addGestureRecognizer(left)
            
            let right = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipe))
            right.direction = .right
            view.addGestureRecognizer(right)
        }
    }
    
    func leftSwipe(swipe: UISwipeGestureRecognizer) {
        self.swipe(swipe)
    }
    
    func rightSwipe(swipe: UISwipeGestureRecognizer) {
        self.swipe(swipe)
    }
    
    func swipe(_ swipe: UISwipeGestureRecognizer) {
        guard let navigationController = navigationController else {
            return
        }
        
        zoomInteractiveTransitionEnabled = false
        
        if swipe.direction == .left {
            if selectedProductIndex < productItemModels.count - 1 {
                let newProductIndex = selectedProductIndex + 1
                let newProduct = productItemModels[newProductIndex]
                let newDetail = ProductDetailViewController(productItemModel: newProduct, selectedProductIndex: newProductIndex, productItemModels: productItemModels)
                newDetail.updatedSelectedIndex = updatedSelectedIndex
                
                if let updatedSelectedIndex = updatedSelectedIndex {
                    updatedSelectedIndex(newProductIndex)
                }
                
                var viewControllers = navigationController.viewControllers
                viewControllers.removeLast()
                viewControllers.append(newDetail)
                navigationController.setViewControllers(viewControllers, animated: true)
            }
        } else if swipe.direction == .right {
            if selectedProductIndex > 0 {
                let newProductIndex = selectedProductIndex - 1
                let newProduct = productItemModels[newProductIndex]
                let newDetail = ProductDetailViewController(productItemModel: newProduct, selectedProductIndex: newProductIndex, productItemModels: productItemModels)
                newDetail.updatedSelectedIndex = updatedSelectedIndex
                
                if let updatedSelectedIndex = updatedSelectedIndex {
                    updatedSelectedIndex(newProductIndex)
                }
                
                var viewControllers = navigationController.viewControllers
                viewControllers.insert(newDetail, at: 1)
                navigationController.setViewControllers(viewControllers, animated: false)
                navigationController.popViewController(animated: true)
            }
        }
        
        zoomInteractiveTransitionEnabled = true
    }
}
