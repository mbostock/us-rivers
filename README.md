![california](https://f.cloud.github.com/assets/230541/520661/b4d9d39a-bf41-11e2-8405-f1e453c307df.png)

To install:

```bash
brew install p7zip
npm install
```

To run, just type `make`. You can override the `REGIONS` environment variable to specify a subset of [NHD regions](http://www.horizon-systems.com/nhdplus/NHDPlusV2_data.php).

```bash
REGIONS=18 make
```
