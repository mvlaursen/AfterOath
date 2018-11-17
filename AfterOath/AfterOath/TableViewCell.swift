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
        
        if !updateThumbnail() {
            DataFetchSimulator.shared.loadThumbnail(indexPath: indexPath) {
                // If updateThumbnail() fails, we don't retry. It's
                // possible by the time the thumbnail is loaded, this cell
                // has been reassigned to a different IndexPath. Instead,
                // rely on the table view data preloading to trigger retry.
                self.updateThumbnail()
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
