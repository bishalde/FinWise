import tempfile
from flask import Flask, request, jsonify
from flask_cors import CORS
import openai

# LangChain imports
from langchain.llms import OpenAI
from langchain.embeddings import OpenAIEmbeddings
from langchain.document_loaders import PyPDFLoader
from langchain.vectorstores import Chroma
from langchain.agents.agent_toolkits import (
    create_vectorstore_agent,
    VectorStoreToolkit,
    VectorStoreInfo
)

# Hardcoding the OpenAI API key - not recommended for production use
openai_api_key= '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'

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes
global_agent_executor = None  # Global variable to store the agent executor

@app.route('/upload', methods=['POST'])
def upload_file():
    global global_agent_executor
    uploaded_file = request.files['file']

    if not uploaded_file or not uploaded_file.filename.endswith('.pdf'):
        return "Invalid file. Please upload a PDF.", 400

    try:
        # Save the uploaded file
        with tempfile.NamedTemporaryFile(delete=False, suffix='.pdf') as temp_file:

            uploaded_file.save(temp_file.name)

        # Process the PDF and prepare the agent for answering questions
        global_agent_executor = prepare_agent_executor(temp_file.name)
    except Exception as e:
        return f"Error processing the PDF: {e}", 500

    return "PDF uploaded and processed successfully."

def prepare_agent_executor(file_path):
    # Use the hardcoded API key
    llm = OpenAI(api_key=openai_api_key, temperature=0.1, verbose=True)
    embeddings = OpenAIEmbeddings(api_key=openai_api_key)


    loader = PyPDFLoader(file_path)
    pages = loader.load_and_split()

    store = Chroma.from_documents(pages, embeddings, collection_name='Pdf')
    vectorstore_info = VectorStoreInfo(
        name="Pdf",
        description="PDF file content",
        vectorstore=store
    )
    toolkit = VectorStoreToolkit(vectorstore_info=vectorstore_info)

    return create_vectorstore_agent(
        llm=llm,
        toolkit=toolkit,
        verbose=True
    )

@app.route('/ask', methods=['POST'])
def ask_question():
    global global_agent_executor

    if not global_agent_executor:
        return jsonify({"error": "No PDF file processed. Please upload a file first."}), 400

    prompt = request.form.get('prompt')
    if not prompt:
        return jsonify({"error": "No prompt provided."}), 400

    try:
        response = global_agent_executor.run(prompt)
        return jsonify({"response": response})
    except Exception as e:
        return jsonify({"error": f"Error in generating response: {e}"}), 500

if __name__ == '__main__':
    app.run(debug=True)