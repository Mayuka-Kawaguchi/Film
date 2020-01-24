import UIKit

class SubFilterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var photoImageView: UIImageView!
    
    var originalImage: UIImage!
    var filter: CIFilter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        didReceiveMemoryWarning()
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        photoImageView.image = info[.editedImage] as? UIImage
        originalImage = photoImageView.image
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func takePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            picker.allowsEditing = true
            
            self.present(picker, animated: true, completion: nil)
        } else {
            print("error")
        }
    }
    
    @IBAction func openAlbum() {
           if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
               let picker = UIImagePickerController()
               picker.sourceType = .photoLibrary
               picker.delegate = self
               picker.allowsEditing = true
               
            self.present(picker, animated: true, completion: nil)
           }
       }
    
    @IBAction func colorFilter() {
        let filterImage: CIImage = CIImage(image: originalImage)!
        
        filter = CIFilter(name: "CIColorControls")!
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        filter.setValue(1.0, forKey: "inputSaturation")
        filter.setValue(0.5, forKey: "inputBrightness")
        filter.setValue(2.0, forKey: "inputContrast")
    
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
        photoImageView.image = UIImage(cgImage: cgImage!)
    }
    
    @IBAction func snsPhoto() {
        let shareText = "写真加工いぇい"
        let shareImage = photoImageView.image!
        let activityItems: [Any] = [shareText, shareImage]
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        let excludedActivityTypes = [UIActivity.ActivityType.postToWeibo, .saveToCameraRoll, .print]
        
        activityViewController.excludedActivityTypes = excludedActivityTypes
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func savePhoto() {
       UIImageWriteToSavedPhotosAlbum(photoImageView.image!, nil, nil, nil)
       
       let alert = UIAlertController(title: "保存完了", message: "正常にライブラリに保存されました", preferredStyle: .alert)
       let action = UIAlertAction(title: "OK", style: .default) { (action) in
           alert.dismiss(animated: true, completion: nil)
       }
       alert.addAction(action)
       self.present(alert, animated: true, completion: nil)
       
    }
}
