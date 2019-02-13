#include <iostream>
#include <sys/wait.h>
#include <unistd.h>
#include <string.h>
#include <fstream>
#include <sstream>
#include <stdio.h>
#include <stdlib.h>

using namespace std;

int main(int argc, char *argv[]){
  //Initiate process id and pipes
  pid_t pid;
  int pipefd[2];
  int pipefd2[2];
  
  

  //Check if pipes initiate correctly
  if(pipe(pipefd) == -1){
    perror("pipe");
    exit(EXIT_FAILURE);
  }

  if(pipe(pipefd2) == -1){
    perror("pipe2");
    exit(EXIT_FAILURE);
  }

  //Create child process
  pid = fork();
    
  if(pid == -1){ //Fork failed
    perror("fork failed creating child");
    exit(EXIT_FAILURE);
  }
  
  if(pid == 0){ //Child process execution
    close(pipefd[1]); //Close write end

    //Read from pipe from parent
    char buf;
    string input = "";
    while(read(pipefd[0], &buf, 1) > 0){
      input += buf;
    }

    //Write contents of pipe to file
    stringstream s2;
    s2 << argv[1] << "-2.txt";
    ofstream file2 (s2.str());
    file2 << input;
    file2.close();

    //Reverse the case of the text in file
    string output = "";
    for(int i = 0; i < input.length(); i++){
      if(isalpha(input[i])){
	if(isupper(input[i])){
	  output += tolower(input[i]);
	}else{
	  output += toupper(input[i]);
	}
      }else{
	output += input[i];
      }
	
    }

    //Write reversed case text to file
    stringstream s3;
    s3 << argv[1] << "-3.txt";
    ofstream file3 (s3.str());
    file3 << output;
    file3.close();

    //Send reversed case text to parent through pipe
    close(pipefd2[0]); //Close read end
    write(pipefd2[1], output.c_str(), output.length());
    close(pipefd2[1]); //Close write end 
    
    close(pipefd[0]);
    _exit(EXIT_SUCCESS);
  }else{

	//Store filename in stringstream
	stringstream s;
	s << argv[1] << "-1.txt";

	//Open file
	fstream file;
	file.open(s.str());

	//Read contents of file and close it
	string line;
	string fileContents = "";
	getline(file, line);
	fileContents += line;
	while (getline(file, line)) {
		fileContents = fileContents + "\n" + line;
	}

	file.close();

    close(pipefd[0]); //Close read end
    //Send text in file to child process
    write(pipefd[1], fileContents.c_str(), fileContents.length());
    close(pipefd[1]); //Close write end
    //Wait for child to finish processing text
    wait(NULL); 

    char buf;
    string intput = "";

    close(pipefd2[1]); //Close write end
    //Read text from pipe from child
    while(read(pipefd2[0], &buf, 1) > 0)
      intput += buf;
   
    close(pipefd2[0]); //Close read end

    //Output reversed case text to fourth file
    stringstream s4;
    s4 << argv[1] << "-4.txt";
    ofstream file4 (s4.str());
    file4 << intput;
    file4.close();
  }
  
  return 0;
}
