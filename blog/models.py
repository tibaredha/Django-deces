from django.db import models

# Create your models here.
class Question(models.Model):
    question_text = models.CharField(max_length=200)
    pub_date = models.DateTimeField("date published")
    
    def __str__(self):
	    return self.question_text	


class Choice(models.Model):
    question = models.ForeignKey(Question, on_delete=models.CASCADE)
    choice_text = models.CharField(max_length=200)
    votes = models.IntegerField(default=0)

    def __str__(self):
	    return self.choice_text	
	
class deces(models.Model):
	nom = models.CharField(max_length=200)
	prenom = models.CharField(max_length=200)
	age = models.CharField(max_length=200)
	date_naissance = models.CharField(max_length=200)
	
	def __str__(self):
		return self.nom
	
	
class wilaya(models.Model):
	nom = models.CharField(max_length=200)
	num = models.IntegerField(default=1)
	
	def __str__(self):
		return self.nom