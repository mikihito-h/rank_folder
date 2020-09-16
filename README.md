[![CircleCI](https://circleci.com/gh/mikihito-h/RankBoard/tree/master.svg?style=svg)](https://circleci.com/gh/mikihito-h/RankBoard/tree/master)

# RankBoard
![image](https://user-images.githubusercontent.com/53965479/91021556-e8646880-e62e-11ea-906b-ef260082a1f6.png)


## エレベーターピッチ
RankBoard（ランクボード）とは、Webサイトの検索順位の変動を記録するのが面倒という問題を解決する、Webサイトを運営しているエンジニア向けの、Google検索順位チェックサービスです。

検索ワードとURLを登録すると、登録したURLのGoogle検索順位を毎日自動で記録することができ、他の検索順位チェックサービスとは違って、サイト運営者がデータを独自に利用できるAPIが備わっている事が特徴です。


## インストール
ファイル`database.yml.example`の名前を`database.yml`に変更して、内容を適宜書き換えてから下記コマンドを実行して下さい。
```
$ bin/setup
$ rails server
```


## テスト
モデルテストを実行する場合は、環境変数`GOOGLE_API_KEY`と`GOOGLE_CSE_ID`を設定して下さい。値はなんでも大丈夫です。

ヘッドレスブラウザーでテスト
```
$ ./bin/test
```

普通のブラウザーでテスト
```
$ HEADED=1 ./bin/test
```

## Lint
rubocopを実行します。
```
$ ./bin/lint
```
