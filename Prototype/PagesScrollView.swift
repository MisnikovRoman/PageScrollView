//
//  PagesScrollView.swift
//  Prototype
//
//  Created by MisnikovRoman on 20/01/2019.
//  Copyright © 2019 MisnikovRoman. All rights reserved.
//

import UIKit

class PagesScrollView: UIScrollView {

	// MARK: - Variables
	private var segmentedControl: UISegmentedControl?
	private var pages: [UIView]
	private var shouldSetupConstraints = true

	// MARK: - Lifecycle methods
	override private init(frame: CGRect) {
		self.pages = []
		super.init(frame: .zero)
	}

	convenience init(pages: [UIView]) {
		self.init(frame: .zero)
		self.pages = pages
		self.propertiesSetup()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func updateConstraints() {
		if(shouldSetupConstraints) {
			self.addPagesToView()
			shouldSetupConstraints = false
		}
		super.updateConstraints()
	}

	// MARK: - Public methods
	public func addSegmentedControl(_ segmentedControl: UISegmentedControl) {
		self.segmentedControl = segmentedControl
	}
	public func goTo(page index: Int) {
		guard index < pages.count else { return }
		self.scrollRectToVisible(pages[index].frame, animated: true)
	}

	// MARK: - Private methods
	private func propertiesSetup() {
		self.isPagingEnabled = true
	}

	private func addPagesToView() {
		pages.forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			self.addSubview($0)
		}

		// margin constraints
		pages.first?.topAnchor
			.constraint(equalTo: self.topAnchor).isActive = true
		pages.first?.bottomAnchor
			.constraint(equalTo: self.bottomAnchor).isActive = true
		pages.first?.leadingAnchor
			.constraint(equalTo: self.leadingAnchor).isActive = true
		pages.last?.trailingAnchor
			.constraint(equalTo: self.trailingAnchor).isActive = true

		// first page size constraints
		pages.first?.widthAnchor
			.constraint(equalTo: self.widthAnchor).isActive = true
		pages.first?.heightAnchor
			.constraint(equalTo: self.heightAnchor).isActive = true

		// grouped constraints
		for (index, page) in pages.enumerated() where index > 0 {
			page.leadingAnchor
				.constraint(equalTo: pages[index - 1].trailingAnchor)
				.isActive = true
			page.topAnchor
				.constraint(equalTo: self.topAnchor)
				.isActive = true
			page.bottomAnchor
				.constraint(equalTo: self.bottomAnchor)
				.isActive = true
			page.widthAnchor
				.constraint(equalTo: self.widthAnchor)
				.isActive = true
			page.heightAnchor
				.constraint(equalTo: self.heightAnchor)
				.isActive = true
		}
	}
}

// MARK: - Control external segmented control
private extension PagesScrollView {
	func setupSegmentedControl() {
		guard let sc = segmentedControl else { return }
	}
}
