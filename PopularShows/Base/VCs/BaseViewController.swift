//
//  BaseViewController.swift
//  PopularShows
//
//  Created by wafaa farrag on 24/12/2021.
//


import UIKit
import  RxCocoa
import  RxSwift
import NVActivityIndicatorView

class BaseViewController <VM: BaseViewModel>: UIViewController {
    
    let disposeBag = DisposeBag()
    let activityIndicator = NVActivityIndicatorView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 25, height: 25))
)
    
    var viewModel: VM! {
        didSet {
            viewModel.message.asSignal().emit(onNext: { messageEvent in
                SwiftMessagesUtils.showMessage(body: messageEvent.0, theme: messageEvent.1)
            }).disposed(by: disposeBag)
            
            viewModel.liteMessage.asSignal().emit(onNext: { messageLiteEvent in
                SwiftMessagesUtils.showMessage(body: messageLiteEvent.0, theme: messageLiteEvent.1, isLiteMessage: true)
            }).disposed(by: disposeBag)
            
            viewModel.isLoadingRequestRelay.asSignal().emit(onNext: { [weak self] indicatorIsAnimating in
                indicatorIsAnimating ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
            }).disposed(by: disposeBag)
        }
    }
}
