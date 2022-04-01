class GetAllUserResponseModel {
  GetAllUserResponseModel({
    this.message,
    this.details,
  });

  String? message;
  List<Detail>? details;

  factory GetAllUserResponseModel.fromJson(Map<String, dynamic> json) =>
      GetAllUserResponseModel(
        message: json["message"],
        details:
            List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
      );
}

class Detail {
  Detail({
    this.lastName,
    this.bio,
    this.profilePicture,
    this.active,
    this.deleted,
    this.verified,
    this.emailVerified,
    this.isSuperuser,
    this.referralLink,
    //  this.cancelAfterCurrentCycle,
    //  this.lastLogin,
    this.id,
    this.firstName,
    this.username,
    this.habits,
    //  this.transactions,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.lastUpdatedBy,
    this.detailId,
    //  this.emailVerificationToken,
    //  this.resetPasswordExpires,
    //  this.resetPasswordToken,
    //    this.phoneNumber,
    //   this.countryCode,
    this.createdBy,
  });

  String? lastName;
  String? bio;
  String? profilePicture;
  bool? active;
  bool? deleted;
  bool? verified;
  bool? emailVerified;
  bool? isSuperuser;
  String? referralLink;
  // bool cancelAfterCurrentCycle;
  // CreatedAt lastLogin;
  String? id;
  String? firstName;
  String? username;
  List<Habit>? habits;
  // List<Transaction> transactions;
  CreatedAt? createdAt;
  CreatedAt? updatedAt;
  int? v;
  String? lastUpdatedBy;
  String? detailId;
  //String emailVerificationToken;
//  int resetPasswordExpires;
  // String resetPasswordToken;
//  int phoneNumber;
//  int countryCode;
  String? createdBy;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        lastName: json["lastName"],
        bio: json["bio"],
        profilePicture: json["profilePicture"],
        active: json["active"],
        deleted: json["deleted"],
        verified: json["verified"],
        emailVerified: json["emailVerified"],
        isSuperuser: json["isSuperuser"],
        referralLink: json["referralLink"],
        // cancelAfterCurrentCycle: json["cancelAfterCurrentCycle"],
        // lastLogin: CreatedAt.fromJson(json["lastLogin"]),
        id: json["_id"],
        firstName: json["firstName"],
        username: json["username"],
        habits: List<Habit>.from(json["habits"].map((x) => Habit.fromJson(x))),
        // transactions: List<Transaction>.from(
        // json["transactions"].map((x) => Transaction.fromJson(x))),
        createdAt: CreatedAt.fromJson(json["createdAt"]),
        updatedAt: CreatedAt.fromJson(json["updatedAt"]),
        v: json["__v"],
        lastUpdatedBy: json["lastUpdatedBy"],
        detailId: json["id"],
        //  emailVerificationToken: json["emailVerificationToken"],
        // resetPasswordExpires: json["resetPasswordExpires"],
        // resetPasswordToken: json["resetPasswordToken"],
        //  phoneNumber: json["phoneNumber"],
        // countryCode: json["countryCode"],
        createdBy: json["createdBy"],
      );
}

class CreatedAt {
  CreatedAt();

  factory CreatedAt.fromJson(Map<String, dynamic> json) => CreatedAt();

  Map<String, dynamic> toJson() => {};
}

class Habit {
  Habit({
    this.reminderDays,
    this.active,
    this.deleted,
    this.id,
    this.habitDetails,
    this.reminderHabit,
    this.exactBehaviour,
    this.reward,
    this.reminderTime,
    this.daysPerMonth,
    this.punishment,
    this.accountabilityPartnerName,
    this.accountabilityPartnerPhoneNumber,
    this.accountabilityPartnerCountryCode,
    this.createdAt,
    this.updatedAt,
    this.habitId,
  });

  List<int>? reminderDays;
  bool? active;
  bool? deleted;
  String? id;
  String? habitDetails;
  String? reminderHabit;
  String? exactBehaviour;
  String? reward;
  int? reminderTime;
  int? daysPerMonth;
  String? punishment;
  String? accountabilityPartnerName;
  String? accountabilityPartnerPhoneNumber;
  int? accountabilityPartnerCountryCode;
  CreatedAt? createdAt;
  CreatedAt? updatedAt;
  String? habitId;

  factory Habit.fromJson(Map<String, dynamic> json) => Habit(
        reminderDays: List<int>.from(json["reminderDays"].map((x) => x)),
        active: json["active"],
        deleted: json["deleted"],
        id: json["_id"],
        habitDetails: json["habitDetails"],
        reminderHabit: json["reminderHabit"],
        exactBehaviour: json["exactBehaviour"],
        reward: json["reward"],
        reminderTime: json["reminderTime"],
        daysPerMonth: json["daysPerMonth"],
        punishment: json["punishment"],
        accountabilityPartnerName: json["accountabilityPartnerName"],
        accountabilityPartnerPhoneNumber:
            json["accountabilityPartnerPhoneNumber"],
        accountabilityPartnerCountryCode:
            json["accountabilityPartnerCountryCode"],
        createdAt: CreatedAt.fromJson(json["createdAt"]),
        updatedAt: CreatedAt.fromJson(json["updatedAt"]),
        habitId: json["id"],
      );
}

class Transaction {
  Transaction({
    this.id,
    this.amount,
    this.mode,
    this.createdAt,
    this.startTime,
    this.endTime,
    this.details,
  });

  String? id;
  int? amount;
  String? mode;
  int? createdAt;
  int? startTime;
  int? endTime;
  Details? details;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["_id"],
        amount: json["amount"],
        mode: json["mode"],
        createdAt: json["createdAt"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        details: Details.fromJson(json["details"]),
      );
}

class Details {
  Details({
    this.id,
    this.type,
    this.referredTo,
    this.referredBy,
  });

  String? id;
  String? type;
  String? referredTo;
  String? referredBy;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        id: json["_id"],
        type: json["type"],
        referredTo: json["referredTo"],
        referredBy: json["referredBy"],
      );
}
