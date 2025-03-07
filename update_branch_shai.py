import sys
import subprocess

def run_command(command):
    print(f"Running: {command}")
    result = subprocess.run(command, shell=True)
    if result.returncode != 0:
        print(f"Command failed: {command}")
        sys.exit(result.returncode)

def update_shai(): # sync the shai branch with alpha branch
    #stage 1:
    run_command("git checkout shai")
    run_command("git pull origin alpha")
    run_command("git push origin shai")
    
def add_commit_push(addArgument, commitMessage):# commit the changes in shai branch
    run_command("git add "+addArgument)
    run_command('git commit -m "{}"'.format(commitMessage))
    run_command("git push origin shai")

def sync_alpha_shai_with_main():
    run_command("git checkout shai")
    run_command("git pull origin main")
    run_command("git push origin shai")
    #------------------------------------
    run_command("git checkout alpha")
    run_command("git pull origin main") # Pulls main into alpha
    run_command("git push origin alpha")
    run_command("git checkout shai")



if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Usage: python update_branch.py [shai|sync_alpha_shai_with_main|add_commit_push]")
        sys.exit(1)

    task = sys.argv[1].lower()
    print("hello")
    print("task=",task)
    if task == "shai":
        update_shai()
        
    elif task == "sync_alpha_shai_with_main":
        sync_alpha_shai_with_main()
        
    elif task == "add_commit_push":
        add_argument = sys.argv[2]
        print("add_argument=",add_argument)
        commit_message = " ".join(sys.argv[3:])  # Join all remaining arguments
        # Validate that neither argument is empty
        print("commit_message=",commit_message)


        if not add_argument.strip() or not commit_message.strip():
            print("Error: Files name or Commit msg cannot be empty.")
            sys.exit(1)


        add_commit_push(add_argument, commit_message)


    else:


        print("Invalid option.")


        sys.exit(1)

