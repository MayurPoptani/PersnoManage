// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class TodoTask extends DataClass implements Insertable<TodoTask> {
  final int id;
  final String title;
  final DateTime scheduledDateTime;
  final DateTime completedDateTime;
  final String tags;
  final String description;
  final double completed;
  TodoTask(
      {@required this.id,
      @required this.title,
      @required this.scheduledDateTime,
      @required this.completedDateTime,
      @required this.tags,
      @required this.description,
      this.completed});
  factory TodoTask.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final doubleType = db.typeSystem.forDartType<double>();
    return TodoTask(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      scheduledDateTime: dateTimeType.mapFromDatabaseResponse(
          data['${effectivePrefix}scheduled_date_time']),
      completedDateTime: dateTimeType.mapFromDatabaseResponse(
          data['${effectivePrefix}completed_date_time']),
      tags: stringType.mapFromDatabaseResponse(data['${effectivePrefix}tags']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      completed: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}completed']),
    );
  }
  factory TodoTask.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return TodoTask(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      scheduledDateTime:
          serializer.fromJson<DateTime>(json['scheduledDateTime']),
      completedDateTime:
          serializer.fromJson<DateTime>(json['completedDateTime']),
      tags: serializer.fromJson<String>(json['tags']),
      description: serializer.fromJson<String>(json['description']),
      completed: serializer.fromJson<double>(json['completed']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'scheduledDateTime': serializer.toJson<DateTime>(scheduledDateTime),
      'completedDateTime': serializer.toJson<DateTime>(completedDateTime),
      'tags': serializer.toJson<String>(tags),
      'description': serializer.toJson<String>(description),
      'completed': serializer.toJson<double>(completed),
    };
  }

  @override
  TodoTasksCompanion createCompanion(bool nullToAbsent) {
    return TodoTasksCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      scheduledDateTime: scheduledDateTime == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduledDateTime),
      completedDateTime: completedDateTime == null && nullToAbsent
          ? const Value.absent()
          : Value(completedDateTime),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      completed: completed == null && nullToAbsent
          ? const Value.absent()
          : Value(completed),
    );
  }

  TodoTask copyWith(
          {int id,
          String title,
          DateTime scheduledDateTime,
          DateTime completedDateTime,
          String tags,
          String description,
          double completed}) =>
      TodoTask(
        id: id ?? this.id,
        title: title ?? this.title,
        scheduledDateTime: scheduledDateTime ?? this.scheduledDateTime,
        completedDateTime: completedDateTime ?? this.completedDateTime,
        tags: tags ?? this.tags,
        description: description ?? this.description,
        completed: completed ?? this.completed,
      );
  @override
  String toString() {
    return (StringBuffer('TodoTask(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('scheduledDateTime: $scheduledDateTime, ')
          ..write('completedDateTime: $completedDateTime, ')
          ..write('tags: $tags, ')
          ..write('description: $description, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          title.hashCode,
          $mrjc(
              scheduledDateTime.hashCode,
              $mrjc(
                  completedDateTime.hashCode,
                  $mrjc(tags.hashCode,
                      $mrjc(description.hashCode, completed.hashCode)))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is TodoTask &&
          other.id == this.id &&
          other.title == this.title &&
          other.scheduledDateTime == this.scheduledDateTime &&
          other.completedDateTime == this.completedDateTime &&
          other.tags == this.tags &&
          other.description == this.description &&
          other.completed == this.completed);
}

class TodoTasksCompanion extends UpdateCompanion<TodoTask> {
  final Value<int> id;
  final Value<String> title;
  final Value<DateTime> scheduledDateTime;
  final Value<DateTime> completedDateTime;
  final Value<String> tags;
  final Value<String> description;
  final Value<double> completed;
  const TodoTasksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.scheduledDateTime = const Value.absent(),
    this.completedDateTime = const Value.absent(),
    this.tags = const Value.absent(),
    this.description = const Value.absent(),
    this.completed = const Value.absent(),
  });
  TodoTasksCompanion.insert({
    this.id = const Value.absent(),
    @required String title,
    @required DateTime scheduledDateTime,
    @required DateTime completedDateTime,
    @required String tags,
    @required String description,
    this.completed = const Value.absent(),
  })  : title = Value(title),
        scheduledDateTime = Value(scheduledDateTime),
        completedDateTime = Value(completedDateTime),
        tags = Value(tags),
        description = Value(description);
  TodoTasksCompanion copyWith(
      {Value<int> id,
      Value<String> title,
      Value<DateTime> scheduledDateTime,
      Value<DateTime> completedDateTime,
      Value<String> tags,
      Value<String> description,
      Value<double> completed}) {
    return TodoTasksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      scheduledDateTime: scheduledDateTime ?? this.scheduledDateTime,
      completedDateTime: completedDateTime ?? this.completedDateTime,
      tags: tags ?? this.tags,
      description: description ?? this.description,
      completed: completed ?? this.completed,
    );
  }
}

