//
//  BaseViewModel.swift
//  PopularShows
//
//  Created by wafaa farrag on 24/12/2021.
//

import RxSwift
import RxCocoa

class BaseViewModel {
    
    let disposeBag = DisposeBag()
    
    // used to show long message
    let message = PublishRelay<(String, MessageTheme)>()
    
    // used to show small message
    let liteMessage = PublishRelay<(String, MessageTheme)>()
    
    let isLoadingRequestRelay = PublishRelay<Bool> ()
    
}

// to send message size to swiftMessages
enum MessageSize {
    case lite
    case large
}
