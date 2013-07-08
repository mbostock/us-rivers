# U.S. Rivers

![us-rivers](https://f.cloud.github.com/assets/230541/522453/556969d4-c031-11e2-8c88-04353d69bb5d.png)

Also available in [massive 3840x2400 resolution](http://bost.ocks.org/mike/us-rivers.png), or roll your own using the below instructions.

To install:

```bash
brew install p7zip cairo pixman optipng
npm install
```

If the installation of the [node-canvas](https://github.com/LearnBoost/node-canvas) module fails for you, you can try this after the above:

```bash
PKG_CONFIG_PATH=/opt/X11/lib/pkgconfig npm install canvas
```

To make the above PNG for the entire United States (it’s big!), type `make`. Or, to make a TopoJSON file for a specific [NHD region](http://www.horizon-systems.com/nhdplus/NHDPlusV2_data.php), specify a target. For example, California:

```bash
make topo/18.json
```

This project was inspired by Nelson Minar’s work on a [vector river map](https://github.com/NelsonMinar/vector-river-map).
