Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A35ACD4F24
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 15:00:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9396110E5E5;
	Wed, 13 May 2026 15:00:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EcCxLE80";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBCDF10E5E5
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 14:59:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 16A306012B
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 14:59:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE394C2BCFA
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 14:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778684398;
 bh=b65Hj6vzoGQXDZXC2RU8pJ9mqehhTTIbmi7MEFwB91g=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=EcCxLE80HyAkiMQl9wnKaOyPCwvsa61x4UC91VHBTAPbnm8GFbgQ57yTZvw3Wp8s6
 Rpc7y4M19BbqYjr2RiyVoqU+xBmBgJXnEZxmtuLa6S1Wm7UEHwvqwOON63FbNSox83
 i7K/73sw8czbs7JgtopUuNUoZUSlbHbqWKgaxU29qrec1pk+ucW7KG4mGcNXdaXGVM
 EwTEPsoRs4fOKtvtKBfoLK/fUNnLY28HE5cV7Wk4dpNoDF1FyUnA4KeqbsPcZZtK4S
 7nlrcHFJgu/uYW5u6FElDT/k/H63bkM2OxSfPLeHNqAWwDvImeSakle+Bwq8jLN5G+
 Y5G6YGyjbKUIA==
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-13354eb66baso2960797c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 07:59:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/jFcWQpN4D99auD7U35nyPoeY6qhwIkPwMMJ3PxAUbcsJccKLLuShsZKcXHexVF5KFWvU+oOKtNAM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyObjJoWaPF/zxvATk/OR6o8HKRp7W98JYo+rxkI2zZu7FQP/sG
 eJkKeP9sWRh/wi5xvCDNBAGlSosKx2yYw+c7FSKmZcVMzdHK+9XrOhhnEaPL4bsl/H3fXp2e1go
 MsdhdRbLb2WCopznCxX3ZAQEE2lFlBg==
X-Received: by 2002:a05:7022:41a0:b0:132:1e79:9c55 with SMTP id
 a92af1059eb24-13436aa4a7amr2312761c88.31.1778684398054; Wed, 13 May 2026
 07:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260403-drm-mediatek-opencode-encoder-init-v1-1-7be86241b876@zohomail.in>
In-Reply-To: <20260403-drm-mediatek-opencode-encoder-init-v1-1-7be86241b876@zohomail.in>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Wed, 13 May 2026 14:59:45 +0000
X-Gmail-Original-Message-ID: <CAAOTY__a6R7CkNApwymRYFLOQ3LErTvWXNh0oOMS7d6iK5+nNQ@mail.gmail.com>
X-Gm-Features: AVHnY4Kxza9CuHOvMdkcK_8Vffimp1ycRH16uNep4anPkT7aEPEK318s88QDYsE
Message-ID: <CAAOTY__a6R7CkNApwymRYFLOQ3LErTvWXNh0oOMS7d6iK5+nNQ@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: mtk_dpi: Open-code drm_simple_encoder_init()
To: shivamkalra98@zohomail.in
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi, Shivam:

Shivam Kalra via B4 Relay
<devnull+shivamkalra98.zohomail.in@kernel.org> =E6=96=BC 2026=E5=B9=B44=E6=
=9C=883=E6=97=A5=E9=80=B1=E4=BA=94
=E4=B8=8B=E5=8D=8812:00=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Shivam Kalra <shivamkalra98@zohomail.in>
>
> The helper drm_simple_encoder_init() is a trivial wrapper around
> drm_encoder_init() that only provides a static drm_encoder_funcs with
> .destroy set to drm_encoder_cleanup(). Open-code the initialization
> with a driver-specific instance of drm_encoder_funcs and remove the
> dependency on drm_simple_kms_helper.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Shivam Kalra <shivamkalra98@zohomail.in>
> ---
> Addresses the "Open-code drm_simple_encoder_init()" task from
> Documentation/gpu/todo.rst.
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index 53360b5d12ba..5b83ca6aecb2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -25,8 +25,8 @@
>  #include <drm/drm_bridge_connector.h>
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_edid.h>
> +#include <drm/drm_encoder.h>
>  #include <drm/drm_of.h>
> -#include <drm/drm_simple_kms_helper.h>
>
>  #include "mtk_ddp_comp.h"
>  #include "mtk_disp_drv.h"
> @@ -993,6 +993,10 @@ static const struct drm_bridge_funcs mtk_dpi_bridge_=
funcs =3D {
>         .debugfs_init =3D mtk_dpi_debugfs_init,
>  };
>
> +static const struct drm_encoder_funcs mtk_dpi_encoder_funcs =3D {
> +       .destroy =3D drm_encoder_cleanup,
> +};
> +
>  void mtk_dpi_start(struct device *dev)
>  {
>         struct mtk_dpi *dpi =3D dev_get_drvdata(dev);
> @@ -1026,8 +1030,8 @@ static int mtk_dpi_bind(struct device *dev, struct =
device *master, void *data)
>         int ret;
>
>         dpi->mmsys_dev =3D priv->mmsys_dev;
> -       ret =3D drm_simple_encoder_init(drm_dev, &dpi->encoder,
> -                                     DRM_MODE_ENCODER_TMDS);
> +       ret =3D drm_encoder_init(drm_dev, &dpi->encoder, &mtk_dpi_encoder=
_funcs,
> +                              DRM_MODE_ENCODER_TMDS, NULL);
>         if (ret) {
>                 dev_err(dev, "Failed to initialize decoder: %d\n", ret);
>                 return ret;
>
> ---
> base-commit: 4b9c36c83b34f710da9573291404f6a2246251c1
> change-id: 20260403-drm-mediatek-opencode-encoder-init-36336e4c4ff3
>
> Best regards,
> --
> Shivam Kalra <shivamkalra98@zohomail.in>
>
>
