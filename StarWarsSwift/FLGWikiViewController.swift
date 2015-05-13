//
//  FLGWikiViewController.swift
//  StarWarsSwift
//
//  Created by Javi Alzueta on 13/5/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

import UIKit

class FLGWikiViewController: UIViewController, UIWebViewDelegate {

    var model: FLGStarWarsCharacter?
    var canLoad: Bool?
    @IBOutlet weak var browser: UIWebView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    convenience init(model: FLGStarWarsCharacter?){
        self.init(nibName: "FLGWikiViewController", bundle: nil)
        self.model = model
        self.title = "Wikipedia"
        self.canLoad = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("notifyThatCharacterDidChange:"), name: CHARACTER_DID_CHANGE_NOTIFICATION_NAME, object: nil)
        
        self.edgesForExtendedLayout = .None
        
        // Sincronizar modelo -> vista
        self.syncViewWithModel()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationItem.hidesBackButton = false
        
        // Asignar delegados
        browser.delegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Me doy de baja de las notificaciones
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - UIWebViewDelegate
    func webViewDidFinishLoad(webView: UIWebView) {
        // Paro y oculto el activity
        activityView.stopAnimating()
        activityView.hidden = true
        
        canLoad = false
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        // Paro y oculto el activity
        activityView.stopAnimating()
        activityView.hidden = true
    }

    // MARK: - Notifications
    // CHARACTER_DID_CHANGE_NOTIFICATION_NAME
    func notifyThatCharacterDidChange(notification: NSNotification){
        
        // Sacamos el personaje
        if let info: NSDictionary = notification.userInfo,
            let character = info.objectForKey(CHARACTER_KEY) as? FLGStarWarsCharacter{
                model = character
        }
        
        // Sincronizar modelo -> vista
        self.syncViewWithModel()
    }
    
    // MARK: - Utils
    func syncViewWithModel(){
        canLoad = true
        
        activityView.hidden = false
        activityView.startAnimating()
        
        if let miModel = model,
            let url = miModel.wikiURL{
                browser.loadRequest(NSURLRequest(URL: url))
        }
    }
    
}
