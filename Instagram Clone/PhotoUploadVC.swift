//
//  PhotoUploadVC.swift
//  Instagram Clone
//
//  Created by monus on 3/14/17.
//  Copyright © 2017 Muhammed Onus. All rights reserved.
//

import UIKit

class PhotoUploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBAction func submitClicked(_ sender: UIButton) {
        Post.postUserImage(image: postImage.image!, withCaption: captionTextField.text!) { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("uploaded successfully!")
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    @IBAction func clickedUploadButton(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
    }
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Do something with the images (based on your use case)
        postImage.image = originalImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
