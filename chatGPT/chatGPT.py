#!/usr/bin/env python3

import openai
import argparse
import sys
import os
from prompt_toolkit import PromptSession
from prompt_toolkit.key_binding import KeyBindings

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
    if not openai.api_key and not args.key:
        parser.error("--key or OPENAI_API_KEY environment variable is required.")
    elif not openai.api_key:
        openai.api_key = args.key

    session = PromptSession()

    while True:
        text = session.prompt("ChatGPT> ", key_bindings=kb)
        if text.strip() == "":
            continue
        elif text.strip() in ["quit", "bye", "exit", "logout"]:
            sys.exit(1)
        elif text.strip() == "clear":
            os.system("clear")
        else:
            query_chatgpt(text)


def query_chatgpt(query):
    prompt = query
    response = openai.Completion.create(
        model="text-davinci-003",
        prompt=prompt,
        temperature=0.5,
        max_tokens=500,
        top_p=1,
        frequency_penalty=0.0,
        presence_penalty=0.0,
        stream=False,
    )

    response = response.choices[0]["text"].strip()
    print(f"\n{response}\n")


if __name__ == "__main__":
    args = parser.parse_args()
    main(args)
