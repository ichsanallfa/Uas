class ApiResponse {
  final bool status;
  final String message;

  ApiResponse({
    required this.status,
    required this.message,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
    );
  }
}