import UIKit

class EditingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITabBarDelegate{
    
    @IBOutlet var cameraImageView: UIImageView!
    @IBOutlet var editViewController: EditTabViewController!
    @IBOutlet var colorSlider: UISlider!
    var filter: CIFilter!
    var pic: UIImage!
    var filterText: String?
    var transMiller = CGAffineTransform()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraImageView.image = pic
        EditViewDelegate.self
    }
    
    @IBAction func colorSliderValue(_ sender: UISlider) {
        print(sender.value)
    }

    @IBAction func inversion() {
        print("inversion")
    }
    
    @IBAction func savePhoto() {
        UIImageWriteToSavedPhotosAlbum(cameraImageView.image!, nil, nil, nil)
        
        let alert = UIAlertController(title: "保存完了", message: "正常にライブラリに保存されました", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
     }
    
    @IBAction func snsPhoto() {
        let shareText = "Filmで、写真加工！"
        let shareImage = cameraImageView.image!
        let activityItems: [Any] = [shareText, shareImage]
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        let excludedActivityTypes = [UIActivity.ActivityType.postToWeibo, .saveToCameraRoll, .print]
        
        activityViewController.excludedActivityTypes = excludedActivityTypes
        present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func backButtonTouched() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension EditingViewController: EditViewDelegate {
    func passSliderValue() {
        viewDidLoad()
        print("aaaaa")
    }
}
