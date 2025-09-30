# Używamy stabilnego obrazu Ubuntu jako bazy
FROM ubuntu:latest
# Instalacja niezbędnych narzędzi
RUN apt-get update -y && \
    apt-get install -y git curl unzip && \
    rm -rf /var/lib/apt/lists/*

# Klonowanie najnowszej STABILNEJ wersji Fluttera
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Ustawienie zmiennych środowiskowych i PATH
ENV FLUTTER_ROOT=/usr/local/flutter
ENV PATH="$FLUTTER_ROOT/bin:$PATH"

# Pobieranie i inicjalizacja Dart SDK
RUN flutter precache --web