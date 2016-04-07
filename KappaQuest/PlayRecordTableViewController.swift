// 冒険の記録（実績解除）
import Foundation
// ステータス画面
import Foundation
import UIKit

class PlayRecordTableViewController: UITableViewController {
    var _play_record : PlayRecordModel = PlayRecordModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "冒険の記録"
        _play_record.selectAllData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        print("sectino header 変更")
        if (section == 0){
            return "冒険回数：\(_play_record._quest_count)回"
        } else {
            return "カッパ"
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        return cell
    }
    
    // テーブルの行をタップした時の処理
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.section == 1) {
        } else if (indexPath.section == 2) {
        }
    }
}

