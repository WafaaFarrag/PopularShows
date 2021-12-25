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
            let showsFromResponse = welcomeArray.compactMap {welcome in
                welcome.show
            }
            self?.shows.accept(showsFromResponse)
        }, onError: { [weak self] error in
            print(error)
            self?.message.accept((error.localizedDescription , .error))
        }).disposed(by: disposeBag)
        
    }
}

