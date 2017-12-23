.PHONY: test
DEBUG = -g
CFLAGS = -Wall -Wextra -Wpedantic -Werror -Wno-unused-parameter -c $(DEBUG)
LFLAGS = -Wall -lm

SRCDIR := src
BUILDDIR := build
OBJDIR := $(BUILDDIR)/obj

NAME := build/wxbasic

override SRCS := $(shell find src/*.cpp -type f)

override OBJS := $(addprefix $(OBJDIR)/, $(notdir $(SRCS:.cpp=.o)))

all: $(NAME)

$(OBJS): $(OBJDIR)/%.o : $(SRCDIR)/%.cpp
	@mkdir -p $(OBJDIR)
	$(CXX) $(CFLAGS) $< -o $@

$(NAME): $(OBJS)
	$(CXX) -o $(NAME) $^ $(LFLAGS)

test:
	./build/wxbasic --tokens ./build/program

clean:
	rm -rf $(OBJDIR)
	rm -rf $(NAME)
