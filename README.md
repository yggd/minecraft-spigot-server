# Minecraft (Spigot) マルチサーバー

Java版Minecraft のマルチプレイに対応したサーバーを建てることができます。

## 必要環境()内は動作確認したバージョン

* Docker Engine (25.0.3)
* Minecraft Java Edition (1.20.4)

## 特徴

* 同時接続は20人まで可能
* plugins フォルダに Bukkit/Spigot 対応のファイルを置くことにより、各種modを導入可能

## 利用ガイド

* サーバーの起動

`docker-compose.yml` ファイルが置かれている場所で、

```sh
$ docker compose up -d
```

で起動します。

* サーバコンソールの開き方

```sh
$ docker ps
CONTAINER ID   IMAGE                            COMMAND                   CREATED      STATUS      PORTS                                           NAMES
3956e7816ced   minecraft-spigot-server-spigot   "java -Xms2G -Xmx2G …"   4 days ago   Up 4 days   0.0.0.0:25565->25565/tcp, :::25565->25565/tcp   minecraft-spigot-server-spigot-1
```

でMinecraftサーバーが起動している `CONTAINER ID` を控え、

```sh
$ docker attach <CONTAINER ID(ここでは395~)>
```

を実行することで、サーバープロセスの標準入力・標準出力にアタッチすることができます。
(試しにhelp+Enterを入力してみてください。)  
用件が済んだら、Ctrl+P, Ctrl+Q で抜けることができます。
(Ctrl+Cを押すとサーバープロセスが終了してしまうので注意してください。)

また、mod適用時はサーバーの再起動を行なってください。
コンソール上からサーバーを停止したい場合は `stop` コマンドを入力してください。

## 注意

* Dockerfileにてeula.txt(エンドユーザライセンス契約)を「読んだもの」としてビルドを行います。
ご利用の前に必ず [MINECRAFT EULA](https://www.minecraft.net/ja-jp/eula) をご一読下さい。
* ビルドした成果物・バイナリデータおよびDockerイメージを再配布することはできません。
* 本サーバ、および本コンテンツは無保証です。ご利用により生じたいかなる結果に対して、作成者は責任を負いません。

