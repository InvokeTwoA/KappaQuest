import Foundation
import SpriteKit

class ActinViewController: UIViewController, BattleDelegate {

    @IBOutlet weak var _skView: SKView!
    
    var _scene = BattleScene()
    
    @IBOutlet weak var _hp_bar0: UIProgressView!
    
    @IBAction func _didButtonFighter0Tapped(sender: AnyObject) {
        print("button pushed")
        _scene.divPushedFighter0Button()
    }
    
    @IBAction func _didButtonFighter1Tapped(sender: AnyObject) {
        print("button pushed")
        _scene.divPushedFighter0Button()
    }
    
    @IBOutlet weak var _hpLabel: UILabel!
    
    // なんらかのボタンを押した時の処理
    @IBAction func didHpButtonPushed(sender: AnyObject) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _skView.showsPhysics = true
        _skView.showsFPS = true
        _skView.showsNodeCount = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(animated: Bool) {
        print("size w=\(_skView.bounds.size.width)")
        print("size h=\(_skView.bounds.size.height)")
        
        let skView = _skView
        
//        _scene = BattleScene(size: _skView.bounds.size)
        
//        _scene = BattleScene(size: _skView.frame.size)
        _scene = BattleScene(size: skView.bounds.size)
        
        _scene.size = _skView.frame.size
//        print("size w=\(_scene.bounds.size.width)")
//        print("size h=\(_scene.bounds.size.height)")
        
        
        _scene._battleDelegate = self
//        _scene.scaleMode = .AspectFill
        _scene.scaleMode = .AspectFit
        //_scene.scaleMode = .ResizeFill
        //_scene.scaleMode = .Fill
        _scene.backgroundColor = UIColor.blueColor()
        
//        _skView.presentScene(_scene) // SKView上にsceneを設定
        skView.presentScene(_scene) // SKView上にsceneを設定
    }
    
    // delegate method
    // HP の変化を表示
    func hpChanged(hp: Int) {
        _hpLabel.text = "HP : \(hp)"
        
        _hp_bar0.progress -= 0.1
    }
    
    
}