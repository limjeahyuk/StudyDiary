//
//  DoubleSlide.swift
//  StudyDiary
//
//  Created by 임재혁 on 2023/06/20.
//

import UIKit

public class DoubleSlide: UIViewController {
    
    private let contentView: UIView
    private let rootViewController: UIViewController
    
    private lazy var dimmingView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var contentSlide: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var sContentSlide: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var sContentView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.image = UIImage(named: "SubContentImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public init(rootVC: UIViewController, contentView: UIView){
        self.rootViewController = rootVC
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setDimmingView()
        setContentView()
        setSubContentView()
    }
    
    private func setContentView(){
        // contentSlide 설정.
        view.addSubview(contentSlide)

        NSLayoutConstraint.activate([
            contentSlide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentSlide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentSlide.heightAnchor.constraint(equalToConstant: 300),
            contentSlide.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // contentView 설정
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentSlide.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: contentSlide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: contentSlide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: contentSlide.bottomAnchor),
            contentView.topAnchor.constraint(equalTo: contentSlide.topAnchor),
        ])
    }
    
    private func setSubContentView(){
        // subContentSlide 설정.
        view.addSubview(sContentSlide)

        NSLayoutConstraint.activate([
            sContentSlide.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            sContentSlide.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            sContentSlide.heightAnchor.constraint(equalToConstant: 150),
            sContentSlide.bottomAnchor.constraint(equalTo: contentSlide.topAnchor, constant: -10)
        ])
        
        // subContentView 설정
        
        sContentSlide.addSubview(sContentView)
        
        NSLayoutConstraint.activate([
            sContentView.leadingAnchor.constraint(equalTo: sContentSlide.leadingAnchor, constant: 10),
            sContentView.trailingAnchor.constraint(equalTo: sContentSlide.trailingAnchor, constant: -10),
            sContentView.bottomAnchor.constraint(equalTo: sContentSlide.bottomAnchor, constant: -10),
            sContentView.topAnchor.constraint(equalTo: sContentSlide.topAnchor, constant: 10),
        ])
    }
    
    
    private func setDimmingView(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissAction))
        dimmingView.addGestureRecognizer(tapGesture)
        view.addSubview(dimmingView)
        
        NSLayoutConstraint.activate([
            dimmingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmingView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func dismissAction(){
        dismiss(animated: true, completion: nil)
    }
    
    
}
