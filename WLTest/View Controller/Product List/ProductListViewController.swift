//
//  ProductListViewController.swift
//  WLTest
//
//  Created by Jordan Perry on 8/20/17.
//  Copyright © 2017 Jordan Perry. All rights reserved.
//

import UIKit

class ProductListCollectionViewLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        
        estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    // Make sure that rows stay even
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if let inheritedAttributes = super.layoutAttributesForElements(in: rect) {
            return inheritedAttributes.enumerated().map {
                guard $0 > 0 else {
                    return $1
                }
                
                if $1.representedElementCategory == .cell {
                    let previous = inheritedAttributes[$0 - 1]
                    let previousFrame = previous.frame
                    let currentFrame = $1.frame
                    
                    let rowRect = CGRect(x: previousFrame.minX, y: previousFrame.minY, width: rect.width, height: previousFrame.height)
                    
                    if currentFrame.intersects(rowRect) {
                        let sizeForAttributes = CGSize(width: $1.size.width, height: max(previous.size.height, $1.size.height))
                        previous.size = sizeForAttributes
                        $1.size = sizeForAttributes
                    }
                }
                
                return $1
            }
        }
        
        return nil
    }
}

class ProductListViewController: UIViewController, ZoomInteractiveTransitionProtocol {
    enum ReuseIdentifier: String {
        case productItemCell = "ProductItemCollectionViewCell"
        case loadingCell = "LoadingCollectionViewCell"
    }
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: ProductListCollectionViewLayout())
    
    var pageModel: ProductListPageModel?
    var products: [ProductItemModel] = []
    
    var currentPage = 0
    var maxProducts = 0
    var loadingDisplaying = false
    
    var transition: ZoomInteractiveTransition?
    
    var zoomView: UIView?
    func viewForType(_ type: ZoomInteractiveTransitionViewType) -> UIView {
        guard let zoomView = self.zoomView else {
            return view
        }
        
        return zoomView
    }
    
    var zoomInteractiveTransitionEnabled: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if traitCollection.userInterfaceIdiom == .phone {
            transition = ZoomInteractiveTransition()
            transition?.navigationController = navigationController
        }
        
        view.backgroundColor = UIColor.white
        
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        collectionView.isPrefetchingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(ProductItemCollectionViewCell.self, forCellWithReuseIdentifier: ReuseIdentifier.productItemCell.rawValue)
        collectionView.register(LoadingCollectionViewCell.self, forCellWithReuseIdentifier: ReuseIdentifier.loadingCell.rawValue)
        
        view.addSubview(collectionView)
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            activityIndicator.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 100.0),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        loadPage(1)
    }
    
    var finishedFirst = false
    var currentlyLoading = false
    func loadPage(_ page: Int) {
        if currentlyLoading {
            return
        }
        
        var requestFinished = false
        
        if page == 1 {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
                guard !requestFinished else {
                    return
                }
                
                self.activityIndicator.startAnimating()
            }
        }
        
        currentlyLoading = true
        currentPage = page
        
        let plp = ProductListPageModel(apiKey: Constants.apiKey(), pageNumber: page, pageSize: 30)
        plp.request { [weak self] (model, response, error) in
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.currentlyLoading = false
            
            guard let model = model else {
                // TODO: Show error
                print(error!)
                return
            }
            
            requestFinished = true
            strongSelf.pageModel = model
            
            if let maxProducts = model.totalProducts {
                strongSelf.maxProducts = maxProducts
            }
            
            var incomingIndexPaths: [IndexPath] = []
            if let products = strongSelf.pageModel?.products {
                let startPoint = strongSelf.products.count
                
                strongSelf.products += products
                
                let endPoint = strongSelf.products.count
                
                let range = startPoint..<endPoint
                
                if startPoint != 0 {
                    incomingIndexPaths = range.map { return IndexPath(item: $0, section: 0) }
                }
            }
            
            DispatchQueue.main.async {
                strongSelf.activityIndicator.stopAnimating()
                
                if incomingIndexPaths.count > 0 {
                    strongSelf.collectionView.performBatchUpdates({ [weak strongSelf] in
                        guard let strongStrongSelf = strongSelf else {
                            return
                        }
                        
                        strongStrongSelf.collectionView.insertItems(at: incomingIndexPaths)
                        
                        if strongStrongSelf.products.count >= strongStrongSelf.maxProducts {
                            strongStrongSelf.collectionView.deleteSections(IndexSet(integer: 1))
                        }
                    }, completion: { (finished) in
                        
                    })
                } else {
                    strongSelf.collectionView.reloadData()
                }
            }
            
            strongSelf.finishedFirst = true
        }
    }
}
