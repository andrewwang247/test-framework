# Compiler and flags.
CXX := g++ -std=c++17
FLAGS := -Wall -Werror -Wextra -Wconversion -pedantic -Wfloat-equal -Wduplicated-branches -Wduplicated-cond -Wshadow
OPT := -O3 -DNDEBUG
DEBUG := -g3 -DDEBUG

FW := framework

release : $(FW).h $(FW).cpp
	$(CXX) $(FLAGS) $(OPT) -c $(FW).cpp

debug : $(FW).h $(FW).cpp
	$(CXX) $(FLAGS) $(DEBUG) -c $(FW).cpp

# Remove executable binary and generated objected files.
.PHONY : clean
clean : 
	rm -f $(FW).o
