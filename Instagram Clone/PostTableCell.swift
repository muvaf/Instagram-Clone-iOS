//
//  PostTableCell.swift
//  Instagram Clone
//
//  Created by monus on 3/14/17.
//  Copyright © 2017 Muhammed Onus. All rights reserved.
//

import UIKit
import ParseUI

class PostTableCell: UITableViewCell {

    @IBOutlet weak var postCaption: UILabel!
    @IBOutlet weak var postImage: PFImageView!
    
    func initWith(post: Post){
        postCaption.text = post.postCaption!
        postImage.file = post.postImage!
        postImage.loadInBackground()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
