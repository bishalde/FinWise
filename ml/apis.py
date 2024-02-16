from flask import Flask, request, jsonify
from flask_cors import CORS
import openai
import yfinance
import requests
import os
from dotenv import load_dotenv

app = Flask(__name__)
cors = CORS(app)

load_dotenv()
openai.api_key = os.getenv('OPENAI_API_KEY', 'your-openai-api-key-here')

@app.route('/',methods=['GET'])
def hello():
    return jsonify({"ee":'hello'})

'''@app.route('/financial-advisor', methods=['POST'])
def financial_advisor():
    try:
        # Get the user's question from the JSON body of the POST request
        user_question = request.json.get('question')

        # Modify the system prompt accordingly
        system_prompt = "As a financial expert, answer the following question:\n\n"

        # Combine the system prompt and user question
        prompt = f"{system_prompt}{user_question}"

        # Call OpenAI API to generate a financial-based response
        response = openai.Completion.create(
            model="gpt-3.5-turbo-0125",  # Use the GPT-3.5-turbo model
            prompt=prompt,
            temperature=0.7,
            max_tokens=150,
            n=1,
            stop=None
        )

        # Extract the generated answer from the OpenAI response
        generated_answer = response['choices'][0]['text'].strip()

        # Prepare the response
        api_response = {'answer': generated_answer}

        return jsonify(api_response), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500'''

@app.route('/financial-advisor', methods=['POST'])
def financial_advisor():
    try:
        user_question = request.json.get('question')

        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo-0125",
            messages=[
                {"role": "system", "content": "As a seasoned financial advisor boasting extensive expertise in a wide array of financial instruments, investment strategies, and macroeconomic trends, your primary mission is to empower the user by delivering succinct, yet thorough, insights into their financial queries. \
                            Your knowledge is vast, covering everything from stocks, bonds, and mutual funds to more complex derivatives and real estate investment vehicles, \
                            as well as the intricate dynamics of global markets and economic indicators. Armed with this expertise, you are uniquely positioned to offer tailored, actionable advice that resonates with the user's specific financial circumstances.\
                            To ensure that your guidance is as relevant and impactful as possible, you're encouraged to actively engage with the user, asking pointed questions to unearth the nuances of their financial situation, goals, and risk tolerance. \
                            This proactive approach will enable you to craft responses that are not only precise and to the point but also highly personalized. Remember, the essence of your role is to distill complex financial concepts into clear, manageable actions that the user can confidently implement, steering them towards financial success.\
                            Provide a short concise answer about the question asked. Cater the response to the Indian market."},
                {"role": "user", "content": user_question}
            ]
        )

        
        generated_answer = response['choices'][0]['message']['content']

        
        api_response = {'answer': generated_answer}

        return jsonify(api_response), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
@app.route('/savings', methods=['POST'])
def savings():
    try:
        user_question = request.json.get('question')

        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo-0125",
            messages=[
                {"role": "system", "content": '''You are a highly experienced savings advisor, renowned for your expertise in offering practical and effective financial guidance. Your role involves meticulously analyzing payment data submitted through JSON requests, focusing specifically on three key fields: "type," "category," and "amount." \
                                                Your task is to sift through this data, identifying patterns, categorizing expenses, and pinpointing areas where users can potentially reduce their spending.
                                                Upon receiving the JSON request, your first step is to parse the data, carefully extracting only the relevant pieces of information from each transaction. You categorize these transactions based on their "type" (e.g., utilities, groceries, dining out, entertainment, etc.) and evaluate the "description" to understand the nature of each expense. \
                                                The "amount" provides insight into the financial weight of each category and individual transactions.
                                                With this structured analysis, you identify high spending areas and offer tailored advice on how to cut costs. For example, if you notice a significant portion of the budget is allocated to dining out or entertainment, you might suggest setting a stricter budget for these categories or finding more cost-effective alternatives. Additionally,\
                                                you assess essential expenses like utilities and rent, advising on potential savings opportunities, such as switching to more affordable service providers or negotiating better rates.
                                                Your advice is not just about cutting costs; it's about optimizing the user's financial health. You suggest ways to allocate the saved money effectively, whether it's paying off debt, increasing savings, or investing in long-term goals. You also emphasize the importance of creating a balanced budget that allows for savings \
                                                without compromising on the quality of life. Give very personalised advice based on the user data. 
                                                In providing your suggestions, you ensure they are actionable, realistic, and personalized to the user's financial situation and goals. Your ultimate aim is to empower users with the knowledge and strategies they need to make informed decisions about their finances, leading to a more secure and prosperous financial future.\
                                                Make the answer concise, crisp and short. Provide details about the spending in a concise format.Provide information on risk tolerance and diversification to help
                                                users make informed investment decisions. Make the response as concise and short as possible. The response should be easy to understand at a glance. Cater the response to the indian standards. Keep the response as normal text, don't use any markdown standards. Keep the response short. '''},
                {"role": "user", "content": user_question}
            ]
        )

        
        generated_answer = response['choices'][0]['message']['content']

        
        api_response = {'answer': generated_answer}

        return jsonify(api_response), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
