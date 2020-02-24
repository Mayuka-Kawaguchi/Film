import UIKit
import AVFoundation


protocol EditTabViewControllerDelegate: class {
   
}

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var editButton: UIButton!
    
    var filterImage: UIImage!
    var captureSession = AVCaptureSession()
    var mainCamera: AVCaptureDevice?
    var innerCamera: AVCaptureDevice?
    var currentDevice: AVCaptureDevice?
    var photoOutput : AVCapturePhotoOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.buttonImage()
        print("aaaaaaaaaaaaaaaaaaaa")
    }
    
    @IBAction func startCamera() {
        setupCaptureSession()
        captureSession.startRunning()
        print("start")
    }
    
    @IBAction func openAlbum() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            present(picker, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="toPhoto" {
            let filterViewContoroller = segue.destination as! EditingViewController
            filterViewContoroller.pic = filterImage
        }
    }
    
    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        filterImage = info[.editedImage] as? UIImage
        dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "toPhoto", sender: nil)
    }
    
    func buttonImage() {
        cameraButton.imageView?.contentMode = .scaleAspectFit
        cameraButton.contentHorizontalAlignment = .fill
        cameraButton.contentVerticalAlignment = .fill
        cameraButton.imageEdgeInsets = UIEdgeInsets(top: 33, left: 33, bottom: 33, right: 33)
        editButton.imageView?.contentMode = .scaleAspectFit
        editButton.contentHorizontalAlignment = .fill
        editButton.contentVerticalAlignment = .fill
        editButton.imageEdgeInsets = UIEdgeInsets(top: 22, left: 22, bottom: 22, right: 22)
    }
}
