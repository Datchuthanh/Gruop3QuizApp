//
//  SettingViewController.swift
//  ProjectGruopCode
//
//  Created by Chu Thanh Dat on 9/9/20.
//  Copyright © 2020 Chu Thanh Dat. All rights reserved.
//

import UIKit
import Firebase

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Setting"
    }
    
   
    @IBAction func clickTest(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "configExamScreen") as! ConfigexamViewController
                                //           vc.score = self.score
                                self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickUser(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "profileScreen") as! ProfileViewController
        //           vc.score = self.score
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
   
    
}
