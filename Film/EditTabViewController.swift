//
//  EditTabView.swift
//  Film
//
//  Created by K Mayuka on 2020/02/23.
//  Copyright © 2020 K Mayuka. All rights reserved.
//

import UIKit

protocol EditViewDelegate: class {
    func passSliderValue()
}
class EditTabViewController: UIViewController,UITableViewDelegate {
    @IBOutlet var colorSlider: UISlider!
    var filter: CIFilter!
    var filterText: String?
    var pic: UIImage!
    var transMiller = CGAffineTransform()
    
    weak var delegate: EditViewDelegate?

    override func didReceiveMemoryWarning() {
        super.viewDidLoad()
        
    }
    @IBAction func sliderValue(_ sender: UISlider) {
        delegate?.passSliderValue()
        print("delegate Called")
        
    }

    @IBAction func inversion() {
        let picker = view
        transMiller = CGAffineTransform(scaleX: -1, y: 1)
        picker!.transform = transMiller
        print("inversion")
    }
    
}
