#!/usr/bin/env python3

import openai
import argparse
import sys
import os
from prompt_toolkit import PromptSession
from prompt_toolkit.auto_suggest import AutoSuggestFromHistory
from prompt_toolkit.history import FileHistory
from prompt_toolkit.key_binding import KeyBindings
from collections import deque

# command keywords
cmds_exit = ["exit", "quit", "q", "logout", "bye"]
cmds_clear = ["clear", "cls"]
cmds_help = ["help", "?"]
# chat history ringbuffer
msg_buffer = deque(maxlen=10)


kb = KeyBindings()

# prompt exit bindings
@kb.add("c-d")
@kb.add("c-q")
@kb.add("escape")
def exit_(event):
    """Pressing Ctrl-D, Ctrl-Q or ESC will exit the prompt."""
    sys.exit(1)


# ctrl-c binding
@kb.add("c-c")
def cancel_(event):
    """Pressing Ctrl-C will do nothing."""
    pass


def show_help():
    print(
        f"""\nHelp
  * Send prompt:\tCtrl+Enter or ESC+Enter
  * Clear screen:\t{cmds_clear}
  * Help screen:\t{cmds_help}
  * Search history:\tCtrl+R (ESC for exit)
  * Exit prompt:\tCtrl-D, Ctrl-Q, ESC or {cmds_exit}
"""
    )


def main():
    parser = argparse.ArgumentParser(description="Query ChatGPT using the API")
    parser.add_argument("--key", type=str, help="OpenAI API key")
    args = parser.parse_args()

    # check for API key
    openai.api_key = os.getenv("OPENAI_API_KEY")
    if not openai.api_key and not args.key:
        parser.error("--key or OPENAI_API_KEY environment variable is required.")
    elif not openai.api_key:
        openai.api_key = args.key
    # prompt history
    history_file = os.path.join(os.path.expanduser("~"), ".chatgpt_history")
    # Check if file ~/.chatgpt_history exists and create if necessary
    if not os.path.exists(history_file):
        with open(history_file.split("/")[-1], "w") as f:
            f.write("")
            f.close()

    # prompt session setup
    session = PromptSession(
        history=FileHistory(
            history_file,
        )
    )

    # prompt loop
    while True:
        prompt = session.prompt(
            "Prompt> ",
            key_bindings=kb,
            auto_suggest=AutoSuggestFromHistory(),
            multiline=True,
        )
        if prompt.strip() == "":
            continue
        elif prompt.strip().lower() in cmds_help:
            show_help()
            continue
        elif prompt.strip().lower() in cmds_clear:
            os.system("clear")
            continue
        elif prompt.strip().lower() in cmds_exit:
            sys.exit(1)
        else:
            try:
                query_chatgpt(prompt)
            except Exception as e:
                print(f"Error:{e}")

        print("\n<<<>>>\n")  # prompt separator


def query_chatgpt(prompt):
    msg_buffer.append({"role": "user", "content": prompt})
    messages = [{"role": "system", "content": "You are a helpful assistant."}]
    for msg in msg_buffer:
        messages.append(msg)

    completion = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",
        max_tokens=500,
        messages=messages,
        frequency_penalty=0.0,  # avoid repeating the same words or phrases, default: 0
        presence_penalty=0.0,  # avoid using words or phrases from prompt or context, default: 0
        stream=False,  # return a continuous stream of responses, default: False
        temperature=0.5,  # control the creativity of the generated text, recommended: 0.7-1.0
        top_p=0.7,  # control the diversity of responses, recommened: 0.7-0.9
    )

    completion = completion.choices[0]["message"]["content"].strip()
    msg_buffer.append({"role": "assistant", "content": completion})
    print(f"\n{completion}")


if __name__ == "__main__":
    main()
