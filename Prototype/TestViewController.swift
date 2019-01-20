//
//  TestViewController.swift
//  Prototype
//
//  Created by MisnikovRoman on 20/01/2019.
//  Copyright © 2019 MisnikovRoman. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    var testBtn = UIButton()
    
    private let colors: [UIColor] = [ CC.Colors.red,
                                      CC.Colors.blue,
                                      CC.Colors.green,
                                      CC.Colors.orange ]
    private var pagesScrollView: PagesScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupPagesScrollView()
        addTestBtn()
    }
    
    private func addTestBtn() {
        testBtn.setTitle("Test", for: .normal)
        testBtn.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        testBtn.addTarget(self, action: #selector(test(_:)), for: .touchUpInside)
        self.view.addSubview(testBtn)
        testBtn.translatesAutoresizingMaskIntoConstraints = false
        testBtn
            .leadingAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            .isActive = true
        testBtn
            .trailingAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            .isActive = true
        testBtn
            .topAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            .isActive = true
        testBtn
            .heightAnchor
            .constraint(equalToConstant: 30.0)
            .isActive = true
    }
    @objc func test(_ sender: UIButton) {
        self.pagesScrollView.updateConstraints()
        print("ScrollView:", self.pagesScrollView.bounds)
        print("Content:", self.pagesScrollView.contentSize)
    }
    
    private func setupViewController() {
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.title = "116 New Montgomery St."
    }
    
    private func setupPagesScrollView() {
        // create subviews
        let views = colors.map { (color) -> UIView in
            let view = UIView()
            view.backgroundColor = color
            
            let lbl = UILabel()
            lbl.text = "Label"
            lbl.textAlignment = .center
            
            view.addSubview(lbl)
            lbl.translatesAutoresizingMaskIntoConstraints = false
            lbl.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            lbl.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            lbl.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            lbl.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            
            return view
        }
        
        // add scroll view as subview
        self.pagesScrollView = PagesScrollView(pages: views)
        self.view.addSubview(self.pagesScrollView)
        
        // setup constraints
        self.pagesScrollView.translatesAutoresizingMaskIntoConstraints = false
        self.pagesScrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50.0).isActive = true
        self.pagesScrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.pagesScrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.pagesScrollView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    
        // temp
        self.pagesScrollView.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    }
}
