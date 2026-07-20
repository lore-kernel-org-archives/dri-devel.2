Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C7DC44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 16:07:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 149AB10E9CF;
	Mon, 20 Jul 2026 16:07:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VmzVp+RI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 567F010E9D1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 16:07:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AAD9860052;
 Mon, 20 Jul 2026 16:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26491F00A3A;
 Mon, 20 Jul 2026 16:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784563646;
 bh=JF6x3v05IF6JcSqACDd1Ioo37Y1aQR5NcKaWwtQBaB4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VmzVp+RI15t4zvpJkkWoY9d5TgC9d8RG2zYDlPpM2oK3npFP9nwgV3cXY+pke5mmq
 vFo+jBvr17XZC09CRsqIaj2HYL30DebOdI7t48fRQQUFtvhdG6nDh24Ty1n+2cRYxM
 /PyZnH7vNUnhJk0Gndyq94EpLFthhgQKiXWcEi0i2AQHeDzJSG7Dmld5uZGfUuFMQp
 Du66Ttodx3dFesyvQ9GGRB0rkVaAz4NtLZIqmd4ZJfTYLDOPp+NuPK7XdiSU5awLT5
 rKOmXx6cKBoL2RMl3f5NDn2TFhpMF8yRvGaMFI0tAURRhEicgYGSwpQpvbQh23OgkV
 Beycik5fCTH2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/15] Documentation/gpu: remove completed
 drm_simple_encoder_init() todo
To: "Diogo Silva" <diogompaissilva@gmail.com>
Cc: linux-amlogic@lists.infradead.org, Frank.Li@kernel.org,
 neil.armstrong@linaro.org, wsa+renesas@sang-engineering.com,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev
In-Reply-To: <20260720-drm_simple_encoder_init-v2-15-5020b630668a@gmail.com>
References: <20260720-drm_simple_encoder_init-v2-0-5020b630668a@gmail.com>
 <20260720-drm_simple_encoder_init-v2-15-5020b630668a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 16:07:25 +0000
Message-Id: <20260720160725.F26491F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incomplete refactoring causes build failure in the gma500 driver du=
e to unconverted usages of `drm_simple_encoder_init()`.
--

--- Patch [15]: [PATCH v2 15/15] Documentation/gpu: remove completed drm_si=
mple_encoder_init() todo ---
commit ecefbc42ff1cbd0e228a1785c066cd3cab8deafc
Author: Diogo Silva <diogompaissilva@gmail.com>

Documentation/gpu: remove completed drm_simple_encoder_init() todo

All drm_simple_encoder_init() users have been removed, so drop the
completed todo item.

> diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
> index 14cf37590fc7e..b7351467dc74c 100644
> --- a/Documentation/gpu/todo.rst
> +++ b/Documentation/gpu/todo.rst
> @@ -29,21 +29,6 @@ refactorings already and are an expert in the specific=
 area
>  Subsystem-wide refactorings
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> =20
> -Open-code drm_simple_encoder_init()
> ------------------------------------
> -
> -The helper drm_simple_encoder_init() was supposed to simplify encoder
> -initialization. Instead it only added an intermediate layer between atom=
ic
> -modesetting and the DRM driver.
> -
> -The task here is to remove drm_simple_encoder_init(). Search for a driver

[Severity: Low]
Are there still remaining users of drm_simple_encoder_init() in the tree?

Looking at the gma500 driver, it appears there are several unconverted calls
remaining, such as in drivers/gpu/drm/gma500/cdv_intel_crt.c:

cdv_intel_crt_init() {
    ...
    ret =3D drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_DAC);
    ...
}

There also seem to be similar calls in cdv_intel_dp.c, cdv_intel_hdmi.c,
cdv_intel_lvds.c, oaktrail_hdmi.c, oaktrail_lvds.c, and psb_intel_lvds.c.

Will this cause a build failure when compiling with CONFIG_DRM_GMA500 if the
underlying function is removed before these are converted?

> -that calls drm_simple_encoder_init() and inline the helper. The driver w=
ill
> -also need its own instance of drm_encoder_funcs.
> -
> -Contact: Thomas Zimmermann, respective driver maintainer
> -
> -Level: Easy
> -
>  Replace struct drm_simple_display_pipe with regular atomic helpers
>  ------------------------------------------------------------------

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-drm_simple=
_encoder_init-v2-0-5020b630668a@gmail.com?part=3D15
