//
//  ShowViewModel.swift
//  PopularShows
//
//  Created by wafaa farrag on 24/12/2021.
//

import Foundation
import RxSwift
import RxCocoa


class ShowViewModel: BaseViewModel {
    
    var shows = BehaviorRelay<[Show]>(value: [])
    
    func requestShows() {
        APICalling().getShows().subscribe(onNext: { [weak self] welcomeArray in
            welcomeArray.compactMap { welcome in
                welcome.show
            }
            //self?.messages.accept(sessionMessages!)
        }, onError: { [weak self] error in
            print(error)
           // self?.errorNotification.accept(true)
        }).disposed(by: disposeBag)
        
    }
}

