import Foundation
import UIKit
class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // ここから追加
    override func viewWillAppear(animated: Bool) {
    }
    
    func displayAlert(title: String, message: String, okString: String){
        let alert: UIAlertController =
            UIAlertController(title:title,
                message: message,
                preferredStyle: UIAlertControllerStyle.Alert
            )
        let yesAction: UIAlertAction = UIAlertAction(title: okString,
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction) -> Void in
                print("ok")
        })
        alert.addAction(yesAction)
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }
    
}

