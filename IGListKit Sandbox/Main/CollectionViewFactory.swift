//
//  CollectionViewFactorty.swift
//  IGListKit Sandbox
//
//  Created by Leonardo  on 11/06/22.
//

import Foundation
import UIKit.UIViewController

enum CollectionType {
  case native
  case iglistkit
}

protocol CollectionView: UIViewController {
  func configureUI()
}

final class CollectionViewFactory {
  func getCollection(_ collection: CollectionType) -> CollectionView {
    switch collection {
      case .native:
        return NativeCollectionController()
      case .iglistkit:
        return IGListKitCollectionController()
    }
  }
}
