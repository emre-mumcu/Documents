




# Creating an Image


## 1. Model
Double click the canvas and select `Load Checkpoint`

C:\ComfyUI\ComfyUI\models\checkpoints

## 2. Prompt
Double click the canvas or drag the `CLIP` point of `Load Checkpoint` and select `CLIP Text Encode (Prompt)`. This will be the positive prompt.

Do the same as above or copy and paste (Ctrl+Shift+V) the `CLIP Text Encode (Prompt)` and connect it with the CLIP point of the `Load Checkpoint` to create the negative prompt.

## 3. KSampler

Drag `CONDITIONING` point of `CLIP Text Encode (Prompt)` of the positive prompt and select `KSampler`. This is bound to the positive point of `KSampler`.

Bount the `CONDITIONING` point of the negative prompt to the negative point of `KSampler`.

Bount the model point of the `KSampler` to the MODEL point of `Load Checkpoint`.

Drag the `latent_image` of the `KSampler` and select `Empty Latent Image`

Drag the `LATENT` point of `KSampler` and select `VAE Decode`.

Bount the `vae` of `VAE Decode` to `VAE` point of `Load Checkpoint`.

## Image Preview

Drag the `IMAGE` point og `VAE Decode` and select `Preview Image`

# Upscaling Image

Using the Manager of ComfyUI, select Model Manager and install an upscalar model

* RealESRGAN x4 Upscaler Model
* 4x UltraSharp Upscaler Model

Drag `IMAGE` point of `VAE Decode` and select `Upscale Image (using Model)`. 

Drag `upscale_model` of `Upscale Image (using Model)` and select the model you want tou use.

Drag the `IMAGE` point of the `Upscale Image (using Model)` and select `Preview Image`

You can select `Upscale Image (using Model)` Ctrl+M to mute upscaling. Then you can re-select `Upscale Image (using Model)` and Ctrl+M to unmute.

Note: Set control after generate to fixed in KSampler.

# References

* https://www.youtube.com/watch?v=g74Cq9Ip2ik

