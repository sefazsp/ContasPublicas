//
//  Compra.swift
//  ComprasPublicas
//
//  Created by Ana Finotti on 5/5/18.
//  Copyright © 2018 Finotti. All rights reserved.
//

import UIKit
import CoreData

class Compra: NSManagedObject {

    @NSManaged var oc: String!
    @NSManaged var modalidade: String!
    @NSManaged var item: String!
    @NSManaged var codigoItem: String!
    @NSManaged var descricaoItem: String!
    @NSManaged var unidadeFornecimento: String!
    @NSManaged var resultadoItem: String!
    @NSManaged var vencedorOCItem: String!
    @NSManaged var valorUnitarioNegociado: String!
    @NSManaged var valorTotalNegociado: String!
    @NSManaged var quantidade: String!
    @NSManaged var dataEncerramento: Date!
    @NSManaged var codigoUGE: String!
    @NSManaged var uge: String!
    @NSManaged var tipoUGE: String!
    @NSManaged var logradouroUGE: String!
    @NSManaged var cepUGE: String!
    @NSManaged var ufUGE: String!
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
}
