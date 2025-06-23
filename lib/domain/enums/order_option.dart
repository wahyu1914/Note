
enum OrderOption { 
  dateModified, 
  dateCreated;

  String get name {
    return switch(this) {
       OrderOption.dateModified => 'Date Modified',
       OrderOption.dateCreated => 'Date Created',
    };
   }
  }