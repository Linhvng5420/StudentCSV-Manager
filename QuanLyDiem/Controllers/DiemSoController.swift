import UIKit

class DiemSoController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    var maHS: String?
    var tenHS: String?
    var diemHS: Double?
    var imagePicker: UIImagePickerController!
    
    var onDiemSaved: ((_ maHS: String, _ diemHS: Double) -> Void)?
    var onTenSaved: ((_ maHS: String, _ tenHS: String) -> Void)?
    
    @IBOutlet weak var maHSLabel: UILabel!
    @IBOutlet weak var nameHSTextField: UITextField!
    @IBOutlet weak var diemHSTextField: UITextField!
    @IBOutlet weak var studentImageView: UIImageView!
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        self.title = "Điểm Số"
        
        // Hiển thị thông tin học sinh
        if let maHS = maHS, let tenHS = tenHS{
            maHSLabel.text = maHS
            nameHSTextField.text = tenHS
        }
        
        if let diemHS = diemHS, diemHS >= 0 && diemHS <= 10 {
            diemHSTextField.text = String(format: "%.1f", diemHS)
        } else {
            diemHSTextField.text = ""
        }
        
        // Cho phép tương tác với UIImageView
        studentImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chooseImageTapped))
        studentImageView.addGestureRecognizer(tapGesture)
        
        // Thêm nút Save vào navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveDiemSo))
    }
    
    // MARK: Avatar
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
    
    // Hàm UIImagePickerControllerDelegate
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

    // MARK: Lưu Điẻm Số
    @objc func saveDiemSo() {
        guard let maHS = self.maHS,
              let tenHS = nameHSTextField.text, // Lấy tên học sinh từ text field
              !tenHS.isEmpty, // Kiểm tra tên không được để trống
              let diemText = diemHSTextField.text,
              let diemSo = Double(diemText),
              diemSo >= 0 && diemSo <= 10 else {
            showAlert(message: "Lưu Thất Bại: Điểm và Tên học sinh phải hợp lệ.")
            return
        }
        
        // Tạo đối tượng lớp Database để cập nhật dữ liệu
        let database = Database()
        
        if database.updateDiem(mahs: maHS, newDiem: diemSo),
           database.updateTenHS(mahs: maHS, newTen: tenHS) {
            
            // Gọi closure để thông báo cho DSHocSinhController khi thay đổi thông tin
            onDiemSaved?(maHS, diemSo)
            onTenSaved?(maHS, tenHS)
            
            // Quay lại màn hình trước đó
            navigationController?.popViewController(animated: true)
        } else {
            // Hiển thị thông báo lỗi nếu cập nhật không thành công
            showAlert(message: "Cập nhật thông tin thất bại.")
        }
    }
    
    // MARK: - Hiển thị thông báo
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Thông Báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
