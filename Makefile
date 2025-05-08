# Ruta de Homebrew en Apple Silicon
BREW_PREFIX := /opt/homebrew

INCLUDE_DIR := include

CXX       := g++
CXXFLAGS  := -std=c++17 \
             -I$(INCLUDE_DIR) \
             -I$(BREW_PREFIX)/include \
             -Wall -Wextra

# Necesario en macOS para GLFW
FRAMEWORKS := \
    -framework Cocoa \
    -framework IOKit \
    -framework CoreVideo \
    -framework OpenGL

LDFLAGS   := -g -L$(BREW_PREFIX)/lib \
             -lGLEW \
             -lglfw \
             $(FRAMEWORKS)

SRC_DIR   := src
BIN_DIR   := bin
TARGET    := $(BIN_DIR)/game_engine

SRCS      := $(wildcard $(SRC_DIR)/*.cpp)
OBJS      := $(patsubst $(SRC_DIR)/%.cpp,$(SRC_DIR)/%.o,$(SRCS))

all: $(TARGET)

$(TARGET): $(OBJS) | $(BIN_DIR)
	$(CXX) $(CXXFLAGS) $^ -o $@ $(LDFLAGS)

$(SRC_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

clean:
	rm -rf $(SRC_DIR)/*.o $(TARGET)

.PHONY: all clean
