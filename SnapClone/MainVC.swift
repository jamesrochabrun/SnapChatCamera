//
//  MainVC.swift
//  SnapClone
//
//  Created by James Rochabrun on 5/4/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    

    @IBOutlet weak var menuScrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let v1 = View1(nibName: "View1", bundle: nil)
        self.addChildViewController(v1)
        self.menuScrollView.addSubview(v1.view)
        v1.didMove(toParentViewController: self)
        
        let v2 = View2(nibName: "View2", bundle: nil)
        self.addChildViewController(v2)
        self.menuScrollView.addSubview(v2.view)
        v2.didMove(toParentViewController: self)
        
        var v2Frame = v2.view.frame
        v2Frame.origin.x = self.view.frame.width
        v2.view.frame = v2Frame
        
        let v3 = View3(nibName: "View3", bundle: nil)
        self.addChildViewController(v3)
        self.menuScrollView.addSubview(v3.view)
        v3.didMove(toParentViewController: self)
        
        var v3Frame = v3.view.frame
        v3Frame.origin.x = self.view.frame.width * 2
        v3.view.frame = v3Frame
        
        self.menuScrollView.contentSize = CGSize(width: self.view.frame.width * 3, height: self.view.frame.size.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
