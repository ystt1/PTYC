class Medicine {
  final String id;
  final String name;
  final String unit; // Đơn vị tính
  final int quantity; // Số lượng
  final int status;

  const Medicine({
    required this.id,
    required this.name,
    required this.unit,
    required this.quantity,
    required this.status,
  });
}