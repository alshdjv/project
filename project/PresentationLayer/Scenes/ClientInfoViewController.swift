import UIKit
import SnapKit

struct Colors {
    static let secondaryLight = UIColor(red: 170/255, green: 171/255, blue: 173/255, alpha: 1.0)
    static let primaryLight = UIColor(red: 43/255, green: 45/255, blue: 51/255, alpha: 1.0)
    static let greyLight = UIColor(red: 213/255, green: 213/255, blue: 214/255, alpha: 1.0)
    static let greenLight = UIColor(red: 52/255, green: 199/255, blue: 89/255, alpha: 1.0)
}

enum ChainImageState {
    case inactiveLight
    case activeLight
}

// MARK: - Model

struct ClientInfo {
    var userData: String?
    var userInfoDescription: String?
    var canCopy: Bool = false
}

struct TitleModel {
    let titleName: String
    let descriptionName: String
}

struct TitleViewModel {
    let model: TitleModel
    var canCopy: Bool = false
}

// MARK: - TableViewCell

final class ClientTableViewCell: UITableViewCell {
    
    static let identifier = "ClientTableViewCell"
    
    private let firstLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = Colors.secondaryLight
        return label
    }()
    
    private let secondLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = Colors.primaryLight
        return label
    }()
    
    private let linkImage: UIImageView = {
        let image = UIImage(named: "chain_img")
        let imageView = UIImageView(image: image?.withRenderingMode(.alwaysTemplate))
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if selectedBackgroundView == nil {
            selectedBackgroundView = UIView()
        }
        selectedBackgroundView?.backgroundColor = .white
        
        setupUI()
    }
    
    private func setupUI() {
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
            make.leading.equalTo(firstLabel.snp.leading)
            make.bottom.equalTo(contentView.snp.bottom).offset(-12)
        }
        
        linkImage.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).offset(-24)
            make.top.equalTo(contentView.snp.top).offset(30)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
    }
    
    public func set(state: ChainImageState) {
        switch state {
        case .inactiveLight:
            linkImage.tintColor = Colors.greyLight
        case .activeLight:
            linkImage.tintColor = Colors.greenLight
        }
    }
    
    public func configure(with vm: TitleViewModel) {
        firstLabel.text = vm.model.titleName
        secondLabel.text = vm.model.descriptionName
        linkImage.isHidden = !vm.canCopy
    }
    
    required init?(coder: NSCoder) {
        coder.decodeObject(forKey: "firstLabel")
        coder.decodeObject(forKey: "secondLabel")
        coder.decodeObject(forKey: "linkImage")
        super.init(coder: coder)
    }
}

// MARK: - Model Mapper

final class TitleModelMapper {
    static func map(for models: [ClientInfo]) -> [TitleViewModel] {
        return models.map { model in
            let titleModel = TitleModel(titleName: model.userData ?? "Unknown",
                                   descriptionName: model.userInfoDescription ?? "Unknown")
            let canCopy: Bool = model.canCopy
            return TitleViewModel(model: titleModel, canCopy: canCopy)
        }
    }
    
    static func map(for clientInfo: ClientInfo) -> TitleViewModel {
        let titleModel = TitleModel(titleName: clientInfo.userData ?? "Unknown",
                               descriptionName: clientInfo.userInfoDescription ?? "Unknown")
        return TitleViewModel(model: titleModel, canCopy: clientInfo.canCopy)
    }
}

// MARK: - ClientInfoViewController

class ClientInfoViewController: UIViewController {
    
    let clients = [
        ClientInfo(userData: "Владелец", userInfoDescription: "TELEKOM DATA FILIALI"),
        ClientInfo(userData: "PIN 1", userInfoDescription: "8671"),
        ClientInfo(userData: "PIN 2", userInfoDescription: "9929"),
        ClientInfo(userData: "PUK 1", userInfoDescription: "40406986"),
        ClientInfo(userData: "PUK 2", userInfoDescription: "51761615"),
        ClientInfo(userData: "Дата подключения", userInfoDescription: "18.07.2022"),
        ClientInfo(userData: "Точка подключения", userInfoDescription: "MChJ AGENT-TUXUM DILLER", canCopy: true)
    ]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(ClientTableViewCell.self, forCellReuseIdentifier: ClientTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.snp.bottom)
        }
    }
}

// MARK: - VC Extensions

extension ClientInfoViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ClientTableViewCell.identifier, for: indexPath) as? ClientTableViewCell else {
            return UITableViewCell()
        }
        
        let labels = clients[indexPath.row]
        cell.configure(with: TitleModelMapper.map(for: labels))
        cell.set(state: .activeLight)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = TableViewHeader()
        return view
    }
}

// MARK: - Blur Effect Class View

class TableViewHeader: UIView {
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "О клиенте"
        label.font = .systemFont(ofSize: 15)
        label.textColor = Colors.primaryLight
        return label
    }()
    
    let blurBg: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = UIColor.clear
        
        addSubview(blurBg)
        blurBg.frame = self.frame
        
        addSubview(title)
        title.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).offset(2)
        }
    }
    
    required init?(coder: NSCoder) {
        coder.decodeObject(forKey: "title")
        coder.decodeObject(forKey: "blurBg")
        super.init(coder: coder)
    }
}
