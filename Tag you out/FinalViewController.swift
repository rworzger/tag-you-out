//
//  FinalViewController.swift
//  Tag you out
//
//  Created by Ruizhe Wang on 11/08/2021.
//

import UIKit

class FinalViewController: UIViewController {

    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .clear
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 32)
        label.numberOfLines = 0
        label.textColor = .white
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = """
            Hey there,

            The Content is Not Targeting at You. You are not what they said.

            However, people worldwide who share the same features as you are now experiencing the silent suffering of the hurtful comments you read. The United Nation reports 1/3 of young adults have been exposed to some sort of cyberviolence — harassment,  threat, insults, and hate speech targeting at the individuals' identity or certain traits.

            #Rethink Before You Type #Share you kindness. #Stop Cyberviolence

            Tag You Out

            

            嘿，

            内容并非针对您。你不是他们说的那样。

            但是，全世界与您具有相同特征的人已经收到了那些来自他人尖锐的攻击。联合国报告称，1/3 的年轻人遭受过某种网络暴力——针对个人身份或某些特征的骚扰、威胁、侮辱和仇恨言论。

            #三思而后行 #分享你的善意 #停止网络暴力

            Tag You Out
            """
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background3")!)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(textLabel)
    }
    
    func setupConstraints() {
//        textLabel.makeConstraints(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, topMargin: 30, leftMargin: 10, rightMargin: 10, bottomMargin: 30, width: 0, height: 0)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            textLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            textLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10)
        ])
    }
}