class $TodoTasksTable extends TodoTasks
    with TableInfo<$TodoTasksTable, TodoTask> {
  final GeneratedDatabase _db;
  final String _alias;
  $TodoTasksTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _scheduledDateTimeMeta =
      const VerificationMeta('scheduledDateTime');
  GeneratedDateTimeColumn _scheduledDateTime;
  @override
  GeneratedDateTimeColumn get scheduledDateTime =>
      _scheduledDateTime ??= _constructScheduledDateTime();
  GeneratedDateTimeColumn _constructScheduledDateTime() {
    return GeneratedDateTimeColumn(
      'scheduled_date_time',
      $tableName,
      false,
    );
  }

  final VerificationMeta _completedDateTimeMeta =
      const VerificationMeta('completedDateTime');
  GeneratedDateTimeColumn _completedDateTime;
  @override
  GeneratedDateTimeColumn get completedDateTime =>
      _completedDateTime ??= _constructCompletedDateTime();
  GeneratedDateTimeColumn _constructCompletedDateTime() {
    return GeneratedDateTimeColumn(
      'completed_date_time',
      $tableName,
      false,
    );
  }

  final VerificationMeta _tagsMeta = const VerificationMeta('tags');
  GeneratedTextColumn _tags;
  @override
  GeneratedTextColumn get tags => _tags ??= _constructTags();
  GeneratedTextColumn _constructTags() {
    return GeneratedTextColumn(
      'tags',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      false,
    );
  }

  final VerificationMeta _completedMeta = const VerificationMeta('completed');
  GeneratedRealColumn _completed;
  @override
  GeneratedRealColumn get completed => _completed ??= _constructCompleted();
  GeneratedRealColumn _constructCompleted() {
    return GeneratedRealColumn(
      'completed',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        scheduledDateTime,
        completedDateTime,
        tags,
        description,
        completed
      ];
  @override
  $TodoTasksTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'todo_tasks';
  @override
  final String actualTableName = 'todo_tasks';
  @override
  VerificationContext validateIntegrity(TodoTasksCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.title.present) {
      context.handle(
          _titleMeta, title.isAcceptableValue(d.title.value, _titleMeta));
    } else if (title.isRequired && isInserting) {
      context.missing(_titleMeta);
    }
    if (d.scheduledDateTime.present) {
      context.handle(
          _scheduledDateTimeMeta,
          scheduledDateTime.isAcceptableValue(
              d.scheduledDateTime.value, _scheduledDateTimeMeta));
    } else if (scheduledDateTime.isRequired && isInserting) {
      context.missing(_scheduledDateTimeMeta);
    }
    if (d.completedDateTime.present) {
      context.handle(
          _completedDateTimeMeta,
          completedDateTime.isAcceptableValue(
              d.completedDateTime.value, _completedDateTimeMeta));
    } else if (completedDateTime.isRequired && isInserting) {
      context.missing(_completedDateTimeMeta);
    }
    if (d.tags.present) {
      context.handle(
          _tagsMeta, tags.isAcceptableValue(d.tags.value, _tagsMeta));
    } else if (tags.isRequired && isInserting) {
      context.missing(_tagsMeta);
    }
    if (d.description.present) {
      context.handle(_descriptionMeta,
          description.isAcceptableValue(d.description.value, _descriptionMeta));
    } else if (description.isRequired && isInserting) {
      context.missing(_descriptionMeta);
    }
    if (d.completed.present) {
      context.handle(_completedMeta,
          completed.isAcceptableValue(d.completed.value, _completedMeta));
    } else if (completed.isRequired && isInserting) {
      context.missing(_completedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TodoTask map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return TodoTask.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TodoTasksCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.title.present) {
      map['title'] = Variable<String, StringType>(d.title.value);
    }
    if (d.scheduledDateTime.present) {
      map['scheduled_date_time'] =
          Variable<DateTime, DateTimeType>(d.scheduledDateTime.value);
    }
    if (d.completedDateTime.present) {
      map['completed_date_time'] =
          Variable<DateTime, DateTimeType>(d.completedDateTime.value);
    }
    if (d.tags.present) {
      map['tags'] = Variable<String, StringType>(d.tags.value);
    }
    if (d.description.present) {
      map['description'] = Variable<String, StringType>(d.description.value);
    }
    if (d.completed.present) {
      map['completed'] = Variable<double, RealType>(d.completed.value);
    }
    return map;
  }

  @override
  $TodoTasksTable createAlias(String alias) {
    return $TodoTasksTable(_db, alias);
  }
}

class TodoSubTask extends DataClass implements Insertable<TodoSubTask> {
  final int id;
  final int parentId;
  final String subTaskText;
  final String subTaskDescription;
  final bool completed;
  final DateTime addedOn;
  final DateTime completedOn;
  TodoSubTask(
      {@required this.id,
      @required this.parentId,
      @required this.subTaskText,
      @required this.subTaskDescription,
      @required this.completed,
      @required this.addedOn,
      this.completedOn});
  factory TodoSubTask.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return TodoSubTask(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      parentId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}parent_id']),
      subTaskText: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}sub_task_text']),
      subTaskDescription: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}sub_task_description']),
      completed:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}completed']),
      addedOn: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}added_on']),
      completedOn: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}completed_on']),
    );
  }
  factory TodoSubTask.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return TodoSubTask(
      id: serializer.fromJson<int>(json['id']),
      parentId: serializer.fromJson<int>(json['parentId']),
      subTaskText: serializer.fromJson<String>(json['subTaskText']),
      subTaskDescription:
          serializer.fromJson<String>(json['subTaskDescription']),
      completed: serializer.fromJson<bool>(json['completed']),
      addedOn: serializer.fromJson<DateTime>(json['addedOn']),
      completedOn: serializer.fromJson<DateTime>(json['completedOn']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'parentId': serializer.toJson<int>(parentId),
      'subTaskText': serializer.toJson<String>(subTaskText),
      'subTaskDescription': serializer.toJson<String>(subTaskDescription),
      'completed': serializer.toJson<bool>(completed),
      'addedOn': serializer.toJson<DateTime>(addedOn),
      'completedOn': serializer.toJson<DateTime>(completedOn),
    };
  }

  @override
  TodoSubTasksCompanion createCompanion(bool nullToAbsent) {
    return TodoSubTasksCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      subTaskText: subTaskText == null && nullToAbsent
          ? const Value.absent()
          : Value(subTaskText),
      subTaskDescription: subTaskDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(subTaskDescription),
      completed: completed == null && nullToAbsent
          ? const Value.absent()
          : Value(completed),
      addedOn: addedOn == null && nullToAbsent
          ? const Value.absent()
          : Value(addedOn),
      completedOn: completedOn == null && nullToAbsent
          ? const Value.absent()
          : Value(completedOn),
    );
  }

  TodoSubTask copyWith(
          {int id,
          int parentId,
          String subTaskText,
          String subTaskDescription,
          bool completed,
          DateTime addedOn,
          DateTime completedOn}) =>
      TodoSubTask(
        id: id ?? this.id,
        parentId: parentId ?? this.parentId,
        subTaskText: subTaskText ?? this.subTaskText,
        subTaskDescription: subTaskDescription ?? this.subTaskDescription,
        completed: completed ?? this.completed,
        addedOn: addedOn ?? this.addedOn,
        completedOn: completedOn ?? this.completedOn,
      );
  @override
  String toString() {
    return (StringBuffer('TodoSubTask(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('subTaskText: $subTaskText, ')
          ..write('subTaskDescription: $subTaskDescription, ')
          ..write('completed: $completed, ')
          ..write('addedOn: $addedOn, ')
          ..write('completedOn: $completedOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          parentId.hashCode,
          $mrjc(
              subTaskText.hashCode,
              $mrjc(
                  subTaskDescription.hashCode,
                  $mrjc(completed.hashCode,
                      $mrjc(addedOn.hashCode, completedOn.hashCode)))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is TodoSubTask &&
          other.id == this.id &&
          other.parentId == this.parentId &&
          other.subTaskText == this.subTaskText &&
          other.subTaskDescription == this.subTaskDescription &&
          other.completed == this.completed &&
          other.addedOn == this.addedOn &&
          other.completedOn == this.completedOn);
}

class TodoSubTasksCompanion extends UpdateCompanion<TodoSubTask> {
  final Value<int> id;
  final Value<int> parentId;
  final Value<String> subTaskText;
  final Value<String> subTaskDescription;
  final Value<bool> completed;
  final Value<DateTime> addedOn;
  final Value<DateTime> completedOn;
  const TodoSubTasksCompanion({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    this.subTaskText = const Value.absent(),
    this.subTaskDescription = const Value.absent(),
    this.completed = const Value.absent(),
    this.addedOn = const Value.absent(),
    this.completedOn = const Value.absent(),
  });
  TodoSubTasksCompanion.insert({
    this.id = const Value.absent(),
    @required int parentId,
    @required String subTaskText,
    @required String subTaskDescription,
    @required bool completed,
    @required DateTime addedOn,
    this.completedOn = const Value.absent(),
  })  : parentId = Value(parentId),
        subTaskText = Value(subTaskText),
        subTaskDescription = Value(subTaskDescription),
        completed = Value(completed),
        addedOn = Value(addedOn);
  TodoSubTasksCompanion copyWith(
      {Value<int> id,
      Value<int> parentId,
      Value<String> subTaskText,
      Value<String> subTaskDescription,
      Value<bool> completed,
      Value<DateTime> addedOn,
      Value<DateTime> completedOn}) {
    return TodoSubTasksCompanion(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      subTaskText: subTaskText ?? this.subTaskText,
      subTaskDescription: subTaskDescription ?? this.subTaskDescription,
      completed: completed ?? this.completed,
      addedOn: addedOn ?? this.addedOn,
      completedOn: completedOn ?? this.completedOn,
    );
  }
}

class $TodoSubTasksTable extends TodoSubTasks
    with TableInfo<$TodoSubTasksTable, TodoSubTask> {
  final GeneratedDatabase _db;
  final String _alias;
  $TodoSubTasksTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _parentIdMeta = const VerificationMeta('parentId');
  GeneratedIntColumn _parentId;
  @override
  GeneratedIntColumn get parentId => _parentId ??= _constructParentId();
  GeneratedIntColumn _constructParentId() {
    return GeneratedIntColumn(
      'parent_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _subTaskTextMeta =
      const VerificationMeta('subTaskText');
  GeneratedTextColumn _subTaskText;
  @override
  GeneratedTextColumn get subTaskText =>
      _subTaskText ??= _constructSubTaskText();
  GeneratedTextColumn _constructSubTaskText() {
    return GeneratedTextColumn(
      'sub_task_text',
      $tableName,
      false,
    );
  }

  final VerificationMeta _subTaskDescriptionMeta =
      const VerificationMeta('subTaskDescription');
  GeneratedTextColumn _subTaskDescription;
  @override
  GeneratedTextColumn get subTaskDescription =>
      _subTaskDescription ??= _constructSubTaskDescription();
  GeneratedTextColumn _constructSubTaskDescription() {
    return GeneratedTextColumn(
      'sub_task_description',
      $tableName,
      false,
    );
  }

  final VerificationMeta _completedMeta = const VerificationMeta('completed');
  GeneratedBoolColumn _completed;
  @override
  GeneratedBoolColumn get completed => _completed ??= _constructCompleted();
  GeneratedBoolColumn _constructCompleted() {
    return GeneratedBoolColumn(
      'completed',
      $tableName,
      false,
    );
  }

  final VerificationMeta _addedOnMeta = const VerificationMeta('addedOn');
  GeneratedDateTimeColumn _addedOn;
  @override
  GeneratedDateTimeColumn get addedOn => _addedOn ??= _constructAddedOn();
  GeneratedDateTimeColumn _constructAddedOn() {
    return GeneratedDateTimeColumn(
      'added_on',
      $tableName,
      false,
    );
  }

  final VerificationMeta _completedOnMeta =
      const VerificationMeta('completedOn');
  GeneratedDateTimeColumn _completedOn;
  @override
  GeneratedDateTimeColumn get completedOn =>
      _completedOn ??= _constructCompletedOn();
  GeneratedDateTimeColumn _constructCompletedOn() {
    return GeneratedDateTimeColumn(
      'completed_on',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        parentId,
        subTaskText,
        subTaskDescription,
        completed,
        addedOn,
        completedOn
      ];
  @override
  $TodoSubTasksTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'todo_sub_tasks';
  @override
  final String actualTableName = 'todo_sub_tasks';
  @override
  VerificationContext validateIntegrity(TodoSubTasksCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.parentId.present) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableValue(d.parentId.value, _parentIdMeta));
    } else if (parentId.isRequired && isInserting) {
      context.missing(_parentIdMeta);
    }
    if (d.subTaskText.present) {
      context.handle(_subTaskTextMeta,
          subTaskText.isAcceptableValue(d.subTaskText.value, _subTaskTextMeta));
    } else if (subTaskText.isRequired && isInserting) {
      context.missing(_subTaskTextMeta);
    }
    if (d.subTaskDescription.present) {
      context.handle(
          _subTaskDescriptionMeta,
          subTaskDescription.isAcceptableValue(
              d.subTaskDescription.value, _subTaskDescriptionMeta));
    } else if (subTaskDescription.isRequired && isInserting) {
      context.missing(_subTaskDescriptionMeta);
    }
    if (d.completed.present) {
      context.handle(_completedMeta,
          completed.isAcceptableValue(d.completed.value, _completedMeta));
    } else if (completed.isRequired && isInserting) {
      context.missing(_completedMeta);
    }
    if (d.addedOn.present) {
      context.handle(_addedOnMeta,
          addedOn.isAcceptableValue(d.addedOn.value, _addedOnMeta));
    } else if (addedOn.isRequired && isInserting) {
      context.missing(_addedOnMeta);
    }
    if (d.completedOn.present) {
      context.handle(_completedOnMeta,
          completedOn.isAcceptableValue(d.completedOn.value, _completedOnMeta));
    } else if (completedOn.isRequired && isInserting) {
      context.missing(_completedOnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TodoSubTask map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return TodoSubTask.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TodoSubTasksCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.parentId.present) {
      map['parent_id'] = Variable<int, IntType>(d.parentId.value);
    }
    if (d.subTaskText.present) {
      map['sub_task_text'] = Variable<String, StringType>(d.subTaskText.value);
    }
    if (d.subTaskDescription.present) {
      map['sub_task_description'] =
          Variable<String, StringType>(d.subTaskDescription.value);
    }
    if (d.completed.present) {
      map['completed'] = Variable<bool, BoolType>(d.completed.value);
    }
    if (d.addedOn.present) {
      map['added_on'] = Variable<DateTime, DateTimeType>(d.addedOn.value);
    }
    if (d.completedOn.present) {
      map['completed_on'] =
          Variable<DateTime, DateTimeType>(d.completedOn.value);
    }
    return map;
  }

  @override
  $TodoSubTasksTable createAlias(String alias) {
    return $TodoSubTasksTable(_db, alias);
  }
}

class Note extends DataClass implements Insertable<Note> {
  final int id;
  final String title;
  final DateTime saveDateTime;
  final DateTime updateDateTime;
  final int subItemCount;
  Note(
      {@required this.id,
      @required this.title,
      @required this.saveDateTime,
      @required this.updateDateTime,
      @required this.subItemCount});
  factory Note.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Note(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      saveDateTime: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}save_date_time']),
      updateDateTime: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}update_date_time']),
      subItemCount: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}sub_item_count']),
    );
  }
  factory Note.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Note(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      saveDateTime: serializer.fromJson<DateTime>(json['saveDateTime']),
      updateDateTime: serializer.fromJson<DateTime>(json['updateDateTime']),
      subItemCount: serializer.fromJson<int>(json['subItemCount']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'saveDateTime': serializer.toJson<DateTime>(saveDateTime),
      'updateDateTime': serializer.toJson<DateTime>(updateDateTime),
      'subItemCount': serializer.toJson<int>(subItemCount),
    };
  }

  @override
  NotesCompanion createCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      saveDateTime: saveDateTime == null && nullToAbsent
          ? const Value.absent()
          : Value(saveDateTime),
      updateDateTime: updateDateTime == null && nullToAbsent
          ? const Value.absent()
          : Value(updateDateTime),
      subItemCount: subItemCount == null && nullToAbsent
          ? const Value.absent()
          : Value(subItemCount),
    );
  }

  Note copyWith(
          {int id,
          String title,
          DateTime saveDateTime,
          DateTime updateDateTime,
          int subItemCount}) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        saveDateTime: saveDateTime ?? this.saveDateTime,
        updateDateTime: updateDateTime ?? this.updateDateTime,
        subItemCount: subItemCount ?? this.subItemCount,
      );
  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('saveDateTime: $saveDateTime, ')
          ..write('updateDateTime: $updateDateTime, ')
          ..write('subItemCount: $subItemCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          title.hashCode,
          $mrjc(saveDateTime.hashCode,
              $mrjc(updateDateTime.hashCode, subItemCount.hashCode)))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Note &&
          other.id == this.id &&
          other.title == this.title &&
          other.saveDateTime == this.saveDateTime &&
          other.updateDateTime == this.updateDateTime &&
          other.subItemCount == this.subItemCount);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<int> id;
  final Value<String> title;
  final Value<DateTime> saveDateTime;
  final Value<DateTime> updateDateTime;
  final Value<int> subItemCount;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.saveDateTime = const Value.absent(),
    this.updateDateTime = const Value.absent(),
    this.subItemCount = const Value.absent(),
  });
  NotesCompanion.insert({
    this.id = const Value.absent(),
    @required String title,
    @required DateTime saveDateTime,
    @required DateTime updateDateTime,
    @required int subItemCount,
  })  : title = Value(title),
        saveDateTime = Value(saveDateTime),
        updateDateTime = Value(updateDateTime),
        subItemCount = Value(subItemCount);
  NotesCompanion copyWith(
      {Value<int> id,
      Value<String> title,
      Value<DateTime> saveDateTime,
      Value<DateTime> updateDateTime,
      Value<int> subItemCount}) {
    return NotesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      saveDateTime: saveDateTime ?? this.saveDateTime,
      updateDateTime: updateDateTime ?? this.updateDateTime,
      subItemCount: subItemCount ?? this.subItemCount,
    );
  }
}

