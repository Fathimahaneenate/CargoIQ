class Onboard {
  final String image, title, desc;

  Onboard({
    required this.image,
    required this.title,
    required this.desc,
  });
}

final List<Onboard> screen = [
  Onboard(
    image: "assets/images/Untitled_design__15_-removebg-preview.png",
    title: "Place a Pickup Request",
    desc:
        "Request a pickup from your location in a few clicks.Choose from various delivery options available.",
  ),
  Onboard(
    image: "assets/images/onboard1.png",
    title: "Track Your Parcel",
    desc:
        "Track your courier in real-time with live updates.\nKnow where your package is every step of the way.",
  ),
  Onboard(
    image: "assets/images/Untitled_design-removebg-preview.png",
    title: "Safe and Reliable Delivery",
    desc:
        "We ensure your parcels are delivered on time and with the utmost care. Trust us with your packages.",
  ),
];