from utils.grader import check_is_correct
from utils.parser import extract_answer

model_pred = "xxxxxxxxx So the final is \\boxed{\\frac{1}{3}}"
gold_answer = "1/3"

extracted_answer = extract_answer(model_pred)

print(check_is_correct(extracted_answer, gold_answer, timeout=True))