from django.contrib import admin

# Register your models here.
from .models import Question
admin.site.register(Question)

from .models import Choice
admin.site.register(Choice)

from .models import deces
admin.site.register(deces)

from .models import wilaya
admin.site.register(wilaya)
