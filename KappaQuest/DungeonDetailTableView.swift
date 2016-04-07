// 迷宮詳細
import Foundation
import UIKit
class DungeonDetailTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 画面遷移
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        // 戻るを選ばなければ探索回数をインクリメント
        let play_record = PlayRecordModel()
        play_record.increment("quest_count")        
    }
    // テーブルの行をタップした時の処理
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if(indexPath.section == 2) {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
}