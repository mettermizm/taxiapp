
AnimatedRatingStars(
  initialRating: person["rate"] ?? 0.0,
  minRating: 0.0,
  maxRating: 5.0,
  customFilledIcon: Icons.star,
  customEmptyIcon: Icons.star_border,
  customHalfFilledIcon: Icons.star_half,
  filledColor: Colors.amber,
  emptyColor: Colors.grey,
  filledIcon: Icons.star,
  halfFilledIcon: Icons.star_half,
  emptyIcon: Icons.star_border,
  onChanged: (double rating) {
    // Kullanıcının puan değişikliklerini işle
    person['rate'] = rating;
    print('Kisi1 Puanı: $rating');
  },
  starSize: 12.0,
)