from fastapi import FastAPI, File, UploadFile
from pydantic import BaseModel
from lib.mosaic_face.index import mosaic_face
import cv2
import numpy as np

app = FastAPI()


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.get("/items/{item_id}")
def read_item(item_id: int, q: str = None, hoge: str = None):
    return {"item_id": item_id, "q": q, "hoge": hoge}

class Item(BaseModel):
    name: str

@app.post("/pictures")
async def add_picture(file: UploadFile):
    image_data = await file.read()
    image = cv2.imdecode(np.fromstring(image_data, np.uint8), cv2.IMREAD_UNCHANGED)
    output = mosaic_face(image)
    cv2.imwrite('./src/assets/images/output.jpg', output)
    return {"filename": file.filename}

