//
//  ViewController.swift
//  Calculator2
//
//  Created by Dima  on 13.06.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var holder: UIView!
   
    var firstNumber = 0
    var resultNumber = 0
    var currentOperations: Operation?
    
    enum Operation {
        case add, subtract, multiply, divide, procent
    }
    
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: "Helvetica", size: 80)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupNumberPad()
        
    }
    

    private func setupNumberPad() {
        let buttonSize: CGFloat = view.frame.size.width / 4
        
        
        
        let zeroButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height-buttonSize, width: buttonSize*3, height: buttonSize))
        zeroButton.setTitleColor(.black, for: .normal)
        zeroButton.backgroundColor = .white
        zeroButton.setTitle("0", for: .normal)
        zeroButton.layer.cornerRadius = 0.4 * zeroButton.frame.size.height
        zeroButton.layer.borderWidth = 5.0
        zeroButton.layer.borderColor = UIColor.white.cgColor
        zeroButton.titleLabel?.font = UIFont(name: "Helvetica", size: 35)
        zeroButton.tag = 1
        zeroButton.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        holder.addSubview(zeroButton)
        
        /*let dotButton = UIButton(frame: CGRect(x: holder.frame.size.width-(buttonSize*2), y: holder.frame.size.height-buttonSize, width: buttonSize, height: buttonSize))
        dotButton.setTitleColor(.black, for: .normal)
        dotButton.backgroundColor = .white
        dotButton.setTitle(".", for: .normal)
        dotButton.layer.cornerRadius = 0.4 * dotButton.frame.size.height
        dotButton.layer.borderWidth = 5.0
        dotButton.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        holder.addSubview(dotButton)*/
        
        
        for x in 0..<3 {
            let button1 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-(buttonSize*2), width: buttonSize, height: buttonSize))
            button1.setTitleColor(.black, for: .normal)
            button1.backgroundColor = .white
            button1.setTitle("\(x+1)", for: .normal)
            button1.layer.cornerRadius = 0.4 * button1.frame.size.height
            button1.layer.borderWidth = 5.0
            button1.titleLabel?.font = UIFont(name: "Helvetica", size: 35)
            button1.tag = x + 2
            button1.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(button1)
        }
        
        for x in 0..<3 {
            let button2 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-(buttonSize*3), width: buttonSize, height: buttonSize))
            button2.setTitleColor(.black, for: .normal)
            button2.backgroundColor = .white
            button2.setTitle("\(x+4)", for: .normal)
            button2.layer.cornerRadius = 0.4 * button2.frame.size.height
            button2.layer.borderWidth = 5.0
            button2.titleLabel?.font = UIFont(name: "Helvetica", size: 35)
            button2.tag = x + 5
            button2.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(button2)
        }
        
        for x in 0..<3 {
            let button3 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-(buttonSize*4), width: buttonSize, height: buttonSize))
            button3.setTitleColor(.black, for: .normal)
            button3.backgroundColor = .white
            button3.setTitle("\(x+7)", for: .normal)
            button3.layer.cornerRadius = 0.4 * button3.frame.size.height
            button3.layer.borderWidth = 5.0
            button3.titleLabel?.font = UIFont(name: "Helvetica", size: 35)
            button3.tag = x + 8
            button3.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(button3)
        }
        
        
        let acButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height-(buttonSize*5), width: buttonSize * 2, height: buttonSize))
        acButton.setTitleColor(.black, for: .normal)
        acButton.backgroundColor = .orange
        acButton.setTitle("AC", for: .normal)
        acButton.layer.cornerRadius = 0.4 * acButton.frame.size.height
        acButton.layer.borderWidth = 5.0
        acButton.titleLabel?.font = UIFont(name: "Helvetica", size: 35)
        holder.addSubview(acButton)
        
       
        
        let operations = ["=","+","-","*","/","%"]
        
        for x in 0..<6 {
            if x < 5 {
            let button4 = UIButton(frame: CGRect(x: buttonSize * 3, y: holder.frame.size.height-(buttonSize * CGFloat(x + 1)), width: buttonSize, height: buttonSize))
                button4.setTitleColor(.white, for: .normal)
                button4.backgroundColor = .orange
                button4.setTitle(operations[x], for: .normal)
                holder.addSubview(button4)
                button4.layer.cornerRadius = 0.4 * button4.frame.size.height
                button4.layer.borderWidth = 5.0
                button4.tag = x + 1
                button4.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
            }
            else if x == 5 {
                let button4 = UIButton(frame: CGRect(x: holder.frame.size.width-(buttonSize*2), y: holder.frame.size.height-(buttonSize*5), width: buttonSize, height: buttonSize))
                button4.setTitleColor(.black, for: .normal)
                button4.backgroundColor = .orange
                button4.setTitle("%", for: .normal)
                button4.layer.cornerRadius = 0.4 * button4.frame.size.height
                button4.layer.borderWidth = 5.0
                button4.titleLabel?.font = UIFont(name: "Helvetica", size: 35)
                holder.addSubview(button4)
                button4.tag = x + 1
                button4.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
            }
            
        }
       
        
        
        resultLabel.frame = CGRect(x: 20, y: acButton.frame.origin.y - 110.0, width: view.frame.size.width - 40, height: 100)
        holder.addSubview(resultLabel)
        
        
  
        acButton.addTarget(self, action: #selector(clearResult), for: .touchUpInside)
      
    }
    
    
    

    @objc func clearResult() {
        resultLabel.text = "0"
        currentOperations = nil
        firstNumber = 0
    }
    
 
    
    @objc func numberPressed(_ sender: UIButton) {
        let tag = sender.tag - 1
        
        if resultLabel.text == "0" {
            resultLabel.text = "\(tag)"
        }
        else if let text = resultLabel.text {
            resultLabel.text = "\(text)\(tag)"
        }
    }
    
   
    
    @objc func operationPressed(_ sender: UIButton) {
        let tag = sender.tag
        
        if let text = resultLabel.text, let value = Int(text), firstNumber == 0 {
            firstNumber = value
            resultLabel.text = "0"
        }
        
        if tag == 1 {
            if let operation = currentOperations {
                var secondNumber = 0
                if let text = resultLabel.text, let value = Int(text) {
                    secondNumber = value
                }
                
                switch operation {
                case .add:
                    let result = firstNumber + secondNumber
                    resultLabel.text = "\(result)"
                    break
                case .subtract:
                    let result = firstNumber - secondNumber
                    resultLabel.text = "\(result)"
                    break
                case .multiply:
                    let result = firstNumber * secondNumber
                    resultLabel.text = "\(result)"
                    break
                case .divide:
                    let result = Float(firstNumber) / Float(secondNumber)
                    resultLabel.text = "\(result)"
                    break
                case .procent:
                    let result = (Float(firstNumber) / Float(secondNumber)) * 100
                    resultLabel.text = "\(result)"
                    break
                    
                }
            }
        }
        else if tag == 2{
            currentOperations = .add
        }
        else if tag == 3{
            currentOperations = .subtract
        }
        else if tag == 4{
            currentOperations = .multiply
        }
        else if tag == 5{
           currentOperations = .divide
        }
        else if tag == 6{
            currentOperations = .procent
        }
        
    }
    
}


