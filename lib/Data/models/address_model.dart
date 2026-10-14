class AddressModel {
  final String id;
  final String name;
  final String phone;
  final String houseNo;
  final String street;
  final String city;
  final String state;
  final String pincode;
  final String type; // "Home" or "Work"
  bool isDefault;

  AddressModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.houseNo,
    required this.street,
    required this.city,
    required this.state,
    required this.pincode,
    this.type = "Home",
    this.isDefault = false,
  });

  String get fullAddress => "$houseNo, $street, $city, $state - $pincode";
}
