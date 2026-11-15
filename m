Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4DD606A31D
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P87a7mX7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A98110E14B;
	Sun, 15 Nov 2026 14:26:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 038F910E4F7
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 14:26:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D90D5623EE
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 14:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922701F000C6
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 14:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794752807;
 bh=VY80GYMWmN2X/cRBWnIR5x01adoLIi2PeDOmn18ACWo=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
 b=P87a7mX7trSCmaFCHcQyFDIH8UjDbYHKiubFgXqc/gTsY3yQkpA/dB9cGBqmVFbxX
 Dqxfi/F/zSteHwNitFJtoynvjmCM+ozfM5mXCzGsZMVLTDIL0T+8u99p2v6FHHdq13
 IwxtiqQ/clUTuo0ze/095tLCo9wYv1nqLk654UgsNNPE3x7j3ChAuxZWQIXR7BpNZO
 E0ziDZXqmnvymoFPg0oclQTXlwWXH69CS2V/RvOpUjIcY24X3VQF0veaVB4Gb7/G8k
 2PpA7Q0PKL/j15UfpIFf83IdUYNm1B+jUA4rQTJGoWL0gp5ClBqnZNacLP/ENO1lH4
 /KXwg8m67qEXw==
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-3ae2fb3fe2fso21881141fa.2
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 06:26:47 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErEHWCaJfPOWjXf0uNNWQJetFF1UR4mAlUdSBycAMzkS2HNqZZjUBA8MyGLDBT+GrxEAQ5jqfXhkiwI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z89Lr6cka7TXeYgnRQoZreon5JBX66rasuPymZpZ0/qW51gt1v8
 9uLXxK3uBLTTa0MqfC5IJFCaLaMqvg0FqspehGyXCV5kK9Zr+nW5pRn5pCMT1TgXIlhDmompqgI
 kvphVH6D13IAgOalbRLNTmVwU47QDeK0=
X-Received: by 2002:a05:651c:41d7:b0:3ad:de02:e9a6 with SMTP id
 38308e7fff4ca-3ae2b4cda67mr25514401fa.16.1794752806007; Sun, 15 Nov 2026
 06:26:46 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261115061102.229680-1-jernej.skrabec@gmail.com>
 <20261115061102.229680-9-jernej.skrabec@gmail.com>
In-Reply-To: <20261115061102.229680-9-jernej.skrabec@gmail.com>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sun, 15 Nov 2026 22:26:32 +0800
X-Gmail-Original-Message-ID: <CAGb2v64wZv7TV1Jb-r0qtvRz=dWWO_YkhYxMwxBNcyVUoKi9VQ@mail.gmail.com>
X-Gm-Features: AclHuK-JOP2IDOiEi7PmqaWN9O63FgTmRJcOIwMzfvjNDqgeqpiwUNzW1M1IK3U
Message-ID: <CAGb2v64wZv7TV1Jb-r0qtvRz=dWWO_YkhYxMwxBNcyVUoKi9VQ@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] drm/sun4i: Switch DE33 to split plane bindings
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
> The shared plane driver and split register resources are now in place.
> Switch DE33 mixer discovery to the new bindings and remove the legacy
> per-mixer plane setup. Mixer register space now covers only display
> blending control, so limit its regmap accordingly.
>
> The old DE33 binding is not supported anymore, since it can't describe
> shared planes and was never used by any device tree. If it's detected,
> print an error asking the user to update the device tree, instead of
> failing silently or misusing the plane register space as blender
> registers.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  drivers/gpu/drm/sun4i/sun8i_mixer.c | 195 ++++++++++++++++++++--------
>  drivers/gpu/drm/sun4i/sun8i_mixer.h |  10 +-
>  2 files changed, 140 insertions(+), 65 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/=
sun8i_mixer.c
> index dbde80b32080..0970be6aa035 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -13,6 +13,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/of_graph.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/reset.h>
>
> @@ -25,6 +26,7 @@
>  #include <drm/drm_probe_helper.h>
>
>  #include "sun4i_drv.h"
> +#include "sun50i_planes.h"

Nit: doesn't seem to follow the order we use elsewhere. I think we normally
would do:

    sun4i_drv.h
    sun8i_*
    sun50i_planes.h

>  #include "sun8i_mixer.h"
>  #include "sun8i_ui_layer.h"
>  #include "sun8i_vi_layer.h"

[...]

