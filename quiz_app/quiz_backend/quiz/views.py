from rest_framework import serializers
from rest_framework.response import Response
from rest_framework.decorators import api_view
from .models import Quiz
from .serializers import QuizSerializer
import random


@api_view(['GET'])
def helloAPI(request):
    return Response('hello!')



@api_view(['GET'])
def randomQuiz(request, id):
    totalQuiz = Quiz.objects.all()
    randomQuizs = random.sample(list(totalQuiz), id)
    serializer = QuizSerializer(randomQuiz, many=True)
    return Response(serializer.data)