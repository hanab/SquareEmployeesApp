//
//  ViewController.swift
//  SquareEmployeesApp
//
//  Created by Hana  Demas on 12/9/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import UIKit

class EmployeesViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet var employeesTableView: UITableView!
    var employeeViewModel: EmployeesViewModel = EmployeesViewModel()
    var alertPresenter: AlertPresenterProtocol! = AlertPresenter()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:#selector(EmployeesViewController.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        
        return refreshControl
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        
        return label
    }()
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.center = self.view.center
        loadingIndicator.color = .black
        
        return loadingIndicator
    }()
        
    //MARK: lifeCycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        employeesTableView.rowHeight = UITableView.automaticDimension
        employeesTableView.estimatedRowHeight = 120
        employeesTableView.addSubview(refreshControl)
        employeesTableView.separatorColor = UIColor.squareBlue()

        self.navigationController?.navigationBar.barTintColor =  UIColor.squareBlue()
        self.navigationItem.title = "Employees"
        
        showActivityIndicator()
        loadDataWithConnectionCheck()
        
    }
    
    //MARK: Methods
    func loadFromNewtork() {
        self.employeeViewModel.fetchData {
            guard self.employeeViewModel.getNetworkError() == nil else {
                DispatchQueue.main.async {
                    self.display(error: self.employeeViewModel.getNetworkError()?.rawValue ?? "")
                    self.hideActivityIndicator()
                }
                
                return
            }
            
            DispatchQueue.main.async {
                self.employeesTableView.reloadData()
                self.hideActivityIndicator()
            }
        }
    }
    
    func loadDataWithConnectionCheck() {
        CheckConectivity.shared.online { [weak self] (err) in
            guard let strongSelf = self else {
                return
            }
            
            if err != false {
                DispatchQueue.main.async {
                    strongSelf.display(error: "Please Check your internet connectivity")
                    strongSelf.hideActivityIndicator()
                }
            } else {
                strongSelf.loadFromNewtork()
            }
        }
    }
    
    func showActivityIndicator() {
        self.view.addSubview(loadingIndicator)
        DispatchQueue.main.async {
            self.employeesTableView.backgroundView = self.loadingIndicator
            self.loadingIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicator(){
        DispatchQueue.main.async {
            self.employeesTableView.backgroundView = self.messageLabel
            self.loadingIndicator.stopAnimating()
       }
    }

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        loadDataWithConnectionCheck()
        refreshControl.endRefreshing()
    }
    
    private func display(error: String) {
        alertPresenter.present(from: self,
                               title: "Unexpected Error",
                               message: error,
                               dismissButtonTitle: "OK")
    }
}

//MARK: viewcontroller extension for implementing datasource and delegates of uitableview
extension EmployeesViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: tableview datasource
    func registerCellsForTableView(tableView: UITableView) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if employeeViewModel.getNumberOfEmployees() == 0 {
            setEmptyMessage("No employee data avaliable, please try again")
        } else {
            self.restore()
        }
        
        return employeeViewModel.getNumberOfEmployees()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EmployeeTableViewCell
        let employee = employeeViewModel.getEmployeeAtIndex(index: indexPath.row)
        cell.setupCell(employee: employee)
        
        return cell
    }
}
