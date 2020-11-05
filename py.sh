
# source setup.sh myproject

# Colors
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

PROJECT=${1-myproject}

echo "${green}>>> Remove djangoproject${reset}"
rm -rf djangoproject

echo "${green}>>> Remove .venv${reset}"
rm -rf .venv

echo "${green}>>> Creating djangoproject.${reset}"
mkdir djangoproject
cd djangoproject

echo "${green}>>> Creating virtualenv${reset}"
python -m venv venv
echo "${green}>>> .venv is created.${reset}"

# active
sleep 2
echo "${green}>>> activate the .venv.${reset}"
venv/Scripts/activate
PS1="(`basename \"$VIRTUAL_ENV\"`)\e[1;34m:/\W\033[00m$ "
sleep 2
# installdjango
echo "${green}>>> Installing the Django${reset}"
pip install django
pip freeze > requirements.txt

# createproject
echo "${green}>>> Creating the project '$PROJECT' ...${reset}"
django-admin.py startproject $PROJECT .
cd $PROJECT
echo "${green}>>> Creating the app 'core' ...${reset}"
python ../manage.py startapp core

echo "${green}>>> Creating forms.py.${reset}"
touch core/forms.py

echo "${green}>>> Creating template directory.${reset}"
mkdir core/templates

echo "${green}>>> Creating index.html.${reset}"

cat << EOF > core/templates/index.html
<html>
  <head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
  </head>
  <body>
    <div class="container">
      <div class="jumbotron">
        <h1>Django Template</h1>
        <h3>index.html</h3>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
      </div>
    </div>
  </body>
</html>
EOF

# up one level
cd ..

python manage.py makemigrations
python manage.py migrate

echo "${green}>>> Creating a 'admin' user ...${reset}"
echo "${green}>>> The password must contain at least 8 characters.${reset}"
echo "${green}>>> Password suggestions: djangoadmin${reset}"
# python manage.py createsuperuser --username='admin' --email='tibaredha@yahoo.fr'

# ********** MAGIC **********
echo "Editing settings.py"
sed -i "/django.contrib.staticfiles/a\    '$PROJECT.core'," $PROJECT/settings.py

echo "Editing urls.py"
# exclude 15 lines by urls.py
# sed -i "1,15d" $PROJECT/urls.py
# insert text in urls.py
sed -i "/import admin/a\import $PROJECT.core.views as v" $PROJECT/urls.py
# the \x24 is $ ascii character
sed -i "/urlpatterns = \[/a\    path('', v.home, name='home')," $PROJECT/urls.py

echo "Create the view more simple"
# exclude line 2 by views.py
sed -i "2d" $PROJECT/core/views.py
sed -i "2c\from django.http import HttpResponse\n\n\n#def home(request):\n    #return HttpResponse('<h1>Welcome to the Django.</h1>')\n\n" $PROJECT/core/views.py
echo "def home(request):" >> $PROJECT/core/views.py
echo "    return render(request, 'index.html')" >> $PROJECT/core/views.py
# ********** END OF THE MAGIC **********

sleep 2
echo "${green}>>> Done${reset}"
sleep 2

# run
python manage.py runserver


