import Foundation

class Database {
    // MARK: - Các thuộc tính chung của cơ sở dữ liệu
    private let DB_NAME = "quldiem.sqlite"
    private let DB_PATH: String?
    private let database: FMDatabase?
    
    // MARK: - Thuộc tính của bảng điểm
    private let DIEM_TABLE_NAME = "diem"
    private let DIEM_MAHS = "mahs"
    private let DIEM_TENHS = "tenhs"
    private let DIEM_DIEM = "diem"
    
    // MARK: - Constructors
    init() {
        // Lấy đường dẫn đến thư mục tài liệu của người dùng
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
            """  // Câu lệnh SQL để tạo bảng nếu chưa tồn tại
            if tableCreate(sql: sql, tableName: DIEM_TABLE_NAME) {
                print("Bảng \(DIEM_TABLE_NAME) đã sẵn sàng.")
            } else {
                print("Không thể tạo bảng \(DIEM_TABLE_NAME).")
            }
        } else {
            print("Khởi tạo cơ sở dữ liệu không thành công.")
        }
    }
    
    // MARK: - Hàm khởi tạo bảng dữ liệu
    private func tableCreate(sql: String, tableName: String) -> Bool {
        var isSuccessful = false  // Biến kiểm tra kết quả tạo bảng
        if open() {
            defer { close() }  // đóng cơ sở dữ liệu sau khi hoàn thành
            if !database!.tableExists(tableName) {
                isSuccessful = database!.executeStatements(sql)  // Tạo bảng nếu nó chưa tồn tại
            } else {
                isSuccessful = true  // Bảng đã tồn tại
            }
        }
        return isSuccessful
    }
    
    // MARK: - Hàm mở cơ sở dữ liệu
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
    
    // MARK: - Hàm đóng cơ sở dữ liệu
    private func close() {
        database?.close()
    }
    
    // MARK: - Hàm xoá tất cả dữ liệu trong bảng điểm
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
    
    // MARK: - Hàm xoá dữ liệu khỏi bảng điểm theo mã học sinh
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
    
    // MARK: - Hàm thêm hoặc cập nhật dữ liệu vào bảng điểm
    func insertOrUpdateDiem(mahs: String, tenhs: String, diem: Double?) -> Bool {
        if open() {
            defer { close() }
            let sql = """
            INSERT OR REPLACE INTO \(DIEM_TABLE_NAME) (\(DIEM_MAHS), \(DIEM_TENHS), \(DIEM_DIEM))
            VALUES (?, ?, ?)
            """  // Câu lệnh SQL để thêm hoặc cập nhật dữ liệu
            do {
                // Dùng NSNull để biểu thị giá trị NULL khi diem là nil
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
    
    // MARK: - Hàm đọc tất cả dữ liệu từ bảng điểm
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
    
    // MARK: - Hàm cập nhật điểm cho học sinh
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
    
    // MARK: - Hàm cập nhật tên cho học sinh
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
    
    // MARK: - Hàm sắp xếp
    func updateStudentWithMaHS(mahs: String, newMahs: String, tenhs: String, diem: Double?) -> Bool {
        if open() {
            defer { close() }
            // Chuẩn bị câu lệnh SQL
            let sql = """
                UPDATE \(DIEM_TABLE_NAME) SET \(DIEM_MAHS) = ?, \(DIEM_TENHS) = ?, \(DIEM_DIEM) = ? WHERE \(DIEM_MAHS) = ?
                """
            do {
                // Dùng NSNull để biểu thị giá trị NULL khi diem là nil
                let diemValue: Any = diem as Any? ?? NSNull()
                
                // Thực thi câu lệnh SQL
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
}
