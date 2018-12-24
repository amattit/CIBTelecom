//
//  DetailViewController.swift
//  SberTeleCom
//
//  Created by Mikhail Seregin on 18.12.2018.
//  Copyright © 2018 Mikhail Seregin. All rights reserved.
//

import UIKit

class CallDetailViewController: UIViewController {

    var callItem: CallItemViewModel? = nil

    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Распознование звонка"
        indicatorView.startAnimating()

        indicatorView.style = .whiteLarge
        indicatorView.color = .blue
        recognizeAudio()
    }
    
    func recognizeAudio() {
        if let id = callItem?.id {
            
            API.shared.recognizeCall(id: id) { [weak self] (recognizedText) in
                DispatchQueue.main.async {
                    self?.indicatorView.stopAnimating()
                    self?.indicatorView.isHidden = true
                    self?.textView.text = recognizedText
                }
                
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureView()
        
    }

    private func configureView() {
        if let item = callItem {
            print(item.id)
        }
    }

}

