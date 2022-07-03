//
//  DiffableViewController.swift
//  Diffable-DataSource-Example
//
//  Created by Jeytery on 02.07.2022.
//

import UIKit
import SnapKit

class DiffableViewController: UIViewController {
    
    enum Section {
        case section1
        case section2
        case section3
    }
    
    struct Item: Hashable {
        let name: String
        let price: Double
        let identifier = UUID()
         
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private lazy var dataSource = UITableViewDiffableDataSource<Section, Item>(
        tableView: tableView,
        cellProvider: {
            (tableView, indexPath, item) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "cell",
                for: indexPath
            )
            cell.textLabel?.text = item.name
            return cell
        }
    )
    
    private lazy var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    
    private let items1: [Item] = [
        .init(name: "1", price: 1),
        .init(name: "2", price: 2),
        .init(name: "3", price: 3)
    ]
    
    private let items2: [Item] = [
        .init(name: "1", price: 1),
        .init(name: "2", price: 2),
        .init(name: "3", price: 3)
    ]
    
    private let items3: [Item] = [
        .init(name: "1", price: 1),
        .init(name: "2", price: 2),
        .init(name: "3", price: 3)
    ]
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        title = "Diffable"
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        dataSource.defaultRowAnimation = .fade
        snapshot.appendSections([.section1, .section2, .section3])
        snapshot.appendItems(items1, toSection: .section1)
        snapshot.appendItems(items2, toSection: .section2)
        snapshot.appendItems(items3, toSection: .section3)
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
