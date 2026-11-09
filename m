Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB712606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=D/8Y79Yf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3928B10E85F;
	Mon,  9 Nov 2026 09:54:17 +0000 (UTC)
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com
 [209.85.160.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9C8210E85F
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 09:54:11 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id
 586e51a60fabf-4ad881b6517so430638fac.2
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 01:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1794218051; x=1794822851;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2a609L2GphDQlVfX0YuvfIMKjC+LWixKm2AkfX7MOhg=;
 b=D/8Y79Yf7kPEZs93VJHXKmMDvM8jYT+X94TLtdkNwc17IYFte58iyVAFSvUQkEu27V
 VVMoZlGNaVdsTumD6F2Dokxu6cXHn6B/ejLLk1B5+AhsCjawHT/jNTDTCcKbhSAO4UQQ
 GBLZ7CWQ95TB0/evsRCtnuQ4gvXt6EqtYOwkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794218051; x=1794822851;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2a609L2GphDQlVfX0YuvfIMKjC+LWixKm2AkfX7MOhg=;
 b=duu9S2HAueDVRNmBIjLMVjDVXE9P0Kbd0LHVYdg7KckngM6bJ8cwDdjaG68Mxp3LcU
 7VrnvBRdbqqLywniSUyqKkgmQcVIT0/D62+HNl0KitY+dlFwoMMEW3oiAAQWFlpaBDMb
 mRgFklMBC/BxXzK/KcHv+aH+fhwCByXdZSY8I15Lmc54NYb1TADbcWUkyxhTb3D0ppTB
 tfA93HzztMnm2oqkcFnavqEOREk7NQ5jhaNEGs4x2NRvbvreSdsP+BPfeWfegBu6AWBj
 gmaTQWMyhhe4UMH5+VeYHK2mgsO3RsKwj9KbMlAknnbRXCuUsVwg+UnqVddB62jbTEky
 yDHA==
X-Forwarded-Encrypted: i=1;
 AL+hErGnoXlkIVj+vWQsIdt6KJ4sCCn2sysxa5DcHFnEkv9E+wtEuySwhI5+uHyy3dMn4ETDzqKlJ9NPM/E=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+CYkUv3dbaaFR+qIZaqJ1x8pUDO3m7/I/ot0m4tB5tyGpiHX4j
 JPLMlx64UC9a4M0x1ZDjw+n0kqe100BowdVy+rxv0KjnKO2IXZVYnf5w8DRlmIYKnxekUSj2PEC
 rAAt6Vw==
X-Gm-Gg: AYBFou1mlp9ts807ofCHGo11DoRD0zrFegagbdpV/FjBQs/ffZhHNlGvf7uU4ir4lrY
 VILdDmK2QkwyMSBy1GrB6bXRbwDDhZA0LsTIeWj1+XscZ2Cv7KM30ljgU9u941EfazTf227dYfW
 VXengf2Ok5kP1RMkqma9TyHDq0/vWxgSE8MQ/BXhjO+FqXId7CJlDBSR/e9kFvuIOKrzaUix1zU
 WPJm00rSzNNXmvVqbd/NnLPcI690RFIzG48res4vS12HHpiKgHdfCR0sdIsD3Np12m5Q+8mRZfX
 FEsA7M2xA+qi/39BqKGuB6eO5n0F2WqOf7VEy3REd5+5EAooeaIdmPA1QHdW2LjgLs44xYoA3eE
 7VnoKILgLrPH9ELET5EeXODFTfa9zofF1UHzFFNg1/+VkEcdAw2JyYjRFTFRusRX3ULV6Mr8+OP
 cQWz5V0Xykcl/NjAymRDS93T6aj+P+FvUsB1x/1wtzOOwgRhZ0VGIA1PCpk1QImmU4Bj3eisvdK
 j51e4261CdW+tCKYNxgunbly3Wta+CQVxeRf+HqREIE0nHCBTC4p4aJO4A/f/bLvLP7JeD2CGty
 LJlv7uu4WYP8I/9n31EcVt8ETqM3uuXx+PCovLK/KwHuHkW88wQNbOJvsj9ymVE=
X-Received: by 2002:a05:6870:b1b:b0:48f:e0f6:c036 with SMTP id
 586e51a60fabf-4adecb4d486mr1580289fac.52.1794218050779; 
 Mon, 09 Nov 2026 01:54:10 -0800 (PST)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com.
 [209.85.210.49]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ade694f5cdsm4957138fac.9.2026.11.09.01.54.09
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 01:54:10 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-823b938464fso469549a34.2
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 01:54:09 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErHEvSlANNLgMKydCfo3uBzUswQte16/fY2A/9746YmQHqyyMVzIfe7AYVtwRjvXVJNqYSz94dcokd4=@lists.freedesktop.org
X-Received: by 2002:a05:7300:ce86:b0:35e:f1a5:9ba6 with SMTP id
 5a478bee46e88-37252b4c091mr6436576eec.5.1794217702332; Mon, 09 Nov 2026
 01:48:22 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-10-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-10-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Mon, 9 Nov 2026 17:47:43 +0800
X-Gmail-Original-Message-ID: <CAC=S1ng1U7XK2SvM+2Tvb7z2nHiDEvLhVP75JHdwzkV7GiaiKA@mail.gmail.com>
X-Gm-Features: AclHuK_kbp2RlyhWxo_Xx4hVQaPPUEY10kfNvYs17nATUWr47nBdslkFDfWhjSg
Message-ID: <CAC=S1ng1U7XK2SvM+2Tvb7z2nHiDEvLhVP75JHdwzkV7GiaiKA@mail.gmail.com>
Subject: Re: [PATCH v2 09/46] drm/mediatek: De-duplicate internal component
 checks
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 justin.yeh@mediatek.com, jason-jh.lin@mediatek.com, kernel@collabora.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Jul 14, 2026 at 7:45=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Both mtk_ddp_comp and mtk_drm_drv are performing similar checks
> to distinguish components that have an external driver from ones
> that don't - with the exception of mtk_ddp_comp also checking if
> the component is related to a backlight driver.
>
> Create helper functions in the main component management driver
> mtk_ddp_comp, one to check if the currently checked component is
> internal/simple, and one (static, internal to mtk_ddp_comp only)
> to check if it is a backlight related one.
>
> Since the amount of internal/simple components is lower than the
> amount of ones having a specific driver, and since it is expected
> that most of (if not all) of any new hardware support will need a
> specific driver as well, the helpers are doing an inverted check
> compared to what the code was doing before, as both mtk_ddp_comp
> and mtk_drm_drv were checking for external component explicitly,
> while now they're doing the same, but checking if NOT internal.
>
> Also, while at it, for the OVL_ADAPTOR components case, instead
> of checking for MTK_DISP_OVL_ADAPTOR, call the already provided
> mtk_ovl_adaptor_is_comp_present() function to check for this type
> of component.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_ddp_comp.c | 46 ++++++++++++++-----------
>  drivers/gpu/drm/mediatek/mtk_ddp_comp.h |  1 +
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c  | 16 ++-------
>  3 files changed, 29 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c b/drivers/gpu/drm/me=
diatek/mtk_ddp_comp.c
> index 2ba2123238b3..a9c3e29fb340 100644
> --- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c

[snip]

> @@ -700,26 +720,12 @@ int mtk_ddp_comp_init(struct device *dev, struct de=
vice_node *node,
>         if (ret)
>                 return ret;
>
> -       if (type =3D=3D MTK_DISP_AAL ||
> -           type =3D=3D MTK_DISP_BLS ||
> -           type =3D=3D MTK_DISP_CCORR ||
> -           type =3D=3D MTK_DISP_COLOR ||
> -           type =3D=3D MTK_DISP_DSC ||
> -           type =3D=3D MTK_DISP_GAMMA ||
> -           type =3D=3D MTK_DISP_MERGE ||
> -           type =3D=3D MTK_DISP_OVL ||
> -           type =3D=3D MTK_DISP_OVL_2L ||
> -           type =3D=3D MTK_DISP_PWM ||
> -           type =3D=3D MTK_DISP_RDMA ||
> -           type =3D=3D MTK_DISP_WDMA ||
> -           type =3D=3D MTK_DISP_DPI ||
> -           type =3D=3D MTK_DISP_DP_INTF ||
> -           type =3D=3D MTK_DISP_DSI)
> -               goto end;
> -
> -       ret =3D mtk_ddp_comp_init_internal_comp(dev, comp->dev);
> -       if (ret)
> -               return ret;
> +       /* If there's no external driver for this component, allocate and=
 init now */
> +       if (mtk_ddp_comp_is_internal_comp(type) || mtk_ddp_comp_is_backli=
ght_comp(type)) {

If I understand this correctly, MTK_DISP_BLS and MTK_DISP_PWM are
bound by the standalone pwm-mtk-disp driver. Initializing them as
internal components requests the same exclusive MMIO region and fails
with -EBUSY on whichever driver probes second.

Drop `mtk_ddp_comp_is_backlight_comp()` here so backlight nodes skip
internal init as before.

> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index e956e1966b86..18683aee61ff 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -1166,20 +1166,8 @@ static int mtk_drm_probe(struct platform_device *p=
dev)
>                  * blocks have separate component platform drivers and in=
itialize their own
>                  * DDP component structure. The others are initialized he=
re.
>                  */
> -               if (comp_type =3D=3D MTK_DISP_AAL ||
> -                   comp_type =3D=3D MTK_DISP_CCORR ||
> -                   comp_type =3D=3D MTK_DISP_COLOR ||
> -                   comp_type =3D=3D MTK_DISP_DSC ||
> -                   comp_type =3D=3D MTK_DISP_GAMMA ||
> -                   comp_type =3D=3D MTK_DISP_MERGE ||
> -                   comp_type =3D=3D MTK_DISP_OVL ||
> -                   comp_type =3D=3D MTK_DISP_OVL_2L ||
> -                   comp_type =3D=3D MTK_DISP_OVL_ADAPTOR ||
> -                   comp_type =3D=3D MTK_DISP_RDMA ||
> -                   comp_type =3D=3D MTK_DISP_WDMA ||
> -                   comp_type =3D=3D MTK_DISP_DP_INTF ||
> -                   comp_type =3D=3D MTK_DISP_DPI ||
> -                   comp_type =3D=3D MTK_DISP_DSI) {
> +               if (!mtk_ddp_comp_is_internal_comp(comp_type) &&
> +                   !mtk_ovl_adaptor_is_comp_present(node)) {

And here, pwm-mtk-disp isn't a component driver and never registers a
component. Adding a backlight component may prevent the DRM master
from ever binding on SoCs.

Add `!mtk_ddp_comp_is_backlight_comp()` here, and in
`mtk_drm_register_sibling()` in patch 40/46.

Regards,
Fei
