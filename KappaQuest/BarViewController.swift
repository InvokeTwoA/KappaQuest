// 酒場
// 冒険者の登録・削除・編集が可能となる
import UIKit
class BarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var _characterTableView: UITableView!

    var _characters : Array<CharacterModel> = Array<CharacterModel>()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "冒険者の酒場"
        _characterTableView.delegate = self
        _characterTableView.dataSource = self
        
        print("bar did load")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        _characterTableView.reloadData()
    }
    
    func selectCharacterData(){
        print("let's select chara data")
        // characters テーブルがなければ作成
        let character = CharacterModel()
        character.createTable()

        // キャラクタデータを取得
        _characters = character.selectAllData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
    // 画面遷移
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        self.navigationItem.title = nil
    }
    
    /* 以下、テーブルの設定 */
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if(editingStyle == UITableViewCellEditingStyle.Delete){
            _characterTableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectCharacterData()
        print("chara count = \(_characters.count)")
        return _characters.count
    }
    
    // cell に関するデータソースメソッド
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->
        UITableViewCell{
            let cell: CharacterCell = tableView.dequeueReusableCellWithIdentifier("characterCell", forIndexPath: indexPath) as! CharacterCell
            let character = _characters[indexPath.row]
            cell.setCell(character)
            return cell
    }
    
    // テーブルをタップしたらステータス画面へ遷移
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let character = _characters[indexPath.row]
        let user_id = character.user_id

        let nextViewController = self.storyboard!.instantiateViewControllerWithIdentifier("StatusTableViewController") as! StatusTableViewController
        nextViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        nextViewController._user_id = user_id
        self.navigationItem.title = nil
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}

