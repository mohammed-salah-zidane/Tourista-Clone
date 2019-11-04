//
//  ItemCollectionViewCell.swift
//  Tourista
//
//  Created by prog_zidane on 11/3/19.
//  Copyright © 2019 prog_zidane. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabal: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    var item:ItemModel?{
        didSet{
            itemImageView.nuke(url: item?.photos?.first ?? "")
            titleLabal.text = item?.name
            categoryLabel.text = item?.shortDescription
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
