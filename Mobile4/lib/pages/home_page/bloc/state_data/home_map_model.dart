class HomeMapModel {
  final List<Object> data1;
  final bool isLoading1;
  final List<Object> data2;
  final bool isLoading2;

  HomeMapModel({
    required this.data1,
    required this.isLoading1,
    required this.data2,
    required this.isLoading2,
  });

  HomeMapModel copyWith({
    List<Object>? data1,
    bool? isLoading1,
    List<Object>? data2,
    bool? isLoading2,
  }) {
    return HomeMapModel(
      data1: data1 ?? this.data1,
      isLoading1: isLoading1 ?? this.isLoading1,
      data2: data2 ?? this.data2,
      isLoading2: isLoading2 ?? this.isLoading2,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data1': data1,
      'isLoading1': isLoading1,
      'data2': data2,
      'isLoading2': isLoading2,
    };
  }

  factory HomeMapModel.fromJson(Map<String, dynamic> json) {
    return HomeMapModel(
      data1: List<Object>.from(json['data1']),
      isLoading1: json['isLoading1'] as bool,
      data2: List<Object>.from(json['data2']),
      isLoading2: json['isLoading2'] as bool,
    );
  }
}
