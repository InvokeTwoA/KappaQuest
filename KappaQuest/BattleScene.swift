// 戦闘シーン
import SpriteKit

let heroCategory:         UInt32 = 0x1 << 0
let enemyCategory:        UInt32 = 0x1 << 1
let worldCategory:        UInt32 = 0x1 << 2
/*
let wallCategory:         UInt32 = 0x1 << 3
let itemCategory:         UInt32 = 0x1 << 4
let fireCategory:         UInt32 = 0x1 << 5
let swordCategory:        UInt32 = 0x1 << 6
let blockCategory:        UInt32 = 0x1 << 7
let magicArmerCategory:   UInt32 = 0x1 << 8
let coinCategory:         UInt32 = 0x1 << 9
let goalCategory:         UInt32 = 0x1 << 10
let downWorldCategory:    UInt32 = 0x1 << 11
let horizonWorldCategory: UInt32 = 0x1 << 12
let leftHorizonWorldCategory: UInt32 = 0x1 << 13
*/

protocol BattleDelegate{
    func hpChanged(hp: Int)
}

class BattleScene : SKScene, SKPhysicsContactDelegate {
    var _battleDelegate: BattleDelegate?
    
    
    var _battle_end_flag : Bool = false
    
    // ボタンを押されたかどうか
    var _didButtonPushed: Bool = false
    
    // 各キャラのステータス
//    var _chara_statuses: [String] = ["rest","rest","rest","rest","rest","rest"]
    
    var _wait_timer : [Int] = [0,0,0,0,0,0]
    
