# Install ComfyUI Locally on Windows

ComfyUI is a powerful and flexible node-based interface for running AI models locally, giving you full control over complex workflows. 

Visit the official ComfyUI GitHub [releases](https://github.com/comfyanonymous/ComfyUI/releases) page, then scroll down to the "Assets" section to find the available download file and download the file `ComfyUI_windows_portable_nvidia.7z`.

Use a tool like 7-Zip to extract the archive to an easy-to-remember location, such as `C:\comfyui`.

## ComfyUI-Manager

The Node Manager is a powerful extension that simplifies to install, remove, enable, or disable custom nodes directly from within ComfyUI. It also provides a central hub to access tools, updates, and community resources, helping streamline your workflow.

1. Go to ComfyUI/custom_nodes dir in terminal (cmd)
2. git clone https://github.com/ltdrdata/ComfyUI-Manager comfyui-manager
3. Restart ComfyUI

Go back to `C:\comfyui` and double-click `run_nvidia_gpu.bat` to start the ComfyUI application.

## Model Manager

* RealESRGAN x4 Upscaler Model
* 4x UltraSharp Upscaler Model
* face_yolov8m (bbox)
* 4x_NMKD-Siax_200k

## Custom Node Manager

* ComfyUI Impact Pack (Dr.Lt.Data)
* ComfyUI Impact Subpack (Dr.Lt.Data)
* ComfyUI-GGUF (City96)

## External Files

To use external files as checkpoints etc. from outside the ComfyUI/models folder, you need to let ComfyUI know where to find them. ComfyUI typically expects models to reside in specific folders like models/checkpoints, models/vae, etc. But you can symlink or configure custom paths using the extra_model_paths.yaml file or symbolic links.

### Option 1: Use extra_model_paths.yaml (Recommended)

Create or edit the file:

ComfyUI/custom_nodes/extra_model_paths.yaml

```yaml
checkpoints:
  - /path/to/your/custom/checkpoints
vae:
  - /path/to/your/custom/vae
loras:
  - /path/to/your/custom/loras
```

[Sample yaml File](/Files/comfyui/extra_model_paths.yaml)

### Option 2: Use symbolic links (symlinks)

If you're comfortable with the command line, you can create a symbolic link from inside the ComfyUI models folder to your external folder.

```
ln -s /your/external/checkpoints /path/to/ComfyUI/models/checkpoints/external
```

# References

* https://github.com/comfyanonymous/ComfyUI
* https://github.com/comfyanonymous/ComfyUI/releases
* https://github.com/Comfy-Org/ComfyUI-Manager
* https://www.nextdiffusion.ai/tutorials/how-to-run-comfyui-locally

* https://civitai.com/
* https://imgsys.org/
* https://www.youtube.com/watch?v=g74Cq9Ip2ik
