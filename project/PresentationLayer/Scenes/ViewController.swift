import UIKit
import SnapKit

//class ViewController: UIViewController {
//    
//    let clients = [
//        ClientInfo(userData: "Владелец", userInfoDescription: "TELEKOM DATA FILIALI"),
//        ClientInfo(userData: "PIN 1", userInfoDescription: "8671"),
//        ClientInfo(userData: "PIN 2", userInfoDescription: "9929"),
//        ClientInfo(userData: "PUK 1", userInfoDescription: "40406986"),
//        ClientInfo(userData: "PUK 2", userInfoDescription: "51761615"),
//        ClientInfo(userData: "Дата подключения", userInfoDescription: "18.07.2022"),
//        ClientInfo(userData: "Точка подключения", userInfoDescription: "MChJ AGENT-TUXUM DILLER", canCopy: true)
//    ]
//    
//    private lazy var tableView: UITableView = {
//        let tableView = UITableView(frame: .zero, style: .grouped)
//        tableView.register(ClientTableViewCell.self, forCellReuseIdentifier: ClientTableViewCell.identifier)
//        tableView.separatorStyle = .none
//        tableView.separatorColor = .clear
//        tableView.backgroundColor = .white
//        tableView.delegate = self
//        tableView.dataSource = self
//        return tableView
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.addSubview(tableView)
//    }
//    
//    override func viewDidLayoutSubviews() {
//        tableView.frame = view.bounds
//    }
//}

// MARK: - Extensions

//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return clients.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: ClientTableViewCell.identifier, for: indexPath) as? ClientTableViewCell else {
//            return UITableViewCell()
//        }
//
//        let labels = clients[indexPath.row]
//        cell.configure(with: TitleModelMapper.map(for: labels))
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 64
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "О клиенте"
//    }
//
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
//        header.textLabel?.font = .systemFont(ofSize: 15)
//        header.textLabel?.textColor = .black
//        header.textLabel?.textAlignment = .center
//        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
//    }
//}
//
//extension String {
//    func capitalizeFirstLetter() -> String {
//        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
//    }
//}
