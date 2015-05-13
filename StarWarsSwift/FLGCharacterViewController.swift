//
//  FLGCharacterViewController.swift
//  StarWarsSwift
//
//  Created by Javi Alzueta on 13/5/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

import UIKit

class FLGCharacterViewController: UIViewController, UISplitViewControllerDelegate, FLGUniverseTableViewControllerDelegate {
    
    var model: FLGStarWarsCharacter?
    @IBOutlet weak var photoView: UIImageView!
    
    convenience init(model: FLGStarWarsCharacter?){
        self.init(nibName: "FLGCharacterViewController", bundle: nil)
        self.model = model
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.edgesForExtendedLayout = .None
        
        // Sincronizar modelo -> vista
        self.syncViewWithModel()
        
        // Si estoy dentro de un SplitVC me pongo el botón
        self.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    @IBAction func playSound(sender: UIBarButtonItem){
        if let miModel = self.model,
            let player: AnyObject = CafPlayer.cafPlayer(),
            let soundData = miModel.soundData{
                player.playSoundData(soundData)
        }
    }
    
    @IBAction func displayWiki(sender: UIBarButtonItem){
        
        // Crear un WikiVC
        let wVC = FLGWikiViewController(model: model)
        
        // Hacer un push
        self.navigationController?.pushViewController(wVC, animated: true)
    }
    
    // MARK: - UISplitViewControllerDelegate
    func splitViewController(svc: UISplitViewController, willChangeToDisplayMode displayMode: UISplitViewControllerDisplayMode) {
        if displayMode == UISplitViewControllerDisplayMode.PrimaryHidden{
            self.navigationItem.leftBarButtonItem = svc.displayModeButtonItem()
        }else{
            self.navigationItem.leftBarButtonItem = nil
        }
    }
    
    // MARK: - FLGUniverseTableViewControllerDelegate
    func universeTableViewController(uVC: FLGUniverseTableViewController, didSelectCharacter: FLGStarWarsCharacter) {
        // Actualizo el modelo
        self.model = didSelectCharacter
        
        // Sincronio modelo -> vista
        self.syncViewWithModel()
    }
    
    
    // MARK: - Utils
    
    func syncViewWithModel(){
        if let myModel = self.model{
            self.title = myModel.alias
            if let photo = myModel.photo{
                photoView.image = photo
            }
        }
    }
    
    
}
