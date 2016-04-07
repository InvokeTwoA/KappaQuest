// 職業選択
import UIKit

protocol JobDelegate{
    func selectJobDidFinished(gender: String)
}

class CharacterMakeJobTableViewController: UITableViewController {
    var delegate: JobDelegate! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "職業の選択"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // テーブルの行をタップした時の処理
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.section == 1) {
            jobDialog("騎士")
        } else if(indexPath.section == 2) {
            jobDialog("傭兵")
        } else if (indexPath.section == 3) {
            jobDialog("僧侶")
        } else if (indexPath.section == 4) {
            jobDialog("魔法使い")
        } else if (indexPath.section == 5) {
            jobDialog("盗賊")
        }
    }

    func jobDialog(job : String) {
        let alertController = UIAlertController(title: job, message: JobModel.getExplain(job), preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "決定", style: .Default,
            handler: {
                (action:UIAlertAction) -> Void in
                self.selectJob(job)
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル",
            style: UIAlertActionStyle.Cancel,
            handler:{
                (action:UIAlertAction) -> Void in
                print("キャンセルしました")
        })

        alertController.addAction(defaultAction)
        alertController.addAction(cancelAction)

        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func selectJob(job: String){
        self.delegate.selectJobDidFinished(job)        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}