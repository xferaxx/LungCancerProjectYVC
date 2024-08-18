from skimage.metrics import structural_similarity as ssim
import numpy as np
import cv2
from flask import Flask
from flask import request
import mysql.connector
from config import *
import urllib.request
import time
import base64
from PIL import Image
import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier
from sklearn.metrics import classification_report, confusion_matrix
from sklearn.model_selection import cross_val_score


app = Flask(__name__, template_folder='C:/xampp/htdocs/project')


@app.route('/my-link/')
def my_link():

    mydb = mysql.connector.connect(
        host=host,
        user=user,
        password=password,
        database=database
    )

    image = request.args.get('image')
    print(image)
    id = request.args.get('id')
    print(id)
    strr = request.args.get('strr')
    print(strr)

    def mse(imageA, imageB):
        # the 'Mean Squared Error' between the two images is the sum of the squared difference between the two images
        mse_error = np.sum(
            (imageA.astype("float") - imageB.astype("float")) ** 2)
        mse_error /= float(imageA.shape[0] * imageA.shape[1])
        # return the MSE. The lower the error, the more "similar" the two images are.
        return mse_error

    mycursor = mydb.cursor()
    mycursor.execute("SELECT * FROM img_drawing WHERE id_d = '"+str(id)+"'")
    myresult = mycursor.fetchone()
    print(myresult[4])

    print(phpapiurl+image)

    url_response_original = urllib.request.urlopen(phpapiurl+myresult[4])
    img_array_original = np.array(
        bytearray(url_response_original.read()), dtype=np.uint8)
    original = cv2.imdecode(img_array_original, -1)
    original = cv2.cvtColor(original, cv2.COLOR_BGRA2BGR)
    # original = cv2.imread(phpapiurl+myresult[4])

    url_response_contrast = urllib.request.urlopen(phpapiurl+image)
    img_array_contrast = np.array(
        bytearray(url_response_contrast.read()), dtype=np.uint8)
    contrast = cv2.imdecode(img_array_contrast, -1)
    # contrast = cv2.cvtColor(contrast, cv2.COLOR_BGRA2BGR)

    url_response_original1 = urllib.request.urlopen(phpapiurl+myresult[4])
    img_array_original1 = np.array(
        bytearray(url_response_original1.read()), dtype=np.uint8)
    original1 = cv2.imdecode(img_array_original1, -1)
    original1 = cv2.cvtColor(original1, cv2.COLOR_BGR2GRAY)

    url_response_contrast1 = urllib.request.urlopen(phpapiurl+image)
    img_array_contrast1 = np.array(
        bytearray(url_response_contrast1.read()), dtype=np.uint8)
    contrast1 = cv2.imdecode(img_array_contrast1, -1)
    contrast1 = cv2.cvtColor(contrast1, cv2.COLOR_BGR2GRAY)

    # this was added here because the not good after RED MASK

    OriginalURL = "original_try.png"
    cv2.imwrite(OriginalURL, original)
    oriRGB = Image.open(
        "C:/xampp/htdocs/project/original_try.png").convert('RGB')
    oriHSV = oriRGB.convert('HSV')

    # the Real solution of the Image to send to user to See
    imgS = cv2.imread(OriginalURL)
    png_imgS = cv2.imencode('.png', imgS)
    SolutionImage = base64.b64encode(png_imgS[1]).decode('utf-8')

    ho, wo, _ = original.shape
    hc, wc, _ = contrast.shape
    ratio_orig = ho/wo
    ratio_comp = hc/wc

    if round(ratio_orig, 2) == round(ratio_comp, 2):
        mse_value = mse(original1, contrast1)

    # compute difference
    difference = cv2.subtract(original, contrast)

    # color the mask red
    Conv_hsv_Gray = cv2.cvtColor(difference, cv2.COLOR_BGR2GRAY)

    ret, mask = cv2.threshold(Conv_hsv_Gray, 0, 255,
                              cv2.THRESH_BINARY_INV | cv2.THRESH_OTSU)

    difference[mask != 255] = [0, 0, 255]

    # add the red mask to the images to make the differences obvious
    original[mask != 255] = [0, 0, 255]
    contrast[mask != 255] = [0, 0, 255]

    difImage = "diff_" + str(time.time()) + ".png"
    cv2.imwrite(difImage, contrast)

    # Script to Thirdcolor
    image = cv2.imread(difImage)
    hsv = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)

    # Define lower and uppper limits of what we call "gray 118"
    brown_lo = np.array([0, 0, 118])
    brown_hi = np.array([0, 0, 118])

    # Mask image to only select grays 118
    mask = cv2.inRange(hsv, brown_lo, brown_hi)

    # Change image to yellow where we found missed
    image[mask > 0] = (0, 255, 255)

    _time = str(time.time())
    seeImage = _time + ".png"
    cv2.imwrite(seeImage, image)

    img = cv2.imread(seeImage)
    png_img = cv2.imencode('.png', img)
    data = base64.b64encode(png_img[1]).decode('utf-8')

    ###########################################

    ####
    # the Open of the original photo is up because not good to put after RED MASK [0,0,225]
    ####

    cv2.imwrite("userresult.png", image)
    ContRGB = Image.open(
        "C:/xampp/htdocs/project/userresult.png").convert('RGB')

    ContHSV = ContRGB.convert('HSV')

    # Make numpy versions
    OriginalRGBna = np.array(oriRGB)
    OriginalHSVna = np.array(oriHSV)

    ContrastRGBna = np.array(ContRGB)
    ContrastHSVna = np.array(ContHSV)

    ContrastHSVnaRed = np.array(ContHSV)

    # Extract Hue
    OriginalH = OriginalHSVna[:, :, 0]

    ContrastH = ContrastHSVna[:, :, 0]

    # Find all green pixels, i.e. where 100 < Hue < 140
    lo, hi = 100, 140

    # Rescale to 0-255, rather than 0-360 because we are using uint8
    lo = int((lo * 255) / 360)
    hi = int((hi * 255) / 360)

    greenOri = np.where((OriginalH > lo) & (OriginalH < hi))

    greenCon = np.where((ContrastH > lo) & (ContrastH < hi))

    # Make all green pixels to blue in images
    OriginalRGBna[greenOri] = [0, 0, 255]

    ContrastRGBna[greenCon] = [0, 0, 255]

    cv2.imwrite("blue.png", ContrastRGBna)

    OriCounter = greenOri[0].size

    ConCounter = greenCon[0].size

    print("Pixels matched Original: {}".format(OriCounter))
    print("Pixels matched Contrast: {}".format(ConCounter))

    ######Counting the RED Pixels#####
    # convert to HSV
    hsv = ContrastHSVnaRed
    h,s,v = cv2.split(hsv)

    # create mask for red color in hsv
    lower_red = np.array([0,50,50])
    upper_red = np.array([10,255,255])
    mask0 = cv2.inRange(hsv, lower_red, upper_red)
    # upper mask (170-180)
    lower_red = np.array([170,50,50])
    upper_red = np.array([180,255,255])
    mask1 = cv2.inRange(hsv, lower_red, upper_red)
    # join my masks
    mask = mask0+mask1


    # count non-zero pixels in mask
    countRed=np.count_nonzero(mask)
    print('count:', countRed)
    score = (ConCounter / (OriCounter + countRed))*100

    if (score >= 90):
        strr = " Perfect"
    elif ((score) >= 80) & ((score) <= 89):
        strr = " Very good "
    elif ((score) >= 70) & ((score) <= 79):
        strr = " Almost Got it good"
    elif ((score) >= 55) & ((score) <= 69):
        strr = " NOT SO GOOD FOCUS"
    else:
        strr = " WRONG TRY AGAIN"

    return [data, str(score), strr, SolutionImage]


