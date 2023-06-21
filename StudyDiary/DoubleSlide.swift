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
    
    // constraint
    var contentBottomConstraint: NSLayoutConstraint?
    var sContentBottomConstraint: NSLayoutConstraint?
    
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
    }
    
    public override func didMove(toParent parent: UIViewController?) {
        
        self.view.frame.origin.y = self.view.frame.size.height
        
        view.addSubview(dimmingView)
        view.addSubview(sContentSlide)
        view.addSubview(contentSlide)
        
        
        setDimmingView()
        setContentView()
        setSubContentView()
    }
    
    public func setDoubleSlide(){
        self.rootViewController.addChild(self)
        self.didMove(toParent: self.rootViewController)
        self.rootViewController.view.addSubview(self.view)
    }
    
    public func openDoubleSlide(){
        self.view.frame.origin.y = 0
        aniContentView(aniTime: 1.0)
        aniSContentView(aniTime: 1.5)
    }
    
    private func setContentView(){
        // contentSlide 설정.
        NSLayoutConstraint.activate([
            contentSlide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentSlide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentSlide.heightAnchor.constraint(equalToConstant: 300),
        ])
        
        contentBottomConstraint = contentSlide.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 300)
        contentBottomConstraint?.isActive = true
        
        
        contentSlide.addSubview(contentView)
        // contentView 설정
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: contentSlide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: contentSlide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: contentSlide.bottomAnchor),
            contentView.topAnchor.constraint(equalTo: contentSlide.topAnchor),
        ])
    }
    
    private func setSubContentView(){
        // subContentSlide 설정.
        NSLayoutConstraint.activate([
            sContentSlide.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            sContentSlide.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            sContentSlide.heightAnchor.constraint(equalToConstant: 150),
            
        ])
        
        sContentBottomConstraint = sContentSlide.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 150)
        sContentBottomConstraint?.isActive = true
        
        
        sContentSlide.addSubview(sContentView)
        // subContentView 설정
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
        
        NSLayoutConstraint.activate([
            dimmingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmingView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Animation
    private func aniContentView(aniTime: TimeInterval){
        UIView.animate(withDuration: aniTime) {
            self.contentBottomConstraint?.isActive = false
            self.contentBottomConstraint = self.contentSlide.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            self.contentBottomConstraint?.isActive = true
            
            // view 새로고침 (필수)
            self.view.layoutIfNeeded()
        }
    }
    
    private func aniSContentView(aniTime: TimeInterval){
        UIView.animate(withDuration: aniTime) {
            self.sContentBottomConstraint?.isActive = false
            self.sContentBottomConstraint = self.sContentSlide.bottomAnchor.constraint(equalTo: self.contentSlide.topAnchor, constant: -10)
            self.sContentBottomConstraint?.isActive = true
            
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func dismissAction(){
        UIView.animate(withDuration: 1.0) {
            self.contentBottomConstraint?.isActive = false
            self.contentBottomConstraint = self.contentSlide.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 300)
            self.contentBottomConstraint?.isActive = true
            
            self.sContentBottomConstraint?.isActive = false
            self.sContentBottomConstraint = self.sContentSlide.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 150)
            self.sContentBottomConstraint?.isActive = true
            
            self.view.layoutIfNeeded()
        }completion: { _ in
            self.view.frame.origin.y = self.view.frame.size.height
        }
    }
    
    
}
