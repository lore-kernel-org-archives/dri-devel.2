Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84347C44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 07:00:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D742510E2A1;
	Thu, 16 Jul 2026 07:00:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EkfKr06F";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41B9110E2A1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 07:00:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B53F241652;
 Thu, 16 Jul 2026 07:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780BE1F000E9;
 Thu, 16 Jul 2026 07:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784185207;
 bh=DNtpx61iGVY3zpNxddX53nIaRdyFLi22BRGM6Zoi+II=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EkfKr06F7TO/1qNHAnXmyPPYchFZwqXyJtwgwOsszhFZyUdEofBJ5pKF69iMOFG6C
 NtETPt6/hP5hpEezBTXbVKjYc4Se5GEAGkMWBjyQl1/E7ODXongONM4dTfSAYdZ28/
 LuQ91VAiSD7nr33Z4MU84vBoF22ZVUqUnKcemAvA1za8+1wiSszWTP2gJ7wDkecFfs
 UI2faxWDnTdC44rRtbU+Yy6tzhzycDJiCn93GEJ38WqsnJGGMmubci7wJmpKBoSmff
 cIAPuLwaUCHrix8SvpUB9j/ms1LdlAnsi01LFHhZ4jKjx3Qm1A6fbB5dDNL/dE40t9
 O6p2SYORLgJxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm: make panel orientation quirks optional
To: "Andrew Zhou" <zhoulol888@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260716065106.150760-1-zhoulol888@gmail.com>
References: <20260716065106.150760-1-zhoulol888@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 07:00:06 +0000
Message-Id: <20260716070007.780BE1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Decoupling the module state from the core DRM subsystem causes sil=
ent feature loss when DRM is built-in and the quirk is a module.
- [Medium] Adding `depends on DRM` to `DRM_PANEL_ORIENTATION_QUIRKS` causes=
 Kconfig unmet direct dependency warnings when selected by fbdev drivers.
- [Low] Using `#ifdef` for a tristate config causes compiler redefinition e=
rrors and strips module metadata for loadable module (`=3Dm`) builds.
--

--- Patch [1]: [PATCH] drm: make panel orientation quirks optional ---
commit babf1234e204a4c51ca97865c82a0c78512e71b2
Author: Andrew Zhou <zhoulol888@gmail.com>

drm: make panel orientation quirks optional

This commit removes the unconditional selection of DRM_PANEL_ORIENTATION_QU=
IRKS
from the DRM subsystem. It makes the option user-visible, adds a dependency
on DRM, and provides fallback stubs for when the option is disabled.

> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 323422861e8f6..da4ac94bbf615 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -8,7 +8,6 @@
>  menuconfig DRM
>  	tristate "Direct Rendering Manager (XFree86 4.1.0 and higher DRI suppor=
t)"
>  	depends on (AGP || AGP=3Dn) && !EMULATED_CMPXCHG && HAS_DMA
> -	select DRM_PANEL_ORIENTATION_QUIRKS

[Severity: High]
Does removing this select statement allow the core DRM subsystem to be buil=
t-in
while DRM_PANEL_ORIENTATION_QUIRKS is configured as a module?

If this configuration happens, the built-in DRM core code might evaluate the
preprocessor checks for the quirk module as false, which could cause the pa=
nel
orientation functionality to be silently dropped even though the module is =
built.

>  	select HDMI
> [ ... ]
> @@ -369,4 +368,15 @@ endif
> =20
>  # Separate option because drm_panel_orientation_quirks.c is shared with =
fbdev
>  config DRM_PANEL_ORIENTATION_QUIRKS
> -	tristate
> +	tristate "Panel orientation quirks for DMI-based detection"
> +	depends on DRM

[Severity: Medium]
Can this new dependency cause Kconfig unmet direct dependency warnings?

The FB_EFI config option unconditionally selects DRM_PANEL_ORIENTATION_QUIR=
KS
since it shares this code. If a system is configured with CONFIG_FB_EFI=3Dy=
 and
CONFIG_DRM=3Dn, the selection from the EFI framebuffer could violate this n=
ew
dependency on DRM, causing a Kconfig unmet dependency warning.

> +	help
> [ ... ]
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu=
/drm/drm_panel_orientation_quirks.c
> index 3a218fb592cef..fb09078a831af 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -589,7 +589,7 @@ EXPORT_SYMBOL(drm_get_panel_orientation_quirk);
> =20
>  #else
> =20
> -/* There are no quirks for non x86 devices yet */
> +/* Fallback stub when DMI or the entire quirk module is disabled. */
>  int drm_get_panel_orientation_quirk(int width, int height)
>  {
>  	return DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
> @@ -598,5 +598,7 @@ EXPORT_SYMBOL(drm_get_panel_orientation_quirk);
> =20
>  #endif
> [ ... ]
> diff --git a/include/drm/drm_utils.h b/include/drm/drm_utils.h
> index 6a46f755daba0..947b8e71260e3 100644
> --- a/include/drm/drm_utils.h
> +++ b/include/drm/drm_utils.h
> @@ -11,10 +11,18 @@
>  #define __DRM_UTILS_H__
> =20
>  #include <linux/types.h>
> +#include <drm/drm_connector.h>
> =20
>  struct drm_edid;
> =20
> +#ifdef CONFIG_DRM_PANEL_ORIENTATION_QUIRKS
>  int drm_get_panel_orientation_quirk(int width, int height);
> +#else
> +static inline int drm_get_panel_orientation_quirk(int width, int height)
> +{
> +	return DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
> +}
> +#endif

[Severity: Low]
Does this preprocessor check properly handle tristate module builds?

If CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=3Dm is configured, kbuild defines
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS_MODULE instead. This causes the check
above to evaluate as false, providing the static inline stub in the header.

Meanwhile, drm_panel_orientation_quirks.c evaluates its own matching check =
as
false and defines a non-static fallback stub for the exact same function.
Including this header in that source file could result in a compiler
redefinition error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716065106.1507=
60-1-zhoulol888@gmail.com?part=3D1
