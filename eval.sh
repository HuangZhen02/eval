CUDA_VISIBLE_DEVICES='0,1,2,3' \
python eval.py \
--model_name_or_path "/inspire/hdd/ws-c6f77a66-a5f5-45dc-a4ce-1e856fe7a7b4/project/public/model/Qwen2.5-32B-Instruct" \
--data_name "gaokao" \
--prompt_type "qwen-instruct" \
--temperature 0.0 \
--start_idx 0 \
--end_idx -1 \
--n_sampling 1 \
--k 1 \
--split "test1" \
--max_tokens 16384 \
--seed 0 \
--top_p 1 \
--surround_with_messages \

