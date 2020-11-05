from django.shortcuts import render
from django.http import HttpResponseRedirect
from .forms import NameForm
from .models import wilaya


def home(request):
	wilatas = wilaya.objects.all() 
	nom = "tibaredha"
	return render(request,"home.html",{"nom":nom,"wilatas":wilatas})


def home1(request):
	
	wilatas = wilaya.objects.all() 
	wilayas_names = []
	
	for wil in wilatas:
		wilayas_names.append(wil.nom)
	# print(wilayas_names)
	wilayas_names_br =  '<br>'.join(wilayas_names)
	nom = "amranemimi"
	return render(request,"home.html",{"nom":wilayas_names_br})




def get_name(request):
    # if this is a POST request we need to process the form data
    if request.method == 'POST':
        # create a form instance and populate it with data from the request:
        form = NameForm(request.POST)
        # check whether it's valid:
        if form.is_valid():
            # process the data in form.cleaned_data as required
            # ...
            # redirect to a new URL:
            return HttpResponseRedirect('/thanks/')

    # if a GET (or any other method) we'll create a blank form
    else:
        form = NameForm()

    return render(request, 'name.html', {'form': form})