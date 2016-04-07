// キャラ新規作成
import Foundation
import UIKit

class CharacterMakeTableViewController: UITableViewController, GenderDelegate, JobDelegate {
    @IBOutlet weak var _genderCellText: UILabel!

    @IBOutlet weak var _jobCell: UITableViewCell!
    
    @IBOutlet weak var _submitCell: UITableViewCell!
    @IBOutlet weak var _jobCellText: UILabel!
    
    var _gender :String = ""
    var _job : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "新しい冒険者の募集"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
 
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.section == 4) {
            completeCharacterMake()
        }
    }
 
    func completeCharacterMake(){
        let character = CharacterModel()
        character.insertData("かっぱ", job: _job, gender: _gender, nickname: "風の")        
        self.navigationController?.popViewControllerAnimated(true)
        
        //self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // 画面遷移
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        if let identifier = segue.identifier {
            switch identifier {
            case  "selectGender" :
                let nextVC: CharacterMakeGenderTableViewController = segue.destinationViewController as! CharacterMakeGenderTableViewController
                nextVC.delegate = self
            case  "selectJob" :
                let nextVC: CharacterMakeJobTableViewController = segue.destinationViewController as! CharacterMakeJobTableViewController
                nextVC.delegate = self
            default:
                print("identifier=\(identifier). not use")
                break // do nothing
            }
        }
        self.navigationItem.title = nil
    }
    
    // 以下、delegateMethod
    // 性別決定後の処理
    func selectGenderDidFinished(gender: String){
        _gender = gender
        _genderCellText.text = gender
        _jobCell.hidden = false
    }
    
    // 職業決定後の処理
    func selectJobDidFinished(job: String){
        print("job= \(job)")
        _job = job
        _jobCellText.text = job
        _submitCell.hidden = false
    }
    
    // 性格決定後の処理
    
    // 名前入力後の処理

}

