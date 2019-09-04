//
//  ViewController.swift
//  FactsInfo
//
//  Created by devika.ramadasi on 03/09/19.
//  Copyright © 2019 devika.ramadasi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var factsInfo :FactsInfo?
    
    var tableView:UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        addTableView()
        refreshFacts()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    //Add TableView
    
    
    func refreshFacts()  {
        FactsManager.getFacts { (updated:FactsInfo?, error: Error?) in
            if updated != nil
            {
                self.factsInfo = updated
                self.refreshUI()
            }
            else if error != nil
            {
                let  alert = UIAlertController(title: "Failed", message: error.debugDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func refreshUI()  {
        self.title = factsInfo?.title
        tableView?.reloadData()
    }
}
extension ViewController:UITableViewDelegate,UITableViewDataSource
{
    func addTableView()  {
        tableView = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.rowHeight = UITableView.automaticDimension
        self.view.addSubview(tableView!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return factsInfo?.rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
            cell?.detailTextLabel?.numberOfLines = 0
            //    cell?.detailTextLabel?.cont
            
        }
        if let fact = factsInfo?.rows[indexPath.row]
        {
            cell?.textLabel?.text = fact.title
            cell?.detailTextLabel?.text = fact.descreption
        }
        return cell!
    }
    
    
}

