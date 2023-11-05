//
//  MoviesListViewController.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 02/11/2023.
//

import UIKit

class MoviesListViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var moviesTable: UITableView!
    @IBOutlet weak var headerView: PageHeaderView!
    @IBOutlet weak var searchBar: CustomTextField!

    //MARK: - Properties
    var presenter: MoviesListPresenterProtocol!
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.fetchMovies(query: nil)
    }

    //MARK: - Private Methods
    private func setupUI() {
        setupTable()
        setupHeader()
        setupSearchBar()
    }
    
    private func setupTable() {
        moviesTable.delegate = self
        moviesTable.dataSource = self
    }
    
    private func setupHeader() {
        headerView.title = "Decade Of Movies"
        headerView.hideBack = true
    }
    
    private func setupSearchBar() {
        searchBar.setCustomStyle()
        searchBar.image = UIImage(systemName: "magnifyingglass")
        searchBar.placeHolder = "Search Here"
        searchBar.onChangeText = { [weak self] text in
            guard let self = self else {return}
            print(text)
            self.presenter.fetchMovies(query: text)
        }
    }
}


//MARK: - Protocol Methods
extension MoviesListViewController: MoviesListViewProtocol{
    func startLoading() {
        AppLoading.show()
    }
    
    func finishLoading() {
        AppLoading.hide()
    }
    
    func success() {
        self.moviesTable.reloadData()
    }
    
    func showError(message: String?) {
        AppAlert.showError(message: message ?? "")
    }
    
    func emptyDataFound() {
        //To Do
    }
}


//MARK: - Table View Methods
extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if presenter.isSearchMode {
            return presenter.moviesCategories.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.moviesCategories[section].movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let model = presenter.moviesCategories[indexPath.section].movies?[indexPath.row]
        cell.textLabel?.text = model?.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if presenter.isSearchMode {
            let model = presenter.moviesCategories[section]
            return "Movies of \(model.year ?? 0)"
        } else {
            return nil
        }
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.goToDetails(index: indexPath)
    }
}
