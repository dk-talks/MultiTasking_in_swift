//
//  ViewController.swift
//  MultiTasking
//
//  Created by Dinesh Sharma on 26/08/23.
//

import UIKit

class ViewController: UIViewController {
    
    var timerCounter = 0
    var timer: Timer?
    var strResult: String = ""
    
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var btnCallApi: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        
    }
    
    @objc func timerFunction() {
        timerCounter += 1
        lblTimer.text = "\(timerCounter)"
    }
    
    
    
    
    @IBAction func btnCallAPITapped(_ sender: UIButton) {
        
        sender.isEnabled = false
        
        // Create and add an activity indicator to the button
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = CGPoint(x: sender.bounds.midX, y: sender.bounds.midY)
        activityIndicator.startAnimating()
        sender.addSubview(activityIndicator)
        
        textView.text = ""
        
        if(segmentControl.selectedSegmentIndex == 0) {
            // need to wrap an async call inside Task to complete asynchronous calls
            
            let _ = Task {
                textView.text = await ApiClient.fetchDataWithMultiTasking()
                DispatchQueue.main.async {
                    // Remove the activity indicator and re-enable the button
                    activityIndicator.removeFromSuperview()
                    sender.isEnabled = true
                }
            }
        } else {
            
            let result = ApiClient.fetchDataSynchronously()
            
            switch result {
            case .success(let jsonString):
                textView.text = jsonString
            case .failure(let error):
                textView.text = error.localizedDescription
            }
            DispatchQueue.main.async {
                // Remove the activity indicator and re-enable the button
                activityIndicator.removeFromSuperview()
                sender.isEnabled = true
            }
        }
        
        
        
    }
}


