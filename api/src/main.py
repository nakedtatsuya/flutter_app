import cv2
import numpy as np
from fastapi import FastAPI, UploadFile
from lib.mosaic_face.index import mosaic_face
import base64

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
