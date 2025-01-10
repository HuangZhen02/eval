安装相关环境的时候需要注意一些包的版本号（尤其是特意标注版本信息的）

此eval脚本包含了推理（使用vllm框架）以及评估（使用rule-based）两个部分

PS：
脚本内的规则评估可以解决aime里的纯数字问题以及大部分MATH里的题型，但是更广泛的题型可能需要涉及model-based eval（可以参考`model_based_eval.ipynb`内的prompt）

## 使用方式

#### 确认待评测的benchmark数据集

所有需要评测的benchmark数据集在`./data`下，并且每个benchmark会有一些子集划分(split)，例如math里有test_500.jsonl，test.jsonl（分别表示500道版本的测试集以及5000道版本的测试集）

如果需要添加新的测试集，可以模仿已经存在的benchmark的格式，在`./data`下添加。

目前已经有的benchmark整理：
AIME -> test.jsonl
MATH -> test_500.jsonl
MATH2024 -> test.jsonl



#### 设置prompt文件

在测试**数学题**时，我们采用qwen-instruct的模版：
```
system_prompt = "Please reason step by step, and put your final answer within \\boxed{}."

few_shot_prompt = ""

question_format = """{question}"""
```

因此，在添加一个新的数学benchmark后，可以在相应的`./prompts/qwen-instruct/xxx.py`中直接复制上述的内容。


#### 运行

```
bash eval.sh
```

eval.sh具体内部的参数解释：

```
CUDA_VISIBLE_DEVICES='0,1,2,3' \
python eval.py \
--model_name_or_path "/inspire/hdd/ws-c6f77a66-a5f5-45dc-a4ce-1e856fe7a7b4/project/public/model/Qwen2.5-32B-Instruct" \  设置为待测试的模型权重路径
--data_name "math" \  benchmark的名称，对应./data下的一级目录名
--prompt_type "qwen-instruct" \  默认采用qwen-instruct的chat template
--temperature 0.0 \ 采样温度
--start_idx 0 \ 参与评估的数据索引（不用改，就从0开始）
--end_idx -1 \  参与评估的数据索引（不用改，就到-1结束）
--n_sampling 1 \ 每道题sample几次机会
--k 1 \ 计算unbiased pass@k的k
--split "test_500" \ 对应的待测benchmark的子集划分
--max_tokens 16384 \ 模型inference输出的最大长度，o1-like的模型必须使用**16384**
--seed 0 \  随机种子，不用动
--top_p 1 \ 采样的top-p参数
--surround_with_messages \ 开启就好
```


