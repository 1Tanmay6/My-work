class Ticket {
  final String? id;
  final String? email;
  final String? enrollment;
  final bool enteredHall;
  final String? name;
  final String? phoneNo;
  final bool preRegestration;
  final bool vipTicket;

  Ticket({
    required this.id,
    required this.email,
    required this.enrollment,
    required this.enteredHall,
    required this.name,
    required this.phoneNo,
    required this.preRegestration,
    required this.vipTicket,
  });
}
