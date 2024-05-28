//
//  DiemSoController.swift
//  QuanLyDiem
//
//  Created by macos on 24/05/2024.
//

import UIKit

class DiemSoController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var maHS: String?
    var tenHS: String?
    var imagePicker: UIImagePickerController!
    
    @IBOutlet weak var maHSLabel: UILabel!
    @IBOutlet weak var tenHSLabel: UILabel!
    @IBOutlet weak var studentImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        self.title = "Điểm Số"
        
        // Hiển thị thông tin học sinh
        if let maHS = maHS, let tenHS = tenHS {
            maHSLabel.text = maHS
            tenHSLabel.text = tenHS
        }
        
        // Cho phép tương tác với UIImageView
        studentImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chooseImageTapped))
        studentImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func chooseImageTapped() {
        let actionSheet = UIAlertController(title: "Chọn Ảnh", message: "Chọn nguồn ảnh", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Thư Viện Ảnh", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.imagePicker.sourceType = .photoLibrary
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Hủy", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    // UIImagePickerControllerDelegate method
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            studentImageView.contentMode = .scaleAspectFit
            studentImageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }



/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */

}
