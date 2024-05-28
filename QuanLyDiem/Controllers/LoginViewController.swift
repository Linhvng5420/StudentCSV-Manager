import UIKit

class LoginViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Go
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let username = usernameTextField.text ?? ""
                let password = passwordTextField.text ?? ""
                
                // Kiểm tra xem tên đăng nhập và mật khẩu có chính xác không
                if username == "linh" && password == "1234" {
                    // Chuyển đến màn hình
                    performSegue(withIdentifier: "showDSHocSinh", sender: nil)

                } else {
                    // Hiển thị thông báo lỗi
                    showAlert(message: "Tên đăng nhập hoặc mật khẩu không chính xác.")
                }
    }
    
    // MARK: Alert
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
