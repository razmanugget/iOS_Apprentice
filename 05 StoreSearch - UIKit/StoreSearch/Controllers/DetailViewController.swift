//
//  DetailViewController.swift
//  StoreSearch
//
//  Created by Rami on 1/21/20.
//  Copyright © 2020 Lyfebug. All rights reserved.
//

import UIKit
import MessageUI

// MARK: - Extensions
extension DetailViewController: UIViewControllerTransitioningDelegate {
   func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
      return DimmingPresentationController(presentedViewController: presented, presenting: presenting)
   }
   func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      switch dismissStyle {
      case .slide:
         return SlideOutAnimationController()
      case .fade:
         return FadeOutAnimationController()
      }
   }
}

extension DetailViewController: UIGestureRecognizerDelegate {
   func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                          shouldReceive touch: UITouch) -> Bool {
      return (touch.view === self.view)
   }
}

extension DetailViewController: MenuViewControllerDelegate {
   func MenuViewControllerSendEmail(_ controller: MenuViewController) {
      dismiss(animated: true) {
         if MFMailComposeViewController.canSendMail() {
            let controller = MFMailComposeViewController()
            controller.mailComposeDelegate = self
            controller.modalPresentationStyle = .formSheet
            controller.setSubject(NSLocalizedString("Support Request", comment: "Email subject"))
            controller.setToRecipients(["rami_s@hotmail.com"])
            self.present(controller, animated: true, completion: nil)
         }
      }
   }
}

extension DetailViewController: MFMailComposeViewControllerDelegate {
   func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
      dismiss(animated: true, completion: nil)
   }
}


class DetailViewController: UIViewController {
   // MARK: - Variables | Outlets
   enum AnimationStyle {
      case slide
      case fade
   }
   
   var searchResult: SearchResult! {
      didSet {
         if isViewLoaded {
            updateUI()
         }
      }
   }
   
   var downloadTask: URLSessionDownloadTask?
   var dismissStyle = AnimationStyle.fade
   var isPopUp = false
   
   @IBOutlet weak var popupView: UIView!
   @IBOutlet weak var artworkImageView: UIImageView!
   @IBOutlet weak var nameLabel: UILabel!
   @IBOutlet weak var artistNameLabel: UILabel!
   @IBOutlet weak var kindLabel: UILabel!
   @IBOutlet weak var genreLabel: UILabel!
   @IBOutlet weak var priceButton: UIButton!
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      modalPresentationStyle = .custom
      transitioningDelegate = self
   }
   
   deinit {
      print("deinit \(self)")
      downloadTask?.cancel()
   }
   
   
   // MARK: - Actions
   @IBAction func openInStore() {
      if let url = URL(string: searchResult.storeURL) {
         UIApplication.shared.open(url, options: [:], completionHandler: nil)
      }
   }
   
   @IBAction func close() {
      dismissStyle = .slide
      dismiss(animated: true, completion: nil)
   }
   
   
   // MARK: - Functions
   // animating the detail bounce in -> annoying
   func animationController(forPresented presented: UIViewController,
                            presenting: UIViewController,
                            source: UIViewController)
      -> UIViewControllerAnimatedTransitioning? {
      return BounceAnimationController()
   }
   
   
   // MARK: - Helper Methods
   func updateUI() {
      nameLabel.text = searchResult.name
      
      if searchResult.artist.isEmpty {
         artistNameLabel.text = "Unknown"
      } else {
         artistNameLabel.text = searchResult.artist
      }
      kindLabel.text = searchResult.type
      genreLabel.text = searchResult.genre
      
      // show price -> currency
      let formatter = NumberFormatter()
      formatter.numberStyle = .currency
      formatter.currencyCode = searchResult.currency
      
      let priceText: String
      if searchResult.price == 0 {
         priceText = "Free"
      } else if let text = formatter.string(from: searchResult.price as NSNumber) {
         priceText = text
      } else {
         priceText = ""
      }
      priceButton.setTitle(priceText, for: .normal)
      
      // get image
      if let largeURL = URL(string: searchResult.imageLarge) {
         downloadTask = artworkImageView.loadImage(url: largeURL)
      }
      popupView.isHidden = false
   }
   
   
   // MARK: - Navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "ShowMenu" {
         let controller = segue.destination as! MenuViewController
         controller.delegate = self
      }
   }
   
   
   // MARK: - View Controller Life Cycle
   override func viewDidLoad() {
      super.viewDidLoad()
     
      
      if (traitCollection.userInterfaceStyle == .light) {
         view.tintColor = UIColor(red: 20/255, green: 160/255,
                                     blue: 160/255, alpha: 1)
      } else {
         view.tintColor = UIColor(red: 140/255, green: 140/255,
                                     blue: 240/255, alpha: 1)
      }
   
      
      popupView.layer.cornerRadius = 10
      
      if isPopUp {
         let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(close))
         gestureRecognizer.cancelsTouchesInView = false
         gestureRecognizer.delegate = self
         view.addGestureRecognizer(gestureRecognizer)
         
         view.backgroundColor = UIColor.clear
      } else {
         view.backgroundColor = UIColor(patternImage: UIImage(named: "LandscapeBackground")!)
         popupView.isHidden = true
         if let displayName = Bundle.main.localizedInfoDictionary?["CFBundleDisplayName"] as? String {
            title = displayName
         }
      }
      
      if searchResult != nil {
         updateUI()
      }
      
      
   }
   
}
