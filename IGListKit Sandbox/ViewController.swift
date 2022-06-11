//
//  ViewController.swift
//  IGListKit Sandbox
//
//  Created by Leonardo  on 9/06/22.
//

import IGListKit
import UIKit

final class ViewController: UIViewController {
  /// # IGListKit Properties
  private var adapter: ListAdapter?

  /// # UI Properties
  private let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return collection
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.systemPink
    configureUI()
    configureCollection()
  }
}

// MARK: - IGListKit Collection

extension ViewController {
  func configureCollection() {
    let updater = ListAdapterUpdater()
    adapter = ListAdapter(updater: updater, viewController: self, workingRangeSize: 1)
    adapter?.collectionView = collectionView
    adapter?.dataSource = self
  }
}

// MARK: - UI

extension ViewController {
  func configureUI() {
    collectionView.backgroundColor = UIColor.systemIndigo
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(collectionView)
    NSLayoutConstraint.activate([
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
      collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
    ])
  }
}

extension ViewController: ListAdapterDataSource {
  /// # Must be `IGListDiffable` compliant
  /// Never mutate the ListDIffable objects, always create a brand new one when updating the DataSource, otherwise the updates will be lost as instances have already been changed
  func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
    let ads: [NSString] = ["Ad 1", "Ad 2", "Ad 3"]
    return ads
  }

  func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
    return AdsSection()
  }

  func emptyView(for listAdapter: ListAdapter) -> UIView? {
    return nil
  }
}

final class AdsSection: ListSectionController {
  override func sizeForItem(at index: Int) -> CGSize {
    return CGSize(width: collectionContext!.containerSize.width, height: 55)
  }

  override func cellForItem(at index: Int) -> UICollectionViewCell {
    return collectionContext!.dequeueReusableCell(of: AdsCell.self, for: self, at: index)
  }

  override func numberOfItems() -> Int {
    return 3
  }
}

final class CustomLayout: ListCollectionViewLayout {
  override var scrollDirection: UICollectionView.ScrollDirection {
    return .vertical
  }
}

final class AdsCell: UICollectionViewCell {
  var label: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Rappi Ad"
    label.textColor = UIColor.systemPink
    return label
  }()

  override func awakeFromNib() {
    super.awakeFromNib()
    configureUI()
  }

  func configureUI() {
    contentView.backgroundColor = UIColor.white
    label.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(label)
    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      label.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5)
    ])
  }
}
