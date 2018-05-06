//
//  CompraCell.swift
//  ComprasPublicas
//
//  Created by Ana Finotti on 5/6/18.
//  Copyright © 2018 Finotti. All rights reserved.
//

import UIKit

class CompraCell: UITableViewCell {

    @IBOutlet var UGELabel: UILabel!
    @IBOutlet var tipoUGELabel: UILabel!
    @IBOutlet var quantidadeLabel: UILabel!
    @IBOutlet var valorTotalLabel: UILabel!
    @IBOutlet var dataEncerramentoLabel: UILabel!
    @IBOutlet var valorUnitarioLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(compra: Compra) {
        UGELabel.text = compra.uge
        tipoUGELabel.text = compra.tipoUGE
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        
        let qtd = formatter.number(from: compra.quantidade)
        quantidadeLabel.text = String(format: "%@", qtd!)
        if compra.valorUnitarioNegociado != nil {
            if let valor = Float(compra.valorUnitarioNegociado) {
                valorUnitarioLabel.text = valor.floatToCurrency()
            } else {
                valorUnitarioLabel.text = ""
            }
        }  else {
            valorUnitarioLabel.text = ""
        }

        if compra.dataEncerramento != nil {
            dataEncerramentoLabel.text = compra.dataEncerramento.toString(format: .isoDateBars)
        }
        if compra.valorTotalNegociado != nil {
            if let valor = Float(compra.valorTotalNegociado) {
                if valor != 0.0 {
                    valorTotalLabel.text = valor.floatToCurrency()
                }
                else {
                    valorTotalLabel.text = "0"
                }
            }
            else {
                valorTotalLabel.text = "0"
            }
        } else {
             valorTotalLabel.text = "0"
        }
    }
}
