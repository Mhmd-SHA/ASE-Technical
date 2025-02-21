import '../../domain/entity/user_entity.dart';

class UserModel extends User {
  UserModel({
    required super.userCode,
    required super.userDisplayName,
    required super.email,
    required super.userEmployeeCode,
    required super.companyCode,
    required super.userLocations,
    required super.userPermissions,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final locations =
        (json['User_Locations'] as List)
            .map((loc) => Location(locationCode: loc['Location_Code']))
            .toList();
    final permissions =
        (json['User_Permissions'] as List)
            .map(
              (perm) => Permission(
                permissionName: perm['Permisson_Name'],
                permissionStatus: perm['Permission_Status'],
              ),
            )
            .toList();

    return UserModel(
      userCode: json['User_Code'],
      userDisplayName: json['User_Display_Name'],
      email: json['Email'],
      userEmployeeCode: json['User_Employee_Code'],
      companyCode: json['Company_Code'],
      userLocations: locations,
      userPermissions: permissions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userCode': userCode,
      'userDisplayName': userDisplayName,
      'email': email,
      'userEmployeeCode': userEmployeeCode,
      'companyCode': companyCode,
    };
  }
}
