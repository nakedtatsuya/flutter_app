import cv2
from lib.mosaic import apply_mosaic
from lib.face_diff import compute_sim
import insightface

face_analysis = insightface.app.FaceAnalysis()
face_analysis.prepare(ctx_id=0, det_size=(640, 640))
image1 = cv2.imread("./api/image.jpg")
faces = face_analysis.get(image1)

for face in faces:

    # 顔認識
    # match = compare_faces('./api/me.png', face_encoding, tolerance=0.4)
    similarity = compute_sim(target_face=face, registed_face_image_path="./api/me.png")
    if similarity < 0.6:
        # 登録済みの顔でない場合にモザイクを適用
        bbox = face.bbox.astype(int)
        x, y, x2, y2 = bbox
        width = x2 - x
        height = y2 - y
        image = apply_mosaic(image1, x, y, width, height, mosaic_size=10)

# 画像の保存
cv2.imwrite('./api/mosaic_faces.jpg', image)

