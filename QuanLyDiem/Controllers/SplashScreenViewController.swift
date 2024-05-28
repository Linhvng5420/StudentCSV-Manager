import UIKit

class SplashScreenViewController: UIViewController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Thực hiện các thiết lập ban đầu khi view được tải
    }
    
    // Được gọi ngay sau khi view xuất hiện trên màn hình
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Thực hiện chuyển tiếp sau một khoảng thời gian trì hoãn
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            // Sử dụng [weak self] để tránh việc giữ chặt self và tránh memory leak
            self?.performSegue(withIdentifier: "segueToMain", sender: self)
        }
    }
}
