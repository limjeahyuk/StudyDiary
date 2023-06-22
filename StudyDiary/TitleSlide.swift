//
//  TitleSlide.swift
//  StudyDiary
//
//  Created by 임재혁 on 2023/06/23.
//

import UIKit

public class TitleSlide: UIViewController{
    
    private var contentView: UIView
    private var titleText: String!
    
    private var dimmingView: UIView = {
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
    
    private lazy var titleView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.text = titleText
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dismissBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "xmark"), for: .normal)
        btn.tintColor = .systemGray
        btn.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    public init(contentView: UIView, titleText: String) {
        self.contentView = contentView
        self.titleText = titleText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        setDimmingView()
        setContentSlide()
        setTitleView()
    }
    
    private func setDimmingView(){
        dimmingView.alpha = 0.0
        
        view.addSubview(dimmingView)
        
        NSLayoutConstraint.activate([
            dimmingView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)

        ])
        
    }
    
    private func setContentSlide(){
        
        view.addSubview(contentSlide)
        
        NSLayoutConstraint.activate([
            contentSlide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 58),
            contentSlide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentSlide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentSlide.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentSlide.addSubview(titleView)
        contentSlide.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: contentSlide.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: contentSlide.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: contentSlide.trailingAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 60),
            
            contentView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: contentSlide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: contentSlide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: contentSlide.bottomAnchor)
        ])
    }
    
    private func setTitleView(){
        
        titleView.addSubview(titleLabel)
        titleView.addSubview(dismissBtn)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 20),
            
            dismissBtn.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 20),
            dismissBtn.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -20)
        ])
    }
    
    private func dimmingPop(){
        dimmingView.alpha = 1.0
    }
    
    public func present(_ rootVC: UIViewController, animated: Bool, completion: @escaping() -> Void){
        self.modalPresentationStyle = .overFullScreen
        rootVC.present(self, animated: animated) {
            completion()
            self.dimmingPop()
        }
    }
    
    
    
    
    // MARK: - objc func
    @objc func dismissAction(){
        print("dismissAction")
        dismiss(animated: true, completion: nil)
    }
    
}
