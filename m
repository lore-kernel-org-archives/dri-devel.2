Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEF7606A6D5
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nfLL7mCc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7B1710E11D;
	Fri, 20 Nov 2026 20:15:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92FEF10E319
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 20:15:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 39C8641802;
 Fri, 20 Nov 2026 20:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80021F000CA;
 Fri, 20 Nov 2026 20:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795205745;
 bh=M4FGIjX9xLX/rASQ3+LLYN4G+LPmSUFHiQryAmX7Ezc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nfLL7mCcowE0DVMTJ0ufTDf6ZnLLCnwB4mlR08IRMQnzP1qodTjYIUVrE0z/LL4sq
 /9PbnVMjWxi24oFmp1urgzUlHTtxFqsMXl2XJG9M5J4mH9ojajyQY7KZhhvhbteuke
 OwhqU6GNf1lUHZGUFoIHWsuLCexZ2uchhiL6a02vWj2NUnlhZyHH1YYXUGMEubP7Dc
 i0XaphIBda4scADbZ0mB/H+bhUp5S0sEw8PO3XNuTIl3V4RI7OcTxA/4X+MutwRsi9
 V6JwBuI5N6x79vJ4AohV1H5SKNzo7t59GosQ9lEemAs1DqnrQwJcKFlFpm5zY1fICv
 8vOMp1o0OyVBA==
Message-ID: <sashiko-outbox-226021@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/mediatek: ovl: Report coverage blending on older SoCs
To: "Ryan Brue" <ryanbrue.dev@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261120-rbrue-suez-mtk-ovl-coverage-v1-1-35040085fc37@gmail.com>
References: <20261120-rbrue-suez-mtk-ovl-coverage-v1-1-35040085fc37@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 20:15:45 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/mediatek: ovl: mtk_ovl_layer_config() sets OVL_CON_AEN on
  XRGB formats
--

commit ecc63cbd272ca62ff2a9d686e47d8eb659dfe660
Author: Ryan Brue <ryanbrue.dev@gmail.com>

drm/mediatek: ovl: Report coverage blending on older SoCs

This commit sets .blend_modes =3D BIT(DRM_MODE_BLEND_COVERAGE) on MT2701,
MT8167, MT8173, and MT8183 OVL driver data to eliminate the DRM plane
init warning when exposing alpha formats without a blend mode property.

> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/me=
diatek/mtk_disp_ovl.c
> index 5445870716f94..81a4143f294d5 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c

[ ... ]

> @@ -667,6 +663,7 @@ static const struct mtk_disp_ovl_data mt2701_ovl_driv=
er_data =3D {
>  	.gmc_bits =3D 8,
>  	.layer_nr =3D 4,
>  	.fmt_rgb565_is_0 =3D false,
> +	.blend_modes =3D BIT(DRM_MODE_BLEND_COVERAGE),
>  	.formats =3D mt8173_formats,
>  	.num_formats =3D ARRAY_SIZE(mt8173_formats),
>  };
> @@ -677,6 +674,7 @@ static const struct mtk_disp_ovl_data mt8167_ovl_driv=
er_data =3D {
>  	.layer_nr =3D 4,
>  	.fmt_rgb565_is_0 =3D true,
>  	.smi_id_en =3D true,
> +	.blend_modes =3D BIT(DRM_MODE_BLEND_COVERAGE),
>  	.formats =3D mt8173_formats,
>  	.num_formats =3D ARRAY_SIZE(mt8173_formats),
>  };
> @@ -686,6 +684,7 @@ static const struct mtk_disp_ovl_data mt8173_ovl_driv=
er_data =3D {
>  	.gmc_bits =3D 8,
>  	.layer_nr =3D 4,
>  	.fmt_rgb565_is_0 =3D true,
> +	.blend_modes =3D BIT(DRM_MODE_BLEND_COVERAGE),
>  	.formats =3D mt8173_formats,
>  	.num_formats =3D ARRAY_SIZE(mt8173_formats),
>  };
> @@ -695,6 +694,7 @@ static const struct mtk_disp_ovl_data mt8183_ovl_driv=
er_data =3D {
>  	.gmc_bits =3D 10,
>  	.layer_nr =3D 4,
>  	.fmt_rgb565_is_0 =3D true,
> +	.blend_modes =3D BIT(DRM_MODE_BLEND_COVERAGE),
>  	.formats =3D mt8173_formats,
>  	.num_formats =3D ARRAY_SIZE(mt8173_formats),
>  };
> @@ -704,6 +704,7 @@ static const struct mtk_disp_ovl_data mt8183_ovl_2l_d=
river_data =3D {
>  	.gmc_bits =3D 10,
>  	.layer_nr =3D 2,
>  	.fmt_rgb565_is_0 =3D true,
> +	.blend_modes =3D BIT(DRM_MODE_BLEND_COVERAGE),
>  	.formats =3D mt8173_formats,
>  	.num_formats =3D ARRAY_SIZE(mt8173_formats),
>  };

[Severity: High]
Does advertising BIT(DRM_MODE_BLEND_COVERAGE) on these SoCs cause
mtk_ovl_layer_config() to set OVL_CON_AEN on opaque formats such as
DRM_FORMAT_XRGB8888?

DRM_MODE_BLEND_PREMULTI is 0 while DRM_MODE_BLEND_COVERAGE is 1.  When
.blend_modes was 0, state->base.pixel_blend_mode stayed at 0, so
mtk_ovl_layer_config() only set OVL_CON_AEN when has_alpha was true:

drivers/gpu/drm/mediatek/mtk_disp_ovl.c:mtk_ovl_layer_config() {
    ...
	unsigned int blend_mode =3D state->base.pixel_blend_mode;
    ...
		if (blend_mode || state->base.fb->format->has_alpha)
			con |=3D OVL_CON_AEN;
    ...
}

With state->base.pixel_blend_mode now initialized to
DRM_MODE_BLEND_COVERAGE (1), blend_mode is non-zero and OVL_CON_AEN is
always set.  Because these older OVL blocks map XRGB8888 to
OVL_CON_CLRFMT_ARGB8888 and do not support OVL_CONST_BLEND, enabling
OVL_CON_AEN makes the hardware read the X byte from memory as per-pixel
alpha, reintroducing the XRGB scanout regression fixed by 995d4d558eea
("drm/mediatek: ovl: Fix XRGB format breakage for blend_modes unsupported
SoCs").

Checking whether ovl->data->blend_modes includes
BIT(DRM_MODE_BLEND_PIXEL_NONE) instead of testing blend_mode as a boolean
would preserve OVL_CON_AEN behavior on coverage-only SoCs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-rbrue-suez=
-mtk-ovl-coverage-v1-1-35040085fc37@gmail.com?part=3D1
