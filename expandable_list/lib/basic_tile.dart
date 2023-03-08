class BasicTile{
  final String title;
  final List<BasicTile> tiles;

  const BasicTile({
    required this.title, this.tiles = const[],
  });
}

final basicTiles = <BasicTile>[
  const BasicTile(title: "Fruits",
  tiles: [
    BasicTile(title: "Apple"),
    BasicTile(title: "Orange"),
    BasicTile(title: "Watermelon"),
    BasicTile(title: "Peach"),
  ]
  ),
  const BasicTile(title: "Continents",
  tiles: [
    BasicTile(title: "Apple", tiles: [BasicTile(title: "america")]),
     BasicTile(title: "Apple", tiles: [BasicTile(title: "america")]),
  ]
  ),
  const BasicTile(title: "Computer",
  tiles: [
    BasicTile(title: "Apple"),
    BasicTile(title: "Orange"),
    BasicTile(title: "Watermelon"),
    BasicTile(title: "Peach"),
  ]
  ),
];