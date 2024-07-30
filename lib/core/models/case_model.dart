class CaseModel {
  final String id;
  final String title;
  final String description;
  final String status;

  CaseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
  });

  factory CaseModel.fromMap(Map<String, dynamic> data) {
    return CaseModel(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      status: data['status'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
    };
  }
}
