//
//  ShowDetailsViewModel.swift
//  PopularShows
//
//  Created by wafaa farrag on 24/12/2021.
//

import Foundation
import RxCocoa
import RxSwift

class ShowDetailsViewModel : BaseViewModel {
    
    var showDetails = BehaviorRelay<Show>(value: Show(id: 0, url: "", name: "", type: TypeEnum.animation, language: Language.english, genres: [], status: Status.ended, runtime: nil, averageRuntime: 0, premiered: "", ended: "", officialSite: nil, schedule: Schedule.init(time: "", days: []), rating: Rating(average: nil), weight: 0, network: nil, webChannel: nil, dvdCountry: nil, externals: Externals.init(tvrage: nil, thetvdb: nil, imdb: nil), image: nil, summary: "", updated: 0, links: Links.init(linksSelf: Previousepisode(href: ""), previousepisode: Previousepisode(href: ""))))
    
}
