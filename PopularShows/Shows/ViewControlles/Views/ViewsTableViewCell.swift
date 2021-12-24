//
//  ViewsTableViewCell.swift
//  PopularShows
//
//  Created by wafaa farrag on 24/12/2021.
//

import UIKit
import Cosmos

class ViewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var premiered: UILabel!
    @IBOutlet weak var runtime: UILabel!
    @IBOutlet weak var link: UITextView!
    @IBOutlet weak var rate: CosmosView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(show: Show) {
        
        if let image = show.image, let url = URL(string: image.medium) {
            showImageView.downloadedFrom(url: url)
        }
        
        name.text = show.name
        
        if let url = URL(string: show.links.linksSelf.href) {
            let attributedString = NSMutableAttributedString(string: "Show link", attributes:[NSAttributedString.Key.link: url])
            link.attributedText = attributedString
        }
        
        premiered.text = "Premiered: \(show.premiered)"
        if let runtimeInt = show.runtime {
            runtime.text = "Runtime: \(String(describing: runtimeInt))"
        }
    
        if let rating = show.rating.average {
            rate.rating = Double(rating)
        }
        
    }
    
}
