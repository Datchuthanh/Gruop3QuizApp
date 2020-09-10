//
//  ProfileViewController.swift
//  ProjectGruopCode
//
//  Created by Chu Thanh Dat on 9/9/20.
//  Copyright © 2020 Chu Thanh Dat. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    let option = UserDefaults.standard.integer(forKey: "option")
    var nameUser = "\(UserDefaults.standard.string(forKey: "nameUserSession") ?? "Underfined")"
    var imgAvatar = "\(UserDefaults.standard.string(forKey: "avatar") ?? "Underfined")"
    var id = ""
    var ref = Database.database().reference()
    @IBOutlet weak var inputName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        inputName.text = nameUser
        setProfile()
      setAvatar()
    }
    
    @IBOutlet weak var viewAvatar: UIImageView!
    
    @IBAction func btnSave(_ sender: Any) {
        
        if(inputName.text == nameUser){
            print("khong thay doi")
            }else {
            updateToFirebase()
            }
    }

    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateToFirebase(){
        let profile = [
            "name" : inputName.text,
               ] as [String : Any]
               
               ref.child("profile").child(id).setValue(profile,withCompletionBlock: { error , ref in
                   if error == nil {
                       self.dismiss(animated: true, completion: nil)
                   }else{
                       //handle
                   }
               } )
        
        
        UserDefaults.standard.set(inputName.text, forKey: "nameUserSession")
              let alertController = UIAlertController(title: "Update profile sucessfully", message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in}
         alertController.addAction(confirmAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setProfile(){
        if(self.option == 1){
                  self.id = UserDefaults.standard.string(forKey: "idFB") ?? ""
              } else {
                  self.id = UserDefaults.standard.string(forKey: "idGG") ?? ""
              }
    }
    
    @IBAction func signOut(_ sender: Any) {
        
        showAlertSignout()

    }
    
    func setAvatar(){ 
        let url = URL(string: self.imgAvatar)
              DispatchQueue.global().async {
                  let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                  DispatchQueue.main.async {
                    print("vao day r")
                    self.viewAvatar.image = UIImage(data: data!)
                  }
              }
    }
    
    func showAlertSignout() {
         let alertController = UIAlertController(title: "Do you want exit", message: nil, preferredStyle: .alert)
         let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                    UserDefaults.standard.removeObject(forKey: "option")
                             UserDefaults.standard.removeObject(forKey: "nameUserSession")
                               UserDefaults.standard.removeObject(forKey: "idGG")
                             UserDefaults.standard.removeObject(forKey: "idFB")
                             let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginController") as! LoginController
                             self.navigationController?.pushViewController(vc, animated: true)
         }
         let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            
            print("cancel")
        }
      
         alertController.addAction(confirmAction)
         alertController.addAction(cancelAction)
         self.present(alertController, animated: true, completion: nil)
     }
}
