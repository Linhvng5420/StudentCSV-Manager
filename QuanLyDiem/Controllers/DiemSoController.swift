import UIKit

class DiemSoController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    var maHS: String?
    var tenHS: String?
    var diemHS: Double?
    var imagePicker: UIImagePickerController!  // Đối tượng để chọn hình ảnh

    // Closure để thông báo khi điểm hoặc tên được lưu
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
        
        self.title = "Điểm Số"  // Đặt tiêu đề cho view controller
        
        // Hiển thị thông tin học sinh nếu có
        if let maHS = maHS, let tenHS = tenHS {
            maHSLabel.text = maHS 
            nameHSTextField.text = tenHS
        }
        
        // Hiển thị điểm học sinh nếu có và hợp lệ
        if let diemHS = diemHS, diemHS >= 0 && diemHS <= 10 {
            diemHSTextField.text = String(format: "%.1f", diemHS)
        } else {
            diemHSTextField.text = ""
        }
        
        // Cho phép tương tác với UIImageView
        studentImageView.isUserInteractionEnabled = true  // Cho phép người dùng tương tác với UIImageView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chooseImageTapped))  // Tạo gesture recognizer cho tap gesture
        studentImageView.addGestureRecognizer(tapGesture)
        
        // Thêm nút Save vào navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveDiemSo))
    }
    
    // MARK: Avatar
    @objc func chooseImageTapped() {
        // Hiển thị action sheet để chọn nguồn ảnh
        let actionSheet = UIAlertController(title: "Chọn Ảnh", message: "Chọn nguồn ảnh", preferredStyle: .actionSheet)
        
        // Tùy chọn chọn ảnh từ thư viện
        actionSheet.addAction(UIAlertAction(title: "Thư Viện Ảnh", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {  // Kiểm tra xem thư viện ảnh có sẵn không
                self.imagePicker.sourceType = .photoLibrary  // Đặt source type là thư viện ảnh
                self.present(self.imagePicker, animated: true, completion: nil)  // Hiển thị image picker
            }
        }))
        
        // Tùy chọn chụp ảnh từ camera
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {  // Kiểm tra xem camera có sẵn không
                self.imagePicker.sourceType = .camera  // Đặt source type là camera
                self.present(self.imagePicker, animated: true, completion: nil)  // Hiển thị image picker
            }
        }))
        
        // Thêm nút hủy vào action sheet
        actionSheet.addAction(UIAlertAction(title: "Hủy", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    // Hàm UIImagePickerControllerDelegate khi người dùng chọn ảnh
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {  // Lấy ảnh người dùng đã chọn
            studentImageView.contentMode = .scaleAspectFit  // Đặt chế độ hiển thị ảnh là scale aspect fit
            studentImageView.image = pickedImage  // Hiển thị ảnh đã chọn trong UIImageView
        }
        dismiss(animated: true, completion: nil)  // Đóng image picker
    }
    
    // Hàm UIImagePickerControllerDelegate khi người dùng hủy chọn ảnh
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)  // Đóng image picker
    }

    // MARK: Lưu Điẻm Số
    @objc func saveDiemSo() {
        // Kiểm tra tính hợp lệ của dữ liệu nhập vào
        guard let maHS = self.maHS,
              let tenHS = nameHSTextField.text,  // Lấy tên học sinh từ text field
              !tenHS.isEmpty,  // Kiểm tra tên không được để trống
              let diemText = diemHSTextField.text,
              let diemSo = Double(diemText),  // Chuyển điểm từ text sang double
              diemSo >= 0 && diemSo <= 10 else {  // Kiểm tra điểm hợp lệ
            showAlert(message: "Lưu Thất Bại: Điểm và Tên học sinh phải hợp lệ.")  // Hiển thị thông báo lỗi nếu dữ liệu không hợp lệ
            return
        }
        
        // Tạo đối tượng lớp Database để cập nhật dữ liệu
        let database = Database()
        
        // Cập nhật điểm và tên học sinh trong cơ sở dữ liệu
        if database.updateDiem(mahs: maHS, newDiem: diemSo),
           database.updateTenHS(mahs: maHS, newTen: tenHS) {
            
            // Gọi closure để thông báo cho DSHocSinhController khi thay đổi thông tin
            onDiemSaved?(maHS, diemSo)  // Gọi closure onDiemSaved
            onTenSaved?(maHS, tenHS)  // Gọi closure onTenSaved
            
            // Quay lại màn hình trước đó
            navigationController?.popViewController(animated: true)  // Quay lại màn hình trước đó
        } else {
            // Hiển thị thông báo lỗi nếu cập nhật không thành công
            showAlert(message: "Cập nhật thông tin thất bại.")  // Hiển thị thông báo lỗi
        }
    }
    
    // MARK: - Hiển thị thông báo
    func showAlert(message: String) {
        // Tạo và hiển thị thông báo
        let alert = UIAlertController(title: "Thông Báo", message: message, preferredStyle: .alert)  // Tạo đối tượng UIAlertController
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))  // Thêm hành động OK vào thông báo
        self.present(alert, animated: true, completion: nil)  // Hiển thị thông báo
    }
}
