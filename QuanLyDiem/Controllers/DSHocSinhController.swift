import UIKit
import UniformTypeIdentifiers

class DSHocSinhController: UITableViewController {
    
    // MARK: Propẻties
    // Trạng thái nút sắp xếp
    var isSortedAscending = true
    
    @IBOutlet weak var StatusImportLable: UILabel!
    
    // MARK: Mảng lưu trữ danh sách học sinh
    var students: [(String, String, Double?)] = []
    var fileImportName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Học Sinh"
        
        self.navigationItem.rightBarButtonItems = [
            // Nhập-Xuất file CSV
            UIBarButtonItem(title: "Import", style: .plain, target: self, action: #selector(importCSV)),
            UIBarButtonItem(title: "Export", style: .plain, target: self, action: #selector(exportCSV))
        ]
        
        // Nút Edit để chỉnh sửa bảng
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTable))
        
        // Nút Sort để sắp xếp danh sách học sinh
        let sortButtonTitle = isSortedAscending ? "Sort-ASC" : "Sort-DESC"
        let sortButton = UIBarButtonItem(title: sortButtonTitle, style: .plain, target: self, action: #selector(sortStudents))
        
        // Thiết lập nút Edit và Sort trên navigation bar
        self.navigationItem.leftBarButtonItems = [editButton, sortButton]
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        // Đọc dữ liệu từ cơ sở dữ liệu
        loadData()
        
        // Khôi phục trạng thái của label khi view được tải
        if let savedText = UserDefaults.standard.string(forKey: "StatusImportLabelText") {
            StatusImportLable.text = savedText
        }
    }
    
    // MARK: Database
    func loadData() {
        let db = Database() // Tại đây chúng ta khởi tạo đối tượng Database
        self.students = db.readAllDiem() // Đọc dữ liệu và cập nhật vào mảng students
        self.tableView.reloadData() // Sau khi cập nhật dữ liệu, ta cần load lại bảng
    }
    
