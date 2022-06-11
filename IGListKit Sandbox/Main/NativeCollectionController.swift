//
//  NativeCollectionController.swift
//  IGListKit Sandbox
//
//  Created by Leonardo  on 11/06/22.
//

import UIKit

final class NativeCollectionController: UIViewController, CollectionView {
  /// # Init
  init() {
    super.init(nibName: nil, bundle: nil)
    configureTabBarItem()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private let ads: [Ad] = [
    Ad(content: "Ad 1"),
    Ad(content: "Ad 2"),
    Ad(content: "Ad 3")
  ]

  private var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 10
    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collection.alwaysBounceVertical = true
    return collection
  }()

  lazy var collectionViewDataSource: UICollectionViewDataSource = {
    let dataSource = NativeCollectionControllerDataSource()
    dataSource.ads = ads
    return dataSource
  }()

  lazy var collectionViewDelegate: UICollectionViewDelegate = {
    let delegate = NativeCollectionControllerDelegate()
    delegate.ads = ads
    return delegate
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.systemGray
    navigationItem.title = "Native Collection"
    collectionView.dataSource = collectionViewDataSource
    collectionView.delegate = collectionViewDelegate
    collectionView.register(AdCell.self, forCellWithReuseIdentifier: "AdCell")
    configureUI()
  }

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

extension NativeCollectionController {
  func configureTabBarItem() {
    let tabBarItem = UITabBarItem(title: "Native", image: UIImage(systemName: "rectangle.grid.2x2"), tag: 1)
    self.tabBarItem = tabBarItem
  }
}

// MARK: - CollectionView DataSource

final class NativeCollectionControllerDataSource: NSObject, UICollectionViewDataSource {
  var ads: [Ad]?

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return ads?.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdCell", for: indexPath) as? AdCell else {
      fatalError("Error dequeing cell: \(AdCell.self) ")
    }
    let ad = ads?[indexPath.row]
    cell.label.text = ad?.content
    return cell
  }
}

// MARK: - CollectionView Delegate

final class NativeCollectionControllerDelegate: NSObject, UICollectionViewDelegate {
  var ads: [Ad]?

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let ad = ads?[indexPath.row]
    print("Selected: \(ad?.content ?? "No Ad")")
  }
}

// MARK: - CollectionView FlowLayoutDelegate

extension NativeCollectionControllerDelegate: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width: CGFloat = collectionView.bounds.width
    let height: CGFloat = 55
    return CGSize(width: width, height: height)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    let height: CGFloat = 5
    let width: CGFloat = 0
    return CGSize(width: width, height: height)
  }
}
