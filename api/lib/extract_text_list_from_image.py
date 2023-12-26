import easyocr

def extract_names_from_image(image_path):
    # EasyOCRリーダーの初期化（英語で初期化）
    reader = easyocr.Reader(['en'])

    # 画像からテキストを抽出
    results = reader.readtext(image_path)

    # 抽出されたテキストを格納するリスト
    extracted_texts = []

    for (bbox, text, prob) in results:
        # 確信度が高いテキストのみをリストに追加
        if prob >= 0.5:
            extracted_texts.append(text)

    return extracted_texts

# 画像のパス
image_path = "./api/image.jpg"

# 画像から名前を抽出
names = extract_names_from_image(image_path)

# 結果の表示
print("抽出されたテキスト:", names)