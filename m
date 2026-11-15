Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452C460A2629
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LawYJ4Tw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E90A10E1C2;
	Sun, 15 Nov 2026 14:02:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 234B510E1A6
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 14:02:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DE7FF455E7
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 14:02:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF02E1F000D2
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 14:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794751333;
 bh=z2MWIKnJJ/fCIM3N2m1iMGulOZFzm+PJBkPqJtMbyaA=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
 b=LawYJ4TwvGqTNp8ftm33rlEmgQF3Qu6fFx3HWWsA9SN0Im34MzTtzf+j+A1wyPCvh
 Xls3Csqza885jSb8m5SaSsvHhLX7T7R9cY1ePWG8q88y/y4SrvOpjryA/Pzfzv2QDq
 SvUyiZGySPrGLe81mdDVZ4xavICgQm/qLcFzSLMwzUzdE9MOe58Y/11qdqmAo7bbBo
 5pJFIn4m0CD+T0u20JZE8hf3jFa0rZ5mVRd+8kPDRNevX/5z2h/8KYif0rQzxhhPJT
 wv5qsH7JSwFoacej9r/wLZ4I/mrxC8tYnaEUIZAn8FW7a6vzb57KGFtlWXlVo34iOZ
 dxCJqkKh44ApQ==
Received: by mail-lj1-f171.google.com with SMTP id
 38308e7fff4ca-3adfed9a887so21575861fa.3
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 06:02:13 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErG4odw3S+wuRBPDqE+wDzS3UrjDU+ES26wJ8g6/oi96TuXSHSgoDInj/N6wzqN/EF53XTjvZIBsfbM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+rhpyGRQBOPrcGThZSy0J0gZmMnVrJU2J/cUyhMcWPI8f0rKi1
 BiHiqZYNV75eUKg3a7Yt6mhPgItWYcU8tWYwPYv23gxrZ/ES3SHNEft8/u8+dcLTyd9w8fePzbj
 4MTabZkzYrnju6Fl5BvnF+F6iwPaXwvw=
X-Received: by 2002:a05:651c:a150:b0:3a9:d70c:f75e with SMTP id
 38308e7fff4ca-3ae2b4a1dd7mr26302241fa.7.1794751332015; Sun, 15 Nov 2026
 06:02:12 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261115061102.229680-1-jernej.skrabec@gmail.com>
 <20261115061102.229680-7-jernej.skrabec@gmail.com>
In-Reply-To: <20261115061102.229680-7-jernej.skrabec@gmail.com>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sun, 15 Nov 2026 22:01:58 +0800
X-Gmail-Original-Message-ID: <CAGb2v64X2hbU4wjv7C4NNkQ6W=0PW5C0xSUp1bzdDiAGrJF+ww@mail.gmail.com>
X-Gm-Features: AclHuK8-o_bvwblkCzsTqNM8KJ9djH1Jg7AEAEwZv4SuwLt3JJu8d-EKluowQT0
Message-ID: <CAGb2v64X2hbU4wjv7C4NNkQ6W=0PW5C0xSUp1bzdDiAGrJF+ww@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] drm/sun4i: Add DE33 shared plane driver
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>, mripard@kernel.org, 
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, 
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 bmasney+clk@redhat.com, jbrunet+clk@baylibre.com, sboyd@kernel.org, 
 Andre Przywara <andre.przywara@arm.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: wens@kernel.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 15, 2026 at 2:11=E2=80=AFPM Jernej Skrabec <jernej.skrabec@gmai=
l.com> wrote:
>
> DE33 makes its plane channels shared resources that mixers select through
> routing registers in the display clock block. The existing mixer-local
> plane initialization cannot represent that topology.
>
> Add a component that owns the shared plane register space, programs the
> default channel-to-mixer mapping and creates each mixer's DRM planes
> from that mapping.

Just some nits.

This should mention that this driver only gets hooked up in the last
patch of the series. This patch alone doesn't register the driver.

> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  drivers/gpu/drm/sun4i/Makefile        |   3 +-
>  drivers/gpu/drm/sun4i/sun50i_planes.c | 215 ++++++++++++++++++++++++++
>  drivers/gpu/drm/sun4i/sun50i_planes.h |  43 ++++++
>  3 files changed, 260 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/sun4i/sun50i_planes.c
>  create mode 100644 drivers/gpu/drm/sun4i/sun50i_planes.h
>
> diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makef=
ile
> index bad7497a0d11..501e3d867918 100644
> --- a/drivers/gpu/drm/sun4i/Makefile
> +++ b/drivers/gpu/drm/sun4i/Makefile
> @@ -16,7 +16,8 @@ sun8i-drm-hdmi-y              +=3D sun8i_hdmi_phy_clk.o
>
>  sun8i-mixer-y                  +=3D sun8i_mixer.o sun8i_ui_layer.o \
>                                    sun8i_vi_layer.o sun8i_ui_scaler.o \
> -                                  sun8i_vi_scaler.o sun8i_csc.o
> +                                  sun8i_vi_scaler.o sun8i_csc.o \
> +                                  sun50i_planes.o
>
>  sun4i-tcon-y                   +=3D sun4i_crtc.o
>  sun4i-tcon-y                   +=3D sun4i_tcon_dclk.o
> diff --git a/drivers/gpu/drm/sun4i/sun50i_planes.c b/drivers/gpu/drm/sun4=
i/sun50i_planes.c
> new file mode 100644
> index 000000000000..22b9f104a391
> --- /dev/null
> +++ b/drivers/gpu/drm/sun4i/sun50i_planes.c
> @@ -0,0 +1,215 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (c) 2025 Jernej Skrabec <jernej.skrabec@gmail.com> */

Need to update the year.

> +
> +#include <drm/drm_device.h>
> +
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>

> +#include <linux/of_graph.h>

This is unused. Leftover from an older version?

> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include "sun50i_planes.h"
> +#include "sun8i_ui_layer.h"
> +#include "sun8i_vi_layer.h"
> +
> +static const struct sun50i_planes_quirks sun50i_h616_planes_quirks =3D {
> +       .def_map =3D {
> +               {
> +                       .map =3D {0, 6, 7},
> +                       .num_ch =3D 3,
> +               },
> +               {
> +                       .map =3D {1, 2, 8},
> +                       .num_ch =3D 3,
> +               },
> +       },
> +       .cfg =3D {
> +               .de_type        =3D SUN8I_MIXER_DE33,
> +               /*
> +                * TODO: All planes support scaling, but driver needs
> +                * improvements to properly support it.
> +                */
> +               .scaler_mask    =3D 0,
> +               .scanline_yuv   =3D 4096,
> +       },
> +};
> +
> +static const struct of_device_id sun50i_planes_of_table[] =3D {
> +       {
> +               .compatible =3D "allwinner,sun50i-h616-de33-planes",
> +               .data =3D &sun50i_h616_planes_quirks
> +       },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, sun50i_planes_of_table);
> +
> +struct drm_plane **
> +sun50i_planes_setup(struct device *dev, struct drm_device *drm,
> +                   unsigned int mixer)
> +{
> +       struct sun50i_planes *planes =3D dev_get_drvdata(dev);
> +       const struct sun50i_planes_quirks *quirks;
> +       struct drm_plane **drm_planes;
> +       const struct default_map *map;
> +       unsigned int i;
> +
> +       if (!of_match_node(sun50i_planes_of_table, dev->of_node)) {
> +               dev_err(dev, "Device is not planes driver!\n");
> +               return ERR_PTR(-EINVAL);

return dev_err_probe();

> +       }
> +
> +       if (!planes) {
> +               dev_err(dev, "Planes driver is not loaded yet!\n");
> +               return ERR_PTR(-EINVAL);

return dev_err_probe();

> +       }
> +
> +       if (mixer > 1) {

Use ">=3D MAX_DISP" or  "!(mixer < MAX_DISP)" here?

> +               dev_err(dev, "Mixer index is too high!\n");
> +               return ERR_PTR(-EINVAL);

return dev_err_probe();


> +       }
> +
> +       quirks =3D planes->quirks;
> +       map =3D &quirks->def_map[mixer];
> +
> +       drm_planes =3D devm_kcalloc(drm->dev, map->num_ch + 1,
> +                                 sizeof(*drm_planes), GFP_KERNEL);
> +       if (!drm_planes)
> +               return ERR_PTR(-ENOMEM);
> +
> +       for (i =3D 0; i < map->num_ch; i++) {
> +               unsigned int phy_ch =3D map->map[i];
> +               struct sun8i_layer *layer;
> +               enum drm_plane_type type;
> +
> +               if ((i =3D=3D 0 && map->num_ch =3D=3D 1) || i =3D=3D 1)
> +                       type =3D DRM_PLANE_TYPE_PRIMARY;
> +               else
> +                       type =3D DRM_PLANE_TYPE_OVERLAY;
> +
> +               if (phy_ch < UI_PLANE_OFFSET)
> +                       layer =3D sun8i_vi_layer_init_one(drm, type, plan=
es->regs,
> +                                                       i, phy_ch, map->n=
um_ch,
> +                                                       &quirks->cfg);
> +               else
> +                       layer =3D sun8i_ui_layer_init_one(drm, type, plan=
es->regs,
> +                                                       i, phy_ch, map->n=
um_ch,
> +                                                       &quirks->cfg);
> +
> +               if (IS_ERR(layer)) {
> +                       dev_err(drm->dev,
> +                               "Couldn't initialize DRM plane\n");
> +                       return ERR_CAST(layer);

return dev_err_probe();


Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

> +               }
> +
> +               drm_planes[i] =3D &layer->plane;
> +       }
> +
> +       return drm_planes;
> +}
> +
> +static void sun50i_planes_init_mapping(struct sun50i_planes *planes)
> +{
> +       const struct sun50i_planes_quirks *quirks =3D planes->quirks;
> +       unsigned int i, j;
> +       u32 mapping;
> +
> +       mapping =3D 0;
> +       for (j =3D 0; j < MAX_DISP; j++)
> +               for (i =3D 0; i < quirks->def_map[j].num_ch; i++) {
> +                       unsigned int ch =3D quirks->def_map[j].map[i];
> +
> +                       if (ch < UI_PLANE_OFFSET)
> +                               mapping |=3D j << (ch * 2);
> +                       else
> +                               mapping |=3D j << ((ch - UI_PLANE_OFFSET)=
 * 2 + 16);
> +               }
> +       regmap_write(planes->mapping, SUNXI_DE33_DE_CHN2CORE_MUX_REG, map=
ping);
> +
> +       for (j =3D 0; j < MAX_DISP; j++) {
> +               mapping =3D 0;
> +               for (i =3D 0; i < quirks->def_map[j].num_ch; i++) {
> +                       unsigned int ch =3D quirks->def_map[j].map[i];
> +
> +                       if (ch >=3D UI_PLANE_OFFSET)
> +                               ch +=3D 2;
> +
> +                       mapping |=3D ch << (i * 4);
> +               }
> +               regmap_write(planes->mapping, SUNXI_DE33_DE_PORT02CHN_MUX=
_REG + j * 4, mapping);
> +       }
> +}
> +
> +static const struct regmap_config sun50i_planes_regmap_config =3D {
> +       .name           =3D "planes",
> +       .reg_bits       =3D 32,
> +       .val_bits       =3D 32,
> +       .reg_stride     =3D 4,
> +       .max_register   =3D 0x17fffc,
> +};
> +
> +static int sun50i_planes_probe(struct platform_device *pdev)
> +{
> +       struct platform_device *clk_pdev;
> +       struct device *dev =3D &pdev->dev;
> +       struct sun50i_planes *planes;
> +       struct device_node *np;
> +       void __iomem *regs;
> +
> +       planes =3D devm_kzalloc(dev, sizeof(*planes), GFP_KERNEL);
> +       if (!planes)
> +               return -ENOMEM;
> +
> +       planes->quirks =3D of_device_get_match_data(dev);
> +       if (!planes->quirks)
> +               return dev_err_probe(dev, -EINVAL, "Unable to get quirks\=
n");
> +
> +       np =3D of_parse_phandle(dev->of_node,
> +                             "allwinner,plane-mapping", 0);
> +       if (!np)
> +               return dev_err_probe(dev, -EINVAL, "Missing mapping phand=
le\n");
> +
> +       clk_pdev =3D of_find_device_by_node(np);
> +       of_node_put(np);
> +       if (!clk_pdev)
> +               return dev_err_probe(dev, -EPROBE_DEFER, "Unable to get m=
apping\n");
> +
> +       /* Regmap is registered by display clocks driver during its probe=
. */
> +       planes->mapping =3D dev_get_regmap(&clk_pdev->dev, NULL);
> +       if (!planes->mapping) {
> +               platform_device_put(clk_pdev);
> +               return dev_err_probe(dev, -EPROBE_DEFER, "Unable to get r=
egmap\n");
> +       }
> +
> +       if (!device_link_add(dev, &clk_pdev->dev,
> +                            DL_FLAG_AUTOREMOVE_CONSUMER)) {
> +               platform_device_put(clk_pdev);
> +               return dev_err_probe(dev, -EINVAL, "Failed to create link=
\n");
> +       }
> +       platform_device_put(clk_pdev);
> +
> +       regs =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(regs))
> +               return PTR_ERR(regs);
> +
> +       planes->regs =3D devm_regmap_init_mmio(dev, regs, &sun50i_planes_=
regmap_config);
> +       if (IS_ERR(planes->regs))
> +               return PTR_ERR(planes->regs);
> +
> +       sun50i_planes_init_mapping(planes);
> +
> +       dev_set_drvdata(dev, planes);
> +
> +       return 0;
> +}
> +
> +struct platform_driver sun50i_planes_platform_driver =3D {
> +       .probe          =3D sun50i_planes_probe,
> +       .driver         =3D {
> +               .name           =3D "sun50i-planes",
> +               .of_match_table =3D sun50i_planes_of_table,
> +       },
> +};
> diff --git a/drivers/gpu/drm/sun4i/sun50i_planes.h b/drivers/gpu/drm/sun4=
i/sun50i_planes.h
> new file mode 100644
> index 000000000000..7be969491f9c
> --- /dev/null
> +++ b/drivers/gpu/drm/sun4i/sun50i_planes.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/* Copyright (c) 2025 Jernej Skrabec <jernej.skrabec@gmail.com> */

2026 now (and almost over ...)

> +
> +#ifndef _SUN50I_PLANES_H_
> +#define _SUN50I_PLANES_H_
> +
> +#include "sun8i_mixer.h"
> +
> +/* mapping registers, located in clock register space */
> +#define SUNXI_DE33_DE_CHN2CORE_MUX_REG 0x24
> +#define SUNXI_DE33_DE_PORT02CHN_MUX_REG        0x28
> +#define SUNXI_DE33_DE_PORT12CHN_MUX_REG        0x2c
> +
> +#define MAX_DISP       2
> +#define MAX_CHANNELS   8
> +#define UI_PLANE_OFFSET        6
> +
> +struct regmap;
> +struct drm_device;
> +
> +struct default_map {
> +       unsigned int map[MAX_CHANNELS];
> +       unsigned int num_ch;
> +};
> +
> +struct sun50i_planes_quirks {
> +       struct default_map      def_map[MAX_DISP];
> +       struct sun8i_layer_cfg  cfg;
> +};
> +
> +struct sun50i_planes {
> +       struct regmap                           *regs;
> +       struct regmap                           *mapping;
> +       const struct sun50i_planes_quirks       *quirks;
> +};
> +
> +struct drm_plane **
> +sun50i_planes_setup(struct device *dev, struct drm_device *drm,
> +                   unsigned int mixer);
> +
> +extern struct platform_driver sun50i_planes_platform_driver;
> +
> +#endif /* _SUN50I_PLANES_H_ */
> --
> 2.43.0
>
