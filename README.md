![california](https://f.cloud.github.com/assets/230541/520661/b4d9d39a-bf41-11e2-8405-f1e453c307df.png)

To install:

```bash
brew install p7zip
npm install
```

To make a TopoJSON file for the entire United States (it’s big!), type `make`. Or, to make a TopoJSON file for a specific [NHD region](http://www.horizon-systems.com/nhdplus/NHDPlusV2_data.php), specify a target. For example, California:

```bash
make topo/18.json
```

This project was inspired by Nelson Minar’s work on a [vector river map](https://github.com/NelsonMinar/vector-river-map).
