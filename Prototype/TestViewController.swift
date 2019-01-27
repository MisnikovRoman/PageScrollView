//
//  TestViewController.swift
//  Prototype
//
//  Created by MisnikovRoman on 20/01/2019.
//  Copyright © 2019 MisnikovRoman. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

	// MARK: - Resources
	private let titles = ["СУПЕРГЕРОИ", "ПРОДУКТЫ", "ГОРОДА"]
	private let colors = [ CC.Colors.red, CC.Colors.blue, CC.Colors.green, CC.Colors.orange ]
	private var superheroNames = ["Человек-паук", "Железный человек", "Капитан Америка", "Черная пантера", "Человек-муравей", "Тор", "Черная вдова", "Оса", "Халк"]
	private var foodNames = ["Бургер", "Блин", "Шаверма", "Ролл", "Пончик", "Чипсы", "Мороженое", "Конфеты", "Лаваш", "Багет", "Пирог", "Пицца", "Суши", "Салат"]
	private var cities = ["Москва", "Санкт-Петербург", "Новосибирск", "Екатеринбург", "Нижний Новгород", "Казань", "Челябинск", "Омск", "Самара", "Ростов-на-Дону", "Уфа", "Красноярск", "Перм", "Воронеж", "Волгоград"]

	// MARK: - UI objects
	private var pagesScrollView: PagesScrollView!
	private var superheroTableView: UITableView!
	private var foodTableView: UITableView!
	private var citiesTableView: UITableView!
	private var segmentedControl: CustomSegmentedControl!
	private var separator: UIView!
	private var testBtn = UIButton()

	// MARK: - VC lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		// Self setup
		setupViewController()
		setupTestBtn()
		setupSegmentedControl()
		setupSeparator()
		setupSuperheroTableView()
		setupFoodTableView()
		setupCitiesTableView()
		setupPagesScrollView()
		// constraints
		createConstraints()
	}

	// MARK: - Setup methods
	private func setupViewController() {
		self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		self.title = "116 New Montgomery St."
	}
	private func setupSuperheroTableView() {
		superheroTableView = UITableView()
		superheroTableView.delegate = self
		superheroTableView.dataSource = self
	}
	private func setupFoodTableView() {
		foodTableView = UITableView()
		foodTableView.delegate = self
		foodTableView.dataSource = self
	}
	private func setupCitiesTableView() {
		citiesTableView = UITableView()
		citiesTableView.delegate = self
		citiesTableView.dataSource = self
	}
	private func setupSegmentedControl() {
		// create
		segmentedControl = CustomSegmentedControl(titles: titles)
		segmentedControl.highlighterHeight = 3
		segmentedControl.textHeight = 14
		segmentedControl.highlighterColor = #colorLiteral(red: 0.7404443622, green: 0.3651067019, blue: 0.316141814, alpha: 1)
		segmentedControl.textColor = #colorLiteral(red: 0.7404443622, green: 0.3651067019, blue: 0.316141814, alpha: 1)
		segmentedControl.delegate = self
		// show
		self.view.addSubview(segmentedControl)
	}
	private func setupPagesScrollView() {
		// create subviews
		var views = Array<UIView>()
		views.append(superheroTableView)
		views.append(foodTableView)
		views.append(citiesTableView)

		// add scroll view as subview
		self.pagesScrollView = PagesScrollView(pages: views)
		self.view.addSubview(self.pagesScrollView)

		// temp
		self.pagesScrollView.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
	}
	private func setupTestBtn() {
		testBtn.setTitle("Test", for: .normal)
		testBtn.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
		testBtn.addTarget(self, action: #selector(test(_:)), for: .touchUpInside)
		self.view.addSubview(testBtn)
	}
	private func setupSeparator() {
		separator = UIView()
		separator.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
		self.view.addSubview(separator)
	}

	private func createConstraints() {
		let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

		testBtn
			.snap(inside: self.view, with: insets, except: [.bottom])
			.setSize(height: 20)
		segmentedControl
			.snap(to: testBtn, from: .bottom, at: 10)
			.snap(inside: self.view, with: insets, except: [.top, .bottom])
			.setSize(height: 50)
		separator
			.snap(to: segmentedControl, from: .bottom, at: 0)
			.snap(inside: self.view, with: insets, except: [.top, .bottom])
			.setSize(height: 1)
		pagesScrollView
			.snap(to: separator, from: .bottom, at: 0)
			.snap(inside: self.view, with: insets, except: [.top, .bottom])
			.setSize(height: 300)
	}

	// MARK: - Handlers
	@objc func test(_ sender: UIButton) {
		// self.pagesScrollView.updateConstraints()
		print("ScrollView:", self.pagesScrollView.bounds)
		print("Content:", self.pagesScrollView.contentSize)
	}
}

extension TestViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if tableView == superheroTableView {
			return superheroNames.count
		} else if tableView == foodTableView {
			return foodNames.count
		} else if tableView == citiesTableView {
			return cities.count
		} else {
			return 0
		}
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if tableView == superheroTableView {
			let cell = UITableViewCell(style: .default, reuseIdentifier: "HeroNameCell")
			cell.textLabel?.text = superheroNames[indexPath.row]
			return cell
		} else if tableView == foodTableView {
			let cell = UITableViewCell(style: .default, reuseIdentifier: "FoodNameCell")
			cell.textLabel?.text = foodNames[indexPath.row]
			return cell
		} else if tableView == citiesTableView {
			let cell = UITableViewCell(style: .default, reuseIdentifier: "CitiesNameCell")
			cell.textLabel?.text = cities[indexPath.row]
			return cell
		} else {
			return UITableViewCell()
		}
	}
}

extension TestViewController: UITableViewDelegate {

}

extension TestViewController: CustomSegmentedControlTapDelegate {
	func didSelectItem(index: Int) {
		pagesScrollView.goTo(page: index)
	}
}
