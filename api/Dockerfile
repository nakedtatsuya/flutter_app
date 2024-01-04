# ベースイメージの指定
FROM python:3.11

# 作業ディレクトリの設定
WORKDIR /app

# 必要なPythonパッケージをインストール
COPY requirements.lock ./
RUN pip install --no-cache-dir -r requirements.lock

# アプリケーションコードをコピー
COPY . .

# ポートを公開
EXPOSE 8000

# FastAPIサーバーを実行
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
