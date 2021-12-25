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
    
    func getLink() -> NSMutableAttributedString? {
        if let url = URL(string: showDetails.value.links.linksSelf.href) {
            return NSMutableAttributedString(string: "Show link", attributes:[NSAttributedString.Key.link: url])
        }
        return nil
    }
    
    func getSummary() -> NSAttributedString? {
        if let htmlData = NSString(string: showDetails.value.summary).data(using: String.Encoding.utf8.rawValue) {
            let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
            
            return try?  NSAttributedString(data: htmlData, options: options, documentAttributes: nil)
            
        }
        return nil
    }
    
    func getScheduleTime() -> String? {
        let time = showDetails.value.schedule.time
        let days = showDetails.value.schedule.days
        if time.isEmpty || days.isEmpty {
          return nil
        } else {
            var timeShow = "\(time) on "
            for day in days {
                timeShow.append("\(day) ")
            }
            return timeShow
        }

        
    }
    
    
}
