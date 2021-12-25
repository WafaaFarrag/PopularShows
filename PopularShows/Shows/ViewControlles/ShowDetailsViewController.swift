//
//  ShowDetailsViewController.swift
//  PopularShows
//
//  Created by wafaa farrag on 24/12/2021.
//

import UIKit
import Cosmos

class ShowDetailsViewController: BaseViewController<ShowDetailsViewModel> {
    
    @IBOutlet weak var containerStacView: UIStackView!
    @IBOutlet weak var averageRuntimeLabel: UILabel!
    @IBOutlet weak var schadualeLabel: UILabel!
    @IBOutlet weak var summaryTextview: UITextView!
    @IBOutlet weak var networkLabel: UILabel!
    @IBOutlet weak var endedLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var premieredLabel: UILabel!
    @IBOutlet weak var linkTextView: UITextView!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var showImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }
    
    
    func  setupBinding() {
        viewModel.showDetails.subscribe(onNext: { [weak self] show in
            
            if let link =  self?.viewModel.getLink() {
                self?.linkTextView.attributedText = link
            } else {
                self?.removeViewFromInnerStack(tag: 9)
            }
            
            if let runtimeInt = show.runtime {
                self?.runtimeLabel.text = "Runtime: \(String(describing: runtimeInt))"
            } else {
                self?.removeViewFromInnerStack(tag: 3)
            }
            
            if let rating = show.rating.average {
                self?.rateView.rating = Double(rating)
            } else {
                self?.removeViewFromInnerStack(tag: 11)
            }
            
            if let summary = self?.viewModel.getSummary() {
                self?.summaryTextview.attributedText = summary
            } else {
                self?.removeViewFromInnerStack(tag: 10)
            }
            
            if let network = show.network {
                self?.networkLabel.text = "Network: \(network.name) at \(network.country.name)"
            } else {
                self?.removeViewFromInnerStack(tag: 7)
            }
            
            if let schedule = self?.viewModel.getScheduleTime() {
                self?.schadualeLabel.text = schedule
            } else {
                
                self?.removeViewFromInnerStack(tag: 6)
            }
            
            self?.nameLabel.text = show.name
            
            self?.premieredLabel.text = "Premiered: \(show.premiered)"
            
            self?.averageRuntimeLabel.text = "Average runtime: \(String(describing: show.averageRuntime))"
            
            self?.statusLabel.text = "Current status: \(show.status.rawValue)"
            
            self?.endedLabel.text = "Ended at: \(show.ended)"
            
            // must be at the last to remove and make sure that first stack still found during changing in the inner stack.
            if let image = show.image, let url = URL(string: image.medium) {
                self?.showImageView.downloadedFrom(url: url)
            } else {
                self?.containerStacView.arrangedSubviews.first(where: {
                    $0.tag == 1
                })?.removeFromSuperview()
            }
        }).disposed(by: disposeBag)
    }
    
    
    private func removeViewFromInnerStack(tag: Int) {
        let innerStack = containerStacView.arrangedSubviews[1] as! UIStackView
        if let element =  innerStack.arrangedSubviews.first(where: { view in
            view.tag == tag
        }) {
            element.removeFromSuperview()
        }
        
    }
    
}
