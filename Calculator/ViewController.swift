import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var indicator: UILabel!
    @IBOutlet weak var list: UITextView!
    
    var num2: Bool = false
    var number1: String = ""
    var number2: String = ""
    var queue: [String] = [String]()
    
    let grey: UIColor! = UIColor.init(white: 255, alpha: 0.79)
    let green: UIColor! = UIColor.init(red: 0, green: 0.53, blue: 0.28, alpha: 1.0)
    let red: UIColor! = UIColor.init(red: 0.98, green: 0.28, blue: 0.29, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reset()
    }
    
    func reset() {
        display.text = ""
        list.text = ""
        
        queue = [String]()
        
        indicator.text = "\\"
        indicator.backgroundColor = grey
    }
    
    func changeColor(num: String!) {
        let number: Int! = Int(num)
        if(number < 0) {
            indicator.text = "N"
            indicator.backgroundColor = red
            return
        }
        indicator.text = "P"
        indicator.backgroundColor = green
    }
    
    func result(num: String!) {
        display.text = num
        changeColor(num: num)
    }
    
    func push(str: String!) {
        if(queue.count == 10) {
            for i in 1...9 {
                queue[i-1] = queue[i]
            }
            queue[9] = str
            return
        }
        queue.append(str)
    }
    
    @IBAction func numeric(_ sender: UIButton) {
        let current: String! = sender.currentTitle!
        if(!num2) {
            number1 = number1 + current
            result(num: number1)
            return
        }
        number2 = number2 + current
        result(num: number2)
    }
    
    @IBAction func operation(_ sender: UIButton) {
        if(!num2) {
            return
        } else if(number1.isEmpty || number2.isEmpty) {
            return
        }
        var res1: Int!
        let n1: Int! = Int(number1)
        let n2: Int! = Int(number2)
        let op: String = sender.currentTitle!
        switch op {
            case "+":
                res1 = n1 + n2
                break
            case "-":
                res1 = n1 - n2
                break
            case "x":
                res1 = n1 * n2
                break
            case "%":
                res1 = n1 / n2
                break
            default:break
        }
        let res2: String = String(res1)
        result(num: res2)
        
        push(str: "\(op) \(number2)")
        var temp: String = ""
        for s in queue {
            temp += "\(s) (>) "
        }
        list.text = temp
        
        number1 = res2
        number2 = ""
    }
    
    @IBAction func enter(_ sender: Any) {
        if(!num2 && !number1.isEmpty) {
            num2 = true
            display.text = ""
        }
    }
    
    @IBAction func clear(_ sender: Any) {
        reset()
    }
}
