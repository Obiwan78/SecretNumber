//
//  InfosViewController.swift
//  SecretNumber
//
//  Created by Alban BERNARD on 30/08/2018.
//  Copyright © 2018 Alban BERNARD. All rights reserved.
//

import UIKit
import MessageUI

class InfosViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        testInternetAndWifiConnexion()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var ui_sendMailButton: UIButton!
    
    @IBAction func SendEmailButton(_ sender: Any) {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        composeVC.setToRecipients(["contact@albanbernard.fr"])
        composeVC.setSubject("LE NOMBRE SECRET")
        composeVC.setMessageBody("Bonjour, <BR><BR>Toute l'équipe de LE NOMBRE SECRET vous remercie encore d'avoir pris le temps de nous donner votre avis et vos commentaires. <BR>  <BR>Pour une meilleur gestion des demandes, veuillez SVP saisir les informations suivantes : <BR> - Votre type de matériel utilisé: iPhone ou iPad ?<BR> - Version d'iOS installée : <BR> <BR> Les points positifs que vous appréciez : <BR>-<BR>-<BR>-<BR><BR> Les améliorations que vous souhaiteriez voir: <BR>-<BR>-<BR>-<BR><BR>Si nécessaire, vous pouvez joindre des captures d'écrans avec des anotations.<BR> <BR>Merci pour votre soutien. <BR><BR>L’équipe de LE NOMBRE SECRET <BR><BR><BR>------------------------------------------------------------<BR><BR>English Version<BR><BR>Hi,<BR><BR>The SECRET NUMBER team thanks you again for taking the time to give us your opinion and comments. <BR> <BR> For a better management of requests, please enter the following information: <BR> - Your type of equipment used: iPhone or iPad? <BR> - Version of iOS installed: <BR> <BR> The positive points you like: <BR> - <BR> - <BR> - <BR> <BR> The improvements you would like to see: <BR> - <BR> - <BR> - <BR> <BR> If necessary, you can attach screenshots with anotations. <BR> <BR> Thank you for your support. <BR> <BR> The SECRET NUMBER team", isHTML: true)
        self.present(composeVC, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        // Check the result or perform other tasks.
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
    func testInternetAndWifiConnexion() {
        // check internet connexion
        // Add : testInternetAndWifiConnexion() in ViewDidLoad
        
        if Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
        } else {
            print("Internet connection FAILED")
            let alertController = UIAlertController.init(title: "Aucune Connexion Internet", message: "Veuillez vérifier votre connexion.\nActivez le Wifi ou les données mobiles.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {(_ ) in }))
            //            alertController.addAction(UIAlertAction(title: "Activer le wifi", style: .cancel, handler: { (_ ) in
            //                print("Activation Wifi")
            //            }))
            //            alertController.addAction(UIAlertAction(title: "Activer les données mobiles", style: .cancel, handler: { (_ ) in
            //                print("Activation Données Mobiles")
            //            }))
            present(alertController, animated: true, completion: nil) // completion : lancer du code une fois qu'il est afficher.
        }
        return
    }
    
    @IBAction func moreAppsButton(_ sender: Any) {
        moreAppsABERNARD (presentedViewController: self)
    }
    
    func moreAppsABERNARD (presentedViewController : UIViewController!) {
        let alertController = UIAlertController(title: "Voir nos applications", message: "Nous vous proposons de regarder nos autres applications sur l'AppStore ou sur notre site internet", preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction( title: "Sur le site internet",
                                                 style: .default,
                                                 handler: {
                                                    (action:UIAlertAction!) -> Void in
                                                    if #available(iOS 10.0, *) {
                                                        UIApplication.shared.open(URL(string: "https://albanbernard.fr/ios-apps")! as URL, options: [:], completionHandler: nil)
                                                    } else {
                                                        // Fallback on earlier versions
                                                    }
        }))
        
        alertController.addAction(UIAlertAction(title: "Sur l'AppStore",
                                                style: .default,
                                                handler: { (_ ) in
                                                    if #available(iOS 10.0, *) {
                                                        UIApplication.shared.open(URL(string: "https://itunes.apple.com/fr/app/le-nombre-secret/id1425470784")! as URL, options: [:], completionHandler: nil)
                                                    } else {
                                                        // Fallback on earlier versions
                                                    }
        }))
        
        alertController.addAction(UIAlertAction(title: "Fermer", style: .cancel, handler: nil))
        
        //        presentedViewController?.present(alertController, animated: true, completion: nil)
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
//    }
    
}
