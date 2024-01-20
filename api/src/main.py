import base64

import cv2
import numpy as np
from fastapi import FastAPI, UploadFile
from fastapi.responses import JSONResponse
from lib.auth.initialize import init_google_oauth
from lib.mosaic_face.index import mosaic_face
from mangum import Mangum
from starlette.middleware.sessions import SessionMiddleware
from starlette.requests import Request
from authors.models import Author
from authors.query import Querier
from sqlalchemy import create_engine, text, create_engine

app = FastAPI()
app.add_middleware(SessionMiddleware, secret_key="secret-string")


@app.get("/")
def read_root():
    con = create_engine("sqlite:///tutorial.db", echo=True).connect()
    querier = Querier(con)
    author = querier.create_author(name="hoge", bio="fuga")
    print(author)
    return {"authors": "res"}


@app.get("/items/{item_id}")
def read_item(item_id: int, q: str = None, hoge: str = None):
    return {"item_id": item_id, "image": "hoge"}


@app.post("/pictures")
async def add_picture(file: UploadFile):
    image_data = await file.read()
    image = cv2.imdecode(np.fromstring(image_data, np.uint8), cv2.IMREAD_UNCHANGED)
    output = mosaic_face(image)
    # 画像をPNG形式にエンコード
    _, buffer = cv2.imencode(".png", output)

    # Base64文字列に変換
    image_base64 = base64.b64encode(buffer).decode("utf-8")
    cv2.imwrite("./src/assets/images/output.jpg", output)
    # 画像をレスポンスとして返す
    return {"item_id": 1, "image": image_base64}


oauth = init_google_oauth()


# we need this to save temporary code & state in session
app.add_middleware(SessionMiddleware, secret_key="some-random-string")


@app.get("/login/google")
async def login_via_google(request: Request):
    # absolute url for callback
    # we will define it below
    redirect_uri = request.url_for("auth")
    return await oauth.google.authorize_redirect(request, redirect_uri)


@app.route("/auth/google")
async def auth(request: Request):
    token = await oauth.google.authorize_access_token(request)
    print(token)
    print("============================")
    user = token["userinfo"]
    print("============================")
    print(user)
    return JSONResponse(user)


handler = Mangum(app)
