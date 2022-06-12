//
//  ViewController.swift
//  IGListKit Sandbox
//
//  Created by Leonardo  on 9/06/22.
//

import IGListDiffKit
import IGListKit
import UIKit

final class IGListKitCollectionController: UIViewController, CollectionView {
  /// # Init
  init() {
    super.init(nibName: nil, bundle: nil)
    configureTabBarItem()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  /// # IGListKit Properties
  private lazy var adapter: ListAdapter = {
    let updater = ListAdapterUpdater()
    return ListAdapter(updater: updater, viewController: self)
  }()

  /// # UI Properties
  private let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collection = UICollectionView(frame: .zero, collectionViewLayout: ListCollectionViewLayout(stickyHeaders: false, topContentInset: 0, stretchToEdge: false))
    collection.alwaysBounceVertical = true
    return collection
  }()

  /// # CollectionView DataSource
  lazy var collectionViewDataSource: ListAdapterDataSource = {
    let dataSource = IGListKitCollectionControllerDataSource()
    return dataSource
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.systemPink
    navigationItem.title = "IGListKit Collection"
    configureUI()
    configureCollection()
  }
}

// MARK: - IGListKit Adapter

extension IGListKitCollectionController {
  func configureCollection() {
    adapter.collectionView = collectionView
    adapter.dataSource = collectionViewDataSource
  }
}

// MARK: - UI

extension IGListKitCollectionController {
  func configureUI() {
    view.addSubview(collectionView)
    collectionView.backgroundColor = UIColor.systemIndigo
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
      collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
    ])
  }
}

extension IGListKitCollectionController {
  func configureTabBarItem() {
    let tabBarItem = UITabBarItem(title: "IGListKit", image: UIImage(systemName: "rectangle.grid.1x2.fill"), tag: 0)
    self.tabBarItem = tabBarItem
  }
}

// MARK: - IGList Datasource

final class IGListKitCollectionControllerDataSource: NSObject, ListAdapterDataSource {
  /// # Must be `IGListDiffable` compliant
  /// Never mutate the ListDIffable objects, always create a brand new one when updating the DataSource, otherwise the updates will be lost as instances have already been changed
  func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
    let ads: [Ad] = [Ad(content: "Ad 1"), Ad(content: "Ad 2"), Ad(content: "Ad 3")]
    return ads
  }

  func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
    return AdsSection()
  }

  func emptyView(for listAdapter: ListAdapter) -> UIView? {
    let view = UIView()
    view.backgroundColor = UIColor.systemGray
    return view
  }
}

// MARK: - Ads Section Controller

final class AdsSection: ListSectionController {
  private var ad: Ad?

  override init() {
    super.init()
    self.inset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
  }

  override func sizeForItem(at index: Int) -> CGSize {
    return CGSize(width: collectionContext!.containerSize.width, height: 55)
  }

  override func cellForItem(at index: Int) -> UICollectionViewCell {
    guard let adCell = collectionContext!.dequeueReusableCell(of: AdCell.self, for: self, at: index) as? AdCell else {
      fatalError("Error dequeing cell: \(AdCell.self)")
    }
    adCell.label.text = ad?.content
    return adCell
  }

  override func didUpdate(to object: Any) {
    ad = object as? Ad
  }
}
