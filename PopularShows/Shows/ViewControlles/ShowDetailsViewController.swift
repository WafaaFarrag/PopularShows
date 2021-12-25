//
//  ShowDetailsViewController.swift
//  PopularShows
//
//  Created by wafaa farrag on 24/12/2021.
//

import UIKit
import Cosmos

class ShowDetailsViewController: BaseViewController<ShowDetailsViewModel> {
    
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
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var showImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBinding()
        // Do any additional setup after loading the view.
    }
    
    func setupView() {
        scrollView.contentSize = CGSize(width:view.frame.width, height: view.frame.height+100)
        
    }
    
    func  setupBinding() {
        viewModel.showDetails.subscribe(onNext: { [weak self] show in
            
            if let image = show.image, let url = URL(string: image.original) {
                self?.showImageView.downloadedFrom(url: url)
            }
            
            self?.nameLabel.text = show.name
            
            if let url = URL(string: show.links.linksSelf.href) {
                let attributedString = NSMutableAttributedString(string: "Show link", attributes:[NSAttributedString.Key.link: url])
                self?.linkTextView.attributedText = attributedString
            }
            
            self?.premieredLabel.text = "Premiered: \(show.premiered)"
            
            if let runtimeInt = show.runtime {
                self?.runtimeLabel.text = "Runtime: \(String(describing: runtimeInt))"
            }
            
            self?.averageRuntimeLabel.text = "Average runtime: \(String(describing: show.averageRuntime))"
            
            self?.statusLabel.text = "Current status: \(show.status.rawValue)"
            
            self?.endedLabel.text = "Ended at: \(show.ended)"
            
            if let rating = show.rating.average {
                self?.rateView.rating = Double(rating)
            }
            
            if let htmlData = NSString(string: show.summary).data(using: String.Encoding.utf8.rawValue) {
                let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
                
                let summaryAttributedText = try!  NSAttributedString(data: htmlData, options: options, documentAttributes: nil)
                self?.summaryTextview.attributedText = summaryAttributedText
            }
            if !show.schedule.time.isEmpty , !show.schedule.days.isEmpty {
                var timeShow = "\(show.schedule.time) on "
                for day in show.schedule.days {
                    timeShow.append("\(day) ")
                }
                self?.schadualeLabel.text = timeShow
            }
            if let network = show.network {
                self?.networkLabel.text = "Network: \(network.name) at \(network.country.name)"
            }
        }).disposed(by: disposeBag)
    }
    
    
}
