import 'package:floor/floor.dart';
@entity
class Active{
  @primaryKey
  final String topic;
  Active(this.topic);
}
@entity
class UnSelected{
  @primaryKey
  final String topic;
  UnSelected(this.topic);
}
@dao
abstract class ActiveDao{
  @Query('SELECT * FROM Active')
  Future<List<Active>> findAllActive();
  @Query('SELECT * FROM Active WHERE topic = :topic')
  Future<Active> findActiveById(String topic);
  @insert
  Future<void> insertTopic(Active active);
  @Query('SELECT * FROM Active WHERE topic =:topic')
  Future<List<Active>> deleteActiveWithId(String topic);
}
@dao
abstract class UnSelectedDao{
  @Query('SELECT * FROM UnSelected')
  Future<List<UnSelected>> findAllUnSelected();
  @Query('SELECT * FROM UnSelected WHERE topic = :topic')
  Future<UnSelected> findUnSelectedById(int topic);
  @insert
  Future<void> insertTopic(UnSelected active);
  @Query('delete * FROM UnSelected WHERE topic =:topic')
  Future<List<UnSelected>> deleteUnSelectedWithId(String topic);
}