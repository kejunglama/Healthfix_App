String ICON_KEY = "icon";
String TITLE_KEY = "title";

final productCategories = <Map>[
  <String, dynamic>{
    ICON_KEY: "assets/icons/app/icons-dumbell.svg",
    TITLE_KEY: "Sports Nutrition",
    // PRODUCT_TYPE_KEY: ProductType.Electronics,
  },
  <String, dynamic>{
    ICON_KEY: "assets/icons/app/icons-suppliment.svg",
    TITLE_KEY: "Vitamin/Supplement",
    // PRODUCT_TYPE_KEY: ProductType.Books,
  },
  <String, dynamic>{
    ICON_KEY: "assets/icons/app/icons-veg.svg",
    TITLE_KEY: "Health Food & Drink",
    // PRODUCT_TYPE_KEY: ProductType.Fashion,
  },
  <String, dynamic>{
    ICON_KEY: "assets/icons/app/icons-shop.svg",
    TITLE_KEY: "Clothing Apparel",
    // PRODUCT_TYPE_KEY: ProductType.Art,
  },
  <String, dynamic>{
    ICON_KEY: "assets/icons/app/icons-explore.svg",
    TITLE_KEY: "Explore Fitness",
    // PRODUCT_TYPE_KEY: ProductType.Others,
  },
];

final categoryHierarchy = {
  "Sports Nutrition": [
    "Proteins",
    "Gainers",
    "Protein Foods",
    "Pre/Post Workout",
    "All Sports",
  ],
  "Vitamin/Supplement": [
    "Omega Fatty Acids ",
    "Multi-Vitamins",
    "Minerals",
    "Vitamins",
    "All Vitamins",
  ],
  "Health Food & Drink": [
    "Weight Loss Foods",
    "Vinegar & Health Juices",
    "Protein Foods & Bars",
    "Family Nutrition",
    "Healthy Beverages",
  ],
  "Clothing Apparel": [
    "Men Clothing",
    "Women Clothing",
    "Fitness Clothing",
    "Sports Apparel",
  ],
  "Explore Fitness": [
    "Gym Equipment",
    "Gym Accessories",
    "Gym Supports",
    "Gym Essentials",
    "Fitness Clothings",
  ],
};