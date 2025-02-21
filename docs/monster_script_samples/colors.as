Color noColor = Color(0, 0, 0, 0);         // rgba(0, 0, 0, 0)
Color black   = Color(0, 0, 0, 255);       // rgba(0, 0, 0, 255)
Color white   = Color(255, 255, 255, 255); // rgba(255, 255, 255, 255)

Color gray   = Color(190, 190, 190, 255);  // rgba(107, 130, 123, 255)
Color yellow = Color(240, 249, 142, 255);  // rgba(240, 249,142, 255)
Color orange = Color(255, 122, 0, 255);    // rgba(255, 122, 0, 255)
Color red    = Color(255, 0, 0, 255);      // rgba(255, 0, 0, 255)
Color pink   = Color(254, 51, 174, 255);   // rgba(254, 51, 174, 255)
Color purple = Color(201, 62, 216, 255);   // rgba(201, 62, 216, 255)
Color blue   = Color(0, 191, 255, 255);    // rgba(0, 191, 255, 255)
Color teal   = Color(0, 180, 147, 255);    // rgba(0, 180, 147, 255)
Color green  = Color(77, 223, 54, 255);    // rgba(77, 223, 54, 255)

int min0max255(int i) {
  return (i > 255) ? 255 : (i < 0) ? 0 : i;
};

Color darken(Color base, int amount) {
  return Color(
    min0max255(base.r - amount),
    min0max255(base.g - amount),
    min0max255(base.b - amount),
    min0max255(base.a - amount)
    );
}

Color lighten(Color base, int amount) {
  return darken(base, -amount);
}

Color transparentify(Color base, int amount) {
  return Color(
    base.r,
    base.g,
    base.b,
    min0max255(base.a - amount)
    );
}

Color opacify(Color base, int amount) {
  return transparentify(base, -amount);
}

Color ranged_light_color = teal;
