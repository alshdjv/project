import UIKit
import SnapKit

// MARK: - Model

struct ClientInfo {
    var userData: String?
    var userInfoDescription: String?
}

// MARK: - ViewModel

struct TitleModel {
    let titleName: String
    let descriptionName: String
}

// MARK: - View

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    
    private let firstLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = UIColor(red: 170/255, green: 171/255, blue: 173/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = UIColor(red: 43/255, green: 45/255, blue: 51/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let linkImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        image.image = UIImage(named: "ChainImage")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(firstLabel)
        contentView.addSubview(secondLabel)
        contentView.addSubview(linkImage)
        
        setConstraints()
    }
    
    private func setConstraints() {
        firstLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(12)
            make.leading.equalTo(contentView.snp.leading).offset(24)
        }
        
        secondLabel.snp.makeConstraints { make in
            make.top.equalTo(firstLabel.snp.bottom).offset(4)
            make.leading.equalTo(contentView.snp.leading).offset(24)
            make.bottom.equalTo(contentView.snp.bottom).offset(-12)
        }
        
        linkImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(30)
            make.trailing.equalTo(contentView.snp.trailing).offset(-24)
            make.bottom.equalTo(contentView.snp.bottom).offset(-12)
        }
    }
    
    public func configure(with model: TitleModel) {
        firstLabel.text = model.titleName
        secondLabel.text = model.descriptionName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Controller

class ViewController: UIViewController {
    
    let clients = [
        ClientInfo(userData: "Владелец", userInfoDescription: "TELEKOM DATA FILIALI"),
        ClientInfo(userData: "PIN 1", userInfoDescription: "8671"),
        ClientInfo(userData: "PIN 2", userInfoDescription: "9929"),
        ClientInfo(userData: "PUK 1", userInfoDescription: "40406986"),
        ClientInfo(userData: "PUK 2", userInfoDescription: "51761615"),
        ClientInfo(userData: "Дата подключения", userInfoDescription: "18.07.2022"),
        ClientInfo(userData: "Точка подключения", userInfoDescription: "MChJ AGENT-TUXUM DILLER")
    ]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
}

// MARK: - Extensions

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
        let labels = clients[indexPath.row]
        cell.configure(with: TitleModel(titleName: labels.userData ?? "Unknown", descriptionName: labels.userInfoDescription ?? "Unknown"))
        if cell.selectedBackgroundView == nil {
            cell.selectedBackgroundView = UIView()
        }
        cell.selectedBackgroundView?.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "О клиенте"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.font = .systemFont(ofSize: 15)
        header.textLabel?.textColor = .black
        header.textLabel?.textAlignment = .center
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
}

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
