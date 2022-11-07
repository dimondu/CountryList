//
//  CountryListViewController.swift
//  CountryList
//
//  Created by Дмитрий Дуров on 31.10.2022.
//

import UIKit


final class CountryListViewController: UIViewController {
    
    // MARK: - Private properties
    
    lazy private var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CountryListCell.self, forCellReuseIdentifier: "CountryListCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var activityIndicator: UIActivityIndicatorView?
    private var viewModel: CountryListViewModelProtocol! {
        didSet {
            viewModel.fetchCountryList { [weak self] in
                self?.tableView.reloadData()
                self?.activityIndicator?.stopAnimating()
            }
        }
    }
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CountryListViewModel()
        
        view.backgroundColor = .yellow
        view.addSubview(tableView)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50

     
        title = "Countries"
    }
}

// MARK: - TableViewDataSourse

extension CountryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "CountryListCell", for: indexPath)
                as? CountryListCell
        else {
            return UITableViewCell()
        }
        
        cell.viewModel = viewModel.getCountryListCellViewModel(at: indexPath)
        return cell
    }
}

// MARK: - TableViewDelegate

extension CountryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
