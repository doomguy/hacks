#!/usr/bin/env python3

import openai
import argparse
import sys
import os
from prompt_toolkit import PromptSession
from prompt_toolkit.key_binding import KeyBindings
from prompt_toolkit.history import FileHistory
from prompt_toolkit.auto_suggest import AutoSuggestFromHistory
from prompt_toolkit.completion import WordCompleter

parser = argparse.ArgumentParser(description="Query ChatGPT using the API")
parser.add_argument("--key", type=str, help="OpenAI API key")

openai.api_key = os.getenv("OPENAI_API_KEY")

kb = KeyBindings()


@kb.add("c-d")
def exit_(event):
    """Pressing Ctrl-D will exit the prompt."""
    sys.exit(1)


@kb.add("c-c")
def cancel_(event):
    """Pressing Ctrl-C will do nothing."""
    pass


def main(args):
    # check for API key
    if not openai.api_key and not args.key:
        parser.error("--key or OPENAI_API_KEY environment variable is required.")
    elif not openai.api_key:
        openai.api_key = args.key

    # prompt history
    history_file = os.path.join(os.path.expanduser("~"), ".chatgpt_history")
    # Check if file ~/.chatgpt_history exists. If not, create it.
    if not os.path.exists(history_file):
        with open(history_file.split("/")[-1], "w") as f:
            f.write("")

    # setup prompt session
    session = PromptSession(
        history=FileHistory(
            history_file,
        )
    )

    # setup word completer
    cmds_exit = ["exit", "quit", "q", "logout", "bye"]
    cmds_clear = ["clear", "cls"]
    cmds_all = cmds_exit + cmds_clear

    # prompt loop
    while True:

        commands = WordCompleter(cmds_all, ignore_case=True)
        prompt = session.prompt(
            "Prompt> ",
            key_bindings=kb,
            completer=commands,
            auto_suggest=AutoSuggestFromHistory(),
            multiline=True,
        )
        if prompt.strip() == "":
            continue
        elif prompt.strip().lower() in cmds_exit:
            sys.exit(1)
        elif prompt.strip().lower() in cmds_clear:
            os.system("clear")
        else:
            try:
                query_chatgpt(prompt)
            except Exception as e:
                print(f"Error:{e}")

        print("\n<<<>>>\n")  # prompt separator


def query_chatgpt(prompt):

    """response = openai.Completion.create(
        model="text-davinci-003",
        prompt=prompt,
        temperature=0.5,
        max_tokens=500,
        top_p=1,
        frequency_penalty=0.0,
        presence_penalty=0.0,
        stream=False,
    )"""

    completion = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",
        messages=[
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": prompt},
        ],
        frequency_penalty=0.0,  # avoid repeating the same words or phrases, default: 0
        presence_penalty=0.0,  # avoid using words or phrases from prompt or context, default: 0
        stream=False,  # return a continuous stream of responses, default: False
        temperature=0.5,  # control the creativity of the generated text, recommended: 0.7-1.0
        top_p=0.7,  # control the diversity of responses, recommened: 0.7-0.9
    )

    completion = completion.choices[0]["message"]["content"].strip()
    print(f"\n{completion}")


if __name__ == "__main__":
    args = parser.parse_args()
    main(args)
