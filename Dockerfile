FROM python:3.8
ENV PY_SERVER_PORT=8000
ENV PY_SERVER_HOST_NAME=localhost
# VOLUME ["py-server"]
RUN mkdir app
COPY py-server/app.py app/app.py
# RUN echo $PY_SERVER_PORT
# RUN export PY_SERVER_PORT=$PY_SERVER_PORT
# RUN export PY_SERVER_HOST_NAME=$PY_SERVER_HOST_NAME
EXPOSE 8000
# CMD ["python", "-m", "http.server", $PY_SERVER_PORT]
# CMD python -m http.server $PY_SERVER_PORT
CMD python app/app.py