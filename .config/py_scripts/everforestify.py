import argparse
from pathlib import Path

import numpy as np
from PIL import Image, ImageColor


def everforestify(image: str):
    image_path = Path(image).expanduser()

    img = Image.open(image_path).convert("RGBA")

    # Everforest palette (soft muted greens, browns, yellows, purples)
    everforest_palette = [
        "#D3C6AA",  # light beige
        "#A7C080",  # moss green
        "#8AA573",  # earthy green
        "#C594C5",  # muted purple
        "#E69875",  # muted orange
        "#DCA561",  # warm sand
        "#7E9E9B",  # muted teal
        "#C0A36E",  # brownish yellow
    ]
    everforest_palette = np.array(
        [ImageColor.getrgb(color) for color in everforest_palette]
    )

    img_array = np.array(img)

    pixels = img_array[:, :, :3][:, :, np.newaxis, :]

    palette = everforest_palette[np.newaxis, np.newaxis, :, :]

    norms = np.linalg.norm(pixels - palette, axis=3)  # (H, W, N)
    closest_indexes = np.argmin(norms, axis=-1)  # (H, W)

    recolored = everforest_palette[closest_indexes]  # (H, W, 3)

    alpha = img_array[:, :, 3:]
    recolored = np.concatenate([recolored, alpha], axis=-1)

    everforest_img = Image.fromarray(recolored.astype("uint8"), "RGBA")

    out_dir = Path.home() / "Pictures" / "wallpapers" / "everforest"
    out_dir.mkdir(parents=True, exist_ok=True)

    out_file = out_dir / f"everforest_{image_path.stem}.png"
    everforest_img.save(out_file)

    print(f"Saved Everforest image at: {out_file}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Everforestify an image using the Everforest color palette"
    )
    parser.add_argument(
        "image",
        type=str,
        help="Path to the image to everforestify",
    )
    args = parser.parse_args()
    everforestify(args.image)
