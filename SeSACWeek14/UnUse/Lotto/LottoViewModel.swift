//
//  LottoViewModel.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/28.
//

import Foundation

class LottoViewModel {
    
    var lotto1 = Observable(3)
    var lotto2 = Observable(10)
    var lotto3 = Observable(33)
    var lotto4 = Observable(23)
    var lotto5 = Observable(12)
    var lotto6 = Observable(11)
    var lotto7 = Observable(44)
    var lottoMoney = Observable("")
    
    
    
    func fetchLottoInfo(_ number: Int) {
        
        APIService.fetchLotto(number: number) { [weak self](lottoData, error) in
            guard error == nil else {
                return
            }
            
            guard let lottoData = lottoData else {
                return
            }
            
            guard let self = self else { return }
            self.lotto1.value = lottoData.drwtNo1
            self.lotto2.value = lottoData.drwtNo2
            self.lotto3.value = lottoData.drwtNo3
            self.lotto4.value = lottoData.drwtNo4
            self.lotto5.value = lottoData.drwtNo5
            self.lotto6.value = lottoData.drwtNo6
            self.lotto7.value = lottoData.bnusNo
            self.lottoMoney.value = self.format(for: lottoData.firstWinamnt)
        }
    }
    
    func format(for number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let result = formatter.string(for: number)!
        return result
    }
    
}
