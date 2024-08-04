import json
import subprocess
import sys
import os

def install_vscode_extensions(extensions):
    for ext in extensions:
        print(f"Installing VS Code extension: {ext}")
        subprocess.run(["code", "--install-extension", ext], check=True)
        print(f"Extension {ext} installed.")

def select_vscode_extensions():
    available_extensions = [
        "ms-python.python", "ms-vscode.cpptools", "ms-vscode.go",
        "esbenp.prettier-vscode", "dbaeumer.vscode-eslint", "redhat.vscode-yaml",
        "ms-azuretools.vscode-docker", "ms-vscode-remote.remote-containers",
        "vscjava.vscode-java-pack", "vscjava.vscode-java-debug", "vscjava.vscode-java-test",
        "ms-azuretools.vscode-azurefunctions", "vscjava.vscode-maven",
        "vscode-icons-team.vscode-icons", "vscjava.vscode-java-dependency",
        "christian-kohler.npm-intellisense", "streetsidesoftware.code-spell-checker",
        "davidanson.vscode-markdownlint", "eg2.vscode-npm-script",
        "wix.vscode-import-cost", "ms-vscode.vscode-typescript-tslint-plugin"
    ]
    
    selected_extensions = []
    
    print("Available extensions:")
    for i, ext in enumerate(available_extensions):
        print(f"{i + 1}: {ext}")
    
    while True:
        try:
            selection = input("Enter the numbers of the extensions you want to install, separated by commas: ")
            selected_indices = [int(x.strip()) - 1 for x in selection.split(',')]
            selected_extensions = [available_extensions[i] for i in selected_indices if 0 <= i < len(available_extensions)]
            break
        except ValueError:
            print("Invalid input. Please enter numbers separated by commas.")

    if selected_extensions:
        install_vscode_extensions(selected_extensions)
    else:
        print("No extensions selected.")

if __name__ == "__main__":
    select_vscode_extensions()
