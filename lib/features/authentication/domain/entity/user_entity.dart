class User {
  final String userCode;
  final String userDisplayName;
  final String email;
  final String userEmployeeCode;
  final String companyCode;
  final List<Location> userLocations;
  final List<Permission> userPermissions;

  User({
    required this.userCode,
    required this.userDisplayName,
    required this.email,
    required this.userEmployeeCode,
    required this.companyCode,
    required this.userLocations,
    required this.userPermissions,
  });
}

class Location {
  final String locationCode;

  Location({required this.locationCode});
}

class Permission {
  final String permissionName;
  final String permissionStatus;

  Permission({required this.permissionName, required this.permissionStatus});
}
