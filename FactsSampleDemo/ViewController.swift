//
//  ViewController.swift
//  FactsInfo
//
//  Created by devika.ramadasi on 03/09/19.
//  Copyright © 2019 devika.ramadasi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /// Provides FactsInfo object containing title and rows.
    var factsInfo :FactsInfo?
    
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    /// represents Table Contents
    var tableView:UITableView?
    var showXibCell = false
    override func viewDidLoad() {
        super.viewDidLoad()
        addTableView()
        refreshFacts()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: UIBarButtonItem.Style.plain, target: self, action: #selector(ViewController.refreshFacts))
        let leftTitle = showXibCell ? "Default" : "XibCell"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: leftTitle, style: UIBarButtonItem.Style.plain, target: self, action: #selector(ViewController.toggleCellUI))
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    @objc   func toggleCellUI()  {
        showXibCell = !showXibCell
        let leftTitle = showXibCell ? "Default" : "XibCell"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: leftTitle, style: UIBarButtonItem.Style.plain, target: self, action: #selector(ViewController.toggleCellUI))
        tableView?.reloadData()
        
    }
    
    /// Fetches and updates facts
    @objc func refreshFacts()  {
        self.view.bringSubviewToFront(self.activityView)
        activityView?.startAnimating()
        FactsManager.getFacts { (updated:FactsInfo?, error: Error?) in
            self.activityView?.stopAnimating()
            
            if updated != nil
            {
                
                self.factsInfo = updated
                self.refreshUI()
                self.tableView?.isHidden = updated!.rows.count > 0 ? false : true
                
            }
            else if error != nil
            {
                let  alert = UIAlertController(title: "Failed", message: error.debugDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    /// Reload table and UI
    private  func refreshUI()  {
        self.title = factsInfo?.title
        tableView?.reloadData()
    }
}
extension ViewController:UITableViewDelegate,UITableViewDataSource
{
    /// Create & tableview to controller view
    func addTableView()  {
        tableView = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.register(FactsListTableViewCell.self, forCellReuseIdentifier: "FactsListTableViewCell")
        tableView?.register(UINib(nibName: "FactsListCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "FactsListCustomTableViewCell")
        let views = ["tableView":tableView]
        self.view.addSubview(tableView!)
        tableView?.translatesAutoresizingMaskIntoConstraints = false
        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[tableView]-|", options: [.alignAllCenterY], metrics: nil, views: views as [String : Any])
        let Constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[tableView]-|", options: [.alignAllCenterX], metrics: nil, views: views as [String : Any])
        self.view.addConstraints(verticalConstraints)
        self.view.addConstraints(Constraints)
        tableView?.isHidden = true
        // self.view.addConstraint([verticalConstraints,Constraints])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return factsInfo?.rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = showXibCell ? tableView.dequeueReusableCell(withIdentifier: "FactsListCustomTableViewCell") as? FactsListCustomTableViewCell: tableView.dequeueReusableCell(withIdentifier: "FactsListTableViewCell") as? FactsListTableViewCell
        if cell == nil
        {
            cell = FactsListTableViewCell()
            cell?.detailTextLabel?.numberOfLines = 0
            //    cell?.detailTextLabel?.cont
            
        }
        if let fact = factsInfo?.rows[indexPath.row]
        {
            if showXibCell
            {
                (cell as? FactsListCustomTableViewCell)?.updateWithFact(fact)
            }
            else
            {
                (cell as? FactsListTableViewCell)?.updateWithFact(fact)
            }
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

