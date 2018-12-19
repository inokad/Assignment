//
//  DataViewController.swift
//  SPHAssignment
//
//  Created by Inoka Dissanayaka on 12/18/18.
//  Copyright © 2018 Inoka Dissanayaka. All rights reserved.
//

import UIKit

class DataViewController: UITableViewController {
    
    var years = [Year]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SPH Usage Data"
        getAllSearchData();
    }
    
    func getAllSearchData() {
        Fetcher.sharedInstance.getSearchedData(
            resourceId: Constants.SPH_SEARCH_RESOURCE_ID,
            completion: { result in
                switch result {
                case .success(let records):

                    var yearsMap: [String: Year] = [:]
                   
                    for record in records {
                        let quarter = Quarter(quarter:record.getQauterWithoutYear(), dataUsage: Double(record.volumeOfMobileData)!)
                        var yearRecord = yearsMap[record.getYear()]
                        
                        if yearRecord != nil {
                            yearRecord!.quarters.append(quarter)
                        } else {
                            yearRecord = Year(year: record.getYear(), quarters: [quarter])
                        }
                        yearsMap[record.getYear()] = yearRecord
                    }
                    self.years.removeAll()
                    self.years = Array(yearsMap.values)
                    self.years = self.years.sorted(by: {$0.year < $1.year})
                    self.tableView.reloadData()
                    
                case .failure(let error):
                    debugPrint("Error: \(error.localizedDescription)")
                }
        }
        )
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.years.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataCell = tableView.dequeueReusableCell(withIdentifier: "UsageDetailsCellID", for: indexPath) as! DataViewTableCell
        
        dataCell.yearLabel.text = self.years[indexPath.row].year
        dataCell.dataUsageLabel.text = String(format: "%.4f", self.years[indexPath.row].getCalculatedTotlaData())
        dataCell.decreasedDataImageView.isHidden = !self.years[indexPath.row].hasDataVolumeReduced()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(imageTapped(tapGestureRecognizer:)))
        dataCell.decreasedDataImageView.isUserInteractionEnabled = true
        dataCell.decreasedDataImageView.addGestureRecognizer(tapGestureRecognizer)
        return dataCell
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "Alert!", message: "Data usage volume decreased", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}




