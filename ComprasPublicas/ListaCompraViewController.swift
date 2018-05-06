//
//  ListaCompraViewController.swift
//  ComprasPublicas
//
//  Created by Ana Finotti on 5/6/18.
//  Copyright © 2018 Finotti. All rights reserved.
//

import UIKit

class ListaCompraViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var compras = [Compra]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CompraCell", bundle: nil), forCellReuseIdentifier: "CompraCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ListaCompraViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompraCell", for: indexPath) as? CompraCell
        let compra = compras[indexPath.row]
        cell?.setupCell(compra: compra)
        if indexPath.row % 2 == 0 {
            cell?.backgroundColor = UIColor(hexString: "E6E6F6").withAlphaComponent(0.52)
        } else {
            cell?.backgroundColor = UIColor(hexString: "E9E6EA").withAlphaComponent(0.52)
        }
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return compras.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 139
    }
}
