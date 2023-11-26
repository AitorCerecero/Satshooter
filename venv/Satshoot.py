from flask import Flask, render_template, request

app = Flask(__name__)

def acccheck(acc):
    if 'D' in acc:
        provider = "Dish Network"
        satellite = "Echostar V"
        logo_url = "https://d1yjjnpx0p53s8.cloudfront.net/styles/logo-thumbnail/s3/032012/dish_logo_4c_red.png?itok=tSC0s1tp"
    elif 'V' in acc:
        provider = "Viasat"
        satellite = "Viasat 3 Americas"
        logo_url = "https://d1yjjnpx0p53s8.cloudfront.net/styles/logo-thumbnail/s3/022023/thumbnail_logo_int_vsat_tm_rgb_grd_0.png?7kQOzCuPh13Z.cumiHLmdQkz7VhYJZ7y&itok=cGJzmxBY"
    elif 'H' in acc:
        provider = "HughesNet"
        satellite = "Jupiter 3"
        logo_url = "https://d1yjjnpx0p53s8.cloudfront.net/styles/logo-thumbnail/s3/052013/hughesnet.png?itok=Ay8cOT-C"
    else:
        provider = None
        satellite = None
        logo_url = None

    return provider, satellite, logo_url

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        acc = request.form['account_number']
        provider, satellite, logo_url = acccheck(acc)
        return render_template('result.html', provider=provider, satellite=satellite, logo_url=logo_url)

    # Solo devuelve la plantilla en la rama GET
    return render_template('index.html')

if __name__ == '__main__':
    app.run(debug=True)



