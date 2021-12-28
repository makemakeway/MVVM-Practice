//
//  ActorViewModel.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/28.
//

import Foundation
import UIKit

class ActorViewModel {
    
    var actor: Observable<Actor> = Observable(Actor(page: 0, results: [], totalPages: 0, totalResults: 0))
    
    func fetchActor(_ query: String, _ page: Int) {
        APIService.fetchActor(query, page) { response, error in
            guard let response = response else {
                return
            }
            
            self.actor.value = response
            
        }
    }
    
    
}

extension ActorViewModel {
    var numberOfRows: Int {
        return actor.value.results.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> Result {
        return actor.value.results[indexPath.row]
    }
}
