# This file contains prompt templates for generating stories

def generate_prompt(name: str, thing: str) -> str:
    return (
        f"Write a creative and heartwarming children's bedtime story about a child named {name} "
        f"who discovers a magical {thing}. The story should be around 200 words, friendly, age-appropriate, "
        f"and include a positive moral or lesson. End it with a calm and soothing tone."
    )