@app.route('/my-level/')
def my_level():

    user_id = request.args.get('user_id')
    token = request.args.get('token')

    mydb = mysql.connector.connect(
        host=host,
        user=user,
        password=password,
        database=database
    )

    mycursor = mydb.cursor()
    mycursor.execute("SELECT * FROM exam WHERE user_id = '" +
                     str(user_id)+"'" + " AND token='" + str(token) + "'")

    myresult = mycursor.fetchall()
    if (int(len(myresult)) < 10):
        quesNo = int(myresult[-1][1])+1
        return str(quesNo)
    else:
        data_url = "C:/xampp/htdocs/project/test1.csv"
        df = pd.read_csv(data_url)

        df["ques_1"] = df["ques_1"].astype('category').cat.codes
        df["ques_2"] = df["ques_2"].astype('category').cat.codes
        df["ques_3"] = df["ques_3"].astype('category').cat.codes
        df["ques_4"] = df["ques_4"].astype('category').cat.codes
        df["ques_5"] = df["ques_5"].astype('category').cat.codes
        df["ques_6"] = df["ques_6"].astype('category').cat.codes
        df["ques_7"] = df["ques_7"].astype('category').cat.codes
        df["ques_8"] = df["ques_8"].astype('category').cat.codes
        df["ques_9"] = df["ques_9"].astype('category').cat.codes
        df["ques_10"] = df["ques_10"].astype('category').cat.codes
        df["target"] = df["target"].astype('category').cat.codes

        x = df.iloc[:, 1:-1]
        y = df.iloc[:, -1]

        df.dtypes
        x.dtypes

        x = x.to_numpy()
        y = y.to_numpy()

        x_train, x_test, y_train, y_test = train_test_split(
            x, y, test_size=0.20, random_state=47)

        classifier = KNeighborsClassifier(n_neighbors=16)
        classifier.fit(x_train, y_train)

        y_pred = classifier.predict(x_test)

        #########Cross Validation#######
        # choose k between 1 to 20

        k_range = range(1, 20)
        k_scores = []

        # after ploting the Cross Validation we got the maximum Cross validation at K = 16
        for k in k_range:
            knn = KNeighborsClassifier(n_neighbors=k)
            scores = cross_val_score(knn, x, y, cv=10, scoring='accuracy')
            k_scores.append(scores.mean())

        print(confusion_matrix(y_test, y_pred))
        print(classification_report(y_test, y_pred))

        mycursor = mydb.cursor()
        mycursor.execute("SELECT (rightAns = answer) AS isCorrect FROM exam WHERE user_id = '" +
                         str(user_id)+"'" + " AND token='" + str(token) + "' AND quesNo <= 10")
        print("SELECT (rightAns = answer) AS isCorrect FROM exam WHERE user_id = '" +
              str(user_id)+"'" + " AND token='" + str(token) + "' AND quesNo <= 10")
        myresult = mycursor.fetchall()

        ques1 = int(myresult[0][0])
        ques2 = int(myresult[1][0])
        ques3 = int(myresult[2][0])
        ques4 = int(myresult[3][0])
        ques5 = int(myresult[4][0])
        ques6 = int(myresult[5][0])
        ques7 = int(myresult[6][0])
        ques8 = int(myresult[7][0])
        ques9 = int(myresult[8][0])
        ques10 = int(myresult[9][0])

        levelP = int(classifier.predict(
            [[ques1, ques2, ques3, ques4, ques5, ques6, ques7, ques8, ques9, ques10]]))

        levelStr = "Low"
        if (int(levelP) == 1):
            levelStr = "Medium"
        elif (int(levelP) == 2):
            levelStr = "High"

        return str(levelStr)


if __name__ == '__main__':
    app.run()
