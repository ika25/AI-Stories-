# Main FastAPI application

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from models.story_model import StoryRequest, StoryResponse
from services.openai_story import get_ai_story

app = FastAPI()

# Allow requests from your Flutter app (Android/iOS)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Replace with specific domain later
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.post("/generate_story", response_model=StoryResponse)
async def generate_story(req: StoryRequest):
    story = get_ai_story(req.name, req.thing)
    return {"story": story}
# Run the application with: uvicorn main:app --reload
# To run the application, use the command: