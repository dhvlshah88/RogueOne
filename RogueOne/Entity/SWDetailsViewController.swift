//
//  SWDetailsViewController.swift
//  RogueOne
//
//

import UIKit

class SWDetailsViewController: UIViewController {
  private var viewModel: ViewModel?

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var bodyStackView: UIStackView!
  @IBOutlet weak var relatedEntitiesStackView: UIStackView!

  init(viewModel: ViewModel) {
    self.viewModel = viewModel
    super.init(nibName: "SWDetailsViewController", bundle: nil)
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor.random()
    guard let viewModel = viewModel else { return }
    titleLabel.text = viewModel.title
    configureBodyStackView(viewModel)
    configureRelatedEntitiesStackView(viewModel)
  }

  private func configureBodyStackView(_ viewModel: ViewModel) {
    viewModel.body.forEach { text in
      let label = UILabel()
      label.textColor = #colorLiteral(red: 0.1058823529, green: 0.1411764706, blue: 0.1960784314, alpha: 0.9)
      label.textAlignment = .left
      label.text = text
      label.sizeToFit()

      bodyStackView.addArrangedSubview(label)
    }
  }

  private func configureRelatedEntitiesStackView(_ viewModel: ViewModel) {
    viewModel.relatedViewModel.forEach { (key: SWEntityType, value:[RelatedEntityViewModel]) in
      value.forEach { vm in
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: vm.imageName), for: .normal)
        button.setTitle(vm.title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .justified
        button.clipsToBounds = true
        button.backgroundColor = UIColor.random()
        button.translatesAutoresizingMaskIntoConstraints = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        relatedEntitiesStackView.addArrangedSubview(button)
      }
    }
  }

}
