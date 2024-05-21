import '../repos/models/category.dart';
import '../repos/models/product.dart';

enum CategoryAmountType { quantity, price, quality }

final stringLorem =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ac lorem eu magna tempus hendrerit aliquet at orci. Quisque dapibus tincidunt lorem quis vulputate. Quisque iaculis eros elit, nec congue metus eleifend et. Sed ultricies viverra pellentesque. Sed vitae mi hendrerit, consectetur lacus hendrerit, congue libero. Ut porta risus vitae nulla tempus, id ultrices arcu hendrerit. Nulla neque mi, sodales sed fermentum eget, auctor vitae diam. Nam et lorem enim. Praesent sagittis, enim id malesuada condimentum, ipsum ligula tincidunt metus, ullamcorper luctus augue lorem rhoncus lorem. Aenean venenatis, ante sed scelerisque tincidunt, ante est rhoncus mauris, nec ornare tortor ex sit amet libero. Aliquam sodales nec augue non pellentesque. Aliquam tristique vel nunc a tempor. Aliquam ac aliquet ligula, a consectetur tortor. In gravida eget dui quis facilisis. Sed auctor metus vitae nisi tincidunt, et hendrerit odio porta. Etiam quis faucibus nisl. Fusce facilisis nunc eu cursus tincidunt. Nam eget malesuada mi. Donec vitae metus nec ante ultricies vestibulum. Etiam et ultrices enim. Vivamus id justo molestie, vestibulum lacus eu, vehicula turpis. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Praesent placerat auctor justo, eget faucibus quam. Sed volutpat turpis in nisl tincidunt consequat. Duis sollicitudin faucibus dignissim. Pellentesque aliquam sodales lacus.Suspendisse malesuada tempus purus at molestie. Donec a dolor et lacus scelerisque viverra. Fusce faucibus venenatis nunc in molestie. Vivamus molestie turpis sed sagittis pulvinar. Sed nec consectetur velit, et aliquam sapien. Maecenas sollicitudin dictum augue quis ullamcorper. Sed libero nibh, maximus eu turpis vel, convallis laoreet mauris. Praesent sollicitudin efficitur blandit. Nunc eu dui ut neque eleifend euismod sit amet ac quam. Lorem ipsum dolor sit amet, consectetur adipiscing elit.";

List<Category>? allcategories = [
  Category(categoryId: 001, categoryName: "Tile"),
  Category(categoryId: 002, categoryName: "Paint"),
  Category(categoryId: 003, categoryName: "Raw Material"),
];
List<ProductPartner>? allpartner = [
  ProductPartner(partnerId: 1, partnerName: "Naveen", partnerPhoneNumber: "91xxxxxxxx"),
  ProductPartner(partnerId: 2, partnerName: "Piyush", partnerPhoneNumber: "91xxxxxxxx"),
];
List<Product>? allproducts = [
  Product(
    productId: 01,
    productName: "Kajaria Tiles",
    categoryId: 001,
    price: 1800.00,
    quantity: 250,
    description: "Floor Tiles",
    productPartner: ProductPartner(partnerId: 1, partnerName: "Naveen", partnerPhoneNumber: "91xxxxxxxxx"),
  ),
  Product(
    productId: 02,
    productName: "SunFlow Tiles",
    categoryId: 001,
    price: 1600.00,
    quantity: 150,
    description: "Floor/Wall Tiles",
    productPartner: ProductPartner(partnerId: 2, partnerName: "Piyush", partnerPhoneNumber: "91xxxxxxxxx"),
  ),
  Product(
    productId: 03,
    productName: "Local Tiles",
    categoryId: 001,
    price: 1000.00,
    quantity: 1000,
    description: "Floor Tiles",
    productPartner: ProductPartner(partnerId: 1, partnerName: "Naveen", partnerPhoneNumber: "91xxxxxxxxx"),
  ),
  Product(
    productId: 04,
    productName: "Beldow Tiles",
    categoryId: 001,
    price: 1400.00,
    quantity: 500,
    description: "Floor/Wall Tiles",
    productPartner: ProductPartner(partnerId: 1, partnerName: "Naveen", partnerPhoneNumber: "91xxxxxxxxx"),
  ),
  Product(
    productId: 05,
    productName: "Nerolac",
    categoryId: 002,
    price: 300.00,
    quantity: 500,
    description: "White Paint(Distemper)",
    productPartner: ProductPartner(partnerId: 2, partnerName: "Piyush", partnerPhoneNumber: "91xxxxxxxxx"),
  ),
  Product(
    productId: 06,
    productName: "Asian",
    categoryId: 002,
    price: 260.00,
    quantity: 100,
    description: "White Paint(Distemper)",
    productPartner: ProductPartner(partnerId: 2, partnerName: "Piyush", partnerPhoneNumber: "91xxxxxxxxx"),
  ),
  Product(
    productId: 07,
    productName: "Badarpur",
    categoryId: 003,
    price: 50.00,
    quantity: 1500,
    description: "Raw Material",
    productPartner: ProductPartner(partnerId: 1, partnerName: "Naveen", partnerPhoneNumber: "91xxxxxxxxx"),
  ),
  Product(
    productId: 08,
    productName: "Ambuja Cement",
    categoryId: 003,
    price: 100.00,
    quantity: 1000,
    description: "Raw Material",
    productPartner: ProductPartner(partnerId: 1, partnerName: "Naveen", partnerPhoneNumber: "91xxxxxxxxx"),
  ),
];