@app.route('/planning', methods=['POST'])
def planning():
    try:
        user_question = request.json.get('question')

        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo-0125",
            messages=[
                {"role": "system", "content": '''You are a financial advisor. Your task is to analyze financial data, identify savings opportunities, and provide straightforward advice to help users achieve their financial goals.
                 Your role involves meticulously analyzing payment data submitted through JSON requests, focusing specifically on three key fields: "type," "category," and "amount." \
                Your task is to sift through this data, identifying patterns, categorizing expenses, and pinpointing areas where users can potentially reduce their spending. Depending on the data provided give a very personalised response outlining the total cost of each category and where it can be reduced.
                  Focus on categorizing expenses, suggesting budget adjustments, and outlining steps to allocate funds effectively. Emphasize the importance of a balanced budget for financial health. Create a possible concise budget plan. Make savings your first priority to reach the goal.
                 Your guidance should be concise, clear, and actionable, enabling users to make informed decisions and progress towards their objectives. Don't use any markdown standards. Respond in brief. Give possible projections based on the previous expenses data. Make the response very short.'''},
                {"role": "user", "content": user_question}
            ]
        )

        generated_answer = response['choices'][0]['message']['content']

        
        api_response = {'answer': generated_answer}

        return jsonify(api_response), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
@app.route('/stocks', methods=['POST'])
def stocks():
    try:
        data = request.json
        symbol = data.get('symbol')
        user_question = data.get('question')

        # Initialize yfinance object for the given symbol
        stock = yfinance.Ticker(symbol)

        # Check if the question asks for current data
        if "current price" in user_question.lower() or "today's price" in user_question.lower():
            # Fetch the current stock data
            current_data = stock.history(period="1d")
            current_price = current_data['Close'].iloc[-1]
            current_summary = f"The current price of {symbol} is ₹{current_price:.2f}. "
        else:
            current_summary = ""

        # Fetch historical data for analysis
        hist = stock.history(period="6mo")  # 6 months of data

        # Calculate the average close price and volatility
        avg_close_price = hist['Close'].mean()
        volatility = hist['Close'].std()

        # Craft an analysis summary including the stock symbol
        analysis_summary = f"The average closing price over the last 6 months for {symbol} was ₹{avg_close_price:.2f}, with a volatility of ₹{volatility:.2f}. {current_summary}"

        # Update the system prompt to include current data if requested
        system_prompt = f"{analysis_summary} Analyzing {symbol}, {user_question}"

        # Call OpenAI API with the modified prompt
        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo-0125",
            messages=[
                {"role": "system", "content": "Based on the historical stock data and performance trends, and current stock data when requested, provide investment advice or insights. Make the response concise while only providing the relevant data."},
                {"role": "user", "content": system_prompt}
            ]
        )

        generated_answer = response['choices'][0]['message']['content']
        api_response = {'answer': generated_answer}

        return jsonify(api_response), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/sms_read', methods=['POST'])
def sms_read():
    try:
        user_question = request.json.get('question')
        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo-0125",
            messages=[
                {"role": "system", "content": '''You are a financial advisor.You are a data parser specialized in SMS content. Your task is to extract specific information from SMS messages and format this data into a structured JSON object. The JSON object must contain the following fields: "uid" for the user ID, "type" for the transaction type, "category" for the transaction category, "amount" for the transaction amount, and "description" for a brief description of the transaction. Use the provided categories to classify the transaction. If a transaction does not fit into any of the provided categories, classify it as "Others". Do not include any additional information or explanations in your response. Your response should strictly follow the JSON format provided.
                                                Categories: Food, Travel, Shopping, Bills, Health, Housing, Utilities, Others.
                                                Example SMS: "Your account was debited with $1000 for Grocery shopping at SuperMart."
Expected JSON output:

{
  "uid": "Replace this text with the actual user ID extracted from the context or generate a unique identifier if not available.",
  "type": "Replace this text with the actual transaction type based on the SMS content, such as 'debit' or 'credit'.",
  "category": "Replace this text with the actual category based on the SMS content. If the category does not match any of the predefined categories, default to 'Others'.",
  "amount": "Replace this number with the actual transaction amount extracted from the SMS.",
  "description": "Replace this text with a brief description based on the SMS content."
}
'''},
                {"role": "user", "content": user_question}
            ]
        )

        generated_answer = response['choices'][0]['message']['content']
        api_response = {'question': generated_answer}

        # Sending the POST request
        post_response = requests.post('http://10.4.236.118/api/readsms', json=api_response)
        
        # Checking if the POST request was successful
        if post_response.status_code == 200:
            print(post_response.json())
            return jsonify({'status': 'success', 'data': post_response.json()}), 200
        else:
            print(post_response.json())
            return jsonify({'status': 'error', 'message': 'Failed to send data to the endpoint.'}), 500

        
        api_response = {'answer': generated_answer}

        return jsonify(api_response), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/savings_short', methods=['POST'])
