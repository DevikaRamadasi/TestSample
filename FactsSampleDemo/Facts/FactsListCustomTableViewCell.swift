//
//  FactsListCustomTableViewCell.swift
//  FactsSampleDemo
//
//  Created by devika.ramadasi on 04/09/19.
//  Copyright © 2019 devika.ramadasi. All rights reserved.
//

import UIKit
import SDWebImage
class FactsListCustomTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbImageView: UIImageView!
    
    @IBOutlet weak var descriptionLable: UILabel!
    @IBOutlet weak var titleLabel1: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func updateWithFact(_ fact:Facts)  {
        titleLabel1?.text = fact.title
        descriptionLable?.text = fact.descreption
        if let path = fact.imageHref ,let imageURL = URL(string: path)
        {
            SDWebImageDownloader.shared.downloadImage(with: imageURL) { (image:UIImage?, data:Data?, error: Error?, completed:Bool) in
                if image != nil
                {
                    self.thumbImageView?.image = image
                    
                }
            }
           
            
        }

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbImageView?.image = #imageLiteral(resourceName: "project-placeholder.png")
    }

}
