//
//  FLGUniverseTableViewController.swift
//  StarWarsSwift
//
//  Created by Javi Alzueta on 12/5/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

import UIKit

protocol FLGUniverseTableViewControllerDelegate{
    func universeTableViewController(uVC: FLGUniverseTableViewController, didSelectCharacter: FLGStarWarsCharacter)
}

class FLGUniverseTableViewController: UITableViewController, FLGUniverseTableViewControllerDelegate{

    var model: FLGStarWarsUniverse?
    var delegate: FLGUniverseTableViewControllerDelegate?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(model: FLGStarWarsUniverse?){
        self.init(nibName: nil, bundle: nil)
        self.model = model
        self.title = "StarWars Universe"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if let model: FLGStarWarsUniverse = self.model{
            if section == IMPERIAL_SECTION{
                return model.imperialCount
            }else{
                return model.rebelCount
            }
        }
        return 0
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == IMPERIAL_SECTION{
            return "Imperial"
        }else{
            return "Rebels"
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell
        var myCell: UITableViewCell
        if let cell = tableView.dequeueReusableCellWithIdentifier("StarWarsCell") as? UITableViewCell{
            myCell = cell
        }else{
            myCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "StarWarsCell")
        }
        

        // Averiguar de qué modelo (personaje) me está hablando
        let character: FLGStarWarsCharacter?
        if let model: FLGStarWarsUniverse = self.model{
            if indexPath.section == IMPERIAL_SECTION{
                character = model.imperialAtIndex(indexPath.row)
            }else{
                character = model.rebelAtIndex(indexPath.row)
            }
            if let char = character{
                // Sincronizar modelo (personaje) -> vista (celda)
                myCell.imageView?.image = char.photo
                myCell.textLabel?.text = char.alias
                myCell.detailTextLabel?.text = char.name
            }
        }

        return myCell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let character: FLGStarWarsCharacter?
        if let model: FLGStarWarsUniverse = self.model{
            
            // Averiguar de qué modelo(personaje) me están hablando
            if indexPath.section == IMPERIAL_SECTION{
                character = model.imperialAtIndex(indexPath.row)
            }else{
                character = model.rebelAtIndex(indexPath.row)
            }
            if let char = character{
                
                // Avisar al delegado
                if let del = self.delegate{
                    del.universeTableViewController(self, didSelectCharacter: char)
                }
                
                // mandamos una notificación
                let nc = NSNotificationCenter.defaultCenter()
                let dict = [CHARACTER_KEY : char]
                let n = NSNotification(name: CHARACTER_DID_CHANGE_NOTIFICATION_NAME, object: self, userInfo: dict)
                nc.postNotification(n)
                
                // Guardamos las coordenadas del último personaje
                let coords = [indexPath.section, indexPath.row]
                let def = NSUserDefaults.standardUserDefaults()
                def.setObject(coords, forKey: LAST_SELECTED_CHARACTER)
                def.synchronize()
            }
        }
    }
    
    // MARK: - FLGUniverseTableViewControllerDelegate
    func universeTableViewController(uVC: FLGUniverseTableViewController, didSelectCharacter: FLGStarWarsCharacter) {
        
        // Creamos un CharacterVC
        let charVC = FLGCharacterViewController(model: didSelectCharacter)
        
        // Hago un push
        self.navigationController?.pushViewController(charVC, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
