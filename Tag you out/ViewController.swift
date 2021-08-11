//
//  ViewController.swift
//  Tag you out
//
//  Created by Ruizhe Wang on 09/08/2021.
//

import UIKit

class ViewController: UIViewController {
    let tweets = AllTweets()
    
    let faceDetectionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonToFaceDetection(_:)), for: .touchUpInside)
        button.setTitle("Click Here to Start", for: .normal)
        button.titleLabel?.font = UIFont(name: "Ancient-Medium", size: 32)
        button.backgroundColor = .clear
        button.showsTouchWhenHighlighted = true
        return button
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tag You Out"
        label.backgroundColor = .clear
//        label.font = UIFont(name: "Cardinal", size: 36)
        label.font = UIFont(name: "Ancient-Medium", size: 64)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /* Check the font installed
        for family: String in UIFont.familyNames{
            print(family)
            for names: String in UIFont.fontNames(forFamilyName: family) {
                print("== \(names)")
            }
        }
        */
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background1")!)
        setupViews()
        setupConstraints()
        
    }
    
    func setupViews() {
        view.addSubview(faceDetectionButton)
        view.addSubview(nameLabel)
    }
    
    func setupConstraints() {
        faceDetectionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        faceDetectionButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200).isActive = true
        
        nameLabel.makeConstraints(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: nil, bottom: nil, topMargin: 30, leftMargin: 20, rightMargin: 0, bottomMargin: 0, width: 0, height: 0)
    }
    
    @objc func buttonToFaceDetection(_ sender: UIButton) {
        let controller = FaceDetectionViewController()
//        self.navigationController?.pushViewController(controller, animated: true)
        self.present(controller, animated: true, completion: nil)
    }
    
}

