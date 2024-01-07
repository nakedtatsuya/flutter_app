import cv2
import numpy as np
from fastapi import FastAPI, UploadFile
from lib.mosaic_face.index import mosaic_face
import base64
from mangum import Mangum
from starlette.requests import Request

app = FastAPI()


@app.get("/")
def read_root():
    return {"Hello": "World"}


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


from starlette.middleware.sessions import SessionMiddleware
from authlib.integrations.starlette_client import OAuth
from starlette.config import Config

config = Config(".env")  # read config from .env file
oauth = OAuth(config)
oauth.register(
    name="google",
    server_metadata_url="https://accounts.google.com/.well-known/openid-configuration",
    client_kwargs={"scope": "openid email profile"},
)

app = FastAPI()
# we need this to save temporary code & state in session
app.add_middleware(SessionMiddleware, secret_key="some-random-string")


@app.get("/login/google")
async def login_via_google(request: Request):
    redirect_uri = request.url_for("auth_via_google")
    return await oauth.google.authorize_redirect(request, redirect_uri)


@app.get("/auth/google")
async def auth_via_google(request: Request):
    token = await oauth.google.authorize_access_token(request)
    user = token["userinfo"]
    return dict(user)


handler = Mangum(app)
