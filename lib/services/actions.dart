String flowTypeIconPath(String flowType) {
  Map<String, String> paths = {
    'nostalgia': 'assets/nostalgia.svg',
    'anxiety': 'assets/anxiety.svg',
    'apathy': 'assets/apathy.svg',
    'doubt': 'assets/doubt.svg',
    'flow': 'assets/flow.svg',
    'boredom': 'assets/boredom.svg',
  };
  return paths[flowType];
}
