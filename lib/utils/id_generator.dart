import 'package:uuid/uuid.dart';
final Uuid _uuid = Uuid();

String generateUuid() {
  return _uuid.v4(); // Ejemplo: "c1f7094e-832d-4be3-b6c9-4c3e6efbdd9f"
}
