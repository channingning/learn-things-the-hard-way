## 添加依赖
向 `Cargo.toml` 文件中的 `[dependencies]` 下添加
```
ferris-says = "0.3.1"
```

运行 `cargo build`，Cargo 就会安装该依赖。

该命令会创建一个新文件 `Cargo.lock`，该文件记录了本地所用依赖库的精确版本。
