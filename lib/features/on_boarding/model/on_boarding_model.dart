class OnBoardingModel {
  const OnBoardingModel({
    required this.title,
    required this.image,
    required this.description,
  });
  final String image;
  final String title;
  final String description;

  static List<OnBoardingModel> onBoardingList() {
    return <OnBoardingModel>[
      const OnBoardingModel(
        title: 'Find Events, get tickets',
        image: 'assets/images/screen_1.png',
        description: 'Just that easy!',
      ),
      const OnBoardingModel(
        title: 'Organize events in easy steps',
        image: 'assets/images/screen_2.png',
        description: 'Just list it, share it, we’ll do the rest',
      ),
      const OnBoardingModel(
        title: 'Your top events in one app',
        image: 'assets/images/screen_3.png',
        description: 'Long list of new features on the way',
      ),
    ];
  }
}
