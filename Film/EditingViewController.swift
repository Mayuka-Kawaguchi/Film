import UIKit

class EditingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate {
    
    @IBOutlet var cameraImageView: UIImageView!
    @IBOutlet var menuScrollView: UIScrollView!
    @IBOutlet var menuView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    var scrollContentView = UIView()
    var filter: CIFilter!
    var pic: UIImage!
    var filterText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraImageView.image = pic
        menuScrollView.contentSize = CGSize(width: menuScrollView.frame.size.width * 3, height: menuScrollView.frame.size.height)
        horizontalScroll()

    }

    func horizontalScroll() {
            //crollContentViewのframe
            scrollContentView.frame = CGRect(x: 20, y: 0, width: 780, height: 30)
            
            //上部のスクロールビューに多数のボタンを配置
            for i in 0...1 {
                let button = UIButton()
                //サイズ
                
                button.frame = CGRect(x: (i*120), y: 8, width: 90, height: 20)
                button.backgroundColor = UIColor.red
                //タグ
                button.tag = i
                //buttonに文字を挿入
                setTitleForButton(tag: button.tag, button: button)
                //button.titleの色
                button.setTitleColor(.white, for: .normal)
                button.layer.borderWidth = 1
                //buttonに処理を追加
                button.addTarget(self, action: #selector(onClick(sender:)), for: .touchUpInside)
                //vcに載せる
                scrollContentView.addSubview(button)
            }
            
            //スクロールビューにvcを配置
            menuScrollView.addSubview(scrollContentView)
            menuScrollView.contentSize = scrollContentView.bounds.size
    }
    
    
    func setTitleForButton(tag:Int, button:UIButton){
        switch tag {
        case 0:
            button.setTitle("Filter", for: .normal)
        case 1:
            button.setTitle("Edit", for: .normal)
        case 2:
            button.setTitle("Edit", for: .normal)
        case 3:
            button.setTitle("文学", for: .normal)
        case 4:
            button.setTitle("社会", for: .normal)
        case 5:
            button.setTitle("科学", for: .normal)
        case 6:
            button.setTitle("ビジネス", for: .normal)
        default:
            break
        }
    }
    
    @objc func onClick(sender: UIButton){
        switch sender.tag {
        case 0:
            print("0")
            var filterView = UINib(nibName: "ChooseFilterView", bundle: Bundle.main).instantiate(withOwner: self, options: nil).first as? UIView
            menuView.addSubview(filterView!)
        case 1:
            print("1")
            var filterView = UINib(nibName: "EditView", bundle: Bundle.main).instantiate(withOwner: self, options: nil).first as? UIView
            menuView.addSubview(filterView!)
        case 2:
            print("2")
        case 3:
            print("3")
        case 4:
            print("4")
        case 5:
            print("5")
        case 6:
            print("6")
        default:
            break
        }
        
    }
    
    @IBAction func sliderValue(_ sender: UISlider) {
        filterText = String(sender.value * 2)
        let filterImage: CIImage = CIImage(image: pic)!
        
        print(filterText)
        filter = CIFilter(name: "CIColorControls")!
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        filter.setValue(filterText, forKey: "inputSaturation")
        filter.setValue(0.5, forKey: "inputBrightness")
        filter.setValue(2.0, forKey: "inputContrast")
        print(filter)
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
        cameraImageView.image = UIImage(cgImage: cgImage!)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(menuScrollView.contentOffset.x / menuScrollView.frame.size.width)
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
