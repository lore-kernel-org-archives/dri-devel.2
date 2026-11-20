Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CB8606A6A7
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 21:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sz6cKZn6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C86A510E12D;
	Fri, 20 Nov 2026 21:15:28 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com
 [209.85.167.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2BBE10E12D
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 21:15:22 +0000 (UTC)
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-5c1479a959aso1020932e87.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:15:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795209320; cv=none;
 d=google.com; s=arc-20260327;
 b=DmrY6j9qEZUda1v9YjqTqRkE8h80vwxrH69v8t3AfcsTIP1UpCKfAFTXjX/fSkx4+E
 sWrcKlyIAdK+kbfEtbCQTAPrrR2srm16p6j+ojlesa5/tYQY0cxd1XylXRqUqegUB4Sx
 dn/HtyoGiTTbxf2U65xdhfw6tMOZ/K6iHjzmceWhU6ST9nh8rY60ADpWS1Nf0N3cmAK8
 Ju1cy9nGsiMurlT+X2sa8khW1fIxQbtxmHcsV7tHLiOi/Qc8KSHVi8h3MIO6wyZCl0ga
 nVnBXbbXyvfhfTNX7h2hXvw9t+uqBy2BnKRYk4O9ZNRAR8SBvf8Vdr9SxLOY+CosPJvZ
 42ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jhsdAq68aTOS0woPorboO2Q3We/YdgAlOANjhDh+IIk=;
 fh=PRsPnlfAr/JU50huH/v2oxBRnGKaOI5bKa1zY0XTzlo=;
 b=Wq/jAoEQ74FpOsTUB7UTyRkWcsFvcpQWTrYCIT3MHv/JobK9mt9ZGZGXV+ejVJb1Qg
 GsFVp5Dmm+7f2uF86maPHz7t6hARPT48PPmegt3RDVX6yls4ISz0CIQ7Qcn071S25ciT
 0raHvwcn5oaZphflQzjawb0TBLDFbsmExdfxqyQcZxcZYZtPNad3CENS+Dck3SAO0m7d
 Aqvn0IlBa/0+cM1oP3Jq+GI/O8pHlYWVsGPLS/wwcgVB5J2Sl2T0tlkHrjE9PQaLYtrb
 Kk09TIYCs9OAC5+/bpeBJMu2NvARkMAS3OMvBJPcUuuq7+09+1p9ukT9u8ISw6q0BLTT
 tOjg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795209320; x=1795814120; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jhsdAq68aTOS0woPorboO2Q3We/YdgAlOANjhDh+IIk=;
 b=sz6cKZn6pTNPj6uIJ8AxXIF69vqjSeJPmO3tuK5yDfOmk4yVsrLgkvVcTkGWAqE/tn
 o+0Uu7XegPJmud8MyYBGC0C1vUBt55ThXVkfg42WThZx/78n1xCSr9iCpHt0aJjPS8Qp
 GQjAt8YyYw3ta+wIqstK00AA5JWREl1cq0BeqBxKGWGJnjjFMtqIFM11X0VtthgfiKIy
 9c/CSmSdXibDcolE4MUK1LmTUm9am3P2FEmGinuaTxSA9RrHEHf5c0AVZsLTrGGEgy8C
 qvD6uL2W5k5NoPxqHHNJVST+vD+l1Bn3jIGSRLYACTZft/hZTid+Of4aCcCSApczMJ/M
 lh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795209320; x=1795814120;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jhsdAq68aTOS0woPorboO2Q3We/YdgAlOANjhDh+IIk=;
 b=l93PwP9Jtsz/6v4D1b3PuCdOFAEIdQjmaKgWRFb7z5jC8hwuAElXN9WaFVL80LaB3o
 dNBAuqL9DPEkCMJqfbGMlPIoX39QhYHHtjLD+SSlR77UiI43KXdvMBTYlu+8/CaOiHvk
 n13JbdfbZ06RUBlDVNQKWfA4E78/ngqbzV/esrzo/QAyNATyZcEqGIlgYKM22VYkXFHm
 20DDAgjtQ1iz/luuShALu1+ll4whphlQdAEkcz5NfMoK2N8Fk2M8QzDjNNy6uR6U0TZV
 nhoUbxFp6s9XYoOVEndiBSXzkZaXogUmDYnYRzq4eM7gsvvNP0TfG8BDRcUZf+cLZfsY
 1rig==
X-Forwarded-Encrypted: i=1;
 AL+hErFfCkMYKYm8qjrq3U2LJM+DH2Eubv5TxRkU06/CA7tl8ozGw+V60+fJDAMhTeP8dZdco4ay5f2GWGk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8h6Y8y1+WTwqYh2eEbonZFDcgQxn1IKrwZfKe1KxtHnNWa9+y+
 sSy0a/Fh87eadytFUyiNef4vT2r2JdtV24d1xRdUSW/cG5yvrb1I9ZXQOCbhOfRb6/P9MSYODat
 yltxvPV12WL03rmHVZa+8tPhwWYrMTJs=
X-Gm-Gg: AZFdTZe2tpyrYpZDdeRF2iPPnmuNva1NgasL/UVRl8lJxmEGDU+enZ57/DKcuIGeUNB
 IIG3RWVA1rLFmBrKtaz8+XGlhleHrpqxVCflxk6nNO9GQs/AJfy7LqG4Ia8zsE4ZiNnU+Qmiefg
 ZppAlgs89J7dYTrG+UWoKDAxmEgwRHIUo6biFUiaOrnrZK7w76ImdJyvuv8fNBoawBWaa8mSTQY
 IC7kZ5o5wOq0S/rX3XQ4Gd3R2Sxc5mvyBsUSDrvtu5naw27mIb4ct3VL4rfY+Ljmwcou73tC7Ok
 S6lOOUiTXWl8XRxD9xpQdJT7EZu+nb+Yjop3lf2Jjpk7pl+ARWaIogqM4lD3g4EBlA+dJhyRINr
 8O0xmOLOMK7DPrKE0PfuVq+4/Q6M6zDTuwgX6fSQKGly2svQjw+M2UZLMF3sTH/kZIAvQQYU7Ho
 vOEJvl/rq63BalbdbcUgST8nJg
X-Received: by 2002:a05:6512:b14:b0:5c1:c4b4:a3e5 with SMTP id
 2adb3069b0e04-5c1c4b4a448mr663384e87.27.1795209320229; Fri, 20 Nov 2026
 13:15:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260909210213.946159-1-festevam@gmail.com>
In-Reply-To: <20260909210213.946159-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 20 Nov 2026 18:15:08 -0300
X-Gm-Features: Aa3M54p88NC6g05pV48qVC2p_9ZAScZjtIt_fyZczxzCKvkLyILovNFeQdmLZhk
Message-ID: <CAOMZO5DuwQq_-hMPvpb65drpU40UNWYXQ_ksPW0ACXxaCwOoWw@mail.gmail.com>
Subject: Re: [PATCH] drm/mxsfb: lcdif: Fix use-after-free on unbind
To: marex@denx.de, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Liu Ying <victor.liu@nxp.com>
Cc: mripard@kernel.org, imx@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Sep 9, 2026 at 6:02=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> lcdif allocates its private data, which embeds the CRTC and primary
> plane, and its encoders using devres. These DRM objects are linked into
> the mode_config lists.
>
> Since mode_config cleanup is DRM-managed, it is deferred until the DRM
> device is released. An open DRM file can keep the DRM device alive after
> the platform device has been unbound and devres has freed those objects.
> The later mode_config cleanup then dereferences freed memory.
>
> Allocate the private data with drmm before initializing mode_config so
> that it remains alive until mode_config cleanup has completed. Allocate
> encoders with drmm_plain_encoder_alloc(), which cleans up each encoder
> and removes it from the mode_config list before freeing its memory.
>
> This can be reproduced on i.MX8MP by keeping the DRM card open across an
> LCDIF unbind and closing it afterwards.
>
> Cc: stable@vger.kernel.org
> Fixes: 1c71d925c03a ("drm: lcdif: Switch to drmm_mode_config_init")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

A gentle ping.



> ---
>  drivers/gpu/drm/mxsfb/lcdif_drv.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lc=
dif_drv.c
> index e2173c4d6fc2..7e9f3b205a45 100644
> --- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
> +++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
> @@ -24,6 +24,7 @@
>  #include <drm/drm_fbdev_dma.h>
>  #include <drm/drm_gem_dma_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_managed.h>
>  #include <drm/drm_mode_config.h>
>  #include <drm/drm_module.h>
>  #include <drm/drm_of.h>
> @@ -43,10 +44,6 @@ static const struct drm_mode_config_helper_funcs lcdif=
_mode_config_helpers =3D {
>         .atomic_commit_tail =3D drm_atomic_helper_commit_tail_rpm,
>  };
>
> -static const struct drm_encoder_funcs lcdif_encoder_funcs =3D {
> -       .destroy =3D drm_encoder_cleanup,
> -};
> -
>  static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
>  {
>         struct device *dev =3D lcdif->drm->dev;
> @@ -74,19 +71,16 @@ static int lcdif_attach_bridge(struct lcdif_drm_priva=
te *lcdif)
>                                              "Failed to get bridge for en=
dpoint%u\n",
>                                              of_ep.id);
>
> -               encoder =3D devm_kzalloc(dev, sizeof(*encoder), GFP_KERNE=
L);
> -               if (!encoder)
> -                       return dev_err_probe(dev, -ENOMEM,
> -                                            "Failed to allocate encoder =
for endpoint%u\n",
> -                                            of_ep.id);
> -
> -               encoder->possible_crtcs =3D drm_crtc_mask(&lcdif->crtc);
> -               ret =3D drm_encoder_init(lcdif->drm, encoder, &lcdif_enco=
der_funcs,
> -                                      DRM_MODE_ENCODER_NONE, NULL);
> -               if (ret)
> +               encoder =3D drmm_plain_encoder_alloc(lcdif->drm, NULL,
> +                                                  DRM_MODE_ENCODER_NONE,=
 NULL);
> +               if (IS_ERR(encoder)) {
> +                       ret =3D PTR_ERR(encoder);
>                         return dev_err_probe(dev, ret,
>                                              "Failed to initialize encode=
r for endpoint%u\n",
>                                              of_ep.id);
> +               }
> +
> +               encoder->possible_crtcs =3D drm_crtc_mask(&lcdif->crtc);
>
>                 ret =3D drm_bridge_attach(encoder, bridge, NULL, DRM_BRID=
GE_ATTACH_NO_CONNECTOR);
>                 if (ret)
> @@ -131,7 +125,7 @@ static int lcdif_load(struct drm_device *drm)
>         struct lcdif_drm_private *lcdif;
>         int ret;
>
> -       lcdif =3D devm_kzalloc(&pdev->dev, sizeof(*lcdif), GFP_KERNEL);
> +       lcdif =3D drmm_kzalloc(drm, sizeof(*lcdif), GFP_KERNEL);
>         if (!lcdif)
>                 return -ENOMEM;
>
> --
> 2.43.0
>
