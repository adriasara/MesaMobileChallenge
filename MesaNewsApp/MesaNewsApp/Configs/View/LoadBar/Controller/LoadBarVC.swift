//
//  LoadBarVC.swift
//  MesaNewsApp
//
//  Created by Ádria Cardoso on 27/03/21.
//

import UIKit

final class LoadBarVC: UIViewController {
    
    let loadBarView: LoadBarView = LoadBarView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.sv(loadBarView)
        loadBarView.fillContainer()
    }
}
