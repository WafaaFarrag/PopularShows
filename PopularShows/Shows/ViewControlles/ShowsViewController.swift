//
//  ShowsViewController.swift
//  PopularShows
//
//  Created by wafaa farrag on 24/12/2021.
//

import UIKit

class ShowsViewController: BaseViewController<ShowViewModel> {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBinding()
    }
    
   private func setupView() {
        viewModel = ShowViewModel()
        viewModel.requestShows()
        registerTableViewCells()
    }
    
    
   private func  setupBinding() {
        _ = viewModel.shows.bind(to: tableView.rx.items(cellIdentifier: "showCell")) { ( row, model, cell) in
            (cell as!ViewsTableViewCell).setupCell(show: model)
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Show.self).subscribe(onNext: { [weak self] show in
            let showDetailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShowDetailsViewController") as! ShowDetailsViewController
            showDetailsViewController.viewModel = ShowDetailsViewModel()

            showDetailsViewController.viewModel.showDetails.accept(show)
            self?.navigationController?.pushViewController(showDetailsViewController, animated: true)
        }).disposed(by: disposeBag)
        
    }
    
    private func registerTableViewCells() {
        let showCell = UINib(nibName: "ViewsTableViewCell",
                             bundle: nil)
        tableView.register(showCell, forCellReuseIdentifier: "showCell")
    }
}
