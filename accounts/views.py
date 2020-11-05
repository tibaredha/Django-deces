from django.shortcuts import render

# Create your views here.

def connect(request):
	nom = "tibaredha"
	return render(request,"home.html",{"nom":nom})
