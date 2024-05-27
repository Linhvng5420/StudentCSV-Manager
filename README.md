# A. Cách Code Hoạt Động
Ứng dụng này là một ứng dụng quản lý danh sách học sinh, cho phép người dùng nhập, xuất và chỉnh sửa thông tin học sinh từ file CSV. Dưới đây là phân tích chi tiết về cách ứng dụng hoạt động:

### 1. **DSHocSinhController.swift**

#### **1.1. Khai báo và khởi tạo**
- **Import UIKit và UniformTypeIdentifiers:** Để sử dụng các thành phần giao diện người dùng và làm việc với các loại tệp tin.
- **Khai báo các thuộc tính:** Bao gồm trạng thái nút sắp xếp, nhãn trạng thái nhập file, mảng lưu trữ danh sách học sinh và tên file nhập.

#### **1.2. viewDidLoad**
- **Thiết lập tiêu đề và các nút trên thanh điều hướng:** Bao gồm các nút Import, Export, Edit và Sort.
- **Đăng ký UITableViewCell:** Để sử dụng lại các cell trong bảng.
- **Đọc dữ liệu từ cơ sở dữ liệu:** Gọi hàm `loadData()` để lấy dữ liệu học sinh từ cơ sở dữ liệu.
- **Khôi phục trạng thái của nhãn StatusImportLabel:** Sử dụng UserDefaults để lưu và khôi phục trạng thái của nhãn.

#### **1.3. Hàm loadData**
- **Khởi tạo đối tượng Database và đọc dữ liệu:** Cập nhật mảng `students` với dữ liệu đọc được và tải lại bảng.

#### **1.4. Hàm importCSV**
- **Mở trình chọn tài liệu để nhập file CSV:** Sử dụng `UIDocumentPickerViewController` để chọn file CSV.

#### **1.5. Hàm exportCSV**
- **Tạo chuỗi CSV từ danh sách học sinh:** Chuyển đổi chuỗi thành dữ liệu và lưu vào file tạm thời. Sau đó, sử dụng `UIActivityViewController` để chia sẻ file CSV.

#### **1.6. Hàm editTable**
- **Chuyển đổi trạng thái chỉnh sửa của bảng:** Cho phép chỉnh sửa danh sách học sinh khi có dữ liệu.

#### **1.7. Hàm sortStudents**
- **Chuyển đổi trạng thái nút sắp xếp và sắp xếp danh sách học sinh:** Đảo trạng thái sắp xếp và cập nhật tiêu đề nút sắp xếp. Sau đó, cập nhật cơ sở dữ liệu với thứ tự mới.

#### **1.8. Hàm updateDatabaseWithSortedStudents**
- **Cập nhật thứ tự của danh sách học sinh trong cơ sở dữ liệu:** Duyệt qua danh sách học sinh và cập nhật thông tin vào cơ sở dữ liệu.

#### **1.9. Hàm didSelectRowAt**
- **Chuyển màn hình điểm số:** Khi chọn một hàng trong bảng, ứng dụng sẽ chuyển đến màn hình chi tiết điểm số của học sinh.

#### **1.10. prepare(for segue:)**
- **Chuyển dữ liệu ban đầu đến DiemSoController:** Truyền dữ liệu học sinh đến màn hình chi tiết điểm số và cài đặt closure khi có sự thay đổi.

### 2. **DiemSoController.swift**

#### **2.1. Khai báo và khởi tạo**
- **Import UIKit:** Để sử dụng các thành phần giao diện người dùng.
- **Khai báo các thuộc tính:** Bao gồm mã học sinh, tên học sinh, điểm số, imagePicker và các closure để thông báo khi có sự thay đổi.

#### **2.2. viewDidLoad**
- **Thiết lập tiêu đề và hiển thị thông tin học sinh:** Hiển thị thông tin học sinh và cho phép tương tác với UIImageView để chọn ảnh.
- **Thêm nút Save vào navigation bar:** Cho phép lưu điểm số và tên học sinh.

#### **2.3. chooseImageTapped**
- **Chọn nguồn ảnh:** Cho phép người dùng chọn ảnh từ thư viện hoặc chụp ảnh bằng camera.

#### **2.4. saveDiemSo**
- **Lưu điểm số và tên học sinh:** Kiểm tra tính hợp lệ của dữ liệu và cập nhật cơ sở dữ liệu. Gọi closure để thông báo cho `DSHocSinhController` khi thay đổi thông tin.

### 3. **Database.swift**

#### **3.1. Khai báo và khởi tạo**
- **Import Foundation:** Để sử dụng các thành phần cơ bản của Swift.
- **Khai báo các thuộc tính:** Bao gồm tên cơ sở dữ liệu, đường dẫn, đối tượng FMDatabase và các thuộc tính của bảng điểm.

#### **3.2. init**
- **Khởi tạo cơ sở dữ liệu và tạo bảng điểm nếu chưa tồn tại:** Sử dụng FMDatabase để quản lý cơ sở dữ liệu SQLite.

#### **3.3. Các hàm mở và đóng cơ sở dữ liệu**
- **open và close:** Mở và đóng kết nối với cơ sở dữ liệu.

#### **3.4. Các hàm thao tác với cơ sở dữ liệu**
- **deleteAllDiem, deleteDiem, insertOrUpdateDiem, readAllDiem, updateDiem, updateTenHS, updateStudentWithMaHS:** Các hàm để thêm, xóa, cập nhật và đọc dữ liệu từ bảng điểm.

### **Tổng kết**
Ứng dụng này cung cấp một giao diện để quản lý danh sách học sinh, cho phép người dùng nhập và xuất dữ liệu từ file CSV, chỉnh sửa thông tin học sinh, và sắp xếp danh sách học sinh. Cơ sở dữ liệu SQLite được sử dụng để lưu trữ và quản lý dữ liệu học sinh.
 
# B. Chi Tiết Nhất
Chắc chắn rồi! Hãy đi sâu hơn vào từng phần của mã nguồn để hiểu rõ cách hoạt động của ứng dụng này.

### 1. **DSHocSinhController.swift**

#### **1.1. Khai báo và khởi tạo**

```swift
import UIKit
import UniformTypeIdentifiers
```
- **UIKit**: Thư viện cung cấp các thành phần giao diện người dùng.
- **UniformTypeIdentifiers**: Thư viện hỗ trợ làm việc với các loại tệp tin.

```swift
class DSHocSinhController: UITableViewController {
    // MARK: Properties
    var isSortedAscending = true
    @IBOutlet weak var StatusImportLable: UILabel!
    var students: [(String, String, Double?)] = []
    var fileImportName: String = ""
```
- **isSortedAscending**: Biến trạng thái để kiểm tra xem danh sách học sinh có đang được sắp xếp theo thứ tự tăng dần hay không.
- **StatusImportLable**: Nhãn để hiển thị trạng thái của việc nhập file CSV.
- **students**: Mảng lưu trữ danh sách học sinh với các thông tin: mã học sinh, tên học sinh và điểm số.
- **fileImportName**: Tên của file CSV được nhập vào.

#### **1.2. viewDidLoad**

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Học Sinh"
    self.navigationItem.rightBarButtonItems = [
        UIBarButtonItem(title: "Import", style: .plain, target: self, action: #selector(importCSV)),
        UIBarButtonItem(title: "Export", style: .plain, target: self, action: #selector(exportCSV))
    ]
    let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTable))
    let sortButtonTitle = isSortedAscending ? "Sort-ASC" : "Sort-DESC"
    let sortButton = UIBarButtonItem(title: sortButtonTitle, style: .plain, target: self, action: #selector(sortStudents))
    self.navigationItem.leftBarButtonItems = [editButton, sortButton]
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    loadData()
    if let savedText = UserDefaults.standard.string(forKey: "StatusImportLabelText") {
        StatusImportLable.text = savedText
    }
}
```
- **Thiết lập tiêu đề**: Đặt tiêu đề cho màn hình là "Học Sinh".
- **Thêm các nút Import, Export, Edit và Sort**: Các nút này được thêm vào thanh điều hướng để thực hiện các chức năng tương ứng.
- **Đăng ký UITableViewCell**: Đăng ký kiểu cell mà bảng sẽ sử dụng.
- **Đọc dữ liệu từ cơ sở dữ liệu**: Gọi hàm `loadData()` để lấy dữ liệu học sinh từ cơ sở dữ liệu.
- **Khôi phục trạng thái của nhãn StatusImportLabel**: Sử dụng UserDefaults để lưu và khôi phục trạng thái của nhãn.

#### **1.3. Hàm loadData**

```swift
func loadData() {
    let db = Database()
    self.students = db.readAllDiem()
    self.tableView.reloadData()
}
```
- **Khởi tạo đối tượng Database**: Tạo một đối tượng `Database` để làm việc với cơ sở dữ liệu.
- **Đọc dữ liệu từ cơ sở dữ liệu**: Gọi hàm `readAllDiem()` để lấy dữ liệu học sinh và cập nhật vào mảng `students`.
- **Tải lại bảng**: Gọi `tableView.reloadData()` để cập nhật giao diện bảng với dữ liệu mới.

#### **1.4. Hàm importCSV**

```swift
@objc func importCSV() {
    let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.commaSeparatedText])
    documentPicker.delegate = self
    present(documentPicker, animated: true, completion: nil)
}
```
- **Mở trình chọn tài liệu**: Sử dụng `UIDocumentPickerViewController` để mở trình chọn tài liệu và cho phép người dùng chọn file CSV.

#### **1.5. Hàm exportCSV**

```swift
@objc func exportCSV() {
    var csvString = "mahs,ten,diem\n"
    for student in students {
        let diemString = student.2.map { "\($0)" } ?? ""
        let csvRow = "\(student.0),\(student.1),\(diemString)\n"
        csvString.append(contentsOf: csvRow)
    }
    guard let data = csvString.data(using: String.Encoding.utf8) else { return }
    var className: String = ""
    let formatter = DateFormatter()
    formatter.dateFormat = "HH'H'mm-ddMMyyyy"
    let currentDate = Date()
    let dateString = formatter.string(from: currentDate)
    if let range = fileImportName.range(of: "Lop") {
        let start = range.lowerBound
        let end = fileImportName.index(start, offsetBy: 8, limitedBy: fileImportName.endIndex) ?? fileImportName.endIndex
        className = String(fileImportName[start..<end])
        print(className)
    } else {
        className = ""
        print("Chuỗi 'Lop' không được tìm thấy.")
    }
    let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("Diem [] \(className) \(dateString).csv")
    do {
        try data.write(to: tempURL, options: .atomicWrite)
        let activityViewController = UIActivityViewController(activityItems: [tempURL], applicationActivities: nil)
        present(activityViewController, animated: true)
    } catch {
        print("Không thể xuất file")
    }
}
```
- **Tạo chuỗi CSV từ danh sách học sinh**: Tạo chuỗi CSV từ mảng `students`.
- **Chuyển đổi chuỗi thành dữ liệu**: Chuyển đổi chuỗi CSV thành dữ liệu và lưu vào file tạm thời.
- **Lưu file tạm thời và chia sẻ**: Sử dụng `UIActivityViewController` để chia sẻ file CSV.

#### **1.6. Hàm editTable**

```swift
@objc func editTable() {
    guard !students.isEmpty else {
        print("Không có dữ liệu để chỉnh sửa.")
        return
    }
    let isEditing = self.tableView.isEditing
    self.tableView.setEditing(!isEditing, animated: true)
    self.navigationItem.leftBarButtonItem?.title = isEditing ? "Edit" : "Done"
}
```
- **Chuyển đổi trạng thái chỉnh sửa của bảng**: Cho phép chỉnh sửa danh sách học sinh khi có dữ liệu.

#### **1.7. Hàm sortStudents**

```swift
@objc func sortStudents() {
    guard !students.isEmpty else {
        print("Không có dữ liệu để sắp xếp.")
        return
    }
    isSortedAscending.toggle()
    students.sort { isSortedAscending ? $0.0 < $1.0 : $0.0 > $1.0 }
    tableView.reloadData()
    if let sortButton = self.navigationItem.leftBarButtonItems?.last {
        sortButton.title = isSortedAscending ? "Sort-ASC" : "Sort-DESC"
    }
    updateDatabaseWithSortedStudents()
}
```
- **Chuyển đổi trạng thái nút sắp xếp và sắp xếp danh sách học sinh**: Đảo trạng thái sắp xếp và cập nhật tiêu đề nút sắp xếp. Sau đó, cập nhật cơ sở dữ liệu với thứ tự mới.

#### **1.8. Hàm updateDatabaseWithSortedStudents**

```swift
func updateDatabaseWithSortedStudents() {
    let database = Database()
    for student in students {
        if !database.updateStudentWithMaHS(mahs: student.0, newMahs: student.0, tenhs: student.1, diem: student.2) {
            print("Đã xảy ra lỗi khi cập nhật thông tin học sinh có MaHS \(student.0)")
        }
    }
    print("Danh sách học sinh đã được cập nhật theo MaHS.")
}
```
- **Cập nhật thứ tự của danh sách học sinh trong cơ sở dữ liệu**: Duyệt qua danh sách học sinh và cập nhật thông tin vào cơ sở dữ liệu.

#### **1.9. Hàm didSelectRowAt**

```swift
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "showDiemSo", sender: indexPath)
}
```
- **Chuyển màn hình điểm số**: Khi chọn một hàng trong bảng, ứng dụng sẽ chuyển đến màn hình chi tiết điểm số của học sinh.

### **1.10. Hàm prepare(for segue:)**

Hàm `prepare(for segue:)` được sử dụng để chuẩn bị dữ liệu trước khi chuyển sang màn hình mới. Trong trường hợp này, khi người dùng chọn một hàng trong bảng, ứng dụng sẽ chuyển đến màn hình chi tiết điểm số của học sinh (`DiemSoController`).

#### **Mã nguồn**

```swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDiemSo", let indexPath = sender as? IndexPath {
        let destinationVC = segue.destination as! DiemSoController
        
        // Chuyển dữ liệu học sinh đến DiemSoController
        destinationVC.maHS = students[indexPath.row].0
        destinationVC.tenHS = students[indexPath.row].1
        destinationVC.diemHS = students[indexPath.row].2
        
        // Cài đặt closure khi có sự thay đổi điểm số
        destinationVC.onDiemSaved = { [weak self] maHS, diemHS in
            if let index = self?.students.firstIndex(where: { $0.0 == maHS }) {
                // Cập nhật điểm số trong mảng students
                self?.students[index].2 = diemHS
                // Cập nhật lại bảng
                self?.tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
        
        // Cài đặt closure khi có sự thay đổi tên học sinh
        destinationVC.onTenSaved = { [weak self] maHS, tenHS in
            if let index = self?.students.firstIndex(where: { $0.0 == maHS }) {
                // Cập nhật tên trong mảng students
                self?.students[index].1 = tenHS
                // Cập nhật lại bảng
                self?.tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
    }
}
```

#### **Giải thích chi tiết**

1. **Kiểm tra segue identifier và sender**:
    ```swift
    if segue.identifier == "showDiemSo", let indexPath = sender as? IndexPath {
    ```
    - Kiểm tra xem segue có identifier là "showDiemSo" không.
    - Kiểm tra xem `sender` có phải là `IndexPath` không. Nếu đúng, tiếp tục thực hiện các bước tiếp theo.

2. **Lấy đối tượng đích của segue**:
    ```swift
    let destinationVC = segue.destination as! DiemSoController
    ```
    - Lấy đối tượng đích của segue và ép kiểu sang `DiemSoController`.

3. **Chuyển dữ liệu học sinh đến `DiemSoController`**:
    ```swift
    destinationVC.maHS = students[indexPath.row].0
    destinationVC.tenHS = students[indexPath.row].1
    destinationVC.diemHS = students[indexPath.row].2
    ```
    - Gán mã học sinh, tên học sinh và điểm số từ mảng `students` cho các thuộc tính tương ứng trong `DiemSoController`.

4. **Cài đặt closure khi có sự thay đổi điểm số**:
    ```swift
    destinationVC.onDiemSaved = { [weak self] maHS, diemHS in
        if let index = self?.students.firstIndex(where: { $0.0 == maHS }) {
            self?.students[index].2 = diemHS
            self?.tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    ```
    - Cài đặt closure `onDiemSaved` để cập nhật điểm số trong mảng `students` khi có sự thay đổi điểm số trong `DiemSoController`.
    - Closure này nhận `maHS` và `diemHS` làm tham số.
    - Tìm vị trí của học sinh trong mảng `students` dựa trên `maHS`.
    - Cập nhật điểm số trong mảng `students` và tải lại hàng tương ứng trong bảng.

5. **Cài đặt closure khi có sự thay đổi tên học sinh**:
    ```swift
    destinationVC.onTenSaved = { [weak self] maHS, tenHS in
        if let index = self?.students.firstIndex(where: { $0.0 == maHS }) {
            self?.students[index].1 = tenHS
            self?.tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    ```
    - Cài đặt closure `onTenSaved` để cập nhật tên học sinh trong mảng `students` khi có sự thay đổi tên trong `DiemSoController`.
    - Closure này nhận `maHS` và `tenHS` làm tham số.
    - Tìm vị trí của học sinh trong mảng `students` dựa trên `maHS`.
    - Cập nhật tên trong mảng `students` và tải lại hàng tương ứng trong bảng.
<br>

### 2. **DiemSoController.swift**

#### **2.1. Khai báo và khởi tạo**

```swift
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
```
- **maHS, tenHS, diemHS**: Các thuộc tính lưu trữ thông tin của học sinh.
- **imagePicker**: Đối tượng cho phép người dùng chọn ảnh từ thư viện hoặc chụp ảnh bằng camera.
- **onDiemSaved, onTenSaved**: Closure để thông báo khi có sự thay đổi điểm số hoặc tên học sinh.
- **maHSLabel, nameHSTextField, diemHSTextField, studentImageView**: Các thành phần giao diện người dùng.

#### **2.2. viewDidLoad**

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    
    self.title = "Điểm Số"
    
    if let maHS = maHS, let tenHS = tenHS {
        maHSLabel.text = maHS
        nameHSTextField.text = tenHS
    }
    
    if let diemHS = diemHS, diemHS >= 0 && diemHS <= 10 {
        diemHSTextField.text = String(format: "%.1f", diemHS)
    } else {
        diemHSTextField.text = ""
    }
    
    studentImageView.isUserInteractionEnabled = true
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chooseImageTapped))
    studentImageView.addGestureRecognizer(tapGesture)
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveDiemSo))
}
```
- **Thiết lập tiêu đề và hiển thị thông tin học sinh**: Hiển thị thông tin học sinh và cho phép tương tác với UIImageView để chọn ảnh.
- **Thêm nút Save vào navigation bar**: Cho phép lưu điểm số và tên học sinh.

#### **2.3. chooseImageTapped**

```swift
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
```
- **Chọn nguồn ảnh**: Cho phép người dùng chọn ảnh từ thư viện hoặc chụp ảnh bằng camera.

#### **2.4. imagePickerController**

```swift
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
```
- **didFinishPickingMediaWithInfo**: Xử lý khi người dùng chọn xong ảnh.
- **imagePickerControllerDidCancel**: Xử lý khi người dùng hủy chọn ảnh.

#### **2.5. saveDiemSo**

```swift
@objc func saveDiemSo() {
    guard let maHS = self.maHS,
          let tenHS = nameHSTextField.text,
          !tenHS.isEmpty,
          let diemText = diemHSTextField.text,
          let diemSo = Double(diemText),
          diemSo >= 0 && diemSo <= 10 else {
        showAlert(message: "Lưu Thất Bại: Điểm và Tên học sinh phải hợp lệ.")
        return
    }
    
    let database = Database()
    
    if database.updateDiem(mahs: maHS, newDiem: diemSo),
       database.updateTenHS(mahs: maHS, newTen: tenHS) {
        
        onDiemSaved?(maHS, diemSo)
        onTenSaved?(maHS, tenHS)
        
        navigationController?.popViewController(animated: true)
    } else {
        showAlert(message: "Cập nhật thông tin thất bại.")
    }
}
```
- **Lưu điểm số và tên học sinh**: Kiểm tra tính hợp lệ của dữ liệu và cập nhật cơ sở dữ liệu. Gọi closure để thông báo cho `DSHocSinhController` khi thay đổi thông tin.

#### **2.6. showAlert**

```swift
func showAlert(message: String) {
    let alert = UIAlertController(title: "Thông Báo", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
}
```
- **Hiển thị thông báo lỗi**: Sử dụng UIAlertController để hiển thị thông báo lỗi khi có sự cố xảy ra.

### 3. **Database.swift**

#### **3.1. Khai báo và khởi tạo**

```swift
import Foundation

class Database {
    private let DB_NAME = "quldiem.sqlite"
    private let DB_PATH: String?
    private let database: FMDatabase?
    
    private let DIEM_TABLE_NAME = "diem"
    private let DIEM_MAHS = "mahs"
    private let DIEM_TENHS = "tenhs"
    private let DIEM_DIEM = "diem"
    
    init() {
        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        DB_PATH = directories[0] + "/" + DB_NAME
        database = FMDatabase(path: DB_PATH)
        
        if database != nil {
            print("Khởi tạo thành công cơ sở dữ liệu")
            let sql = """
            CREATE TABLE IF NOT EXISTS \(DIEM_TABLE_NAME) (
            \(DIEM_MAHS) TEXT PRIMARY KEY,
            \(DIEM_TENHS) TEXT,
            \(DIEM_DIEM) REAL
            )
            """
            if tableCreate(sql: sql, tableName: DIEM_TABLE_NAME) {
                print("Bảng \(DIEM_TABLE_NAME) đã sẵn sàng.")
            } else {
                print("Không thể tạo bảng \(DIEM_TABLE_NAME).")
            }
        } else {
            print("Khởi tạo cơ sở dữ liệu không thành công.")
        }
    }
```
- **DB_NAME, DB_PATH, database**: Các thuộc tính để quản lý cơ sở dữ liệu SQLite.
- **DIEM_TABLE_NAME, DIEM_MAHS, DIEM_TENHS, DIEM_DIEM**: Các thuộc tính của bảng điểm.
- **init**: Khởi tạo cơ sở dữ liệu và tạo bảng điểm nếu chưa tồn tại.

#### **3.2. tableCreate**

```swift
private func tableCreate(sql: String, tableName: String) -> Bool {
    var isSuccessful = false
    if open() {
        defer { close() }
        if !database!.tableExists(tableName) {
            isSuccessful = database!.executeStatements(sql)
        } else {
            isSuccessful = true
        }
    }
    return isSuccessful
}
```
- **Tạo bảng dữ liệu**: Tạo bảng điểm nếu chưa tồn tại.

#### **3.3. open và close**

```swift
private func open() -> Bool {
    if database != nil {
        if database!.open() {
            print("Mở cơ sở dữ liệu thành công.")
            return true
        } else {
            print("Không mở được cơ sở dữ liệu.")
        }
    } else {
        print("Cơ sở dữ liệu không tồn tại.")
    }
    return false
}

private func close() {
    database?.close()
}
```
- **Mở và đóng kết nối với cơ sở dữ liệu**: Mở và đóng kết nối với cơ sở dữ liệu.

Chắc chắn rồi, hãy tiếp tục với phần 3.4 và các hàm thao tác với cơ sở dữ liệu.

#### **3.4. Các hàm thao tác với cơ sở dữ liệu**

##### **3.4.1. Hàm deleteAllDiem**

```swift
func deleteAllDiem() -> Bool {
    if open() {
        defer { close() }
        let sql = "DELETE FROM \(DIEM_TABLE_NAME)"
        do {
            try database!.executeUpdate(sql, values: nil)
            print("Đã xoá tất cả bản ghi trong bảng \(DIEM_TABLE_NAME).")
            return true
        } catch {
            print("Lỗi khi xoá bản ghi: \(error.localizedDescription)")
            return false
        }
    }
    return false
}
```
- **Xoá tất cả bản ghi trong bảng điểm**: Xóa toàn bộ dữ liệu trong bảng điểm.

##### **3.4.2. Hàm deleteDiem**

```swift
func deleteDiem(mahs: String) -> Bool {
    if open() {
        defer { close() }
        let sql = "DELETE FROM \(DIEM_TABLE_NAME) WHERE \(DIEM_MAHS) = ?"
        do {
            try database!.executeUpdate(sql, values: [mahs])
            print("Đã xoá bản ghi có mã học sinh \(mahs) từ bảng \(DIEM_TABLE_NAME).")
            return true
        } catch {
            print("Lỗi khi xoá bản ghi: \(error.localizedDescription)")
            return false
        }
    }
    return false
}
```
- **Xoá bản ghi cụ thể trong bảng điểm**: Xóa bản ghi của học sinh có mã `mahs` trong bảng điểm.

##### **3.4.3. Hàm insertOrUpdateDiem**

```swift
func insertOrUpdateDiem(mahs: String, tenhs: String, diem: Double?) -> Bool {
    if open() {
        defer { close() }
        let sql = """
        INSERT OR REPLACE INTO \(DIEM_TABLE_NAME) (\(DIEM_MAHS), \(DIEM_TENHS), \(DIEM_DIEM))
        VALUES (?, ?, ?)
        """
        do {
            let diemValue: Any = diem as Any? ?? NSNull()
            try database!.executeUpdate(sql, values: [mahs, tenhs, diemValue])
            print("Dữ liệu của học sinh có mã \(mahs) đã được thêm hoặc cập nhật trong bảng \(DIEM_TABLE_NAME).")
            return true
        } catch {
            print("Lỗi khi thêm hoặc cập nhật dữ liệu của học sinh: \(error.localizedDescription)")
            return false
        }
    }
    return false
}
```
- **Thêm hoặc cập nhật dữ liệu học sinh**: Chèn hoặc cập nhật bản ghi của học sinh trong bảng điểm.

##### **3.4.4. Hàm readAllDiem**

```swift
func readAllDiem() -> [(mahs: String, tenhs: String, diem: Double)] {
    var diems: [(String, String, Double)] = []
    if open() {
        defer { close() }
        let sql = "SELECT * FROM \(DIEM_TABLE_NAME)"
        do {
            let results = try database!.executeQuery(sql, values: nil)
            while results.next() {
                let mahs = results.string(forColumn: DIEM_MAHS) ?? ""
                let tenhs = results.string(forColumn: DIEM_TENHS) ?? ""
                let diem = results.double(forColumn: DIEM_DIEM)
                diems.append((mahs, tenhs, diem))
            }
        } catch {
            print("Lỗi khi đọc bảng \(DIEM_TABLE_NAME): \(error.localizedDescription)")
        }
    }
    return diems
}
```
- **Đọc tất cả dữ liệu từ bảng điểm**: Lấy toàn bộ dữ liệu học sinh từ bảng điểm.

##### **3.4.5. Hàm updateDiem**

```swift
func updateDiem(mahs: String, newDiem: Double) -> Bool {
    if open() {
        defer { close() }
        let sql = "UPDATE \(DIEM_TABLE_NAME) SET \(DIEM_DIEM) = ? WHERE \(DIEM_MAHS) = ?"
        do {
            try database!.executeUpdate(sql, values: [newDiem, mahs])
            print("Điểm đã được cập nhật cho học sinh có mã \(mahs).")
            return true
        } catch {
            print("Lỗi khi cập nhật điểm: \(error.localizedDescription)")
        }
    }
    return false
}
```
- **Cập nhật điểm cho học sinh**: Cập nhật điểm số của học sinh có mã `mahs`.

##### **3.4.6. Hàm updateTenHS**

```swift
func updateTenHS(mahs: String, newTen: String) -> Bool {
    if open() {
        defer { close() }
        let sql = "UPDATE \(DIEM_TABLE_NAME) SET \(DIEM_TENHS) = ? WHERE \(DIEM_MAHS) = ?"
        do {
            try database!.executeUpdate(sql, values: [newTen, mahs])
            print("Tên học sinh có mã \(mahs) đã được cập nhật thành \(newTen).")
            return true
        } catch {
            print("Lỗi khi cập nhật tên học sinh: \(error.localizedDescription)")
            return false
        }
    }
    return false
}
```
- **Cập nhật tên cho học sinh**: Cập nhật tên của học sinh có mã `mahs`.

##### **3.4.7. Hàm updateStudentWithMaHS**

```swift
func updateStudentWithMaHS(mahs: String, newMahs: String, tenhs: String, diem: Double?) -> Bool {
    if open() {
        defer { close() }
        let sql = """
            UPDATE \(DIEM_TABLE_NAME) SET \(DIEM_MAHS) = ?, \(DIEM_TENHS) = ?, \(DIEM_DIEM) = ? WHERE \(DIEM_MAHS) = ?
            """
        do {
            let diemValue: Any = diem as Any? ?? NSNull()
            try database!.executeUpdate(sql, values: [newMahs, tenhs, diemValue, mahs])
            print("Thông tin học sinh có mã \(mahs) đã được cập nhật.")
            return true
        } catch {
            print("Lỗi khi cập nhật thông tin học sinh: \(error.localizedDescription)")
            return false
        }
    }
    return false
}
```
- **Cập nhật thông tin học sinh**: Cập nhật thông tin của học sinh có mã `mahs` với mã mới, tên mới và điểm số mới.

Chắc chắn rồi, hãy tiếp tục với phần 3.5 và các hàm còn lại trong `Database.swift`.

#### **3.5. Hàm sắp xếp**

##### **3.5.1. Hàm updateStudentWithMaHS**

```swift
func updateStudentWithMaHS(mahs: String, newMahs: String, tenhs: String, diem: Double?) -> Bool {
    if open() {
        defer { close() }
        let sql = """
            UPDATE \(DIEM_TABLE_NAME) SET \(DIEM_MAHS) = ?, \(DIEM_TENHS) = ?, \(DIEM_DIEM) = ? WHERE \(DIEM_MAHS) = ?
            """
        do {
            let diemValue: Any = diem as Any? ?? NSNull()
            try database!.executeUpdate(sql, values: [newMahs, tenhs, diemValue, mahs])
            print("Thông tin học sinh có mã \(mahs) đã được cập nhật.")
            return true
        } catch {
            print("Lỗi khi cập nhật thông tin học sinh: \(error.localizedDescription)")
            return false
        }
    }
    return false
}
```
- **Cập nhật thông tin học sinh**: Cập nhật thông tin của học sinh có mã `mahs` với mã mới, tên mới và điểm số mới.
<br>
 
### 4. **UIDocumentPickerDelegate Extension**

Để xử lý việc chọn tài liệu CSV, chúng ta cần mở rộng `DSHocSinhController` với `UIDocumentPickerDelegate`. Phần này sẽ bao gồm các hàm để xử lý khi người dùng chọn tệp CSV từ trình chọn tài liệu.

#### **4.1. Khai báo Extension**

```swift
extension DSHocSinhController: UIDocumentPickerDelegate {
    // MARK: Xử lý khi chọn tài liệu
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else { return }
        
        // Lấy tên file từ đường dẫn URL
        let fileName = url.lastPathComponent
        
        // Lấy tên file từ đường dẫn URL
        fileImportName = fileName.replacingOccurrences(of: ".csv", with: "")
        
        do {
            let content = try String(contentsOf: url)
            parseCSV(content)
            
            // Cập nhật StatusImportLabel với tên file vừa nhập
            StatusImportLable.text = "\"\(fileImportName)\""
            
            // Lưu trạng thái này vào UserDefaults
            UserDefaults.standard.set(StatusImportLable.text, forKey: "StatusImportLabelText")
            
        } catch {
            print("Lỗi đọc file")
        }
    }
    
    // MARK: Đọc nội dung file CSV và ghi vào cơ sở dữ liệu
    func parseCSV(_ content: String) {
        let rows = content.split(separator: "\n")
        let database = Database() // Tạo đối tượng database
        
        guard !rows.dropFirst().isEmpty else {
            StatusImportLable.textColor = UIColor.red
            fileImportName = "File Import Rỗng"
            // Xoá dữ liệu hiện tại
            clearCurrentData()
            return
        }
        
        // Bỏ qua dòng đầu tiên là dòng tiêu đề
        let studentsData = rows.dropFirst().compactMap { row -> (String, String, Double?)? in
            let columns = row.split(separator: ",")
            
            // Kiểm tra nếu không đủ cột
            guard columns.count >= 2 else {
                StatusImportLable.textColor = UIColor.red
                fileImportName = "File Import Bị Lỗi"
                return nil
            }
            
            let mahs = String(columns[0])
            let tenhs = String(columns[1])
            // Kiểm tra xem có cột điểm không và cột điểm có phải là số thực hay không
            let diem: Double? = (columns.count > 2) ? Double(columns[2]) : nil
            
            StatusImportLable.textColor = UIColor.white
            
            return (mahs, tenhs, diem)
        }
        
        // Xoá dữ liệu cũ nếu có
        if database.deleteAllDiem() {
            for student in studentsData {
                // Kiểm tra điểm trước khi ghi vào CSDL
                if let diem = student.2 {
                    // Ghi dữ liệu vào CSDL
                    _ = database.insertOrUpdateDiem(mahs: student.0, tenhs: student.1, diem: diem)
                }
                // Xử lý trường hợp không có điểm
                _ = database.insertOrUpdateDiem(mahs: student.0, tenhs: student.1, diem: Double(EMPTY))
            }
            
            self.students = studentsData
            tableView.reloadData()
        } else {
            print("Không thể xoá dữ liệu cũ trong bảng")
        }
        
        // Cập nhật dữ liệu và UI
        self.students = studentsData
        tableView.reloadData()
    }
    
    func clearCurrentData() {
        let database = Database() // Tạo đối tượng database
        if database.deleteAllDiem() {
            print("Dữ liệu cũ đã được xoá.")
        } else {
            print("Không thể xoá dữ liệu cũ trong bảng")
        }
        
        // Xoá dữ liệu trong mảng 'students' và cập nhật UI
        students.removeAll()
        tableView.reloadData()
    }
}
```

#### **Giải thích chi tiết**

1. **documentPicker(_:didPickDocumentsAt:)**

    ```swift
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else { return }
        
        let fileName = url.lastPathComponent
        fileImportName = fileName.replacingOccurrences(of: ".csv", with: "")
        
        do {
            let content = try String(contentsOf: url)
            parseCSV(content)
            
            StatusImportLable.text = "\"\(fileImportName)\""
            UserDefaults.standard.set(StatusImportLable.text, forKey: "StatusImportLabelText")
        } catch {
            print("Lỗi đọc file")
        }
    }
    ```
    - **Lấy URL của tệp CSV**: Lấy URL của tệp CSV được chọn.
    - **Lấy tên tệp**: Lấy tên tệp từ URL và cập nhật thuộc tính `fileImportName`.
    - **Đọc nội dung tệp**: Đọc nội dung tệp CSV và gọi hàm `parseCSV` để xử lý nội dung.
    - **Cập nhật giao diện**: Cập nhật nhãn trạng thái nhập file và lưu trạng thái vào UserDefaults.

2. **parseCSV(_:)**

    ```swift
    func parseCSV(_ content: String) {
        let rows = content.split(separator: "\n")
        let database = Database()
        
        guard !rows.dropFirst().isEmpty else {
            StatusImportLable.textColor = UIColor.red
            fileImportName = "File Import Rỗng"
            clearCurrentData()
            return
        }
        
        let studentsData = rows.dropFirst().compactMap { row -> (String, String, Double?)? in
            let columns = row.split(separator: ",")
            
            guard columns.count >= 2 else {
                StatusImportLable.textColor = UIColor.red
                fileImportName = "File Import Bị Lỗi"
                return nil
            }
            
            let mahs = String(columns[0])
            let tenhs = String(columns[1])
            let diem: Double? = (columns.count > 2) ? Double(columns[2]) : nil
            
            StatusImportLable.textColor = UIColor.white
            
            return (mahs, tenhs, diem)
        }
        
        if database.deleteAllDiem() {
            for student in studentsData {
                if let diem = student.2 {
                    _ = database.insertOrUpdateDiem(mahs: student.0, tenhs: student.1, diem: diem)
                }
                _ = database.insertOrUpdateDiem(mahs: student.0, tenhs: student.1, diem: Double(EMPTY))
            }
            
            self.students = studentsData
            tableView.reloadData()
        } else {
            print("Không thể xoá dữ liệu cũ trong bảng")
        }
        
        self.students = studentsData
        tableView.reloadData()
    }
    ```
    - **Phân tích nội dung CSV**: Phân tích nội dung CSV và chuyển đổi thành mảng `studentsData`.
    - **Xóa dữ liệu cũ**: Xóa dữ liệu cũ trong cơ sở dữ liệu nếu có.
    - **Cập nhật cơ sở dữ liệu và giao diện**: Thêm dữ liệu mới vào cơ sở dữ liệu và cập nhật giao diện bảng.

3. **clearCurrentData()**

    ```swift
    func clearCurrentData() {
        let database = Database()
        if database.deleteAllDiem() {
            print("Dữ liệu cũ đã được xoá.")
        } else {
            print("Không thể xoá dữ liệu cũ trong bảng")
        }
        
        students.removeAll()
        tableView.reloadData()
    }
    ```
    - **Xóa dữ liệu hiện tại**: Xóa toàn bộ dữ liệu hiện tại trong cơ sở dữ liệu và mảng `students`, sau đó cập nhật giao diện bảng.

### **Tổng kết**

Phần mở rộng `UIDocumentPickerDelegate` trong `DSHocSinhController` xử lý việc chọn tài liệu CSV, phân tích nội dung CSV và cập nhật cơ sở dữ liệu cũng như giao diện người dùng. Khi người dùng chọn một tệp CSV, nội dung của tệp sẽ được đọc và phân tích. Dữ liệu cũ trong cơ sở dữ liệu sẽ bị xóa và dữ liệu mới sẽ được thêm vào. Giao diện người dùng sẽ được cập nhật để phản ánh các thay đổi này.
 
# C. Tổng Kết
Có vẻ như chúng ta đã bao quát hầu hết các phần quan trọng của ứng dụng, nhưng để đảm bảo không bỏ sót phần nào, hãy kiểm tra lại từng phần một cách chi tiết:

1. **DSHocSinhController.swift**:
   - Đã hoàn thành: Khai báo, khởi tạo, viewDidLoad, loadData, importCSV, exportCSV, editTable, sortStudents, updateDatabaseWithSortedStudents, didSelectRowAt, prepare(for segue:), và extension cho UIDocumentPickerDelegate.

2. **DiemSoController.swift**:
   - Đã hoàn thành: Khai báo, khởi tạo, viewDidLoad, chooseImageTapped, imagePickerController, saveDiemSo, và showAlert.

3. **Database.swift**:
   - Đã hoàn thành: Khai báo, khởi tạo, tableCreate, open, close, deleteAllDiem, deleteDiem, insertOrUpdateDiem, readAllDiem, updateDiem, updateTenHS, updateStudentWithMaHS.

### Kiểm tra lại các phần quan trọng:

#### **1. DSHocSinhController.swift**

- **Mở rộng với UIDocumentPickerDelegate**: Đã hoàn thành.

#### **2. DiemSoController.swift**

- **Các hàm cần thiết**: Đã hoàn thành.

#### **3. Database.swift**

- **Các hàm CRUD (Create, Read, Update, Delete)**: Đã hoàn thành.

### Phần kiểm tra bổ sung:

#### **1. Kiểm tra các hàm UITableViewDataSource và UITableViewDelegate**

Trong `DSHocSinhController.swift`, cần đảm bảo rằng các hàm UITableViewDataSource và UITableViewDelegate đã được triển khai đầy đủ.

```swift
override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
}

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return students.count
}

// Cấu hình cell cho bảng
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
    let student = students[indexPath.row]
    cell.textLabel?.text = student.1 // Tên học sinh
    cell.detailTextLabel?.text = student.0 // Mã học sinh
    return cell
}

// Xử lý việc xóa hàng
override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
        let mahs = students[indexPath.row].0
        let database = Database()
        if database.deleteDiem(mahs: mahs) {
            students.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else {
            print("Xóa thất bại từ cơ sở dữ liệu.")
        }
    }
}
```

#### **2. Kiểm tra các hàm di chuyển hàng (nếu cần)**

Nếu cần cho phép di chuyển hàng trong bảng, hãy đảm bảo rằng các hàm liên quan đã được triển khai:

```swift
// Cho phép di chuyển hàng cho tất cả các hàng trong bảng
override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
}

// Xử lý việc thay đổi vị trí của hàng
override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let movedObject = self.students[sourceIndexPath.row]
    students.remove(at: sourceIndexPath.row)
    students.insert(movedObject, at: destinationIndexPath.row)
}
```

### Tổng kết

Sau khi kiểm tra lại, có vẻ như chúng ta đã bao quát tất cả các phần quan trọng của ứng dụng. Dưới đây là các thành phần chính của ứng dụng:

1. **DSHocSinhController.swift**:
   - Khai báo và khởi tạo
   - viewDidLoad
   - loadData
   - importCSV
   - exportCSV
   - editTable
   - sortStudents
   - updateDatabaseWithSortedStudents
   - didSelectRowAt
   - prepare(for segue:)
   - Extension cho UIDocumentPickerDelegate
   - UITableViewDataSource và UITableViewDelegate

2. **DiemSoController.swift**:
   - Khai báo và khởi tạo
   - viewDidLoad
   - chooseImageTapped
   - imagePickerController
   - saveDiemSo
   - showAlert

3. **Database.swift**:
   - Khai báo và khởi tạo
   - tableCreate
   - open
   - close
   - deleteAllDiem
   - deleteDiem
   - insertOrUpdateDiem
   - readAllDiem
   - updateDiem
   - updateTenHS
   - updateStudentWithMaHS
