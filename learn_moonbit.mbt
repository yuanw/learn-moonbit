///|
/// [1518. Water Bottles](https://leetcode.com/problems/water-bottles/)
///
/// There are `num_bottles` water bottles that are initially full of water.
/// You can exchange `num_exchange` empty water bottles from the market
/// with one full water bottle. The operation of drinking a full water
/// bottle turns it into an empty bottle.
///
/// Return the maximum number of water bottles you can drink.
pub fn num_water_bottles(num_bottles : Int, num_exchange : Int) -> Int {
  for full = num_bottles, drunk = 0 {
    if full >= num_exchange {
      continue full - num_exchange + 1, drunk + num_exchange
    } else {
      break full + drunk
    }
  }
}

///|
test {
  assert_eq(num_water_bottles(9, 3), 13) // 9 + 3 + 1 = 13
  assert_eq(num_water_bottles(15, 4), 19)
}
