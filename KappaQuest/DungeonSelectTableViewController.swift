// 迷宮選択
import UIKit
class DungeonSelectTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    // model からダンジョン情報を取得するようにする
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        if indexPath.row == 0 {
            cell.textLabel!.text = "カッパの洞窟"
        } else {
            cell.textLabel!.text = "???"
        }
 
        
        return cell
    }
    
}
