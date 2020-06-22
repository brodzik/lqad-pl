local SEED = std.parseInt(std.extVar("SEED"));
local BATCH_SIZE = std.parseInt(std.extVar("BATCH_SIZE"));
local EPOCHS = std.parseInt(std.extVar("NUM_EPOCHS"));
local MODEL = std.extVar("MODEL");
local GRADIENT = std.parseJson(std.extVar("GRADIENT"));
local LEARNING_RATE = std.parseJson(std.extVar("LEARNING_RATE"));
local EPSILON = std.parseJson(std.extVar("EPSILON"));

{
  "dataset_reader": {
      "type": "transformer_squad",
      "transformer_model_name": MODEL,
      "skip_invalid_examples": true,
      //"max_instances": 200  // debug setting
  },
  "validation_dataset_reader": self.dataset_reader + {
      "skip_invalid_examples": false,
  },
  "train_data_path": "/net/scratch/people/plgapohl/lqad-pl-pretty/lqad-pl-pretty-train.json",
  "validation_data_path": "/net/scratch/people/plgapohl/lqad-pl-pretty/lqad-pl-pretty-dev.json",
  "model": {
      "type": "transformer_qa",
      "transformer_model_name": MODEL,
  },
  "data_loader": {
    "batch_sampler": {
      "type": "bucket",
      "batch_size": BATCH_SIZE
    }
  },
  "trainer": {
    "optimizer": {
      "type": "huggingface_adamw",
      "weight_decay": 0.0,
      "parameter_groups": [[["bias", "LayerNorm\\.weight", "layer_norm\\.weight"], {"weight_decay": 0}]],
      "lr": LEARNING_RATE,
      "eps": EPSILON
    },
    "learning_rate_scheduler": {
      "type": "slanted_triangular",
      "num_epochs": EPOCHS,
      "cut_frac": 0.1,
    },
    "grad_clipping": GRADIENT,
    "num_epochs": EPOCHS,
    "cuda_device": 0
  },
  "random_seed": SEED,
  "numpy_seed": SEED,
  "pytorch_seed": SEED,
}
