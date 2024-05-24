class UserModel {
  String? name;
  String? email;
  String? phone;
  String? password;
  String? dateOfBirth;

  String? profileImage;
  UserModel({
    this.name,
    this.email,
    this.phone,
    this.password,
    this.profileImage,
    this.dateOfBirth,
  });

  Map<String, dynamic> toRegister() => {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'profile_image': profileImage,
        'date_of_birth': dateOfBirth,
      };
  Map<String, dynamic> toLogin() => {
        'email': email,
        'password': password,
      };
}
