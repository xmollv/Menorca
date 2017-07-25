//
//  TimelineViewController.swift
//  Menorca
//
//  Created by Xavi Moll on 25/06/2017.
//  Copyright © 2017 Xavi Moll. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet private var tableView: UITableView!
    
    //MARK: Class properties
    var dataProvider: DataProvider!
    var schedules: [Schedule]!
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.calendar = Calendar.current
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }()
    
    //MARK: View controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Schedule"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
    }

}

//MARK: UITableViewDataSource
extension EventsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return schedules.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedules[section].events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventsCell", for: indexPath) as! EventsCell
        let event = schedules[indexPath.section].events[indexPath.row]
        cell.configure(with: event)
        // Remove the first and last vertical lines for the tableView cell
        if schedules[indexPath.section].events.count == 1 {
            cell.topVerticalLine.isHidden = true
            cell.bottomVerticalLine.isHidden = true
        } else if event == schedules[indexPath.section].events.first {
            cell.topVerticalLine.isHidden = true
        } else if event == schedules[indexPath.section].events.last {
            cell.bottomVerticalLine.isHidden = true
        }
        return cell
    }
}

//MARK: UITableViewDelegate
extension EventsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .primary
        label.backgroundColor = UIColor.white.withAlphaComponent(0.95)
        label.text = dateFormatter.string(from: schedules[section].day)
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
