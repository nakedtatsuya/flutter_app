import cv2

def apply_mosaic(image, x, y, width, height, mosaic_size=10):
    """
    Apply a mosaic to a rectangle area in the image.
    """
    # モザイクをかける範囲を切り取る
    face = image[y:y + height, x:x + width]
    # 縮小して拡大することでモザイクを適用
    face = cv2.resize(face, (mosaic_size, mosaic_size), interpolation=cv2.INTER_LINEAR)
    face = cv2.resize(face, (width, height), interpolation=cv2.INTER_NEAREST)
    # 元の画像にモザイクを適用した部分を戻す
    image[y:y + height, x:x + width] = face
    return image