// 名前入力
import UIKit

protocol NameDelegate{
    func inputNameDidFinished(gender: String)
}

class CharacterMakeNameViewController: UITableViewController {
    var delegate: NameDelegate! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "名前の入力"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // テーブルの行をタップした時の処理
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.section == 1) {
        } else if(indexPath.section == 2) {
        } else if (indexPath.section == 3) {
        } else if (indexPath.section == 4) {
        } else if (indexPath.section == 5) {
        }
    }
    
    func inputName(name: String){
        self.delegate.inputNameDidFinished(name)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}