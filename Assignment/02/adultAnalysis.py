
import pandas as pd
import numpy as np
import graphviz
from sklearn.tree import export_graphviz
from sklearn.tree import DecisionTreeClassifier
from sklearn.preprocessing import LabelEncoder
from sklearn.metrics import accuracy_score
import pydotplus
import matplotlib.pyplot as plt
from sklearn.impute import SimpleImputer
import matplotlib.image as mpimg

def cleanData(df):
    
    df = df.fillna('None')
    df.income = df.income.apply(lambda x: 0 if x.replace('.', '') == '<=50K' else 1)
    # print(df.head(5))
    # print(df.columns)
    return df

def splitDataframe(df):
    x = df.drop(['income'], axis=1)
    y = df['income']
    return x, y

def handleWithLabelEncoder(trainData, testData, objectList):
    label_encoder = LabelEncoder()
    for col in objectList:
        trainData[col] = label_encoder.fit_transform(trainData[col])
        testData[col] = label_encoder.transform(testData[col])

    return trainData, testData

if __name__ == "__main__":
    trainPath = 'adult.data'
    testPath = 'adult.test'

    traindf = pd.read_csv(trainPath, engine='python', sep=',\s', na_values=['?'])
    testdf = pd.read_csv(testPath, engine='python', sep=',\s', na_values=['?'])
    
    # print(traindf.income.unique())

    traindf = cleanData(traindf)
    testdf = cleanData(testdf)

    xTrain, yTrain = splitDataframe(traindf)
    xTest, yTest = splitDataframe(testdf)

    # xTrain, xTest = handleWithImputer(xTrain, xTest)

    # Get list of categorical variables
    s = (traindf.dtypes == 'object')
    object_cols = list(s[s].index)
    xTrain, xTest = handleWithLabelEncoder(xTrain, xTest, object_cols)

    # print(xTrain)
    # print(xTest)
    model = DecisionTreeClassifier(max_depth=5, min_samples_split=2, random_state=0)
    model.fit(xTrain, yTrain)
    pred = model.predict(xTest)
    print(accuracy_score(yTest, pred))
    
    g = export_graphviz(model, feature_names=xTrain.columns,filled=True, rounded=True)
    gr = pydotplus.graph_from_dot_data(g)
    gr.write_png('b.png')
    plt.figure(figsize=(12, 12))
    img = mpimg.imread('b.png')
    imgplot = plt.imshow(img)

    plt.show()