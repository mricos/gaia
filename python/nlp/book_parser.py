import json
import re

class BookParser:
    def __init__(self, book_text):
        self.book_text = book_text
        self.data = {
            "prompts": {},
            "chapters": {}
        }

    def parse(self):
        lines = self.book_text.split('\n')
        chapter_pattern = re.compile(r'C(\d+):\s*(.*)')
        prompt_pattern = re.compile(r'P(\d+):\s*(.*)')
        
        current_chapter = None
        current_prompt = None
        
        for line in lines:
            chapter_match = chapter_pattern.match(line)
            if chapter_match:
                chapter_number, chapter_title = chapter_match.groups()
                current_chapter = {
                    "summary": "",
                    "prompts": {},
                    "youtube": "URL_PLACEHOLDER"
                }
                self.data["chapters"][chapter_number] = current_chapter
                continue
            
            prompt_match = prompt_pattern.match(line)
            if prompt_match:
                prompt_number, prompt_text = prompt_match.groups()
                if chapter_number == '2':
                    self.data["prompts"][prompt_number] = prompt_text
                else:
                    current_prompt = prompt_text
                continue
            
            if current_chapter is not None:
                if current_prompt:
                    current_chapter["prompts"][current_prompt] = current_chapter["prompts"].get(current_prompt, '') + line + ' '
                else:
                    current_chapter["summary"] += line + ' '
    
    def get_json(self):
        return json.dumps(self.data, indent=4)

    def write_json_to_file(self, file_path):
        with open(file_path, 'w') as json_file:
            json_file.write(self.get_json())

# To use the class, you would do the following:

# Sample usage:
book_text = """
C1: Introduction
This is the introduction text.
C2: Taking a leap into the deeply personal
text that introduces ten prompts
P1: Since living systems do not exist independently in nature, what am I? What does that feel like?
P2: Integrity is a function of how well a system is integrated. Are any conflicting emotions currently creating instability in me?
...
"""

# Create a BookParser object
parser = BookParser(book_text)

# Parse the book text
parser.parse()

# Get the JSON representation
book_json = parser.get_json()

# Optionally, write the JSON to a file
parser.write_json_to_file('book.json')
