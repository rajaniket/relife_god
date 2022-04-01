class UserAllHabitsModel {
  String? message;
  List<Details>? details;

  UserAllHabitsModel({this.message, this.details});

  UserAllHabitsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
  }
}

class Details {
  List<int>? reminderDays;
  bool? active;
  bool? deleted;
  String? sId;
  HabitDetails? habitDetails;
  String? reminderHabit;
  String? exactBehaviour;
  String? reward;
  int? reminderTime;
  int? daysPerMonth;
  String? punishment;
  String? accountabilityPartnerName;
  String? accountabilityPartnerPhoneNumber;
  int? accountabilityPartnerCountryCode;
  int? createdAt;
  int? updatedAt;
  String? id;
  List<StreakData>? streakData;
  int? currentStreak;
  int? longestStreak;
  int? thisMonth;
  int? tillDate;
  int? toReachYourGoal;

  Details(
      {this.reminderDays,
      this.active,
      this.deleted,
      this.sId,
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
      this.id,
      this.streakData,
      this.currentStreak,
      this.longestStreak,
      this.thisMonth,
      this.tillDate,
      this.toReachYourGoal});

  Details.fromJson(Map<String, dynamic> json) {
    reminderDays = json['reminderDays'].cast<int>();
    active = json['active'];
    deleted = json['deleted'];
    sId = json['_id'];
    habitDetails = json['habitDetails'] != null
        ? new HabitDetails.fromJson(json['habitDetails'])
        : null;
    reminderHabit = json['reminderHabit'];
    exactBehaviour = json['exactBehaviour'];
    reward = json['reward'];
    reminderTime = json['reminderTime'];
    daysPerMonth = json['daysPerMonth'];
    punishment = json['punishment'];
    accountabilityPartnerName = json['accountabilityPartnerName'];
    accountabilityPartnerPhoneNumber = json['accountabilityPartnerPhoneNumber'];
    accountabilityPartnerCountryCode = json['accountabilityPartnerCountryCode'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    if (json['streakData'] != null) {
      streakData = <StreakData>[];
      json['streakData'].forEach((v) {
        streakData!.add(new StreakData.fromJson(v));
      });
    }
    currentStreak = json['currentStreak'];
    longestStreak = json['longestStreak'];
    thisMonth = json['thisMonth'];
    tillDate = json['tillDate'];
    toReachYourGoal = json['toReachYourGoal'];
  }
}

class HabitDetails {
  List<String>? reminderHabits;
  List<String>? exactBehaviour;
  List<String>? reward;
  bool? active;
  bool? deleted;
  String? sId;
  String? name;
  String? code;
  int? createdAt;
  int? updatedAt;
  int? iV;
  String? id;

  HabitDetails(
      {this.reminderHabits,
      this.exactBehaviour,
      this.reward,
      this.active,
      this.deleted,
      this.sId,
      this.name,
      this.code,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.id});

  HabitDetails.fromJson(Map<String, dynamic> json) {
    reminderHabits = json['reminderHabits'].cast<String>();
    exactBehaviour = json['exactBehaviour'].cast<String>();
    reward = json['reward'].cast<String>();
    active = json['active'];
    deleted = json['deleted'];
    sId = json['_id'];
    name = json['name'];
    code = json['code'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    id = json['id'];
  }
}

class StreakData {
  Author? author;
  List<Content>? content;
  String? contentType;
  int? createdAt;
  String? id;
  ReactionsCount? reactionsCount;
  Source? source;
  String? status;
  int? statusUpdatedAt;
  int? commentsCount;
  Mentions? mentions;

  StreakData(
      {this.author,
      this.content,
      this.contentType,
      this.createdAt,
      this.id,
      this.reactionsCount,
      this.source,
      this.status,
      this.statusUpdatedAt,
      this.commentsCount,
      this.mentions});

  StreakData.fromJson(Map<String, dynamic> json) {
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    if (json['content'] != null) {
      content = <Content>[];
      json['content'].forEach((v) {
        content!.add(new Content.fromJson(v));
      });
    }
    contentType = json['content_type'];
    createdAt = json['created_at'];
    id = json['id'];
    reactionsCount = json['reactions_count'] != null
        ? new ReactionsCount.fromJson(json['reactions_count'])
        : null;
    source =
        json['source'] != null ? new Source.fromJson(json['source']) : null;
    status = json['status'];
    statusUpdatedAt = json['status_updated_at'];
    commentsCount = json['comments_count'];
    mentions = json['mentions'] != null
        ? new Mentions.fromJson(json['mentions'])
        : null;
  }
}

class Author {
  User? user;

  Author({this.user});

  Author.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
}

class User {
  AuthIdentities? authIdentities;
  String? id;
  String? avatarUrl;
  String? displayName;

  User({this.authIdentities, this.id, this.avatarUrl, this.displayName});

  User.fromJson(Map<String, dynamic> json) {
    authIdentities = json['auth_identities'] != null
        ? new AuthIdentities.fromJson(json['auth_identities'])
        : null;
    id = json['id'];
    avatarUrl = json['avatar_url'];
    displayName = json['display_name'];
  }
}

class AuthIdentities {
  String? relifeUserId;

  AuthIdentities({this.relifeUserId});

  AuthIdentities.fromJson(Map<String, dynamic> json) {
    relifeUserId = json['relife_userId'];
  }
}

class Content {
  List<Attachments>? attachments;
  String? language;
  String? text;

  Content({this.attachments, this.language, this.text});

  Content.fromJson(Map<String, dynamic> json) {
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(new Attachments.fromJson(v));
      });
    }
    language = json['language'];
    text = json['text'];
  }
}

class Attachments {
  String? image;

  Attachments({this.image});

  Attachments.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }
}

class ReactionsCount {
  int? like;

  ReactionsCount({this.like});

  ReactionsCount.fromJson(Map<String, dynamic> json) {
    like = json['like'];
  }
}

class Source {
  Id? id;

  Source({this.id});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? new Id.fromJson(json['id']) : null;
  }
}

class Id {
  String? id;
  String? type;

  Id({this.id, this.type});

  Id.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
  }
}

class Mentions {
  List<En>? en;

  Mentions({this.en});

  Mentions.fromJson(Map<String, dynamic> json) {
    if (json['en'] != null) {
      en = <En>[];
      json['en'].forEach((v) {
        en!.add(new En.fromJson(v));
      });
    }
  }
}

class En {
  int? endIndex;
  String? mentionType;
  int? startIndex;
  String? userId;

  En({this.endIndex, this.mentionType, this.startIndex, this.userId});

  En.fromJson(Map<String, dynamic> json) {
    endIndex = json['end_index'];
    mentionType = json['mention_type'];
    startIndex = json['start_index'];
    userId = json['user_id'];
  }
}
