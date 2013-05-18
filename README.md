![us-rivers](https://f.cloud.github.com/assets/230541/522207/a4bc168c-c007-11e2-86ad-8abb5d513a47.png)

To install:

```bash
brew install p7zip cairo pixman
npm install
```

To make the above PNG for the entire United States (it’s big!), type `make`. Or, to make a TopoJSON file for a specific [NHD region](http://www.horizon-systems.com/nhdplus/NHDPlusV2_data.php), specify a target. For example, California:

```bash
make topo/18.json
```

This project was inspired by Nelson Minar’s work on a [vector river map](https://github.com/NelsonMinar/vector-river-map).
