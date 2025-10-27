# Run HiDream in ComfyUI

HiDream-I1 is a new open-source image generative foundation model with 17B parameters that achieves state-of-the-art image generation quality within seconds.

Native integration of HiDream into ComfyUI provides a major milestone. Now, with native support, the setup is faster, more intuitive, and far more accessible—even for those with limited hardware. Users can benefit from enhanced functionality like improved text encoding via four specialized encoders, standard KSampler support, and new quantized GGUF versions that perform well even on systems with less than 16GB of VRAM.

## HiDream-I1 Model Variants (Official)

HiDream-AI provides three primary model versions, each optimized for different use cases:

* [HiDream-I1-Full] (https://huggingface.co/HiDream-ai/HiDream-I1-Full)
* [HiDream-I1-Dev] (https://huggingface.co/HiDream-ai/HiDream-I1-Dev)
* [HiDream-I1-Fast] (https://huggingface.co/HiDream-ai/HiDream-I1-Fast)

## Community Variants & Optimized Versions

Provided by [city96](https://huggingface.co/city96), these use the new GGUF format to reduce file size and memory usage without fully sacrificing quality.

| **Model**                                                                            | **VRAM Needed (Est.)** | **Notes**                          |
| ------------------------------------------------------------------------------------ | ---------------------- | ---------------------------------- |
| [HiDream-I1-Full-GGUF](https://huggingface.co/city96/HiDream-I1-Full-gguf/tree/main) | ~16–20 GB              | Best quality in GGUF format        |
| [HiDream-I1-Dev-GGUF](https://huggingface.co/city96/HiDream-I1-Dev-gguf/tree/main)   | ~12 GB                 | Ideal middle-ground version        |
| [HiDream-I1-Fast-GGUF](https://huggingface.co/city96/HiDream-I1-Fast-gguf/tree/main) | ~8 GB                  | Lightest, fastest for low-end GPUs |

## Required Files

To run HiDream in ComfyUI, you’ll need to manually download a few essential components. These are not bundled by default with ComfyUI.

### Four CLIP Text Encoders

HiDream uses four separate CLIP encoders to improve semantic understanding. These must be placed in the correct directory.

* [clip_l_hidream.safetensors](https://huggingface.co/Comfy-Org/HiDream-I1_ComfyUI/blob/main/split_files/text_encoders/clip_l_hidream.safetensors)
* [clip_g_hidream.safetensors](https://huggingface.co/Comfy-Org/HiDream-I1_ComfyUI/blob/main/split_files/text_encoders/clip_g_hidream.safetensors)
* [t5xxl_fp8_e4m3fn_scaled.safetensors](https://huggingface.co/Comfy-Org/HiDream-I1_ComfyUI/blob/main/split_files/text_encoders/t5xxl_fp8_e4m3fn_scaled.safetensors)
* [llama_3.1_8b_instruct_fp8_scaled.safetensors](https://huggingface.co/Comfy-Org/HiDream-I1_ComfyUI/blob/main/split_files/text_encoders/llama_3.1_8b_instruct_fp8_scaled.safetensors)

📁 Save them to `ComfyUI/models/text_encoders/`

### Variational Autoencoder (VAE)

HiDream requires a specific VAE (same as Flux VAE) for decoding latent representations into final images.

* [ae.safetensors](https://huggingface.co/Comfy-Org/HiDream-I1_ComfyUI/blob/main/split_files/vae/ae.safetensors)

📁 Save it to `ComfyUI/models/vae/`

### HiDream Model Checkpoint

There are multiple versions of HiDream. We recommend starting with the hidream_i1_dev_fp8.safetensors for optimal balance or any other HiDream (GGUF) model you choose.

* [hidream_i1_dev_fp8.safetensors](https://huggingface.co/Comfy-Org/HiDream-I1_ComfyUI/blob/main/split_files/diffusion_models/hidream_i1_dev_fp8.safetensors) 

#### Optional

* [GGUF Full Links](https://huggingface.co/city96/HiDream-I1-Full-gguf/tree/main)
* [GGUF Dev Links](https://huggingface.co/city96/HiDream-I1-Dev-gguf/tree/main)
* [GGUF Fast Links](https://huggingface.co/city96/HiDream-I1-Fast-gguf/tree/main)

📁 Save it to `ComfyUI/models/diffusion_models/`

### Sample Workflow

Download the gguf workflow [here](https://cdn.nextdiffusion.ai/comfyui-workflows/hidream-i1-dev-fp8.json) and change the model in `Unet Loader (GGUF)` with the one you have downloaded and run the workflow.

### Sample Workflow using GGUF

To use GGUF models, you need the ComfyUI-GGUF extension. Open ComfyUI and go to `Manager → Custom Node Manager` and search for `ComfyUI-GGUF (by City96)` and install the node and then restart ComfyUI.

Download the gguf workflow [here](https://cdn.nextdiffusion.ai/comfyui-workflows/hidream-i1-dev-gguf.json) and change the model in `Unet Loader (GGUF)` with the one you have downloaded and run the workflow.

# References

* https://github.com/HiDream-ai/HiDream-I1
* https://www.nextdiffusion.ai/tutorials/run-hidream-in-comfyui-step-by-step-guide
* https://huggingface.co/HiDream-ai
