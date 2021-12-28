//
//  LottoViewController.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/28.
//

import UIKit

class LottoViewController: UIViewController {
    
    //MARK: Properties
    let viewModel = LottoViewModel()
    
    
    //MARK: UI
    let label1 = UILabel()
    let label2 = UILabel()
    let label3 = UILabel()
    let label4 = UILabel()
    let label5 = UILabel()
    let label6 = UILabel()
    let label7 = UILabel()
    let dateLabel = UILabel()
    let moneyLabel = UILabel()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.backgroundColor = .white
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    //MARK: Method
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.lotto1.bind { (number) in
            self.label1.text = "\(number)"
        }
        
        viewModel.lotto2.bind { (number) in
            self.label2.text = "\(number)"
        }
        
        viewModel.lotto3.bind { (number) in
            self.label3.text = "\(number)"
        }
        
        viewModel.lotto4.bind { (number) in
            self.label4.text = "\(number)"
        }
        
        viewModel.lotto5.bind { (number) in
            self.label5.text = "\(number)"
        }
        
        viewModel.lotto6.bind { (number) in
            self.label6.text = "\(number)"
        }
        
        viewModel.lotto7.bind { (number) in
            self.label7.text = "\(number)"
        }
        
        viewModel.lottoMoney.bind { string in
            self.moneyLabel.text = string
        }
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.viewModel.fetchLottoInfo(555)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) { [weak self] in
            self?.viewModel.fetchLottoInfo(777)
        }
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
            make.center.equalToSuperview()
        }
        
        [label1, label2, label3, label4, label5, label6, label7].forEach {
            $0.backgroundColor = .lightGray
            stackView.addArrangedSubview($0)
        }
        
        view.addSubview(dateLabel)
        dateLabel.backgroundColor = .white
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        
        view.addSubview(moneyLabel)
        moneyLabel.backgroundColor = .white
        moneyLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
    }
}
