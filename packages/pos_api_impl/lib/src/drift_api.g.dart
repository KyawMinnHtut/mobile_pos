// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_api.dart';

// ignore_for_file: type=lint
class ContactTableData extends DataClass
    implements Insertable<ContactTableData> {
  final String name;
  final String phNumber;
  final String address;
  final bool isCustomer;
  const ContactTableData(
      {required this.name,
      required this.phNumber,
      required this.address,
      required this.isCustomer});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    map['phNumber'] = Variable<String>(phNumber);
    map['address'] = Variable<String>(address);
    map['is_customer'] = Variable<bool>(isCustomer);
    return map;
  }

  ContactTableCompanion toCompanion(bool nullToAbsent) {
    return ContactTableCompanion(
      name: Value(name),
      phNumber: Value(phNumber),
      address: Value(address),
      isCustomer: Value(isCustomer),
    );
  }

  factory ContactTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContactTableData(
      name: serializer.fromJson<String>(json['name']),
      phNumber: serializer.fromJson<String>(json['phNumber']),
      address: serializer.fromJson<String>(json['address']),
      isCustomer: serializer.fromJson<bool>(json['isCustomer']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'phNumber': serializer.toJson<String>(phNumber),
      'address': serializer.toJson<String>(address),
      'isCustomer': serializer.toJson<bool>(isCustomer),
    };
  }

  ContactTableData copyWith(
          {String? name,
          String? phNumber,
          String? address,
          bool? isCustomer}) =>
      ContactTableData(
        name: name ?? this.name,
        phNumber: phNumber ?? this.phNumber,
        address: address ?? this.address,
        isCustomer: isCustomer ?? this.isCustomer,
      );
  @override
  String toString() {
    return (StringBuffer('ContactTableData(')
          ..write('name: $name, ')
          ..write('phNumber: $phNumber, ')
          ..write('address: $address, ')
          ..write('isCustomer: $isCustomer')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(name, phNumber, address, isCustomer);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContactTableData &&
          other.name == this.name &&
          other.phNumber == this.phNumber &&
          other.address == this.address &&
          other.isCustomer == this.isCustomer);
}

class ContactTableCompanion extends UpdateCompanion<ContactTableData> {
  final Value<String> name;
  final Value<String> phNumber;
  final Value<String> address;
  final Value<bool> isCustomer;
  const ContactTableCompanion({
    this.name = const Value.absent(),
    this.phNumber = const Value.absent(),
    this.address = const Value.absent(),
    this.isCustomer = const Value.absent(),
  });
  ContactTableCompanion.insert({
    required String name,
    required String phNumber,
    required String address,
    required bool isCustomer,
  })  : name = Value(name),
        phNumber = Value(phNumber),
        address = Value(address),
        isCustomer = Value(isCustomer);
  static Insertable<ContactTableData> custom({
    Expression<String>? name,
    Expression<String>? phNumber,
    Expression<String>? address,
    Expression<bool>? isCustomer,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (phNumber != null) 'phNumber': phNumber,
      if (address != null) 'address': address,
      if (isCustomer != null) 'is_customer': isCustomer,
    });
  }

  ContactTableCompanion copyWith(
      {Value<String>? name,
      Value<String>? phNumber,
      Value<String>? address,
      Value<bool>? isCustomer}) {
    return ContactTableCompanion(
      name: name ?? this.name,
      phNumber: phNumber ?? this.phNumber,
      address: address ?? this.address,
      isCustomer: isCustomer ?? this.isCustomer,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phNumber.present) {
      map['phNumber'] = Variable<String>(phNumber.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (isCustomer.present) {
      map['is_customer'] = Variable<bool>(isCustomer.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactTableCompanion(')
          ..write('name: $name, ')
          ..write('phNumber: $phNumber, ')
          ..write('address: $address, ')
          ..write('isCustomer: $isCustomer')
          ..write(')'))
        .toString();
  }
}

class $ContactTableTable extends ContactTable
    with TableInfo<$ContactTableTable, ContactTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _phNumberMeta =
      const VerificationMeta('phNumber');
  @override
  late final GeneratedColumn<String> phNumber = GeneratedColumn<String>(
      'phNumber', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isCustomerMeta =
      const VerificationMeta('isCustomer');
  @override
  late final GeneratedColumn<bool> isCustomer =
      GeneratedColumn<bool>('is_customer', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_customer" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  @override
  List<GeneratedColumn> get $columns => [name, phNumber, address, isCustomer];
  @override
  String get aliasedName => _alias ?? 'contact_table';
  @override
  String get actualTableName => 'contact_table';
  @override
  VerificationContext validateIntegrity(Insertable<ContactTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phNumber')) {
      context.handle(_phNumberMeta,
          phNumber.isAcceptableOrUnknown(data['phNumber']!, _phNumberMeta));
    } else if (isInserting) {
      context.missing(_phNumberMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('is_customer')) {
      context.handle(
          _isCustomerMeta,
          isCustomer.isAcceptableOrUnknown(
              data['is_customer']!, _isCustomerMeta));
    } else if (isInserting) {
      context.missing(_isCustomerMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  ContactTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContactTableData(
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      phNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phNumber'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address'])!,
      isCustomer: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_customer'])!,
    );
  }

  @override
  $ContactTableTable createAlias(String alias) {
    return $ContactTableTable(attachedDatabase, alias);
  }
}

class CategoryTableData extends DataClass
    implements Insertable<CategoryTableData> {
  final String name;
  final String description;
  const CategoryTableData({required this.name, required this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    map['desc'] = Variable<String>(description);
    return map;
  }

  CategoryTableCompanion toCompanion(bool nullToAbsent) {
    return CategoryTableCompanion(
      name: Value(name),
      description: Value(description),
    );
  }

  factory CategoryTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryTableData(
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
    };
  }

  CategoryTableData copyWith({String? name, String? description}) =>
      CategoryTableData(
        name: name ?? this.name,
        description: description ?? this.description,
      );
  @override
  String toString() {
    return (StringBuffer('CategoryTableData(')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(name, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryTableData &&
          other.name == this.name &&
          other.description == this.description);
}

class CategoryTableCompanion extends UpdateCompanion<CategoryTableData> {
  final Value<String> name;
  final Value<String> description;
  const CategoryTableCompanion({
    this.name = const Value.absent(),
    this.description = const Value.absent(),
  });
  CategoryTableCompanion.insert({
    required String name,
    required String description,
  })  : name = Value(name),
        description = Value(description);
  static Insertable<CategoryTableData> custom({
    Expression<String>? name,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (description != null) 'desc': description,
    });
  }

  CategoryTableCompanion copyWith(
      {Value<String>? name, Value<String>? description}) {
    return CategoryTableCompanion(
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['desc'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryTableCompanion(')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $CategoryTableTable extends CategoryTable
    with TableInfo<$CategoryTableTable, CategoryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'desc', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [name, description];
  @override
  String get aliasedName => _alias ?? 'category_table';
  @override
  String get actualTableName => 'category_table';
  @override
  VerificationContext validateIntegrity(Insertable<CategoryTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('desc')) {
      context.handle(_descriptionMeta,
          description.isAcceptableOrUnknown(data['desc']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  CategoryTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryTableData(
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}desc'])!,
    );
  }

  @override
  $CategoryTableTable createAlias(String alias) {
    return $CategoryTableTable(attachedDatabase, alias);
  }
}

class ItemTableData extends DataClass implements Insertable<ItemTableData> {
  final String name;
  final int qty;
  final String category;
  final int purchasePrice;
  final int retailPrice;
  final int wholeSalePrice;
  final String desc;
  const ItemTableData(
      {required this.name,
      required this.qty,
      required this.category,
      required this.purchasePrice,
      required this.retailPrice,
      required this.wholeSalePrice,
      required this.desc});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['item_name'] = Variable<String>(name);
    map['quantity'] = Variable<int>(qty);
    map['category'] = Variable<String>(category);
    map['purchase_price'] = Variable<int>(purchasePrice);
    map['retail_price'] = Variable<int>(retailPrice);
    map['wholesale_price'] = Variable<int>(wholeSalePrice);
    map['desc'] = Variable<String>(desc);
    return map;
  }

  ItemTableCompanion toCompanion(bool nullToAbsent) {
    return ItemTableCompanion(
      name: Value(name),
      qty: Value(qty),
      category: Value(category),
      purchasePrice: Value(purchasePrice),
      retailPrice: Value(retailPrice),
      wholeSalePrice: Value(wholeSalePrice),
      desc: Value(desc),
    );
  }

  factory ItemTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItemTableData(
      name: serializer.fromJson<String>(json['name']),
      qty: serializer.fromJson<int>(json['qty']),
      category: serializer.fromJson<String>(json['category']),
      purchasePrice: serializer.fromJson<int>(json['purchasePrice']),
      retailPrice: serializer.fromJson<int>(json['retailPrice']),
      wholeSalePrice: serializer.fromJson<int>(json['wholeSalePrice']),
      desc: serializer.fromJson<String>(json['desc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'qty': serializer.toJson<int>(qty),
      'category': serializer.toJson<String>(category),
      'purchasePrice': serializer.toJson<int>(purchasePrice),
      'retailPrice': serializer.toJson<int>(retailPrice),
      'wholeSalePrice': serializer.toJson<int>(wholeSalePrice),
      'desc': serializer.toJson<String>(desc),
    };
  }

  ItemTableData copyWith(
          {String? name,
          int? qty,
          String? category,
          int? purchasePrice,
          int? retailPrice,
          int? wholeSalePrice,
          String? desc}) =>
      ItemTableData(
        name: name ?? this.name,
        qty: qty ?? this.qty,
        category: category ?? this.category,
        purchasePrice: purchasePrice ?? this.purchasePrice,
        retailPrice: retailPrice ?? this.retailPrice,
        wholeSalePrice: wholeSalePrice ?? this.wholeSalePrice,
        desc: desc ?? this.desc,
      );
  @override
  String toString() {
    return (StringBuffer('ItemTableData(')
          ..write('name: $name, ')
          ..write('qty: $qty, ')
          ..write('category: $category, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('retailPrice: $retailPrice, ')
          ..write('wholeSalePrice: $wholeSalePrice, ')
          ..write('desc: $desc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      name, qty, category, purchasePrice, retailPrice, wholeSalePrice, desc);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemTableData &&
          other.name == this.name &&
          other.qty == this.qty &&
          other.category == this.category &&
          other.purchasePrice == this.purchasePrice &&
          other.retailPrice == this.retailPrice &&
          other.wholeSalePrice == this.wholeSalePrice &&
          other.desc == this.desc);
}

class ItemTableCompanion extends UpdateCompanion<ItemTableData> {
  final Value<String> name;
  final Value<int> qty;
  final Value<String> category;
  final Value<int> purchasePrice;
  final Value<int> retailPrice;
  final Value<int> wholeSalePrice;
  final Value<String> desc;
  const ItemTableCompanion({
    this.name = const Value.absent(),
    this.qty = const Value.absent(),
    this.category = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.retailPrice = const Value.absent(),
    this.wholeSalePrice = const Value.absent(),
    this.desc = const Value.absent(),
  });
  ItemTableCompanion.insert({
    required String name,
    required int qty,
    required String category,
    required int purchasePrice,
    required int retailPrice,
    required int wholeSalePrice,
    required String desc,
  })  : name = Value(name),
        qty = Value(qty),
        category = Value(category),
        purchasePrice = Value(purchasePrice),
        retailPrice = Value(retailPrice),
        wholeSalePrice = Value(wholeSalePrice),
        desc = Value(desc);
  static Insertable<ItemTableData> custom({
    Expression<String>? name,
    Expression<int>? qty,
    Expression<String>? category,
    Expression<int>? purchasePrice,
    Expression<int>? retailPrice,
    Expression<int>? wholeSalePrice,
    Expression<String>? desc,
  }) {
    return RawValuesInsertable({
      if (name != null) 'item_name': name,
      if (qty != null) 'quantity': qty,
      if (category != null) 'category': category,
      if (purchasePrice != null) 'purchase_price': purchasePrice,
      if (retailPrice != null) 'retail_price': retailPrice,
      if (wholeSalePrice != null) 'wholesale_price': wholeSalePrice,
      if (desc != null) 'desc': desc,
    });
  }

  ItemTableCompanion copyWith(
      {Value<String>? name,
      Value<int>? qty,
      Value<String>? category,
      Value<int>? purchasePrice,
      Value<int>? retailPrice,
      Value<int>? wholeSalePrice,
      Value<String>? desc}) {
    return ItemTableCompanion(
      name: name ?? this.name,
      qty: qty ?? this.qty,
      category: category ?? this.category,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      retailPrice: retailPrice ?? this.retailPrice,
      wholeSalePrice: wholeSalePrice ?? this.wholeSalePrice,
      desc: desc ?? this.desc,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['item_name'] = Variable<String>(name.value);
    }
    if (qty.present) {
      map['quantity'] = Variable<int>(qty.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (purchasePrice.present) {
      map['purchase_price'] = Variable<int>(purchasePrice.value);
    }
    if (retailPrice.present) {
      map['retail_price'] = Variable<int>(retailPrice.value);
    }
    if (wholeSalePrice.present) {
      map['wholesale_price'] = Variable<int>(wholeSalePrice.value);
    }
    if (desc.present) {
      map['desc'] = Variable<String>(desc.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemTableCompanion(')
          ..write('name: $name, ')
          ..write('qty: $qty, ')
          ..write('category: $category, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('retailPrice: $retailPrice, ')
          ..write('wholeSalePrice: $wholeSalePrice, ')
          ..write('desc: $desc')
          ..write(')'))
        .toString();
  }
}

class $ItemTableTable extends ItemTable
    with TableInfo<$ItemTableTable, ItemTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'item_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _qtyMeta = const VerificationMeta('qty');
  @override
  late final GeneratedColumn<int> qty = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES category_table (name)'));
  static const VerificationMeta _purchasePriceMeta =
      const VerificationMeta('purchasePrice');
  @override
  late final GeneratedColumn<int> purchasePrice = GeneratedColumn<int>(
      'purchase_price', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _retailPriceMeta =
      const VerificationMeta('retailPrice');
  @override
  late final GeneratedColumn<int> retailPrice = GeneratedColumn<int>(
      'retail_price', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _wholeSalePriceMeta =
      const VerificationMeta('wholeSalePrice');
  @override
  late final GeneratedColumn<int> wholeSalePrice = GeneratedColumn<int>(
      'wholesale_price', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _descMeta = const VerificationMeta('desc');
  @override
  late final GeneratedColumn<String> desc = GeneratedColumn<String>(
      'desc', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [name, qty, category, purchasePrice, retailPrice, wholeSalePrice, desc];
  @override
  String get aliasedName => _alias ?? 'item_table';
  @override
  String get actualTableName => 'item_table';
  @override
  VerificationContext validateIntegrity(Insertable<ItemTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('item_name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['item_name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
          _qtyMeta, qty.isAcceptableOrUnknown(data['quantity']!, _qtyMeta));
    } else if (isInserting) {
      context.missing(_qtyMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('purchase_price')) {
      context.handle(
          _purchasePriceMeta,
          purchasePrice.isAcceptableOrUnknown(
              data['purchase_price']!, _purchasePriceMeta));
    } else if (isInserting) {
      context.missing(_purchasePriceMeta);
    }
    if (data.containsKey('retail_price')) {
      context.handle(
          _retailPriceMeta,
          retailPrice.isAcceptableOrUnknown(
              data['retail_price']!, _retailPriceMeta));
    } else if (isInserting) {
      context.missing(_retailPriceMeta);
    }
    if (data.containsKey('wholesale_price')) {
      context.handle(
          _wholeSalePriceMeta,
          wholeSalePrice.isAcceptableOrUnknown(
              data['wholesale_price']!, _wholeSalePriceMeta));
    } else if (isInserting) {
      context.missing(_wholeSalePriceMeta);
    }
    if (data.containsKey('desc')) {
      context.handle(
          _descMeta, desc.isAcceptableOrUnknown(data['desc']!, _descMeta));
    } else if (isInserting) {
      context.missing(_descMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  ItemTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItemTableData(
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_name'])!,
      qty: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      purchasePrice: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}purchase_price'])!,
      retailPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}retail_price'])!,
      wholeSalePrice: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}wholesale_price'])!,
      desc: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}desc'])!,
    );
  }

  @override
  $ItemTableTable createAlias(String alias) {
    return $ItemTableTable(attachedDatabase, alias);
  }
}

class TransactionTableData extends DataClass
    implements Insertable<TransactionTableData> {
  final int id;
  final String desc;
  final int amount;
  final String remark;
  final bool isIncome;
  final DateTime dateRecorded;
  const TransactionTableData(
      {required this.id,
      required this.desc,
      required this.amount,
      required this.remark,
      required this.isIncome,
      required this.dateRecorded});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['desc'] = Variable<String>(desc);
    map['amount'] = Variable<int>(amount);
    map['remark'] = Variable<String>(remark);
    map['is_income'] = Variable<bool>(isIncome);
    map['date_recorded'] = Variable<DateTime>(dateRecorded);
    return map;
  }

  TransactionTableCompanion toCompanion(bool nullToAbsent) {
    return TransactionTableCompanion(
      id: Value(id),
      desc: Value(desc),
      amount: Value(amount),
      remark: Value(remark),
      isIncome: Value(isIncome),
      dateRecorded: Value(dateRecorded),
    );
  }

  factory TransactionTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionTableData(
      id: serializer.fromJson<int>(json['id']),
      desc: serializer.fromJson<String>(json['desc']),
      amount: serializer.fromJson<int>(json['amount']),
      remark: serializer.fromJson<String>(json['remark']),
      isIncome: serializer.fromJson<bool>(json['isIncome']),
      dateRecorded: serializer.fromJson<DateTime>(json['dateRecorded']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'desc': serializer.toJson<String>(desc),
      'amount': serializer.toJson<int>(amount),
      'remark': serializer.toJson<String>(remark),
      'isIncome': serializer.toJson<bool>(isIncome),
      'dateRecorded': serializer.toJson<DateTime>(dateRecorded),
    };
  }

  TransactionTableData copyWith(
          {int? id,
          String? desc,
          int? amount,
          String? remark,
          bool? isIncome,
          DateTime? dateRecorded}) =>
      TransactionTableData(
        id: id ?? this.id,
        desc: desc ?? this.desc,
        amount: amount ?? this.amount,
        remark: remark ?? this.remark,
        isIncome: isIncome ?? this.isIncome,
        dateRecorded: dateRecorded ?? this.dateRecorded,
      );
  @override
  String toString() {
    return (StringBuffer('TransactionTableData(')
          ..write('id: $id, ')
          ..write('desc: $desc, ')
          ..write('amount: $amount, ')
          ..write('remark: $remark, ')
          ..write('isIncome: $isIncome, ')
          ..write('dateRecorded: $dateRecorded')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, desc, amount, remark, isIncome, dateRecorded);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionTableData &&
          other.id == this.id &&
          other.desc == this.desc &&
          other.amount == this.amount &&
          other.remark == this.remark &&
          other.isIncome == this.isIncome &&
          other.dateRecorded == this.dateRecorded);
}

class TransactionTableCompanion extends UpdateCompanion<TransactionTableData> {
  final Value<int> id;
  final Value<String> desc;
  final Value<int> amount;
  final Value<String> remark;
  final Value<bool> isIncome;
  final Value<DateTime> dateRecorded;
  const TransactionTableCompanion({
    this.id = const Value.absent(),
    this.desc = const Value.absent(),
    this.amount = const Value.absent(),
    this.remark = const Value.absent(),
    this.isIncome = const Value.absent(),
    this.dateRecorded = const Value.absent(),
  });
  TransactionTableCompanion.insert({
    this.id = const Value.absent(),
    required String desc,
    required int amount,
    required String remark,
    required bool isIncome,
    required DateTime dateRecorded,
  })  : desc = Value(desc),
        amount = Value(amount),
        remark = Value(remark),
        isIncome = Value(isIncome),
        dateRecorded = Value(dateRecorded);
  static Insertable<TransactionTableData> custom({
    Expression<int>? id,
    Expression<String>? desc,
    Expression<int>? amount,
    Expression<String>? remark,
    Expression<bool>? isIncome,
    Expression<DateTime>? dateRecorded,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (desc != null) 'desc': desc,
      if (amount != null) 'amount': amount,
      if (remark != null) 'remark': remark,
      if (isIncome != null) 'is_income': isIncome,
      if (dateRecorded != null) 'date_recorded': dateRecorded,
    });
  }

  TransactionTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? desc,
      Value<int>? amount,
      Value<String>? remark,
      Value<bool>? isIncome,
      Value<DateTime>? dateRecorded}) {
    return TransactionTableCompanion(
      id: id ?? this.id,
      desc: desc ?? this.desc,
      amount: amount ?? this.amount,
      remark: remark ?? this.remark,
      isIncome: isIncome ?? this.isIncome,
      dateRecorded: dateRecorded ?? this.dateRecorded,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (desc.present) {
      map['desc'] = Variable<String>(desc.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (remark.present) {
      map['remark'] = Variable<String>(remark.value);
    }
    if (isIncome.present) {
      map['is_income'] = Variable<bool>(isIncome.value);
    }
    if (dateRecorded.present) {
      map['date_recorded'] = Variable<DateTime>(dateRecorded.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionTableCompanion(')
          ..write('id: $id, ')
          ..write('desc: $desc, ')
          ..write('amount: $amount, ')
          ..write('remark: $remark, ')
          ..write('isIncome: $isIncome, ')
          ..write('dateRecorded: $dateRecorded')
          ..write(')'))
        .toString();
  }
}

class $TransactionTableTable extends TransactionTable
    with TableInfo<$TransactionTableTable, TransactionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _descMeta = const VerificationMeta('desc');
  @override
  late final GeneratedColumn<String> desc = GeneratedColumn<String>(
      'desc', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _remarkMeta = const VerificationMeta('remark');
  @override
  late final GeneratedColumn<String> remark = GeneratedColumn<String>(
      'remark', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isIncomeMeta =
      const VerificationMeta('isIncome');
  @override
  late final GeneratedColumn<bool> isIncome =
      GeneratedColumn<bool>('is_income', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_income" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _dateRecordedMeta =
      const VerificationMeta('dateRecorded');
  @override
  late final GeneratedColumn<DateTime> dateRecorded = GeneratedColumn<DateTime>(
      'date_recorded', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, desc, amount, remark, isIncome, dateRecorded];
  @override
  String get aliasedName => _alias ?? 'transaction_table';
  @override
  String get actualTableName => 'transaction_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<TransactionTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('desc')) {
      context.handle(
          _descMeta, desc.isAcceptableOrUnknown(data['desc']!, _descMeta));
    } else if (isInserting) {
      context.missing(_descMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('remark')) {
      context.handle(_remarkMeta,
          remark.isAcceptableOrUnknown(data['remark']!, _remarkMeta));
    } else if (isInserting) {
      context.missing(_remarkMeta);
    }
    if (data.containsKey('is_income')) {
      context.handle(_isIncomeMeta,
          isIncome.isAcceptableOrUnknown(data['is_income']!, _isIncomeMeta));
    } else if (isInserting) {
      context.missing(_isIncomeMeta);
    }
    if (data.containsKey('date_recorded')) {
      context.handle(
          _dateRecordedMeta,
          dateRecorded.isAcceptableOrUnknown(
              data['date_recorded']!, _dateRecordedMeta));
    } else if (isInserting) {
      context.missing(_dateRecordedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      desc: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}desc'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      remark: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remark'])!,
      isIncome: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_income'])!,
      dateRecorded: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}date_recorded'])!,
    );
  }

  @override
  $TransactionTableTable createAlias(String alias) {
    return $TransactionTableTable(attachedDatabase, alias);
  }
}

class InvoiceTableData extends DataClass
    implements Insertable<InvoiceTableData> {
  final int id;
  final String person;
  final DateTime dateRecorded;
  final int totalAmount;
  final bool isSale;
  const InvoiceTableData(
      {required this.id,
      required this.person,
      required this.dateRecorded,
      required this.totalAmount,
      required this.isSale});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['person'] = Variable<String>(person);
    map['date_recorded'] = Variable<DateTime>(dateRecorded);
    map['total_amount'] = Variable<int>(totalAmount);
    map['is_sale'] = Variable<bool>(isSale);
    return map;
  }

  InvoiceTableCompanion toCompanion(bool nullToAbsent) {
    return InvoiceTableCompanion(
      id: Value(id),
      person: Value(person),
      dateRecorded: Value(dateRecorded),
      totalAmount: Value(totalAmount),
      isSale: Value(isSale),
    );
  }

  factory InvoiceTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoiceTableData(
      id: serializer.fromJson<int>(json['id']),
      person: serializer.fromJson<String>(json['person']),
      dateRecorded: serializer.fromJson<DateTime>(json['dateRecorded']),
      totalAmount: serializer.fromJson<int>(json['totalAmount']),
      isSale: serializer.fromJson<bool>(json['isSale']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'person': serializer.toJson<String>(person),
      'dateRecorded': serializer.toJson<DateTime>(dateRecorded),
      'totalAmount': serializer.toJson<int>(totalAmount),
      'isSale': serializer.toJson<bool>(isSale),
    };
  }

  InvoiceTableData copyWith(
          {int? id,
          String? person,
          DateTime? dateRecorded,
          int? totalAmount,
          bool? isSale}) =>
      InvoiceTableData(
        id: id ?? this.id,
        person: person ?? this.person,
        dateRecorded: dateRecorded ?? this.dateRecorded,
        totalAmount: totalAmount ?? this.totalAmount,
        isSale: isSale ?? this.isSale,
      );
  @override
  String toString() {
    return (StringBuffer('InvoiceTableData(')
          ..write('id: $id, ')
          ..write('person: $person, ')
          ..write('dateRecorded: $dateRecorded, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('isSale: $isSale')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, person, dateRecorded, totalAmount, isSale);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoiceTableData &&
          other.id == this.id &&
          other.person == this.person &&
          other.dateRecorded == this.dateRecorded &&
          other.totalAmount == this.totalAmount &&
          other.isSale == this.isSale);
}

class InvoiceTableCompanion extends UpdateCompanion<InvoiceTableData> {
  final Value<int> id;
  final Value<String> person;
  final Value<DateTime> dateRecorded;
  final Value<int> totalAmount;
  final Value<bool> isSale;
  const InvoiceTableCompanion({
    this.id = const Value.absent(),
    this.person = const Value.absent(),
    this.dateRecorded = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.isSale = const Value.absent(),
  });
  InvoiceTableCompanion.insert({
    this.id = const Value.absent(),
    required String person,
    required DateTime dateRecorded,
    required int totalAmount,
    required bool isSale,
  })  : person = Value(person),
        dateRecorded = Value(dateRecorded),
        totalAmount = Value(totalAmount),
        isSale = Value(isSale);
  static Insertable<InvoiceTableData> custom({
    Expression<int>? id,
    Expression<String>? person,
    Expression<DateTime>? dateRecorded,
    Expression<int>? totalAmount,
    Expression<bool>? isSale,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (person != null) 'person': person,
      if (dateRecorded != null) 'date_recorded': dateRecorded,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (isSale != null) 'is_sale': isSale,
    });
  }

  InvoiceTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? person,
      Value<DateTime>? dateRecorded,
      Value<int>? totalAmount,
      Value<bool>? isSale}) {
    return InvoiceTableCompanion(
      id: id ?? this.id,
      person: person ?? this.person,
      dateRecorded: dateRecorded ?? this.dateRecorded,
      totalAmount: totalAmount ?? this.totalAmount,
      isSale: isSale ?? this.isSale,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (person.present) {
      map['person'] = Variable<String>(person.value);
    }
    if (dateRecorded.present) {
      map['date_recorded'] = Variable<DateTime>(dateRecorded.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<int>(totalAmount.value);
    }
    if (isSale.present) {
      map['is_sale'] = Variable<bool>(isSale.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceTableCompanion(')
          ..write('id: $id, ')
          ..write('person: $person, ')
          ..write('dateRecorded: $dateRecorded, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('isSale: $isSale')
          ..write(')'))
        .toString();
  }
}

class $InvoiceTableTable extends InvoiceTable
    with TableInfo<$InvoiceTableTable, InvoiceTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoiceTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _personMeta = const VerificationMeta('person');
  @override
  late final GeneratedColumn<String> person = GeneratedColumn<String>(
      'person', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES contact_table (name)'));
  static const VerificationMeta _dateRecordedMeta =
      const VerificationMeta('dateRecorded');
  @override
  late final GeneratedColumn<DateTime> dateRecorded = GeneratedColumn<DateTime>(
      'date_recorded', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _totalAmountMeta =
      const VerificationMeta('totalAmount');
  @override
  late final GeneratedColumn<int> totalAmount = GeneratedColumn<int>(
      'total_amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isSaleMeta = const VerificationMeta('isSale');
  @override
  late final GeneratedColumn<bool> isSale =
      GeneratedColumn<bool>('is_sale', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_sale" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  @override
  List<GeneratedColumn> get $columns =>
      [id, person, dateRecorded, totalAmount, isSale];
  @override
  String get aliasedName => _alias ?? 'invoice_table';
  @override
  String get actualTableName => 'invoice_table';
  @override
  VerificationContext validateIntegrity(Insertable<InvoiceTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('person')) {
      context.handle(_personMeta,
          person.isAcceptableOrUnknown(data['person']!, _personMeta));
    } else if (isInserting) {
      context.missing(_personMeta);
    }
    if (data.containsKey('date_recorded')) {
      context.handle(
          _dateRecordedMeta,
          dateRecorded.isAcceptableOrUnknown(
              data['date_recorded']!, _dateRecordedMeta));
    } else if (isInserting) {
      context.missing(_dateRecordedMeta);
    }
    if (data.containsKey('total_amount')) {
      context.handle(
          _totalAmountMeta,
          totalAmount.isAcceptableOrUnknown(
              data['total_amount']!, _totalAmountMeta));
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('is_sale')) {
      context.handle(_isSaleMeta,
          isSale.isAcceptableOrUnknown(data['is_sale']!, _isSaleMeta));
    } else if (isInserting) {
      context.missing(_isSaleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvoiceTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvoiceTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      person: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}person'])!,
      dateRecorded: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}date_recorded'])!,
      totalAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_amount'])!,
      isSale: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_sale'])!,
    );
  }

  @override
  $InvoiceTableTable createAlias(String alias) {
    return $InvoiceTableTable(attachedDatabase, alias);
  }
}

class SaleTableData extends DataClass implements Insertable<SaleTableData> {
  final int id;
  final int? invoiceId;
  final String item;
  final int itemPrice;
  final int itemQty;
  const SaleTableData(
      {required this.id,
      this.invoiceId,
      required this.item,
      required this.itemPrice,
      required this.itemQty});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || invoiceId != null) {
      map['invoice_id'] = Variable<int>(invoiceId);
    }
    map['item'] = Variable<String>(item);
    map['item_price'] = Variable<int>(itemPrice);
    map['item_qty'] = Variable<int>(itemQty);
    return map;
  }

  SaleTableCompanion toCompanion(bool nullToAbsent) {
    return SaleTableCompanion(
      id: Value(id),
      invoiceId: invoiceId == null && nullToAbsent
          ? const Value.absent()
          : Value(invoiceId),
      item: Value(item),
      itemPrice: Value(itemPrice),
      itemQty: Value(itemQty),
    );
  }

  factory SaleTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SaleTableData(
      id: serializer.fromJson<int>(json['id']),
      invoiceId: serializer.fromJson<int?>(json['invoiceId']),
      item: serializer.fromJson<String>(json['item']),
      itemPrice: serializer.fromJson<int>(json['itemPrice']),
      itemQty: serializer.fromJson<int>(json['itemQty']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoiceId': serializer.toJson<int?>(invoiceId),
      'item': serializer.toJson<String>(item),
      'itemPrice': serializer.toJson<int>(itemPrice),
      'itemQty': serializer.toJson<int>(itemQty),
    };
  }

  SaleTableData copyWith(
          {int? id,
          Value<int?> invoiceId = const Value.absent(),
          String? item,
          int? itemPrice,
          int? itemQty}) =>
      SaleTableData(
        id: id ?? this.id,
        invoiceId: invoiceId.present ? invoiceId.value : this.invoiceId,
        item: item ?? this.item,
        itemPrice: itemPrice ?? this.itemPrice,
        itemQty: itemQty ?? this.itemQty,
      );
  @override
  String toString() {
    return (StringBuffer('SaleTableData(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('item: $item, ')
          ..write('itemPrice: $itemPrice, ')
          ..write('itemQty: $itemQty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, invoiceId, item, itemPrice, itemQty);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SaleTableData &&
          other.id == this.id &&
          other.invoiceId == this.invoiceId &&
          other.item == this.item &&
          other.itemPrice == this.itemPrice &&
          other.itemQty == this.itemQty);
}

class SaleTableCompanion extends UpdateCompanion<SaleTableData> {
  final Value<int> id;
  final Value<int?> invoiceId;
  final Value<String> item;
  final Value<int> itemPrice;
  final Value<int> itemQty;
  const SaleTableCompanion({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.item = const Value.absent(),
    this.itemPrice = const Value.absent(),
    this.itemQty = const Value.absent(),
  });
  SaleTableCompanion.insert({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    required String item,
    required int itemPrice,
    required int itemQty,
  })  : item = Value(item),
        itemPrice = Value(itemPrice),
        itemQty = Value(itemQty);
  static Insertable<SaleTableData> custom({
    Expression<int>? id,
    Expression<int>? invoiceId,
    Expression<String>? item,
    Expression<int>? itemPrice,
    Expression<int>? itemQty,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (item != null) 'item': item,
      if (itemPrice != null) 'item_price': itemPrice,
      if (itemQty != null) 'item_qty': itemQty,
    });
  }

  SaleTableCompanion copyWith(
      {Value<int>? id,
      Value<int?>? invoiceId,
      Value<String>? item,
      Value<int>? itemPrice,
      Value<int>? itemQty}) {
    return SaleTableCompanion(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      item: item ?? this.item,
      itemPrice: itemPrice ?? this.itemPrice,
      itemQty: itemQty ?? this.itemQty,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<int>(invoiceId.value);
    }
    if (item.present) {
      map['item'] = Variable<String>(item.value);
    }
    if (itemPrice.present) {
      map['item_price'] = Variable<int>(itemPrice.value);
    }
    if (itemQty.present) {
      map['item_qty'] = Variable<int>(itemQty.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SaleTableCompanion(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('item: $item, ')
          ..write('itemPrice: $itemPrice, ')
          ..write('itemQty: $itemQty')
          ..write(')'))
        .toString();
  }
}

class $SaleTableTable extends SaleTable
    with TableInfo<$SaleTableTable, SaleTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SaleTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _invoiceIdMeta =
      const VerificationMeta('invoiceId');
  @override
  late final GeneratedColumn<int> invoiceId = GeneratedColumn<int>(
      'invoice_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES invoice_table (id)'));
  static const VerificationMeta _itemMeta = const VerificationMeta('item');
  @override
  late final GeneratedColumn<String> item = GeneratedColumn<String>(
      'item', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES item_table (item_name)'));
  static const VerificationMeta _itemPriceMeta =
      const VerificationMeta('itemPrice');
  @override
  late final GeneratedColumn<int> itemPrice = GeneratedColumn<int>(
      'item_price', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _itemQtyMeta =
      const VerificationMeta('itemQty');
  @override
  late final GeneratedColumn<int> itemQty = GeneratedColumn<int>(
      'item_qty', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, invoiceId, item, itemPrice, itemQty];
  @override
  String get aliasedName => _alias ?? 'sale_table';
  @override
  String get actualTableName => 'sale_table';
  @override
  VerificationContext validateIntegrity(Insertable<SaleTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('invoice_id')) {
      context.handle(_invoiceIdMeta,
          invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta));
    }
    if (data.containsKey('item')) {
      context.handle(
          _itemMeta, item.isAcceptableOrUnknown(data['item']!, _itemMeta));
    } else if (isInserting) {
      context.missing(_itemMeta);
    }
    if (data.containsKey('item_price')) {
      context.handle(_itemPriceMeta,
          itemPrice.isAcceptableOrUnknown(data['item_price']!, _itemPriceMeta));
    } else if (isInserting) {
      context.missing(_itemPriceMeta);
    }
    if (data.containsKey('item_qty')) {
      context.handle(_itemQtyMeta,
          itemQty.isAcceptableOrUnknown(data['item_qty']!, _itemQtyMeta));
    } else if (isInserting) {
      context.missing(_itemQtyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SaleTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SaleTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      invoiceId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}invoice_id']),
      item: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item'])!,
      itemPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}item_price'])!,
      itemQty: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}item_qty'])!,
    );
  }

  @override
  $SaleTableTable createAlias(String alias) {
    return $SaleTableTable(attachedDatabase, alias);
  }
}

abstract class _$DatabaseImpl extends GeneratedDatabase {
  _$DatabaseImpl(QueryExecutor e) : super(e);
  late final $ContactTableTable contactTable = $ContactTableTable(this);
  late final $CategoryTableTable categoryTable = $CategoryTableTable(this);
  late final $ItemTableTable itemTable = $ItemTableTable(this);
  late final $TransactionTableTable transactionTable =
      $TransactionTableTable(this);
  late final $InvoiceTableTable invoiceTable = $InvoiceTableTable(this);
  late final $SaleTableTable saleTable = $SaleTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        contactTable,
        categoryTable,
        itemTable,
        transactionTable,
        invoiceTable,
        saleTable
      ];
}