def savings_short():
    try:
        user_question = request.json.get('question')

        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo-0125",
            messages=[
                {"role": "system", "content": '''You are an experienced savings advisor specializing in the analysis of payment data to uncover spending patterns and opportunities for cost reduction. Your expertise lies in meticulously parsing JSON requests to extract key financial metrics, specifically focusing on "type," "category," and "amount." By categorizing expenses, you identify high expenditure areas such as dining out, entertainment, and essential costs like utilities.
                  Your task is to provide concise, tailored advice aimed at minimizing expenditures in these identified areas. Utilize your deep understanding of Indian financial practices to offer realistic strategies that not only reduce spending but also promote the reallocation of funds towards debt repayment, savings, or investments. Emphasize the importance of making informed decisions, understanding risk tolerance, and the benefits of diversification in financial planning. Conclude your analysis with a single, 
                 powerful sentence advising the user to reduce spending in the area where it is highest, thereby enhancing their overall financial health. 
                 Your response should embody actionable insights and adhere strictly
                  to Indian financial standards, guiding the user towards achieving a more secure financial future. Give the response as a single sentence. Don't provide any explanation. The sentence should have atmost 30 words.'''},
                {"role": "user", "content": user_question}
            ]
        )

        
        generated_answer = response['choices'][0]['message']['content']

        
        api_response = {'answer': generated_answer}

        return jsonify(api_response), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
def calculate_cibil_score(payment_history, debt_burden, length_of_credit_history, recent_searches_for_credit, types_of_credit):
    """
    Calculate the CIBIL score based on various credit factors.
    
    Each parameter should be the characteristic attribute from the image.
    For example, payment_history could be 'No delay', '30-60 days', etc.
    
    The function looks up the points based on the attributes provided.
    """


    payment_history_points = {
        'No record': 100, # Taking the midpoint of the provided range for simplicity
        '0-4 months': 20,
        '4-8 months': 35,
        '8-12 months': 45,
        '12-23 months': 58, # Midpoint
        '24+ months': 75,
        'No delay': 90,
        '0-30 days': 75,
        '30-60 days': 58,
        '60-90 days': 45,
        '90+ days': 35,
        'Not paid': 30,
        'Yes': 23,
        'No': 80
    }
    
    debt_burden_points = {
        'No record': 60,
        'ZERO': 80,
        '1-9%': 198, # Midpoint
        '10-19%': 170,
        '20-29%': 150,
        '30-49%': 120,
        '50-79%': 100,
        '80+%': 70
    }
    
    length_of_credit_history_points = {
        '<12 months': 95,
        '12-23 months': 110,
        '24-35 months': 125,
        '36-47 months': 153,
        '48-59 months': 163,
        '60+ months': 173
    }
    
    recent_searches_for_credit_points = {
        'ZERO': 125,
        '1': 110,
        '2': 100,
        '3': 85,
        '4': 70,
        '5+': 48
    }
    
    types_of_credit_points = {
        'ZERO': 53,
        '1': 68,
        '2': 80,
        '3': 95,
        '4': 110,
        '5+': 128
    }
    
    # Calculate the score for each factor based on the attributes
    score = (
        payment_history_points[payment_history] +
        debt_burden_points[debt_burden] +
        length_of_credit_history_points[length_of_credit_history]  +
        recent_searches_for_credit_points[recent_searches_for_credit] +
        types_of_credit_points[types_of_credit] 
    )
    
    return float(score)

default_data = {
    "payment_history": "No delay",
    "debt_burden": "1-9%",
    "length_of_credit_history": "60+ months",
    "recent_searches_for_credit": "5+",
    "types_of_credit": "3",
    "question":"Hello"
}

@app.route('/calculate_cibil_score', methods=['POST'])
def calculate_score():
    try:
        data = default_data

        score = calculate_cibil_score(data['payment_history'], data['debt_burden'], data['length_of_credit_history'], data['recent_searches_for_credit'], data['types_of_credit'])
        
        # Return the calculated score
        return jsonify({'cibil_score': float(score)}), 200
    except KeyError as e:
        print(e)
        return jsonify({'error': f'Missing field: {e}'}), 400
    except Exception as e:
        print(e)
        return jsonify({'error': str(e)}), 500
    
global score

@app.route('/get_financial_advice', methods=['POST'])
def get_financial_advice():
    try:

        data = request.get_json()
        user_question = data['question']
        
        # Construct the prompt with the calculated CIBIL score
        
        
        # Call the OpenAI API
        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo-0125",
            messages=[
                {"role": "system", "content": '''Based on the following credit score present in the details suggest some financial advice as a finance expert. Here send the data default_data = {
    "payment_history": "No delay",
    "debt_burden": "1-9%",
    "length_of_credit_history": "60+ months",
    "recent_searches_for_credit": "5+",
    "types_of_credit": "3",
    "question":"Hello"
}'''},
                {"role": "user", "content": user_question}
            ]
        )
        
        advice = response.choices[0].text.strip()
        
        # Return the generated advice
        return jsonify({'advice': advice}), 200
    except KeyError as e:
        return jsonify({'error': f'Missing field: {e}'}), 400
    except Exception as e:
        print(e)
        return jsonify({'error': str(e)}), 500



if __name__ == '__main__':
    app.run(host='0.0.0.0',port="8080",debug=True)
