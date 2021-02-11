//
//  ViewController.swift
//  Book Finder
//
//  Created by Sajith Konara on 2021-02-11.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let homeVM = HomeViewModel()
    fileprivate let bag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupObservables()
        setupSearchBar()
    }
    
    private func setupTableView(){
        tableView.register(UINib(nibName: "BookInfoTableViewCell", bundle: .main), forCellReuseIdentifier: UIConstants.Cell.BookInfoTableViewCell.rawValue)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupObservables(){
        homeVM.items.subscribe(onNext: { _ in
            self.tableView.reloadData()
        }).disposed(by: self.bag)
        
        homeVM.error.subscribe(onNext: { (e) in
            if let error = e{
                print(error)
            }
        }).disposed(by: self.bag)
    }
    
    private func setupSearchBar(){
        searchBar.delegate = self
    }
}


extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeVM.numbeOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = homeVM.items.value[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: UIConstants.Cell.BookInfoTableViewCell.rawValue) as! BookInfoTableViewCell
        let vm = BookInfoTableViewCellViewModel(item: item)
        cell.bookInfoTableViewCellVM = vm
        
        if indexPath.row <= homeVM.numbeOfCells - 1{
            homeVM.loadNextPage()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = homeVM.items.value[indexPath.row]
        let infoVM = InfoViewModel()
        infoVM.volumeID.accept(item.id)
        let infoVC = UIHelper.makeViewController(viewControllerName: .InfoVC) as! InfoViewController
        infoVC.infoVM = infoVM
        self.navigationController?.pushViewController(infoVC, animated: true)
    }
    
    

}

extension HomeViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        homeVM.resetSearch()
        searchBar.resignFirstResponder()
        homeVM.searchedQuery.accept(searchBar.text)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
}


