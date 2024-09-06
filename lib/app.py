from flask import Flask, jsonify, request

app = Flask(__name__)

@app.route('/')
def home():
    return "Hello, World!"

@app.route('/api/data', methods=['GET'])
def get_data():
    # ตัวอย่างการส่งข้อมูล JSON
    data = {"message": "Hello from Flask!"}
    return jsonify(data)

@app.route('/api/upload', methods=['POST'])
def upload():
    if 'file' not in request.files:
        return jsonify({"error": "No file part"}), 400

    file = request.files['file']
    if file.filename == '':
        return jsonify({"error": "No selected file"}), 400

    # เก็บไฟล์หรือดำเนินการอื่น ๆ
    file.save(f"./uploads/{file.filename}")
    return jsonify({"message": "File uploaded successfully"}), 200

if __name__ == '__main__':
    app.run(debug=True)
