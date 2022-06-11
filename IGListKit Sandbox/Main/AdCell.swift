//
//  AdCell.swift
//  IGListKit Sandbox
//
//  Created by Leonardo  on 11/06/22.
//

import UIKit

// MARK: - Ad Cell

final class AdCell: UICollectionViewCell {
  var label: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Rappi Ad"
    label.textColor = UIColor.systemPink
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - AwakeFromNib()

  /// # ONLY WORKS WITH IBOUTLETS (Storyboard or Xibs)
  /// As there are no SB or Xibs, this delegate is NEVER called
  override func awakeFromNib() {
    super.awakeFromNib()
    print("Awoke from nib - should never be called")
  }

  // MARK: - UI

  func configureUI() {
    contentView.backgroundColor = UIColor.systemYellow
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
