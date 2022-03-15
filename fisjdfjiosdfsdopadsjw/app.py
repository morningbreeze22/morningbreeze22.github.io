from flask import Flask, render_template,request
import pandas as pd
import joblib

def predict(age,weight):
    clf = joblib.load("regr.pkl")
    x = pd.DataFrame([[age, weight]], columns=["Age", "Weight"])
    prediction = clf.predict(x)[0]
    return prediction


app = Flask(__name__)

@app.route("/", methods=["GET","POST"])
def index():
    if request.method == "POST":
        age = request.form.get("age")
        weight = request.form.get("weight")
        return render_template("index.html",result=predict(age,weight))
    return render_template("index.html",result="")    

