//
//  CustomSegmentedControl.swift
//  Prototype
//
//  Created by Мисников Роман on 26/01/2019.
//  Copyright © 2019 MisnikovRoman. All rights reserved.
//

import UIKit

protocol CustomSegmentedControlTapDelegate: AnyObject {
	func didSelectItem(index: Int)
}

class CustomSegmentedControl: UIView {

	// basic
	private(set) var selectedItemIndex: Int = 0
	// sizes
	var highlighterHeight: CGFloat = 10 {
		willSet { highlighterHeightConstraint.constant = newValue }
	}
	var textHeight: Int = 12 {
		willSet {
			buttons.forEach {
				$0.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(newValue))
			}
		}
	}
	// colors
	var buttonsBackgroundColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) {
		willSet { buttons.forEach { $0.backgroundColor = newValue } }
	}
	var highlighterColor: UIColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1) {
		willSet { highlighter.backgroundColor = newValue }
	}
	var textColor: UIColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) {
		willSet { buttons.forEach { $0.setTitleColor(newValue, for: .normal) } }
	}

	// delegate
	weak var delegate: CustomSegmentedControlTapDelegate?

	private var shouldSetupConstraints = true
	private var container: UIStackView
	private var buttons: [UIButton]
	private var highlighter: UIView
	private var highlighterPositionConstraint: NSLayoutConstraint!
	private var highlighterHeightConstraint: NSLayoutConstraint!

	init(titles: [String]) {
		// create views
		let buttons: [UIButton] = titles.map {
			let btn = UIButton()
			btn.setTitle($0, for: .normal)
			btn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
			return btn
		}
		let highlighter: UIView = {
			let view = UIView()
			view.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
			return view
		}()
		let container: UIStackView = {
			let stack = UIStackView(arrangedSubviews: buttons)
			stack.axis = .horizontal
			stack.distribution = .fillEqually
			return stack
		}()

		self.highlighterHeightConstraint = NSLayoutConstraint (
			item: highlighter,
			attribute: .height,
			relatedBy: .equal,
			toItem: nil,
			attribute: .notAnAttribute,
			multiplier: 1.0,
			constant: 20
		)

		// add to self properties
		self.buttons = buttons
		self.highlighter = highlighter
		self.container = container

		// init from super class
		super.init(frame: .zero)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func updateConstraints() {
		if(shouldSetupConstraints) {
			initialSetup()
			shouldSetupConstraints = false
		}
		super.updateConstraints()
	}

	private func initialSetup() {
		setupContainerConstraints()
		setupHighlighterConstaints()
		setupHandlers()
	}

	func changeSelectedItem(to newIndex: Int) {
		selectedItemIndex = newIndex
		moveHighlighter(to: newIndex)
	}

	private func setupContainerConstraints() {
		self.addSubview(container)

		container
			.snap(inside: self, from: .top, at: 0)
			.snap(inside: self, from: .left, at: 0)
			.snap(inside: self, from: .right, at: 0)
	}

	private func setupHighlighterConstaints() {
		self.addSubview(highlighter)

		highlighter
			.snap(inside: self, from: .bottom, at: 0)
			.snap(to: container, from: .bottom, at: 0)
			.setEqual(.width, to: buttons[0])

		highlighterPositionConstraint = NSLayoutConstraint (
			item: highlighter,
			attribute: .leading,
			relatedBy: .equal,
			toItem: self,
			attribute: .leading,
			multiplier: 1.0,
			constant: 0
		)

		highlighterPositionConstraint.isActive = true
		highlighterHeightConstraint.isActive = true

	}

	private func moveHighlighter(to position: Int) {
		selectedItemIndex = position

		delegate?.didSelectItem(index: position)

		let containerWidth = container.bounds.width
		let buttonWidth = containerWidth / CGFloat(buttons.count)
		let moveDistance = buttonWidth / 2 + CGFloat(position) * buttonWidth - highlighter.bounds.width / 2

		UIView.animate(withDuration: 0.2) {
			self.highlighterPositionConstraint.constant = moveDistance
			self.layoutIfNeeded()
		}
	}

	private func setupHandlers() {
		buttons.forEach { $0.addTarget(self, action: #selector(tap(_:)), for: .touchUpInside) }
	}

	@objc private func tap(_ sender: UIButton) {
		guard let index = buttons.firstIndex(of: sender) else { return }
		moveHighlighter(to: index)
	}

}
