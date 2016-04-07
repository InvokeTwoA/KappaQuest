// ステータス画面
import Foundation
import UIKit

class StatusTableViewController: UITableViewController {
  
    @IBOutlet weak var _name: UILabel!
    @IBOutlet weak var _lv: UILabel!
    @IBOutlet weak var _gender: UILabel!
    
    var _user_id: Int = 0
    var _character : CharacterModel = CharacterModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ステータス"
        _character = CharacterModel().selectData(_user_id)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
    }
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        _name.text = "風の\(_character.job) \(_character.name)"
        _lv.text = "LV \(_character.lv)"
        _gender.text = "性別: \(_character.gender)"
        return cell
    }
    
    // テーブルの行をタップした時の処理
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.section == 1) {
        } else if (indexPath.section == 2) {
            // キャラクターの削除
            confirmDeleteDialog()
        }
    }
    
    // 削除前の確認ダイアログ
    func confirmDeleteDialog(){
        let alertController = UIAlertController(title: "冒険者の解雇", message: "もう二度と会えなくなるが、かまわないだろうか？", preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "解雇する", style: .Default,
            handler: {
                (action:UIAlertAction) -> Void in
                self._character.destroyData()
                self.navigationController?.popViewControllerAnimated(true)
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "考え直す",
            style: UIAlertActionStyle.Cancel,
            handler: nil)
        
        alertController.addAction(defaultAction)
        alertController.addAction(cancelAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
}

