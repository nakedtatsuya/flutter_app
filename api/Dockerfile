# ベースイメージの指定
FROM python:3.11

# 作業ディレクトリの設定
WORKDIR /app

# アプリケーションコードと依存関係ファイルをコピー
COPY . .

RUN apt update

# OpenCVの依存ライブラリをインストール
RUN apt-get update && apt-get install -y \docker
    libgl1-mesa-dev

# 必要なPythonパッケージをインストール
RUN pip install --no-cache-dir -r requirements.lock

# ポートを公開
EXPOSE 8000

# FastAPIサーバーを実行
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
