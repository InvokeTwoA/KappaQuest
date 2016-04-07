// 性別選択
import UIKit

protocol GenderDelegate{
    func selectGenderDidFinished(gender: String)
}

class CharacterMakeGenderTableViewController: UITableViewController {
    var delegate: GenderDelegate! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "性別の選択"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // テーブルの行をタップした時の処理
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.section == 1) {
            selectGender("男性")
        } else if (indexPath.section == 2) {
            selectGender("女性")
        } else if (indexPath.section == 3) {
            selectGender("不明")
        }
    }
    
    func selectGender(gender: String){
        self.delegate.selectGenderDidFinished(gender)
        self.navigationController?.popViewControllerAnimated(true)
    }

}