#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <readline/readline.h>
#include <readline/history.h>

static char* oldName;

static int set_oldname() {
  //printf("running startup hook: %s\n", oldName);
  rl_insert_text(oldName);
  rl_startup_hook = NULL;
  return 0;
}

int main(int argc, char** argv) {

  if (argc != 2) {
    printf("rn: rename file/directory\n");
    printf(" usage: %s <file/dir to rename>\n", argv[0]);
    return 1;
  }

  oldName = argv[1];
  
  char* newName, prompt[100];

  rl_startup_hook = set_oldname;

  for(;;) {

    snprintf(prompt, sizeof(prompt), "rename '%s' to: ", oldName);
    
    // Display prompt and read newName (NB: newName must be freed after use)...
    newName = readline(prompt);

    // Check for EOF.
    if (!newName || !(*newName)) {
      return 0;
    }

    // Add newName to history.
    add_history(newName);

    //printf(" %s => %s\n", oldName, newName);
    
    int r = rename(oldName, newName);
    if (r != 0) {
      perror("rename failed");
      return 1;
    }

    free(newName);
  }
    
  return 0;
}
