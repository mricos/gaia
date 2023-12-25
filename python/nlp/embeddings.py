import json

def read_file(file_path):
    with open(file_path, 'r') as file:
        return file.readlines()

def process_text(text_lines, index_lines):
    # Data structure to hold the processed information
    document_structure = {}

    # Process index lines to map paragraphs to chapters and sections
    for line in index_lines:
        parts = line.split()
        if 'chapterStart' in line:
            current_chapter = parts[2]
            document_structure[current_chapter] = {}
        elif 'promptStart' in line:
            current_section = parts[1]
            document_structure[current_chapter][current_section] = []

    # Assign paragraphs to the appropriate chapter and section
    current_chapter = None
    current_section = None
    for line in text_lines:
        if line.strip() and current_chapter in document_structure:
            if current_section and current_section in document_structure[current_chapter]:
                document_structure[current_chapter][current_section].append(line.strip())

    return document_structure

def generate_embeddings(document_structure):
    embeddings = {}
    for chapter, sections in document_structure.items():
        chapter_embeddings = {}
        for section, paragraphs in sections.items():
            # Placeholder for concept2vec embeddings
            concept_embeddings = [f"con2vec for {chapter} {section}, para{index + 1}" for index, _ in enumerate(paragraphs)]
            # Placeholder for thought2vec embedding
            thought_embedding = f"tht2vec for {chapter} {section}"

            chapter_embeddings[section] = {"concept_embeddings": concept_embeddings, "thought_embedding": thought_embedding}
        embeddings[chapter] = chapter_embeddings

    return embeddings

# Main function to run the program
def main():
    text_lines = read_file('clean.txt')
    index_lines = read_file('clean.index')
    document_structure = process_text(text_lines, index_lines)
    embeddings = generate_embeddings(document_structure)

    # Print the JSON structure
    print(json.dumps(embeddings, indent=4))

if __name__ == "__main__":
    main()