class $NotesTable extends Notes with TableInfo<$NotesTable, Note> {
  final GeneratedDatabase _db;
  final String _alias;
  $NotesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _saveDateTimeMeta =
      const VerificationMeta('saveDateTime');
  GeneratedDateTimeColumn _saveDateTime;
  @override
  GeneratedDateTimeColumn get saveDateTime =>
      _saveDateTime ??= _constructSaveDateTime();
  GeneratedDateTimeColumn _constructSaveDateTime() {
    return GeneratedDateTimeColumn(
      'save_date_time',
      $tableName,
      false,
    );
  }

  final VerificationMeta _updateDateTimeMeta =
      const VerificationMeta('updateDateTime');
  GeneratedDateTimeColumn _updateDateTime;
  @override
  GeneratedDateTimeColumn get updateDateTime =>
      _updateDateTime ??= _constructUpdateDateTime();
  GeneratedDateTimeColumn _constructUpdateDateTime() {
    return GeneratedDateTimeColumn(
      'update_date_time',
      $tableName,
      false,
    );
  }

  final VerificationMeta _subItemCountMeta =
      const VerificationMeta('subItemCount');
  GeneratedIntColumn _subItemCount;
  @override
  GeneratedIntColumn get subItemCount =>
      _subItemCount ??= _constructSubItemCount();
  GeneratedIntColumn _constructSubItemCount() {
    return GeneratedIntColumn(
      'sub_item_count',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, title, saveDateTime, updateDateTime, subItemCount];
  @override
  $NotesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'notes';
  @override
  final String actualTableName = 'notes';
  @override
  VerificationContext validateIntegrity(NotesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.title.present) {
      context.handle(
          _titleMeta, title.isAcceptableValue(d.title.value, _titleMeta));
    } else if (title.isRequired && isInserting) {
      context.missing(_titleMeta);
    }
    if (d.saveDateTime.present) {
      context.handle(
          _saveDateTimeMeta,
          saveDateTime.isAcceptableValue(
              d.saveDateTime.value, _saveDateTimeMeta));
    } else if (saveDateTime.isRequired && isInserting) {
      context.missing(_saveDateTimeMeta);
    }
    if (d.updateDateTime.present) {
      context.handle(
          _updateDateTimeMeta,
          updateDateTime.isAcceptableValue(
              d.updateDateTime.value, _updateDateTimeMeta));
    } else if (updateDateTime.isRequired && isInserting) {
      context.missing(_updateDateTimeMeta);
    }
    if (d.subItemCount.present) {
      context.handle(
          _subItemCountMeta,
          subItemCount.isAcceptableValue(
              d.subItemCount.value, _subItemCountMeta));
    } else if (subItemCount.isRequired && isInserting) {
      context.missing(_subItemCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Note map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Note.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(NotesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.title.present) {
      map['title'] = Variable<String, StringType>(d.title.value);
    }
    if (d.saveDateTime.present) {
      map['save_date_time'] =
          Variable<DateTime, DateTimeType>(d.saveDateTime.value);
    }
    if (d.updateDateTime.present) {
      map['update_date_time'] =
          Variable<DateTime, DateTimeType>(d.updateDateTime.value);
    }
    if (d.subItemCount.present) {
      map['sub_item_count'] = Variable<int, IntType>(d.subItemCount.value);
    }
    return map;
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(_db, alias);
  }
}

class NoteSubItem extends DataClass implements Insertable<NoteSubItem> {
  final int id;
  final int parentId;
  final int type;
  final String body;
  final DateTime saveDateTime;
  NoteSubItem(
      {@required this.id,
      @required this.parentId,
      @required this.type,
      @required this.body,
      @required this.saveDateTime});
  factory NoteSubItem.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return NoteSubItem(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      parentId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}parent_id']),
      type: intType.mapFromDatabaseResponse(data['${effectivePrefix}type']),
      body: stringType.mapFromDatabaseResponse(data['${effectivePrefix}body']),
      saveDateTime: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}save_date_time']),
    );
  }
  factory NoteSubItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return NoteSubItem(
      id: serializer.fromJson<int>(json['id']),
      parentId: serializer.fromJson<int>(json['parentId']),
      type: serializer.fromJson<int>(json['type']),
      body: serializer.fromJson<String>(json['body']),
      saveDateTime: serializer.fromJson<DateTime>(json['saveDateTime']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'parentId': serializer.toJson<int>(parentId),
      'type': serializer.toJson<int>(type),
      'body': serializer.toJson<String>(body),
      'saveDateTime': serializer.toJson<DateTime>(saveDateTime),
    };
  }

  @override
  NoteSubItemsCompanion createCompanion(bool nullToAbsent) {
    return NoteSubItemsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      body: body == null && nullToAbsent ? const Value.absent() : Value(body),
      saveDateTime: saveDateTime == null && nullToAbsent
          ? const Value.absent()
          : Value(saveDateTime),
    );
  }

  NoteSubItem copyWith(
          {int id,
          int parentId,
          int type,
          String body,
          DateTime saveDateTime}) =>
      NoteSubItem(
        id: id ?? this.id,
        parentId: parentId ?? this.parentId,
        type: type ?? this.type,
        body: body ?? this.body,
        saveDateTime: saveDateTime ?? this.saveDateTime,
      );
  @override
  String toString() {
    return (StringBuffer('NoteSubItem(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('type: $type, ')
          ..write('body: $body, ')
          ..write('saveDateTime: $saveDateTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(parentId.hashCode,
          $mrjc(type.hashCode, $mrjc(body.hashCode, saveDateTime.hashCode)))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is NoteSubItem &&
          other.id == this.id &&
          other.parentId == this.parentId &&
          other.type == this.type &&
          other.body == this.body &&
          other.saveDateTime == this.saveDateTime);
}

class NoteSubItemsCompanion extends UpdateCompanion<NoteSubItem> {
  final Value<int> id;
  final Value<int> parentId;
  final Value<int> type;
  final Value<String> body;
  final Value<DateTime> saveDateTime;
  const NoteSubItemsCompanion({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    this.type = const Value.absent(),
    this.body = const Value.absent(),
    this.saveDateTime = const Value.absent(),
  });
  NoteSubItemsCompanion.insert({
    this.id = const Value.absent(),
    @required int parentId,
    @required int type,
    @required String body,
    @required DateTime saveDateTime,
  })  : parentId = Value(parentId),
        type = Value(type),
        body = Value(body),
        saveDateTime = Value(saveDateTime);
  NoteSubItemsCompanion copyWith(
      {Value<int> id,
      Value<int> parentId,
      Value<int> type,
      Value<String> body,
      Value<DateTime> saveDateTime}) {
    return NoteSubItemsCompanion(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      type: type ?? this.type,
      body: body ?? this.body,
      saveDateTime: saveDateTime ?? this.saveDateTime,
    );
  }
}

class $NoteSubItemsTable extends NoteSubItems
    with TableInfo<$NoteSubItemsTable, NoteSubItem> {
  final GeneratedDatabase _db;
  final String _alias;
  $NoteSubItemsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _parentIdMeta = const VerificationMeta('parentId');
  GeneratedIntColumn _parentId;
  @override
  GeneratedIntColumn get parentId => _parentId ??= _constructParentId();
  GeneratedIntColumn _constructParentId() {
    return GeneratedIntColumn(
      'parent_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedIntColumn _type;
  @override
  GeneratedIntColumn get type => _type ??= _constructType();
  GeneratedIntColumn _constructType() {
    return GeneratedIntColumn(
      'type',
      $tableName,
      false,
    );
  }

  final VerificationMeta _bodyMeta = const VerificationMeta('body');
  GeneratedTextColumn _body;
  @override
  GeneratedTextColumn get body => _body ??= _constructBody();
  GeneratedTextColumn _constructBody() {
    return GeneratedTextColumn(
      'body',
      $tableName,
      false,
    );
  }

  final VerificationMeta _saveDateTimeMeta =
      const VerificationMeta('saveDateTime');
  GeneratedDateTimeColumn _saveDateTime;
  @override
  GeneratedDateTimeColumn get saveDateTime =>
      _saveDateTime ??= _constructSaveDateTime();
  GeneratedDateTimeColumn _constructSaveDateTime() {
    return GeneratedDateTimeColumn(
      'save_date_time',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, parentId, type, body, saveDateTime];
  @override
  $NoteSubItemsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'note_sub_items';
  @override
  final String actualTableName = 'note_sub_items';
  @override
  VerificationContext validateIntegrity(NoteSubItemsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.parentId.present) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableValue(d.parentId.value, _parentIdMeta));
    } else if (parentId.isRequired && isInserting) {
      context.missing(_parentIdMeta);
    }
    if (d.type.present) {
      context.handle(
          _typeMeta, type.isAcceptableValue(d.type.value, _typeMeta));
    } else if (type.isRequired && isInserting) {
      context.missing(_typeMeta);
    }
    if (d.body.present) {
      context.handle(
          _bodyMeta, body.isAcceptableValue(d.body.value, _bodyMeta));
    } else if (body.isRequired && isInserting) {
      context.missing(_bodyMeta);
    }
    if (d.saveDateTime.present) {
      context.handle(
          _saveDateTimeMeta,
          saveDateTime.isAcceptableValue(
              d.saveDateTime.value, _saveDateTimeMeta));
    } else if (saveDateTime.isRequired && isInserting) {
      context.missing(_saveDateTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NoteSubItem map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return NoteSubItem.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(NoteSubItemsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.parentId.present) {
      map['parent_id'] = Variable<int, IntType>(d.parentId.value);
    }
    if (d.type.present) {
      map['type'] = Variable<int, IntType>(d.type.value);
    }
    if (d.body.present) {
      map['body'] = Variable<String, StringType>(d.body.value);
    }
    if (d.saveDateTime.present) {
      map['save_date_time'] =
          Variable<DateTime, DateTimeType>(d.saveDateTime.value);
    }
    return map;
  }

  @override
  $NoteSubItemsTable createAlias(String alias) {
    return $NoteSubItemsTable(_db, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $TodoTasksTable _todoTasks;
  $TodoTasksTable get todoTasks => _todoTasks ??= $TodoTasksTable(this);
  $TodoSubTasksTable _todoSubTasks;
  $TodoSubTasksTable get todoSubTasks =>
      _todoSubTasks ??= $TodoSubTasksTable(this);
  $NotesTable _notes;
  $NotesTable get notes => _notes ??= $NotesTable(this);
  $NoteSubItemsTable _noteSubItems;
  $NoteSubItemsTable get noteSubItems =>
      _noteSubItems ??= $NoteSubItemsTable(this);
  @override
  List<TableInfo> get allTables =>
      [todoTasks, todoSubTasks, notes, noteSubItems];
}
