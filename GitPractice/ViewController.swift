//
//  ViewController.swift
//  GitPractice
//
//  Created by tobihige on 2023/12/26.
//

import UIKit

class ViewController: UIViewController {
    
    private var fruits = ["orange", "melon", "banana"]
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        
        return tableView
    }()
    
    private var githubModels = [GithubModel]()
    
    private let githubAPI = GithubAPI.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigationController()
        githubAPI.get(searchWord: "sample"){
            [weak self] result in
            switch result {
            case let .success(models):
                DispatchQueue.main.async {
                    self?.githubModels = models
                    self?.tableView.reloadData()
                }
            case let .failure(error):
                print(error)
                break
            }
        }
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureNavigationController() {
        let rightButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonTapped))
        navigationItem.rightBarButtonItem = rightButton
        navigationItem.title = "Title"
    }
    
    @objc private func nextButtonTapped() {
        print("tapped")
    }
    
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return githubModels.count
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell else { fatalError() }
        
        cell.configure(githubModel: githubModels[indexPath.row])
        return cell
        
    }
}
