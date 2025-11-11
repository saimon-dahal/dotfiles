import argparse
from pathlib import Path

import numpy as np
from PIL import Image, ImageColor


def nordify(image: str):
    image_path = Path(image).expanduser()

    img = Image.open(image_path).convert("RGBA")

    # Nord palette
    nord_palette = [
        "#BF616A",
        "#D08770",
        "#EBCB8B",
        "#A3BE8C",
        "#B48EAD",
        "#8FBCBB",
        "#88C0D0",
        "#81A1C1",
        "#5E81AC",
        "#2E3440",
        "#3B4252",
        "#434C5E",
        "#4C566A",
        "#D8DEE9",
        "#E5E9F0",
        "#ECEFF4",
    ]
    nord_palette = np.array([ImageColor.getrgb(color) for color in nord_palette])

    img_array = np.array(img)

    pixels = img_array[:, :, :3][:, :, np.newaxis, :]

    palette = nord_palette[np.newaxis, np.newaxis, :, :]

    norms = np.linalg.norm(pixels - palette, axis=3)  # (H, W, 16)
    closest_indexes = np.argmin(norms, axis=-1)  # (H, W)

    recolored = nord_palette[closest_indexes]  # (H, W, 3)

    alpha = img_array[:, :, 3:]
    recolored = np.concatenate([recolored, alpha], axis=-1)

    nord_img = Image.fromarray(recolored.astype("uint8"), "RGBA")

    out_dir = Path.home() / "Pictures" / "wallpapers" / "nord"
    out_dir.mkdir(parents=True, exist_ok=True)

    out_file = out_dir / f"nordified_{image_path.stem}.png"
    nord_img.save(out_file)

    print(f"Saved Nordified image at: {out_file}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Nordify an image using the Nord color palette"
    )
    parser.add_argument(
        "image",
        type=str,
        help="Path to the image to nordify",
    )
    args = parser.parse_args()
    nordify(args.image)
