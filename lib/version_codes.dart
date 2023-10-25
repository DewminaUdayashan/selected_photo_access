enum Android {
  /// The original, first, version of Android. Yay!
  /// Released publicly as Android 1.0 in September 2008.
  base(1),

  /// First Android update.
  /// Released publicly as Android 1.1 in February 2009.
  base2(2),

  /// C.
  /// Released publicly as Android 1.5 in April 2009.
  cupcake(3),

  /// D.
  /// Released publicly as Android 1.6 in September 2009.
  donut(4),

  /// E.
  /// Released publicly as Android 2.0 in October 2009.
  eclair(5),

  /// E incremental update.
  /// Released publicly as Android 2.0.1 in December 2009.
  eclair01(6),

  ///E MR1.
  /// Released publicly as Android 2.1 in January 2010.
  eclairMR1(7),

  /// Froyo.
  /// Released publicly as Android 2.2 in May 2010.
  froyo(8),

  /// G.
  /// Released publicly as Android 2.3 in December 2010.
  gingerbread(9),

  ///G MR1.
  /// Released publicly as Android 2.3.3 in February 2011.
  gingerbreadMR1(10),

  /// H.
  /// Released publicly as Android 3.0 in February 2011.
  honeycomb(11),

  ///H MR1.
  /// Released publicly as Android 3.1 in May 2011.
  honeycombMR1(12),

  ///H MR2.
  /// Released publicly as Android 3.2 in July 2011.
  honeycombMR2(13),

  /// I.
  /// Released publicly as Android 4.0 in October 2011.
  iceCreamSandwich(14),

  ///I MR1.
  /// Released publicly as Android 4.03 in December 2011.
  iceCreamSandwichMR1(15),

  /// J.
  /// Released publicly as Android 4.1 in July 2012.
  jellyBean(16),

  ///J MR1.
  /// Released publicly as Android 4.2 in November 2012.
  jellyBeanMR1(17),

  ///J MR2.
  /// Released publicly as Android 4.3 in July 2013.
  jellyBeanMR2(18),

  /// K.
  /// Released publicly as Android 4.4 in October 2013.
  kitKat(19),

  ///K for watches.
  /// Released publicly as Android 4.4W in June 2014.
  kitKatWatch(20),

  /// Lollipop.
  /// Released publicly as Android 5.0 in November 2014.
  lollipop(21),

  ///L MR1.
  /// Released publicly as Android 5.1 in March 2015.
  lollipopMR1(22),

  /// Marshmallow.
  /// Released publicly as Android 6.0 in October 2015.
  marshmallow(23),

  /// Nougat.
  /// Released publicly as Android 7.0 in August 2016.
  nougat(24),

  ///N MR1.
  /// Released publicly as Android 7.1 in October 2016.
  nougatMR1(25),

  /// Oreo.
  /// Released publicly as Android 8.0 in August 2017.
  oreo(26),

  ///O MR1.
  /// Released publicly as Android 8.1 in December 2017.
  oreoMR1(27),

  /// Pie.
  /// Released publicly as Android 9.0 in August 2018.
  pie(28),

  /// Android 10.
  /// Released publicly as Android 10 in September 2019.
  q(29),

  /// Android 11.
  /// Released publicly as Android 11 in September 2020.
  r(30),

  /// Android 12.
  /// Released publicly as Android 12 in October 2021.
  s(31),

  /// Android 12v2.
  sV2(32),

  /// Android 13.
  /// Released publicly as Android 13 August 2022.
  tiramisu(33),

  /// Upside Down Cake.
  /// Expected to release in October,2023 as Android 14.
  upsideDownCake(34);

  const Android(this.sdkInt);

  final int sdkInt;
}
