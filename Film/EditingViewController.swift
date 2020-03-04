import UIKit

class EditingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITabBarDelegate{
    
    @IBOutlet var cameraImageView: UIImageView!
    var filter: CIFilter!
    var pic: UIImage!
    var filterText: String?
    var transMiller = CGAffineTransform()
    var contrast: Float = 0.5
    var brightness: Float = 0
    var saturation: Float = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraImageView.image = pic
    }
    
    @IBAction func colorSliderValue(_ sender: Any) {
        guard let slider = sender as? UISlider, let identifier = slider.accessibilityIdentifier else { return }
        switch identifier {
        case "contrast":
            self.contrast = slider.value
        case "brightness":
            self.brightness = slider.value
        case "saturation":
            self.saturation = slider.value
        default: break
        }
        imageFilter()
        print(contrast)
    }
    
    @IBAction func inversion() {
        print("inversion")
        let picker = cameraImageView
        transMiller = CGAffineTransform(scaleX: -1, y: 1)
        picker!.transform = transMiller
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
    @IBAction func reset() {
       cameraImageView.image = pic
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
    
    func imageFilter(){
        let image = cameraImageView.image!
        let ciImage = CIImage(image:image)
        if let ciFilter  = CIFilter(name: "CIColorControls") {
            ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
            ciFilter.setValue(self.contrast, forKey: "inputContrast")
            ciFilter.setValue(self.brightness, forKey: "inputBrightness")
            ciFilter.setValue(self.saturation, forKey: "inputSaturation")
            let ciContext:CIContext = CIContext(options: nil)
            if let outputImage = ciFilter.outputImage {
                if let cgimg: CGImage = ciContext.createCGImage(outputImage, from: outputImage.extent) {
                    cameraImageView.image = UIImage(cgImage: cgimg, scale: 1.0, orientation: UIImage.Orientation.up)
                }
            }
        }
    }
}
