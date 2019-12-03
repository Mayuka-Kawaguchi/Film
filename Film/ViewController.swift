import UIKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var cameraButton: UIButton!
    
    
    var captureSession = AVCaptureSession()
    var mainCamera: AVCaptureDevice?
    var innerCamera: AVCaptureDevice?
    var currentDevice: AVCaptureDevice?
    var photoOutput : AVCapturePhotoOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
//            self.performSegue(withIdentifier: "toFilter", sender: nil)
        }
    }
    
    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let storyboard: UIStoryboard = self.storyboard!
        let next = storyboard.instantiateViewController(withIdentifier: "FilterViewController")
        self.present(next, animated: true, completion: nil)
        print("gggg")
        
//        originalImage = cameraImageView.image
//        dismiss(animated: true, completion: nil)
    }
}
