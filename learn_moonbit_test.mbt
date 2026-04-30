// Blackbox tests run against the package's public API. Use `@learn_moonbit` to import.
// Prefer high-level behaviors over implementation details.
// Run `moon test` to execute and `moon test --update` to refresh snapshots.

///|
test {
  assert_eq(@learn_moonbit.num_water_bottles(9, 3), 13)
  assert_eq(@learn_moonbit.num_water_bottles(15, 4), 19)
  assert_eq(@learn_moonbit.num_water_bottles(1, 2), 1)
  assert_eq(@learn_moonbit.num_water_bottles(100, 2), 199)
}
