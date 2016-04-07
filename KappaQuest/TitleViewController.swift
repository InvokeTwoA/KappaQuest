// タイトル
import Foundation
import UIKit
class TitleViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    
    @IBAction func didResetButtonPushed(sender: AnyObject) {
        let alertController = UIAlertController(title: "データのリセット", message: "失われたデータはもう二度と戻らないが、かまわないだろうか？", preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "覚悟の上だ", style: .Default,
            handler: {
                (action:UIAlertAction) -> Void in
                BaseModel().resetAllData()
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "考え直す",
            style: UIAlertActionStyle.Cancel,
            handler: nil)
        alertController.addAction(defaultAction)
        alertController.addAction(cancelAction)
        presentViewController(alertController, animated: true, completion: nil)
            
    
    }
    
}