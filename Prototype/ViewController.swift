//
//  ViewController.swift
//  Prototype
//
//  Created by MisnikovRoman on 20/01/2019.
//  Copyright © 2019 MisnikovRoman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private enum ScrollType {
        case manual (segmentIndex: Int)
        case programm
    }

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var scrollType: ScrollType = .programm
    private let colors: [UIColor] = [.red, .blue, .green]
    private let colorNames = [ "Red", "Blue", "Green" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createScrollViewSubviews(scrollViewSize: scrollView.bounds.size)
        setupSegmentedControl()
    }

    private func createScrollViewSubviews(scrollViewSize superSize: CGSize) {
        // setup delegate
        self.scrollView.delegate = self
        
        // create view pages from color names array
        let views = self.colors.enumerated().map { (number, color) -> UIView in
            let view = UIView(frame: .zero)
            let viewOrigin = CGPoint(x: superSize.width * CGFloat(number), y: 0)
            let viewFrame = CGRect(origin: viewOrigin, size: superSize)
            
            view.frame = viewFrame
            view.backgroundColor = color
            return view
        }
        
        // adding subviews
        views.forEach { self.scrollView.addSubview($0) }
        
        // set content size
        scrollView.contentSize = CGSize(
            width: superSize.width * CGFloat(views.count),
            height: superSize.height
        )
    }

    private func setupSegmentedControl() {
        // add segments
        self.segmentedControl.removeAllSegments()
        colorNames.enumerated().forEach {
            self.segmentedControl.insertSegment(
                withTitle: $0.element,
                at: $0.offset,
                animated: false
            )
        }
        
        // initial select
        self.segmentedControl.selectedSegmentIndex = 0
        
        // add handler
        self.segmentedControl.addTarget(self, action: #selector(segmentedControlTappped(_:)), for: .valueChanged)
    }
    
    @objc
    private func segmentedControlTappped(_ sender: UISegmentedControl) {
        let selectedItemNumber = sender.selectedSegmentIndex
        let pageWidth = self.scrollView.bounds.width
        let pagesCount = colors.count
        
        guard segmentedControl.numberOfSegments == pagesCount,
            scrollView.contentSize.width / pageWidth == CGFloat(pagesCount),
            (0 ..< pagesCount) ~= selectedItemNumber else {
                assertionFailure()
                return
        }
        
        let newContentOrigin = CGPoint(x: CGFloat(selectedItemNumber) * pageWidth, y: 0)
        let rectToDisplay = CGRect(origin: newContentOrigin, size: self.scrollView.bounds.size)
        
        self.scrollView.setContentOffset(newContentOrigin, animated: true)
    }
}

extension ViewController: UIScrollViewDelegate {
    // FOR: switch segmented control after manual scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switch self.scrollType {
        case .manual(let segmentIndex):
            self.segmentedControl.selectedSegmentIndex = segmentIndex
        case .programm:
            return
        }
        self.scrollType = .programm
    }
    
    // FOR: understand if scroll was manual
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x) / Int(self.scrollView.bounds.width)
        self.scrollType = .manual(segmentIndex: index)
    }
}
