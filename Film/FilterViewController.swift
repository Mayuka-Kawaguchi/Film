import UIKit

class FilterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var cameraImageView: UIImageView!
    
    var filterImage: UIImage!
    var originalImage: UIImage!
    var filter: CIFilter!
    var pic: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraImageView.image = pic
    }
    
    override func didReceiveMemoryWarning() {
        didReceiveMemoryWarning()
    }

    @IBAction func backButtonTouched() {
        self.dismiss(animated: true, completion: nil)
    }
}
