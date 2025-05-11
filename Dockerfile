WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

RUN npm run build

EXPOSE 3000

CMD ["node", "dist/index.js"]
```

**このDockerfileの内容:**

* `FROM node:18-alpine`: ベースとなるDockerイメージとして、Node.js 18のAlpine Linuxディストリビューションを使用します。Alpine Linuxは軽量で、コンテナイメージのサイズを小さく保てます。
* `WORKDIR /app`: コンテナ内の作業ディレクトリを `/app` に設定します。
* `COPY package*.json ./`: ホストマシンの `package.json` と `package-lock.json` をコンテナ内の `/app` ディレクトリにコピーします。
* `RUN npm install`: コンテナ内で `npm install` を実行し、`package.json` に記述された依存関係をインストールします。
* `COPY . .`: ホストマシンの現在のディレクトリ (`nogizaka-api`) の内容すべてをコンテナ内の `/app` ディレクトリにコピーします。
* `RUN npm run build`: TypeScriptのコードをJavaScriptにコンパイルするためのビルドスクリプトを実行します (`package.json` に定義する必要があります）。
* `EXPOSE 3000`: コンテナがポート3000をリッスンすることを外部に通知します。
* `CMD ["node", "dist/index.js"]`: コンテナ起動時に実行するコマンドを指定します。ここでは、ビルドされたJavaScriptファイル (`dist/index.js`) をNode.jsで実行します。
