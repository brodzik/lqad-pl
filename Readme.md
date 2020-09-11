# LQAD-PL

Polish Legal Question Answering Dataset contains questions extracted from the official tests for Legal Trainees.
It consist of 2916 QA pairs distributed in a standard: train/validation/test split. Its format is compatible with SQuAD
2.0 making it very easy to use the existing models and pipelines.

The repository contains the dataset and the configurations of the experiments (Allen NLP format) performed on the following models:
* multilingual BERT
* PolBERT (aka Polish BERT)
* multilingual BERT trained on Polish SQuAD
* XLMR


## Parameter search with AllenTune

The experiments were run with the latest AllenNLP and AllenNLP models installed via PIP.

To search among 30 parameter configuration for a specific configuration (e.g. `XLMR`):

```
allentune search  --experiment-name lqad_search_xlmr --num-cpus 1 --num-gpus 1 --cpus-per-trial 1  \
  --gpus-per-trial 1 --search-space search_lqad_xlmr.json --num-samples 30 --base-config transformer_lqad.jsonnet --include-package allennlp_models
```

To gather results of the experiments:

```
allentune report --log-dir logs/lqad_search_xlmr/ --performance-metric best_validation_per_instance_em --model xlmr
```

To plot the results of single model:
```
allentune plot --data-name LQAD-PL --subplot 1 1 --result-file logs/lqad_search_xlmr/results.jsonl \
 --output-file xlmr.pdf --performance-metric-field best_validation_per_instance_em  --performance-metric accuracy
```

To evaluate the model on the test set:
```
allennlp evaluate path/to/model/model.tar.gz ./lqad-pl-pretty-test.json
```

## Citation

```
Aleksander Smywiński-Pohl. LQAD-PL 1.0 — Polish Question-Answering Dataset for the Legal Domain. (to appear)
```
