//
//  ShowsViewController.swift
//  PopularShows
//
//  Created by wafaa farrag on 24/12/2021.
//

import UIKit

class ShowsViewController: BaseViewController<ShowViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = ShowViewModel() // TODO
        
        setupView()
        setupBinding()
    }
    
    func setupView() {
        
    }

    
    func  setupBinding() {
        
    }
}
