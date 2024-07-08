# FROM python:3.9-alpine3.13
# LABEL mainterner="ItsYoKidOjay"

# ENV PYTHONUNBUFFERED 1

# COPY ./requirements.txt /tmp/requirements.txt
# COPY ./app /app
# WORKDIR /app
# EXPOSE 8000


# RUN python -m venv /py && \
#     /py/bin/pip install --upgrade pip && \
#     /py/bin/pip install -r /tmp/requirements.txt && \
#     rm -rf /tmp && \
#     adduser \ 
#         --disable-password \
#         --no-create-home \
#         django-user

# ENV PATH="/py/bin:$PATH"

# USER django-user

FROM python:3.9-alpine3.13
LABEL maintainer="ItsYoKidOjay"

ENV PYTHONUNBUFFERED=1

# Install build dependencies
RUN apk update && apk add --no-cache \
    gcc \
    musl-dev \
    linux-headers \
    libffi-dev \
    postgresql-dev \
    python3-dev \
    py3-setuptools \
    build-base

# Install virtualenv
RUN python -m ensurepip && \
    pip install --no-cache --upgrade pip setuptools wheel

# Copy application files
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false

# Create virtual environment and install dependencies
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ "$DEV" = "true" ]; then /py/bin/pip install -r /tmp/requirements.dev.txt; fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

# Add virtual environment to PATH
ENV PATH="/py/bin:$PATH"

# Change to non-root user
USER django-user

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
