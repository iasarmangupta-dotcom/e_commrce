abstract class UserEvent {}

class UserLoginEvent extends UserEvent {
  String email, pass;

  UserLoginEvent({required this.email, required this.pass});
}

class UserRegisterEvent extends UserEvent {
  String name, email, mobNo, pass;

  UserRegisterEvent({
    required this.name,
    required this.email,
    required this.mobNo,
    required this.pass,
  });
}