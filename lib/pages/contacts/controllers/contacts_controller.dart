import 'package:mob_whatsapp/core/models/user.dart';
import 'package:mob_whatsapp/pages/contacts/services/contacts_service.dart';
import 'package:mobx/mobx.dart';
part 'contacts_controller.g.dart';

class ContactsController = _ContactsControllerBase with _$ContactsController;

abstract class _ContactsControllerBase with Store {

  final ContactsService _contactsService = ContactsService();

  _ContactsControllerBase();

  @observable
  List<UserModel> contacts = ObservableList.of([]);
  
  @observable
  List<UserModel> foundContacts = ObservableList.of([]);

  Future<List<UserModel>> getContacts() async {
    contacts = await _contactsService.findContacts();
    foundContacts = contacts;
    return contacts;
  }

  @action
  void filterContact(String filter) {
    foundContacts = contacts.where(
      (contact) => contact.name!.toLowerCase().startsWith(filter.toLowerCase())
    ).toList();
  }
}