![us-rivers](https://f.cloud.github.com/assets/230541/522244/86958e38-c00f-11e2-98be-e5f541d5eba2.png)

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
