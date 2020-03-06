import UIKit

class EditingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITabBarDelegate{
    
    @IBOutlet var cameraImageView: UIImageView!
    @IBOutlet var brightnessSlider: UISlider!
    @IBOutlet var saturationSlider: UISlider!
    @IBOutlet var contrastSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    var filter: CIFilter!
    var pic: UIImage!
    var filterText: String?
    var transMiller = CGAffineTransform()
    var brightness: Float = 0
    var saturation: Float = 1
    var contrast: Float = 1
    var blue: Float = 3.14
    //    var blue: CIVector = (x: 0, y: 0, z: 0, w: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraImageView.image = pic
    }
    
    @IBAction func colorSliderValue(_ sender: Any) {
        guard let slider = sender as? UISlider, let identifier = slider.accessibilityIdentifier else { return }
        switch identifier {
        case "brightness":
            self.brightness = slider.value
        case "saturation":
            self.saturation = slider.value
        case "contrast":
            self.contrast = slider.value
        case "blue":
            self.blue = slider.value
        case "red":
            self.saturation = slider.value
        case "green":
            self.contrast = slider.value
        default: break
        }
        
        Filter()
        imageFilter()
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
        brightnessSlider.value = 0
        saturationSlider.value = 1
        contrastSlider.value = 1
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
            ciFilter.setValue(self.brightness, forKey: "inputBrightness")
            ciFilter.setValue(self.saturation, forKey: "inputSaturation")
            ciFilter.setValue(self.contrast, forKey: "inputContrast")
            let ciContext:CIContext = CIContext(options: nil)
            if let outputImage = ciFilter.outputImage {
                if let cgimg: CGImage = ciContext.createCGImage(outputImage, from: outputImage.extent) {
                    cameraImageView.image = UIImage(cgImage: cgimg, scale: 1.0, orientation: UIImage.Orientation.up)
                }
            }
        }
    }
    
    func Filter(){
        let image = cameraImageView.image!
        let ciImage = CIImage(image:image)
        if let ciFilter = CIFilter(name: "CIToneCurve") {
            ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
            ciFilter.setValue(CIVector(x: 0.0, y: 0.0), forKey: "inputPoint0")
            ciFilter.setValue(CIVector(x: 0.25, y: 0.1), forKey: "inputPoint1")
            ciFilter.setValue(CIVector(x: 0.5, y: 0.5), forKey: "inputPoint2")
            ciFilter.setValue(CIVector(x: 0.75, y: 0.9), forKey: "inputPoint3")
            ciFilter.setValue(CIVector(x: 1.0, y: 1.0), forKey: "inputPoint4")
            let ciContext:CIContext = CIContext(options: nil)
            if let outputImage = ciFilter.outputImage {
                if let cgimg: CGImage = ciContext.createCGImage(outputImage, from: outputImage.extent) {
                    cameraImageView.image = UIImage(cgImage: cgimg, scale: 1.0, orientation: UIImage.Orientation.up)
                }
            }
        }
    }
}
