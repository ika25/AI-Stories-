# Pydantic model for request and response validation

from pydantic import BaseModel

class StoryRequest(BaseModel):
    name: str
    thing: str

class StoryResponse(BaseModel):
    story: str
