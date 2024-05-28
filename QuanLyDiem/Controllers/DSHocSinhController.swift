import UIKit
import UniformTypeIdentifiers

class DSHocSinhController: UITableViewController {

    // Mảng lưu trữ danh sách học sinh
    var students: [(String, String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Danh Sách Học Sinh"
        self.navigationItem.rightBarButtonItems = [
            // Nút Import để nhập file CSV
            UIBarButtonItem(title: "Import", style: .plain, target: self, action: #selector(importCSV))
        ]
        
        self.navigationItem.leftBarButtonItems = [
            // Nút Edit để chỉnh sửa bảng
            UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTable))
        ]
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    // Hàm chuyển đổi trạng thái chỉnh sửa của bảng
        @objc func editTable() {
            let isEditing = self.tableView.isEditing
            self.tableView.setEditing(!isEditing, animated: true)
            // Cập nhật tiêu đề của nút "Edit"/"Done"
            self.navigationItem.leftBarButtonItem?.title = isEditing ? "Edit" : "Done"
        }


    // Hàm mở trình chọn tài liệu để nhập file CSV
    @objc func importCSV() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.commaSeparatedText])
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }

    // Cấu hình cell cho bảng
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let student = students[indexPath.row]
        cell.textLabel?.text = student.1
        cell.detailTextLabel?.text = student.0
        return cell
    }

    // Hàm cho phép xóa hàng trong chế độ chỉnh sửa
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            students.remove(at: indexPath.row) // Xóa học sinh khỏi mảng
            tableView.deleteRows(at: [indexPath], with: .fade) // Cập nhật lại bảng
        }
    }
    
    // Chuyển màn hình điểm số
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showDiemSo", sender: indexPath)
        
//        let diemSoController = DiemSoController() // Khởi tạo màn hình Điểm Số
//        // Truyền dữ liệu của học sinh được chọn sang màn hình Điểm Số
//        diemSoController.maHS = students[indexPath.row].0
//        diemSoController.tenHS = students[indexPath.row].1
//        navigationController?.pushViewController(diemSoController, animated: true) // Chuyển đến màn hình Điểm Số
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDiemSo" {
            if let indexPath = sender as? IndexPath {
                let destinationVC = segue.destination as! DiemSoController
                destinationVC.maHS = students[indexPath.row].0
                destinationVC.tenHS = students[indexPath.row].1
            }
        }
    }

}

extension DSHocSinhController: UIDocumentPickerDelegate {
    // Hàm xử lý khi người dùng chọn tài liệu
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else { return }
        do {
            let content = try String(contentsOf: url)
            parseCSV(content)
        } catch {
            print("Failed to read the file")
        }
    }

    // Hàm phân tích nội dung file CSV
    func parseCSV(_ content: String) {
        let rows = content.split(separator: "\n")
        // Bỏ qua dòng đầu tiên
        students = rows.dropFirst().compactMap { row in
            let columns = row.split(separator: ",")
            guard columns.count >= 2 else { return nil } // Kiểm tra file csv đủ 2 cột
            return (String(columns[0]), String(columns[1]))
        }
        tableView.reloadData() // Cập nhật lại bảng
    }
}
