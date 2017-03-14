//
//  Post.swift
//  Instagram Clone
//
//  Created by monus on 3/14/17.
//  Copyright © 2017 Muhammed Onus. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {
    var postImage: PFFile?
    var postCaption: String?
    
    init(post: PFObject){
        postCaption = post["caption"] as! String
        postImage = post["media"] as! PFFile
    }
    /**
     * Other methods
     */
    
    /**
     Method to add a user post to Parse (uploading image file)
     
     - parameter image: Image that the user wants upload to parse
     - parameter caption: Caption text input by the user
     - parameter completion: Block to be executed after save operation is complete
     */
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let post = PFObject(className: "Post")
        
        // Add relevant fields to the object
        post["media"] = getPFFileFromImage(image: image) // PFFile column type
        post["author"] = PFUser.current() // Pointer column type that points to PFUser
        post["caption"] = caption
        post["likesCount"] = 0
        post["commentsCount"] = 0
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground(block: completion)
    }
    
    /**
     Method to convert UIImage to PFFile
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImageJPEGRepresentation(image, 0.1) {
                return PFFile(name: "image.jpg", data: imageData)
            }
        }
        return nil
    }
}
