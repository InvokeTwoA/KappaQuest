// 探検画面
import Foundation
import UIKit

class QuestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var _doorTableView: UITableView!
    @IBOutlet weak var _textLabel: UILabel!
    
    let cellIdentifier : String = "battleTextCell"
    var _quest = QuestModel()
    
    // 戻る系を押したときに出てくる選択肢リスト
    var _back_choiceList : Array<QuestModel.door> = Array<QuestModel.door>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ランダムな選択肢を用意
        _quest.setRandomChoice()
        
        _doorTableView.dataSource = self
        _doorTableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        _doorTableView.reloadData();
    }
    
    // UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _quest._choiceList.count
    }
    
    // cell に関するデータソースメソッド
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->
        UITableViewCell{
            let cell: DoorCell = tableView.dequeueReusableCellWithIdentifier("DoorCell", forIndexPath: indexPath) as! DoorCell
            cell.setCell(_quest._choiceList[indexPath.row])
            return cell
    }
    
    // テーブルをタップされた時の処理
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let choice = _quest._choiceList[indexPath.row]
        _textLabel.text = QuestModel.getText(choice.key)
        
        // back_save_flag
        // back に戻る flag
        
        switch(choice.key) {
        case "up":
            _back_choiceList = _quest._choiceList
            _quest.setNewChoice(choice.key)
            _doorTableView.reloadData()
        case "escape_door":
            _back_choiceList = _quest._choiceList
            _quest.setNewChoice(choice.key)
            _doorTableView.reloadData()
        case "back":
            _quest._choiceList = _back_choiceList
            _doorTableView.reloadData()
        case "goEscape":
            self.dismissViewControllerAnimated(true, completion: nil)
        default:
            _quest.setNewChoice(choice.key)
            _doorTableView.reloadData()
            break
        }
    }    
}

