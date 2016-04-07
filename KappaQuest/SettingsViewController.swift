// 設定
import Foundation
import UIKit

class SettingsViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // ここから追加
    override func viewWillAppear(animated: Bool) {
    }
    
    // 遊び方の説明
    @IBAction func tappedExplayingPlayRuleButton(sender: AnyObject) {
        //displayAlert("タイトル", message: "説明文１ \n  説明文２ \n\n 説明文３", okString: "わかった")
    }
    
    /*
    * 画面遷移
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        /*
        if let identifier = segue.identifier {
            switch identifier {
            case  "goKappaStatus" :
                let nextVC: StatusViewController = segue.destinationViewController as! StatusViewController
                nextVC.param = "カッパ"
            case "goOdorikoStatus":
                let nextVC: StatusViewController = segue.destinationViewController as! StatusViewController
                nextVC.param = "踊り子"                
            case "goWizardStatus" :
                let nextVC: StatusViewController = segue.destinationViewController as! StatusViewController
                nextVC.param = "魔法使い"
            default:
                print("identifier=\(identifier). not use")
                break // do nothing
            }
        }
*/
    }
}