> @@ -566,12 +582,34 @@ static int sun8i_mixer_bind(struct device *dev, str=
uct device *master,
>         if (!mixer->cfg)
>                 return -EINVAL;
>
> +       if (mixer->cfg->de_type =3D=3D SUN8I_MIXER_DE33) {
> +               /*
> +                * The original DE33 binding described planes as part of
> +                * the mixer, which can't work with more than one mixer.
> +                * It was never used by any device tree, so it's not
> +                * supported.
> +                */
> +               if (of_property_match_string(dev->of_node, "reg-names",
> +                                            "layers") >=3D 0 ||

No need to wrap this bit.

> +                   !of_property_present(dev->of_node, "allwinner,planes"=
))
> +                       return dev_err_probe(dev, -EINVAL,
> +                                            "Unsupported DE33 mixer bind=
ing, please update the device tree\n");
> +
> +               mixer->engine.ops =3D &sun50i_engine_ops;
> +       } else {
> +               mixer->engine.ops =3D &sun8i_engine_ops;
> +       }
> +
>         regs =3D devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(regs))
>                 return PTR_ERR(regs);
>
> -       mixer->engine.regs =3D devm_regmap_init_mmio(dev, regs,
> -                                                  &sun8i_mixer_regmap_co=
nfig);
> +       if (mixer->cfg->de_type =3D=3D SUN8I_MIXER_DE33)
> +               mixer->engine.regs =3D devm_regmap_init_mmio(dev, regs,
> +                                                          &sun50i_mixer3=
3_regmap_config);
> +       else
> +               mixer->engine.regs =3D devm_regmap_init_mmio(dev, regs,
> +                                                          &sun8i_mixer_r=
egmap_config);

At some point we need to move most of the bind function to the probe functi=
on.
None of the devm_* stuff gets released if the bind function fails.

We can also switch to the combined devm_* helpers for clks and resets.

>         if (IS_ERR(mixer->engine.regs)) {
>                 dev_err(dev, "Couldn't create the mixer regmap\n");
>                 return PTR_ERR(mixer->engine.regs);
> @@ -588,17 +626,6 @@ static int sun8i_mixer_bind(struct device *dev, stru=
ct device *master,
>                         dev_err(dev, "Couldn't create the top regmap\n");
>                         return PTR_ERR(mixer->top_regs);
>                 }
> -
> -               regs =3D devm_platform_ioremap_resource_byname(pdev, "dis=
play");
> -               if (IS_ERR(regs))
> -                       return PTR_ERR(regs);
> -
> -               mixer->disp_regs =3D devm_regmap_init_mmio(dev, regs,
> -                                                        &sun8i_disp_regm=
ap_config);
> -               if (IS_ERR(mixer->disp_regs)) {
> -                       dev_err(dev, "Couldn't create the disp regmap\n")=
;
> -                       return PTR_ERR(mixer->disp_regs);
> -               }
>         }
>
>         mixer->reset =3D devm_reset_control_get(dev, NULL);
> @@ -638,6 +665,40 @@ static int sun8i_mixer_bind(struct device *dev, stru=
ct device *master,
>
>         clk_prepare_enable(mixer->mod_clk);
>
> +       if (mixer->cfg->de_type =3D=3D SUN8I_MIXER_DE33) {
> +               struct platform_device *pdev;
> +               struct device_link *link;
> +               struct device_node *np;
> +               void *data;
> +
> +               np =3D of_parse_phandle(dev->of_node, "allwinner,planes",=
 0);
> +               if (!np) {
> +                       ret =3D -ENODEV;
> +                       goto err_disable_mod_clk;
> +               }
> +
> +               pdev =3D of_find_device_by_node(np);
> +               of_node_put(np);
> +               if (!pdev) {
> +                       ret =3D -EPROBE_DEFER;
> +                       goto err_disable_mod_clk;
> +               }
> +               mixer->planes_dev =3D &pdev->dev;
> +
> +               data =3D platform_get_drvdata(pdev);
> +               if (!data) {

"device_is_bound(&pdev->dev)" is probably more straightforward.

> +                       ret =3D -EPROBE_DEFER;
> +                       goto err_put_device;
> +               }
> +
> +               link =3D device_link_add(dev, &pdev->dev,
> +                                      DL_FLAG_AUTOREMOVE_CONSUMER);
> +               if (!link) {
> +                       ret =3D -EINVAL;
> +                       goto err_put_device;
> +               }
> +       }
> +
>         list_add_tail(&mixer->engine.list, &drv->engine_list);
>
>         /* Reset registers and disable unused sub-engines */
> @@ -672,6 +733,10 @@ static int sun8i_mixer_bind(struct device *dev, stru=
ct device *master,
>
>         return 0;
>
> +err_put_device:
> +       put_device(mixer->planes_dev);

Should you have matching "if (mixer->cfg->de_type =3D=3D SUN8I_MIXER_DE33)"
like in the .unbind callback?

Once fixed,


Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
