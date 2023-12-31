//
//   SlideExample.swift
//  StudyDiary
//
//  Created by 임재혁 on 2023/06/24.
//

import UIKit
import WebKit

class SlideExample: UIViewController{
    
    private lazy var doubleSlider: DoubleSlide = {
        let vc = DoubleSlide(rootVC: self, contentView: DashBoardView())
        return vc
    }()
    
    private lazy var titleSlide: TitleSlide = {
        let vc = TitleSlide(contentView: UIView(frame: .zero), titleText: "타이틀")
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        doubleSlider.setDoubleSlide()
    }
    
    // 버튼 생성 해야합니다.
    @IBAction func doubleBtnAction(_ sender: Any) {
        doubleSlider.openDoubleSlide()
    }
    
    @IBAction func titleBtnAction(_ sender: Any) {
        titleSlide.present(self, animated: true) {
            print("done")
        }
    }
    
}

public class DashBoardView: UIView, WKScriptMessageHandler{
    
    var webView: WKWebView!
    
    public override init(frame: CGRect){
        super.init(frame: .zero)
        
        setWKView()
        loadWebPage("http://192.168.45.39:3000/Ticket")
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setWKView(){
        let controller = WKUserContentController()
        controller.add(self, name: "LimBridge")
        
        let config = WKWebViewConfiguration()
        config.userContentController = controller
        
        webView = WKWebView(frame: .zero, configuration: config)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(webView)
        
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: self.topAnchor),
            webView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        
    }
    
    private func loadWebPage(_ loadUrl: String){
        guard let myUrl = URL(string: loadUrl) else {
            return
        }
        let request = URLRequest(url: myUrl)
        
        DispatchQueue.main.async {
            self.webView?.load(request)
        }
        
    }
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("dddd")
        
    }

    
}