    // MARK: Mở trình chọn tài liệu để nhập file CSV
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
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let student = students[indexPath.row]
        cell.textLabel?.text = student.1 // Tên học sinh
        cell.detailTextLabel?.text = student.0 // Mã học sinh
        return cell
    }
    
    // MARK: Hàm xuất file CSV
    @objc func exportCSV() {
        // Bắt đầu với dòng tiêu đề cho file CSV
        var csvString = "mahs,ten,diem\n"
        
        // Lặp qua danh sách học sinh và tạo chuỗi CSV
        for student in students {
            // Tạo chuỗi CSV, khi điểm là nil thì để trống cột điểm
            let diemString = student.2.map { "\($0)" } ?? ""
            let csvRow = "\(student.0),\(student.1),\(diemString)\n"
            
            csvString.append(contentsOf: csvRow)
        }
        
        // Chuyển đổi chuỗi thành dữ liệu NSData
        guard let data = csvString.data(using: String.Encoding.utf8) else { return }
        
        // Tên Lớp để Xuất File
        var className: String = ""
        
        // Tạo dateString với ngày, tháng, năm, giờ và phút
        let formatter = DateFormatter()
        formatter.dateFormat = "HH'H'mm-ddMMyyyy"
        let currentDate = Date()
        let dateString = formatter.string(from: currentDate) // Ví dụ: "10H15-25052024"
        
        // Tìm chuỗi "Lop" và 5 ký tự tiếp theo của fileImportName
        if let range = fileImportName.range(of: "Lop") {
            let start = range.lowerBound
            let end = fileImportName.index(start, offsetBy: 8, limitedBy: fileImportName.endIndex) ?? fileImportName.endIndex
            className = String(fileImportName[start..<end])
            
            // In ra className
            print(className) // In ra lop
        } else {
            className = ""
            print("Chuỗi 'Lop' không được tìm thấy.")
        }
        
        // Sử dụng FileManager để lưu file tạm thời
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("Diem [] \(className) \(dateString).csv")
        
        do {
            try data.write(to: tempURL, options: .atomicWrite)
            let activityViewController = UIActivityViewController(activityItems: [tempURL], applicationActivities: nil)
            present(activityViewController, animated: true)
        } catch {
            print("Không thể xuất file")
        }
    }
    
    // MARK: Chế độ chỉnh sửa
    // Chuyển đổi trạng thái chỉnh sửa của bảng
    @objc func editTable() {
        // Kiểm tra nếu danh sách students rỗng
        guard !students.isEmpty else {
            print("Không có dữ liệu để chỉnh sửa.")
            return
        }
        
        // Chỉ cho phép chỉnh sửa khi có dữ liệu
        let isEditing = self.tableView.isEditing
        self.tableView.setEditing(!isEditing, animated: true)
        // Cập nhật tiêu đề của nút "Edit"/"Done"
        self.navigationItem.leftBarButtonItem?.title = isEditing ? "Edit" : "Done"
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Lấy mã học sinh của sinh viên cần xoá
            let mahs = students[indexPath.row].0
            
            // Xoá bản ghi trong cơ sở dữ liệu
            let database = Database()
            if database.deleteDiem(mahs: mahs) {
                // Nếu xoá thành công trong cơ sở dữ liệu, xoá trong array và UI
                students.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                print("Xoá thất bại từ cơ sở dữ liệu.")
            }
        }
    }
    
    // MARK: Sắp xếp lại danh sách học sinh
    // Chuyển đổi trạng thái nút sắp xếp
    @objc func sortStudents() {
        // Kiểm tra nếu danh sách students rỗng
        guard !students.isEmpty else {
            print("Không có dữ liệu để sắp xếp.")
            return
        }
        
        isSortedAscending.toggle()  // Đảo trạng thái
        
        // Thực hiện sắp xếp
        students.sort { isSortedAscending ? $0.0 < $1.0 : $0.0 > $1.0 }
        
        // Cập nhật tableView với danh sách đã sắp xếp
        tableView.reloadData()
        
        // Cập nhật tiêu đề của nút sắp xếp
        if let sortButton = self.navigationItem.leftBarButtonItems?.last {
            sortButton.title = isSortedAscending ? "Sort-ASC" : "Sort-DESC"
        }
        
        // Cập nhật cơ sở dữ liệu với thứ tự mới
        updateDatabaseWithSortedStudents()
    }
    
    func updateDatabaseWithSortedStudents() {
        // Tạo một tham chiếu đến CSDL
        let database = Database()
        
        // Cập nhật thứ tự của danh sách học sinh trong CSDL
        for student in students {
            if !database.updateStudentWithMaHS(mahs: student.0, newMahs: student.0, tenhs: student.1, diem: student.2) {
                print("Đã xảy ra lỗi khi cập nhật thông tin học sinh có MaHS \(student.0)")
            }
        }
        
        print("Danh sách học sinh đã được cập nhật theo MaHS.")
    }
    
    // MARK: Di chuyển vị trí item trong tableview
//    // Cho phép di chuyển hàng cho tất cả các hàng trong bảng
//        override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//            return true
//        }
//
//        // Xử lý việc thay đổi vị trí của hàng
//        override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//            let movedObject = self.students[sourceIndexPath.row]
//            students.remove(at: sourceIndexPath.row)
//            students.insert(movedObject, at: destinationIndexPath.row)
//
//        }
    
    // MARK: Chuyển màn hình điểm số
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDiemSo", sender: indexPath)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDiemSo", let indexPath = sender as? IndexPath {
            let destinationVC = segue.destination as! DiemSoController
            // Chuyển dữ liệu ban đầu đến DiemSoController
            destinationVC.maHS = students[indexPath.row].0
            destinationVC.tenHS = students[indexPath.row].1
            destinationVC.diemHS = students[indexPath.row].2
            
            // Cài đặt closure khi có sự thay đổi
            destinationVC.onDiemSaved = { [weak self] maHS, diemHS in
                if let index = self?.students.firstIndex(where: { $0.0 == maHS }) {
                    // Cập nhật điểm số
                    self?.students[index].2 = diemHS
                    // Cập nhật lại bảng
                    self?.tableView.reloadRows(at: [indexPath], with: .none)
                }
            }
            
            destinationVC.onTenSaved = { [weak self] maHS, tenHS in
                if let index = self?.students.firstIndex(where: { $0.0 == maHS }) {
                    // Cập nhật tên
                    self?.students[index].1 = tenHS
                    // Cập nhật lại bảng
                    self?.tableView.reloadRows(at: [indexPath], with: .none)
                }
            }
        }
    }
}

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
