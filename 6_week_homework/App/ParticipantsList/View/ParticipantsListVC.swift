//
//  ParticipantsListVC.swift
//  firstapp
//
//  Created by Petr Urban on 22/03/2018.
//  Copyright © 2018 Etnetera, a. s. All rights reserved.
//

import UIKit
class ParticipantsListVC: UIViewController {
    
    //MARK: private vars
    private let viewModel: ParticipantsListVM
    private let tableView: UITableView = UITableView(frame: .zero, style: .grouped)
    private let participantIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    private let refreshControl = UIRefreshControl()

    //MARK: inits
    init(viewModel: ParticipantsListVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: view methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.topItem?.title = "Seznam Účastníků"
        tableView.indexPathsForSelectedRows?.forEach {
            tableView.deselectRow(at: $0, animated: true)
        }
    }

    override func loadView() {
        super.loadView()
        if Reachability.isConnectedToNetwork(){
            showTableView()
        } else {
            let label = UILabel()
            label.font = .systemFont(ofSize: 24)
            label.textColor = UIColor(named: "academy")
            label.text = "Internetové připojení není dostupné..."
            view.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
    }

    override func viewDidLoad() {
        if Reachability.isConnectedToNetwork(){
            super.viewDidLoad()
            tableView.delegate = self
            tableView.dataSource = self
            bindViewModel()
            viewModel.loadData()
        }
    }
    
    //MARK: public functions
    public func stopAnimatingIndicator(){
        participantIndicator.stopAnimating()
    }
    public func startAnimatingIndicator(){
        participantIndicator.startAnimating()
    }
    
    //MARK: private functions
    private func showTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.register(ParticipantCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(participantIndicator)
        setupParticipantIndicator()
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        setupRefreshControl()
    }
    private func bindViewModel() {
        viewModel.didUpdateModel = { [weak self] model in
            self?.tableView.reloadData()
        }
        viewModel.waiting = { [weak self] in
            self?.startAnimatingIndicator()
        }
        
        viewModel.stopWaiting = { [weak self] in
            self?.stopAnimatingIndicator()
        }
    }
    private func setupParticipantIndicator(){
        participantIndicator.translatesAutoresizingMaskIntoConstraints = false
        participantIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        participantIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    private func setupRefreshControl(){
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(reloadTableData(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor(named: "academy")
        refreshControl.attributedTitle = NSAttributedString(string: "Aktualizuji seznam ...")
    }
    @objc private func reloadTableData(_ sender: Any) {
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
}

// MARK: Delegate & datarousce
extension ParticipantsListVC: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.modelForSection(section).header
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return viewModel.modelForSection(section).footer
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.modelForRow(inSection: indexPath.section, atIdx: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ParticipantCell

        switch model {
        case let .participant(person):
            cell.customize(with: person)
        }
        return cell
    }
}

extension ParticipantsListVC {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.modelForRow(inSection: indexPath.section, atIdx: indexPath.row)
        var id: Int = 0
        switch model {
            case .participant(let participant):
                id = participant.id
        }
        
        let businessCardVM = BusinessCardVM(with: RemoteDataProvider(), with: id)
        let businessCardVC = BusinessCardVC(with: businessCardVM)
        self.navigationController?.pushViewController(businessCardVC, animated: true)
    }
}
