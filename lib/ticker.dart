class Ticker {
  const Ticker();

  Stream<int> makeTickStream({required int maxTicks}) {
    return Stream.periodic(
      const Duration(milliseconds: 50),
      (tick) {
        return maxTicks - tick - 1;
      },
    ).take(maxTicks);
  }
}
