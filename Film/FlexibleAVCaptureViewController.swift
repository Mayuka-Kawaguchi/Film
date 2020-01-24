import UIKit
import FlexibleAVCapture

class CaptureViewController: UIViewController, FlexibleAVCaptureDelegate {
    
    let flexibleAVCaptureVC: FlexibleAVCaptureViewController = FlexibleAVCaptureViewController()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.flexibleAVCaptureVC.delegate = self
        self.present(flexibleAVCaptureVC, animated: true, completion: nil)
    }
    
    func didCapture(withFileURL fileURL: URL) {
        print(fileURL)
    }

}
