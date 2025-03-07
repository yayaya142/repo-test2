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
    
def add_commit_push(add, string):
    run_command("git add "+add)
    run_command("git commit -m "+string)
    run_command("git push origin daniel")

def update_alpha():
    run_command("git checkout alpha")
    run_command("git pull origin alpha")

def update_main():
    run_command("git checkout main")
    run_command("git pull origin main")

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print("Usage: python update_branch.py [daniel|alpha|main]")
        sys.exit(1)

    task = sys.argv[1].lower()
    if task == "daniel":
        update_daniel()
    elif task == "alpha":
        update_alpha()
    elif task == "main":
        update_main()
    else:
        print("Invalid option. Please choose 'daniel', 'alpha', or 'main'.")
        sys.exit(1)