    // 時間管理の変数（１秒ごとに処理できるようにする）
    var _lastUpdateTimeInterval : NSTimeInterval = 0
    var _timeSinceStart : NSTimeInterval = 0
    var _timeSinceLastSecond : NSTimeInterval = 0
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.contactDelegate = self
        setWorld()
        setFighter()
        generateEnemy()
    }
    
    func divPushedFighter0Button(){
        moveFighter()
    }
    func divPushedFighter1Button(){
        moveFighter()
    }
    
    // 画面の周囲に見えない壁を作成
    func setWorld(){
        makeWall(CGPoint(x:CGRectGetMidX(self.frame), y: CGRectGetMinY(self.frame)), size: CGSizeMake(CGRectGetMaxX(self.frame), 1))
        makeWall(CGPoint(x:CGRectGetMidX(self.frame), y: CGRectGetMaxY(self.frame)), size: CGSizeMake(CGRectGetMaxX(self.frame), 1))
        makeWall(CGPoint(x:CGRectGetMinX(self.frame), y: CGRectGetMidY(self.frame)), size: CGSizeMake(1, CGRectGetMaxY(self.frame)))
        makeWall(CGPoint(x:CGRectGetMaxX(self.frame), y: CGRectGetMidY(self.frame)), size: CGSizeMake(1, CGRectGetMaxY(self.frame)))
    }
    
    // 見えない壁
    func makeWall(point : CGPoint, size : CGSize){
        let wall : SKSpriteNode = SKSpriteNode(color: UIColor.grayColor(), size: size)
        wall.position = point
        wall.zPosition = 100
        let physic = SKPhysicsBody(rectangleOfSize: size)
        physic.affectedByGravity = false
        physic.allowsRotation = false
        physic.dynamic = false
        physic.categoryBitMask = worldCategory
        wall.physicsBody = physic
        self.addChild(wall)
    }
    
    // キャラ情報をセット
    func setFighter(){
        let chara = SKSpriteNode(imageNamed: "kappa_32_32")
        chara.name = "fighter0"
        let point : CGPoint = CGPoint(x:CGRectGetMinX(self.frame) + 50, y:CGRectGetMidY(self.frame))
        chara.position = point
        chara.hidden = true
        chara.userData =
            [
                "hp" : 100,
                "str" : 6,
                "def": 50,
                "mdef": 50,
                "status": "rest"
        ]
        self.addChild(chara)
    }
    
    // ステータスに応じてキャラを動かす
    func moveFighter(){
        let chara : SKSpriteNode? = childNodeWithName("fighter0") as? SKSpriteNode
        
        switch chara!.userData?.objectForKey("status") as! String {
        case "rest" :
            visibleFighter()
        case "battle" :
            chara?.userData!["status"] = "escape"
            chara?.physicsBody?.velocity = CGVectorMake(-300, 0)
        case "escape" :
            chara?.userData!["status"] = "battle"
            chara?.physicsBody?.velocity = CGVectorMake(200, 0)
        default :
            print("status not exist \(chara!.userData?.objectForKey("status") as! String)")
            break
        }
    }
    
    // キャラを登場させる
    func visibleFighter(){
        let chara : SKSpriteNode? = childNodeWithName("fighter0") as? SKSpriteNode
        chara!.physicsBody =  SKPhysicsBody(rectangleOfSize: CGSizeMake(32, 32))
        chara!.physicsBody?.affectedByGravity = false
        chara!.physicsBody?.categoryBitMask = heroCategory
        chara!.physicsBody?.contactTestBitMask = worldCategory | enemyCategory
        chara!.physicsBody?.collisionBitMask = worldCategory
        chara!.physicsBody?.velocity = CGVectorMake(50, 0)
        chara!.hidden = false
        let point : CGPoint = CGPoint(x:CGRectGetMinX(self.frame) + 50, y:CGRectGetMidY(self.frame))
        chara?.position = point
        
        chara?.userData?["status"] = "battle"
    }
    
    func generateEnemy(){
        let chara = SKSpriteNode(imageNamed: "skelton_32_32")
        chara.name = "enemy"
        let point : CGPoint = CGPoint(x:CGRectGetMaxX(self.frame) - 50, y:CGRectGetMidY(self.frame))
        chara.position = point
        chara.physicsBody =  SKPhysicsBody(rectangleOfSize: CGSizeMake(32, 32))
        chara.physicsBody?.velocity = CGVectorMake(-100, 0)
        chara.physicsBody?.affectedByGravity = false
        chara.physicsBody?.categoryBitMask = enemyCategory
        chara.physicsBody?.contactTestBitMask = worldCategory
        chara.physicsBody?.collisionBitMask = worldCategory
        chara.userData =
            [
                "hp" : 30,
                "str" : 2,
                "def": 3,
                "mdef": 5,
                "status": "battle"
        ]

        self.addChild(chara)
    }

    func displayHP(){
        
    }
    
    // 衝突判定
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody, secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        if firstBody.node == nil || secondBody.node == nil {
            return
        }
        
        if (firstBody.categoryBitMask & heroCategory != 0 ) {
            heroContact(firstBody, contactBody: secondBody)
        }
    }
    
    // 味方キャラの各衝突判定
    func heroContact(heroBody: SKPhysicsBody, contactBody: SKPhysicsBody){
        if contactBody.categoryBitMask & enemyCategory != 0 {
            hitEnemy(heroBody, enemyBody: contactBody)
        } else if contactBody.categoryBitMask & worldCategory != 0 {
            hitWorld(heroBody, worldBody: contactBody)
        }
    }
    
    // 味方キャラと敵キャラの衝突
    func hitEnemy(heroBody: SKPhysicsBody, enemyBody: SKPhysicsBody){
        makeSpark(enemyBody.node?.position)
        damaged(heroBody)
        enemyBody.velocity = CGVectorMake(0, 0)
        enemyBody.linearDamping = 0.9
        var hp = enemyBody.node?.userData!["hp"] as! Int
        hp -= heroBody.node?.userData!["str"] as! Int
        if hp <= 0 {
            enemyBody.node?.removeFromParent()
        } else {
            enemyBody.node?.userData!["hp"] = hp
            enemyBody.applyImpulse(CGVectorMake(5, 0))
        }
    }
    
    // 味方キャラが壁と衝突
    func hitWorld(heroBody: SKPhysicsBody, worldBody: SKPhysicsBody){
        let chara : SKSpriteNode? = childNodeWithName("fighter0") as? SKSpriteNode
        if chara?.userData!["status"] as! String == "escape" {
            chara?.userData!["status"] = "rest"
            heroBody.node?.removeFromParent()
        }
    }
    
    
    func makeSpark(location : CGPoint?){
        if location == nil {
            return
        }

        let path = NSBundle.mainBundle().pathForResource(name, ofType: "sks")
        let particle = NSKeyedUnarchiver.unarchiveObjectWithFile(path!) as! SKEmitterNode
        particle.zPosition = 1
        particle.numParticlesToEmit = 100 // 何個、粒を出すか。
        particle.particleBirthRate = 200 // 一秒間に何個、粒を出すか。
        particle.particleSpeed = 80 // 粒の速度
        particle.xAcceleration = 0
        particle.yAcceleration = 0 // 加速度を0にすることで、重力がないようになる。
        
        particle.position = location!
        particle.zPosition = 1
        
        let fade : SKAction = SKAction.fadeOutWithDuration(4)
        particle.runAction(fade)
        self.addChild(particle)
    }
    
    func damaged(heroBody: SKPhysicsBody){
        var hp = heroBody.node?.userData!["hp"] as! Int
        hp -= 1
        heroBody.node?.userData!["hp"] = hp
        _battleDelegate?.hpChanged(hp)
        
        heroBody.velocity = CGVectorMake(0, 0)
        heroBody.linearDamping = 0.9
        
        heroBody.applyImpulse(CGVectorMake(-3, 0))
        
        if hp <= 0 {
            heroBody.node?.userData!["status"] = "dead"
        } else {
            heroBody.node?.userData!["status"] = "damaged"
            _wait_timer[0] = 50
        }
    }
    
    
    func wait_action(){
        if _wait_timer[0] <= 0 {
            return
        }
        _wait_timer[0] -= 1

        if _wait_timer[0] <= 0 {
            print("hukkatu")
            let chara : SKSpriteNode? = childNodeWithName("fighter0") as? SKSpriteNode
            chara?.physicsBody?.velocity = CGVectorMake(200, 0)
            chara?.physicsBody?.linearDamping = 0.0
            chara?.userData!["status"] = "battle"
        }
    
    }

    override func update(currentTime: CFTimeInterval) {
        // 処理終了
        if(_battle_end_flag == true) {
            return
        }
        
        // 時間関係の処理
        let timeSinceLast : CFTimeInterval = currentTime - _lastUpdateTimeInterval
        _timeSinceStart += timeSinceLast
        _timeSinceLastSecond += timeSinceLast
        if (_timeSinceLastSecond >= 1) {
            wait_action()
        }
        _lastUpdateTimeInterval = currentTime
    }
    

}
