//
//  FactsListTableViewCell.swift
//  FactsSampleDemo
//
//  Created by devika.ramadasi on 04/09/19.
//  Copyright © 2019 devika.ramadasi. All rights reserved.
//

import UIKit
import SDWebImage
class FactsListTableViewCell: UITableViewCell {
    var thumbImageView : UIImageView?
    var titleLabel1 : UILabel?
    var descriptionLabel : UILabel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    /// Creates and adds content views to display Image , Title & Description
   private func addSubviews()  {
        if thumbImageView == nil {
            thumbImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
            self.contentView.addSubview(thumbImageView!)
            thumbImageView?.image = #imageLiteral(resourceName: "project-placeholder.png")



        }
        if titleLabel1 == nil {
            titleLabel1 = UILabel(frame: CGRect(x: 0, y: 5, width: 100, height: 20))
            titleLabel1?.numberOfLines = 0
            self.contentView.addSubview(titleLabel1!)
            
        }
        if descriptionLabel == nil {
            descriptionLabel = UILabel(frame: CGRect(x: 50, y: 35, width: 35, height: 20))
            descriptionLabel?.numberOfLines = 0
            self.contentView.addSubview(descriptionLabel!)

        }
        
        let viewsDict = [
            "image" : thumbImageView,
            "title" : titleLabel1,
            "message" : descriptionLabel
            ]
        thumbImageView?.contentMode = .scaleAspectFit
        thumbImageView?.translatesAutoresizingMaskIntoConstraints = false
        titleLabel1?.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel?.translatesAutoresizingMaskIntoConstraints = false

        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "[image(<=50)]", options: [], metrics: nil, views: viewsDict as [String : Any]))

        //contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[image]", options: [], metrics: nil, views: viewsDict as [String : Any]))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[image]-|", options: [], metrics: nil, views: viewsDict as [String : Any]))

        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[title]-[message]-|", options: [], metrics: nil, views: viewsDict as [String : Any]))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image]-[title]-|", options: [], metrics: nil, views: viewsDict as [String : Any]))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image]-[message]-|", options: [], metrics: nil, views: viewsDict as [String : Any]))


    }
    /// Updates the Cell UI with Provided Data
    /// - Parameter fact: instance of Facts , which contents will be displayed
    func updateWithFact(_ fact : Facts)  {
        addSubviews()
        titleLabel1?.text = fact.title
        descriptionLabel?.text = fact.descreption
        if let path = fact.imageHref ,let imageURL = URL(string: path)
        {
            SDWebImageDownloader.shared.downloadImage(with: imageURL) { (image:UIImage?, data:Data?, error: Error?, completed:Bool) in
                if image != nil
                {
                    self.thumbImageView?.image = image
                    
                }
            }
            /*sdImageManager.loadImage(with: imageURL, options: SDWebImageOptions.continueInBackground, progress: { (info :Int, progress:Int,url: URL?) in
                
            }) { (image:UIImage?, date:Data?, error:Error?, type:SDImageCacheType, val:Bool, url:URL?) in
                if image != nil
                {
                    self.thumbImageView?.image = image
                    
                }
            }*/
            /*imageView?.sd_setImage(with: imageURL, completed: { (image:UIImage?, error:Error?, type:SDImageCacheType, url:URL?) in
                if image != nil
                {
                    self.thumbImageView?.image = image

                }
            })*/

        }

    }
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbImageView?.image = #imageLiteral(resourceName: "project-placeholder.png")
    }

}
