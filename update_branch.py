import sys
import subprocess

def run_command(command):
    print(f"Running: {command}")
    result = subprocess.run(command, shell=True)
    if result.returncode != 0:
        print(f"Command failed: {command}")
        sys.exit(result.returncode)

def update_daniel():
    run_command("git checkout daniel")
    run_command("git pull origin alpha")
    run_command("git push origin daniel")
    
def add_commit_push(addArgument, commitMessage):
    run_command("git add "+addArgument)
    run_command('git commit -m "{}"'.format(commitMessage))
    run_command("git push origin daniel")

def update_alpha():
    run_command("git checkout alpha")
    run_command("git pull origin alpha")

def update_main():
    run_command("git checkout main")
    run_command("git pull origin main")

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Usage: python update_branch.py [daniel|alpha|main|add_commit_push]")
        sys.exit(1)

    task = sys.argv[1].lower()
    if task == "daniel":
        update_daniel()
        
    elif task == "alpha":
        update_alpha()
        
    elif task == "main":
        update_main()
        
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
