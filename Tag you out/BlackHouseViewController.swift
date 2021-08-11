//
//  BlackHouseViewController.swift
//  
//
//  Created by Ruizhe Wang on 11/08/2021.
//

import UIKit

class BlackHouseViewController: UIViewController {
    
    var image: UIImage
    var person: Person?
    var tweets: [Tweet] = AllTweets.asiansTweets
    
    let proceedButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "play"), for: .normal)
        button.addTarget(self, action: #selector(handleProceed), for: .touchUpInside)
        button.tintColor = .white
        button.showsTouchWhenHighlighted = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func handleProceed() {
        let nav = self.presentingViewController as! UINavigationController
        self.dismiss(animated: true) {
            nav.pushViewController(FinalViewController(), animated: true)
        }
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let informationLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.font = UIFont(name: "Ancient-Medium", size: 24)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let promptLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.numberOfLines = 0
        label.font = UIFont(name: "Ancient-Medium", size: 24)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Here are some tweets about\n—————people who look like you—————"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let tweetsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    } ()
    
    let tweetsReuseIdentifier = "tweetsReuseIdentifier"
    
    func setupTableView() {
        tweetsTableView.register(TweetsTableViewCell.self, forCellReuseIdentifier: tweetsReuseIdentifier)
        tweetsTableView.dataSource = self
        tweetsTableView.delegate = self
        view.addSubview(tweetsTableView)
    }
    
    func setupViews() {
        view.backgroundColor = UIColor.init(patternImage: UIImage(named: "background2")!)
        informationLabel.text =
        """
        Estimated Age: \(self.person?.age ?? 10)
        Gender: \(self.person?.gender.gender ?? "Male")
        Ethniciy: \(self.person?.ethnicity.ethnicity ?? "Asian")
        Attractiveness: \(self.person?.attractiveness ?? 10.000)
        """
        view.addSubview(informationLabel)
        view.addSubview(imageView)
        view.addSubview(promptLabel)
        view.addSubview(proceedButton)
    }
    
    func setupConstraints() {
        imageView.makeConstraints(top: view.topAnchor, left: view.leftAnchor, right: nil, bottom: nil, topMargin: 5, leftMargin: 5, rightMargin: 0, bottomMargin: 0, width: 125, height: 200)
        informationLabel.makeConstraints(top: view.topAnchor, left: imageView.rightAnchor, right: view.rightAnchor, bottom: imageView.bottomAnchor, topMargin: 5, leftMargin: 5, rightMargin: 5, bottomMargin: 5, width: 0, height: 0)
        promptLabel.makeConstraints(top: imageView.bottomAnchor, left: nil, right: nil, bottom: nil, topMargin: 5, leftMargin: 0, rightMargin: 0, bottomMargin: 0, width: 0, height: 0)
        promptLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        tweetsTableView.makeConstraints(top: promptLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, topMargin: 5, leftMargin: 5, rightMargin: 5, bottomMargin: 5, width: 0, height: 0)
        
        proceedButton.makeConstraints(top: view.safeAreaLayoutGuide.topAnchor, left: nil, right: view.rightAnchor, bottom: nil, topMargin: 20, leftMargin: 0, rightMargin: 20, bottomMargin: 0, width: 20, height: 20)
    }
    
//    func setupConstraints() {
//
//        promptLabel.makeConstraints(top: view.topAnchor, left: nil, right: nil, bottom: nil, topMargin: 5, leftMargin: 0, rightMargin: 0, bottomMargin: 0, width: 0, height: 0)
//        promptLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//
//        tweetsTableView.makeConstraints(top: promptLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: imageView.topAnchor, topMargin: 5, leftMargin: 5, rightMargin: 5, bottomMargin: 5, width: 0, height: 0)
//
//        imageView.makeConstraints(top: nil, left: view.leftAnchor, right: nil, bottom: view.bottomAnchor, topMargin: 0, leftMargin: 5, rightMargin: 0, bottomMargin: 5, width: 125, height: 200)
//
//        informationLabel.makeConstraints(top: nil, left: imageView.rightAnchor, right: view.rightAnchor, bottom: nil, topMargin: 0, leftMargin: 5, rightMargin: 5, bottomMargin: 0, width: 0, height: 0)
//
//        informationLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
//    }
    
    init(image: UIImage, people: [Person]) {
        self.image = image
        if people.count != 0 {
            self.person = people[0]
        }
        self.imageView.image = self.image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTableView()
        setupConstraints()
    }
}

extension BlackHouseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tweets.count
    }
}

extension BlackHouseViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tweetsReuseIdentifier, for: indexPath) as! TweetsTableViewCell
        let tweet = tweets[indexPath.section]
        cell.configure(with: tweet)
        cell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        cell.layer.cornerRadius = 5
        cell.clipsToBounds = true
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
     
    
}
