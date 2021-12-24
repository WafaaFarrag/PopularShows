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
        viewModel = ShowViewModel() // TODO
        viewModel.requestShows()
        setupView()
        setupBinding()
    }
    
    func setupView() {
     registerTableViewCells()
}

    
    func  setupBinding() {
        _ = viewModel.shows.bind(to: tableView.rx.items(cellIdentifier: "showCell")) { ( row, model, cell) in
            (cell as!ViewsTableViewCell).setupCell(show: model)
        }.disposed(by: disposeBag)
    }
    
    
    private func registerTableViewCells() {
        let showCell = UINib(nibName: "ViewsTableViewCell",
                                  bundle: nil)
        tableView.register(showCell, forCellReuseIdentifier: "showCell")
    }
}
