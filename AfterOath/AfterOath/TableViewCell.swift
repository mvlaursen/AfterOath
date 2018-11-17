//
//  TableViewCell.swift
//  AfterOath
//
//  Created by Mike Laursen on 11/13/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    private var _indexPath: IndexPath? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func assign(indexPath: IndexPath) {
        _indexPath = indexPath
        
        label.text = String("Row Number: \(indexPath.row)")
        
        if !updateThumbnail() {
            DataFetchSimulator.shared.loadThumbnail(indexPath: indexPath) {
                // If updateThumbnail() fails, don't retry. For one thing, it's
                // likely that the thumbnail we requested is still in the cache
                // but this cell was reassigned to a new IndexPath while it was
                // loading, in which case we now need to load thumbnail data
                // for the new IndexPath.
                _ = self.updateThumbnail()
            }
        }
    }
    
    func updateThumbnail() -> Bool {
        var succeeded: Bool = false
        
        if let indexPath = _indexPath {
            if let imageData = DataFetchSimulator.shared.thumbnail(indexPath: indexPath) {
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = UIImage(data: imageData)
                }
                succeeded = true
            }
        }
        
        return succeeded
    }
}
