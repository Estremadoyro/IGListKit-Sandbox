//
//  Ad.swift
//  IGListKit Sandbox
//
//  Created by Leonardo  on 11/06/22.
//

import Foundation
import IGListDiffKit

// MARK: - Ad Model (ListDiffable)

final class Ad: NSObject {
  let content: String

  init(content: String) {
    self.content = content
  }
}

extension Ad: ListDiffable {
  func diffIdentifier() -> NSObjectProtocol {
    return self
  }

  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    if let object = object as? Ad {
      return content == object.content
    }
    return false
  }
}
