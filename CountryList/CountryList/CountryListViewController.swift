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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy private var refreshControl = UIRefreshControl()
    
    private var activityIndicator: UIActivityIndicatorView?
    private var viewModel: CountryListViewModelProtocol! {
        didSet {
            viewModel.fetchCountryList() { [weak self] in
                self?.tableView.reloadData()
                self?.activityIndicator?.stopAnimating()
            }
        }
    }
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CountryListViewModel()
        view.addSubview(tableView)
        title = "Countries"
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        
        activityIndicator = showActivityIndicator(in: view)
    }
    
    // MARK: - Private methods
    
    private func showActivityIndicator(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true

        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
    
    @objc private func refreshTable() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
                let maximumOffset = tableView.contentSize.height - scrollView.frame.size.height
                let deltaOffset = maximumOffset - currentOffset
                
        if deltaOffset <= 0 {
            if viewModel.url != "" {
                viewModel.fetchCountryList() { [weak self] in
                    self?.tableView.reloadData()
                    self?.activityIndicator?.stopAnimating()
                }
            }
            print("refresh")
        }
    }
}

// MARK: - TableViewDataSourse

extension CountryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.numberOfRows())
        return viewModel.numberOfRows()
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
