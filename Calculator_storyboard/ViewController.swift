//
//  ViewController.swift
//  Calculator_storyboard
//
//  Created by 임혜정 on 6/25/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var 버튼들: [UIButton]!
    @IBOutlet weak var 표시창: UILabel!
    
    private var 입력된정수: Int?
    private var 현재연산자: 연산자?
    private var 새로운입력 = true
    private var 결과값: Int?
    private var 계산완료: Bool = true
    private var 현재식 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        인터페이스스타일()
    }
    
    @IBAction func 버튼눌림(_ 발신: UIButton) {
        if let 연산 = 연산자(rawValue: 발신.tag) {
            연산자처리(연산)
        } else {
            숫자입력(발신.tag)
        }
    }
    
    func 숫자입력(_ 숫자: Int) {
        if 새로운입력 {
            표시창.text = "\(숫자)"
            현재식 += "\(숫자)"
            새로운입력 = false
        } else {
            표시창.text? += "\(숫자)"
            현재식 += "\(숫자)"
        }
    }
    
    private func 연산자처리(_ 연산: 연산자) {
        switch 연산 {
        case .더하기, .빼기, .곱하기, .나누기:
            현재식 += 연산.연산기호
            새로운입력 = true
        case .는:
            guard !현재식.isEmpty else { return }
            let expression = NSExpression(format: 현재식)
            if let result = expression.expressionValue(with: nil, context: nil) as? NSNumber {
                let intResult = Int(round(result.doubleValue))
                표시창.text = "\(intResult)"
                현재식 = "\(intResult)"
            } else {
                표시창.text = "Error"
                현재식 = ""
            }
            새로운입력 = true
        case .초기화:
            초기화()
        }
    }
    
    private func 초기화() {
        표시창.text = "0"
        입력된정수 = nil
        현재연산자 = nil
        결과값 = nil
        새로운입력 = true
        현재식 = ""
    }
}

enum 연산자: Int {
    case 더하기 = 100
    case 빼기 = 101
    case 곱하기 = 102
    case 나누기 = 103
    case 는 = 104
    case 초기화 = 105
    
    var 연산기호: String {
        switch self {
        case .더하기: return "+"
        case .빼기: return "-"
        case .곱하기: return "*"
        case .나누기: return "/"
        case .는: return "="
        case .초기화: return "AC"
        }
    }
    func 연산수행(_ 첫번째: Int, _ 두번째: Int) -> Int {
        switch self {
        case .더하기: return 첫번째 + 두번째
        case .빼기: return 첫번째 - 두번째
        case .곱하기: return 첫번째 * 두번째
        case .나누기: return 첫번째 / 두번째
        default: return 0
        }
    }
}

extension ViewController {
    private func 인터페이스스타일() {
        view.backgroundColor = .black
        버튼들.forEach {
            $0.frame.size = CGSize(width: 80, height: 80)
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 40
        }
        표시창.text = "0"
    }
    
}
