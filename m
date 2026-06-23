Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3C1CDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 13:02:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27F0310EB56;
	Tue, 23 Jun 2026 13:02:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g/5DlOmn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84E3010EB47
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 13:02:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 416CE41E61;
 Tue, 23 Jun 2026 13:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064881F000E9;
 Tue, 23 Jun 2026 13:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782219741;
 bh=vnbGol1v7ynRPoMVGuTvcKz3YjhojcCH3nDLjBHVLhU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=g/5DlOmnX2FhMgIooFuXcZuRA6KNBWSARpNZQKS/vp3b0ISzadDIalvgBM2e13AH5
 FEe6sqLchk+VeA7P44f4dFS2lniviziLLK3HiNDQD/NbLiTGPx9w5TkND+fk9Ht2nY
 QybYozL24xw0SJn6u9Zzx9uzROzae0kJoGmDdoXtPCk/FizzncPWPIrlZlFNVy5oZd
 sNVhinJks5i3Q1auLPBDVJoT9+CyXjxydobF8J3xsdxTiEZVQHon+wobJketK8/S6U
 HYEwAL0yjvEeA6nnvHn4bza/n30IWralzgQCelICgPGaU72TAZjQ7C8WizhfCpsOSF
 mHaAZ5SMYzmsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/exynos: Remove dependency on DRM simple helpers
To: "Diogo Silva" <diogompaissilva@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260623-exynos-drm-simple-v1-1-bb52f098b1ee@gmail.com>
References: <20260623-exynos-drm-simple-v1-0-bb52f098b1ee@gmail.com>
 <20260623-exynos-drm-simple-v1-1-bb52f098b1ee@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 13:02:20 +0000
Message-Id: <20260623130221.064881F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Syntax error due to double ampersand (`&&`) instead of single amper=
sand (`&`) in `drm_encoder_init` call.

Pre-existing issues:
- [Critical] DRM encoder objects are allocated using `devm_kzalloc()`, whic=
h ties their lifetime to the physical device rather than the DRM object ref=
erence count.
--

commit 5be41232e9cf54bf4af0459074670bd80664b354
Author: Diogo Silva <diogompaissilva@gmail.com>

drm/exynos: Remove dependency on DRM simple helpers

Simple KMS helper are deprecated since they only add an intermediate
layer between drivers and the atomic modesetting.
This patch removes the dependency on drm simple helpers from exynos
DRM drivers.

> diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/=
exynos_dp.c
> index b805403281504..a2095fb434835 100644
> --- a/drivers/gpu/drm/exynos/exynos_dp.c
> +++ b/drivers/gpu/drm/exynos/exynos_dp.c
[ ... ]
> @@ -95,7 +99,8 @@ static int exynos_dp_bind(struct device *dev, struct de=
vice *master, void *data)
> =20
>  	dp->drm_dev =3D drm_dev;
> =20
> -	drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_TMDS);
> +	drm_encoder_init(drm_dev, encoder, &exynos_dp_encoder_funcs,
> +			 DRM_MODE_ENCODER_TMDS, NULL);

[Severity: Critical]
This is a pre-existing issue, but does tying the DRM encoder object lifetime
to the physical device cause a use-after-free on unbind?

Looking at exynos_dp_probe() in drivers/gpu/drm/exynos/exynos_dp.c:

  dp =3D devm_kzalloc(&pdev->dev, sizeof(struct exynos_dp_device), GFP_KERN=
EL);

If a userspace program holds an open file descriptor to the DRM device, the
DRM subsystem holds a reference to the encoder even after the physical devi=
ce
is unbound. When devres frees the memory on unbind, the subsequent
drm_mode_config_cleanup() will access freed memory when it calls the encode=
r's
destroy function.

This devm_kzalloc() pattern is also present in:
- drivers/gpu/drm/exynos/exynos_drm_dpi.c:exynos_dpi_probe()
- drivers/gpu/drm/exynos/exynos_drm_dsi.c:exynos_dsi_register_host()
- drivers/gpu/drm/exynos/exynos_drm_vidi.c:vidi_probe()
- drivers/gpu/drm/exynos/exynos_hdmi.c:hdmi_probe()

[ ... ]
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/e=
xynos/exynos_drm_vidi.c
> index 67bbf9b8bc0ef..b0f3cfc2a2830 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
[ ... ]
> @@ -445,7 +449,8 @@ static int vidi_bind(struct device *dev, struct devic=
e *master, void *data)
>  		return PTR_ERR(ctx->crtc);
>  	}
> =20
> -	drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_TMDS);
> +	drm_encoder_init(drm_dev, encoder, &&exynos_vidi_encoder_funcs,
> +			 DRM_MODE_ENCODER_TMDS, NULL);

[Severity: Low]
Will this compile successfully?

The double ampersand (&&) in vidi_bind() is a GCC extension for taking the
address of a label, but exynos_vidi_encoder_funcs is a struct variable. This
causes a 'label used but not defined' build failure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623-exynos-drm=
-simple-v1-0-bb52f098b1ee@gmail.com?part=3D1
