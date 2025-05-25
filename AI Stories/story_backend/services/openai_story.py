# Handles interaction with OpenAI's GPT API
# Updated for OpenAI Python SDK 1.0+

import os
from openai import OpenAI
from dotenv import load_dotenv
from utils.prompts import generate_prompt

# Load API key from .env
load_dotenv()
client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

def get_ai_story(name: str, thing: str) -> str:
    prompt = generate_prompt(name, thing)

    try:
        response = client.chat.completions.create(
            model="gpt-4o",
            messages=[
                {"role": "system", "content": "You are a children's story writer."},
                {"role": "user", "content": prompt}
            ],
            temperature=0.9,
            max_tokens=300
        )
        return response.choices[0].message.content.strip()

    except Exception as e:
        return f"Error generating story: {str(e)}"
# Note: Ensure you have the OpenAI Python SDK installed and your API key set in .env
# Usage:
