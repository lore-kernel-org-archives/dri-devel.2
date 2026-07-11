Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464A0C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 23:48:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 579BA10E354;
	Sat, 11 Jul 2026 23:48:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DapoH1C8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D5EA10E354
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 23:48:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E272C42E58;
 Sat, 11 Jul 2026 23:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACFD1F000E9;
 Sat, 11 Jul 2026 23:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783813722;
 bh=iR0jMN6veAMC8iKgWIuc3RK9FxZwjvkazBFJHvxpS3s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DapoH1C8NxWbjsUe5Wrk6GsgiSNBfR8pDJcd7Ty8sWcgZlvnGvlrTyy5517tLOpc0
 BC8l3E/HWA76ETXnJZ8HRssGVo8mVGWBxqzJgcdu8oJ1ysKVS1YAcCcnZWVDRKLXqh
 4r+NIcpHWU/LMw6LS/EpMuPcqA8HuDJiNP94JhhPF5Cc8NBL3m7fkdJgw2pTD+XuUk
 exmiDsEFul8Q9R/RUAqklIjqkQIIf05sygBv/YZjQJf5xqwCgr1rdoBbutVkzPwqZv
 j/Z3IQnrmOwav7S7UCz3QR0QEKIeltVQxyhRghTHH2Q0yUV33garEPmIlKln3Roc1Q
 45h3GbxrK/xWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/panel: fix unmet dependency bug for
 DRM_PANEL_HIMAX_HX83121A
To: "Julian Braha" <julianbraha@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260711234230.2236041-1-julianbraha@gmail.com>
References: <20260711234230.2236041-1-julianbraha@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 23:48:42 +0000
Message-Id: <20260711234842.9ACFD1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Medium] The commit fixes an unmet dependency warning for `DRM_PANEL_HIMA=
X_HX83121A` by adding `select DRM_DISPLAY_HELPER`, but fails to apply the s=
ame fix to `DRM_PANEL_ILITEK_ILI9882T` and `DRM_PANEL_SAMSUNG_S6E3HA8`. Bot=
h of these configs also select `DRM_DISPLAY_DSC_HELPER` without selecting i=
ts dependency `DRM_DISPLAY_HELPER`. Notably, `DRM_PANEL_ILITEK_ILI9882T` is=
 explicitly listed in the Kconfig warning output cited in the commit messag=
e itself.
--

--- Patch [1]: [PATCH] drm/panel: fix unmet dependency bug for DRM_PANEL_HI=
MAX_HX83121A ---
commit 0826a9c22686833fa118df0f402fe8308a98fa6d
Author: Julian Braha <julianbraha@gmail.com>

drm/panel: fix unmet dependency bug for DRM_PANEL_HIMAX_HX83121A

This commit fixes an unmet dependency warning for DRM_PANEL_HIMAX_HX83121A
by selecting DRM_DISPLAY_HELPER. It addresses a warning where
DRM_DISPLAY_DSC_HELPER was selected without its dependencies being met.

>     WARNING: unmet direct dependencies detected for DRM_DISPLAY_DSC_HELPER
>       Depends on [n]: HAS_IOMEM [=3Dy] && DRM [=3Dm] && DRM_DISPLAY_HELPE=
R [=3Dn]
>       Selected by [m]:
>       - DRM_PANEL_HIMAX_HX83121A [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm]=
 && DRM_PANEL [=3Dy] && OF [=3Dy] && DRM_MIPI_DSI [=3Dy] && BACKLIGHT_CLASS=
_DEVICE [=3Dm]
>       - DRM_PANEL_ILITEK_ILI9882T [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm=
] && DRM_PANEL [=3Dy] && OF [=3Dy] && DRM_MIPI_DSI [=3Dy] && BACKLIGHT_CLAS=
S_DEVICE [=3Dm]

[Severity: Medium]
This is a pre-existing issue, but should this patch also add the select=20
DRM_DISPLAY_HELPER statement for DRM_PANEL_ILITEK_ILI9882T?

The warning message above indicates that DRM_PANEL_ILITEK_ILI9882T suffers
from the exact same unmet dependency.

Additionally, looking at drivers/gpu/drm/panel/Kconfig, it appears
DRM_PANEL_SAMSUNG_S6E3HA8 has the same issue:

config DRM_PANEL_SAMSUNG_S6E3HA8
	tristate "Samsung S6E3HA8 DSI video mode panel"
	...
	select DRM_DISPLAY_DSC_HELPER

Could we apply the same fix to both of these Kconfig options to completely
resolve the unmet dependency warnings across the panel drivers?

> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index cfbfb371bc67e..06bfcef35a72e 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -253,6 +253,7 @@ config DRM_PANEL_HIMAX_HX83121A
>  	depends on OF
>  	depends on DRM_MIPI_DSI
>  	depends on BACKLIGHT_CLASS_DEVICE
> +	select DRM_DISPLAY_HELPER
>  	select DRM_DISPLAY_DSC_HELPER
>  	select DRM_KMS_HELPER
>  	help

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711234230.2236=
041-1-julianbraha@gmail.com?part=3D1
