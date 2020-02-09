import UIKit
import AVFoundation


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var photoImageView: UIImageView!
    
    var filterImage: UIImage!
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
}
