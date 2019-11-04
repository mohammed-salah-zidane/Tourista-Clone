//
//  ItemTableViewCell.swift
//  Tourista
//
//  Created by prog_zidane on 11/3/19.
//  Copyright © 2019 prog_zidane. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sectionIcons: UIImageView!
    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    var items:[ItemModel]?{
        didSet{
            itemsCollectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initCollectuonView()
    }
    func initCollectuonView(){
        itemsCollectionView.registerCellNib(cellClass: ItemCollectionViewCell.self)
        itemsCollectionView.delegate = self
        itemsCollectionView.dataSource = self
    }
    
}


extension ItemTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return items?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeue(indexPath: indexPath) as ItemCollectionViewCell
        cell.item = items![indexPath.row]
        return cell
    }
}

extension ItemTableViewCell:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (itemsCollectionView.frame.width  / 1.8) - 10 , height: itemsCollectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 17)
    }
}


