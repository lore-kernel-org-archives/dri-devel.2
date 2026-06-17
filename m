Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA2DCD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 08:25:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8EF210EEB7;
	Wed, 17 Jun 2026 08:25:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bTY8aL9b";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C60610EEB7
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:25:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CF751434A7;
 Wed, 17 Jun 2026 08:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0291F00A3A;
 Wed, 17 Jun 2026 08:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781684724;
 bh=Oerw3gfrqx1elTzbTzXFQ74prbxIcESetH/z5NcYpxw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bTY8aL9bYmaUR7klfs7bNSRpdNCoZoRvgtqwMS0KQhrk/NdGLaD959zcQNBAUJunm
 HukPMqUKmIlkisoNQWelbBcMc42CTpeAxaq0OHqzeEc9HXm6Xyzp0yQdr1zAxZDPjO
 vcm13UNPV2BKcpEPSTnJJ7NIimGUPUvsv6qjpyc30PP8ES+7FKcpjE1gDnXbBIF0e6
 CbQXOfYLLrfpSLqV/d3Nni4oSOilbiZf1kqZxTw4MiwlG2UHzVLxaa+Uykf2hr+P8t
 oaZzTzD4dswr7JT/cOJzMGAiXXtqgw666VRd236FwshKb4awAVb8VCGgxY7KLDi8oR
 99LLsnyUaR6HA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] firmware: sysfb: Mark CONFIG_SYSFB_SIMPLEFB as deprecated
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260617081810.218168-1-tzimmermann@suse.de>
References: <20260617081810.218168-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 08:25:24 +0000
Message-Id: <20260617082524.8C0291F00A3A@smtp.kernel.org>
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
- [Medium] The updated help text for `SYSFB_SIMPLEFB` incorrectly claims th=
at `efidrm` and `vesadrm` can act as fallbacks when `SYSFB_SIMPLEFB` is ena=
bled.
- [Medium] Incomplete deprecation leads to conflicting Kconfig instructions=
 for `SYSFB_SIMPLEFB` and `DRM_SIMPLEDRM`.
--

commit 5ea287d9e1ed6b65c8ad4f43e0319a4e41d57b15
Author: Thomas Zimmermann <tzimmermann@suse.de>

firmware: sysfb: Mark CONFIG_SYSFB_SIMPLEFB as deprecated
   =20
This commit marks CONFIG_SYSFB_SIMPLEFB as deprecated. Enabling it allows
to run simpledrm and simplefb on EFI/VESA framebuffers, which is now
discouraged in favor of using efidrm and vesadrm.

> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 12dc70254842c..dea907178e4ad 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -187,32 +187,23 @@ config SYSFB
>  	select SCREEN_INFO
> =20
>  config SYSFB_SIMPLEFB
> -	bool "Mark VGA/VBE/EFI FB as generic system framebuffer"
> +	bool "Mark VGA/VBE/EFI FB as generic system framebuffer (deprecated)"
>  	depends on X86 || EFI
>  	select SYSFB
>  	help

[ ... ]

> +	  This option, if enabled, marks VBE/EFI framebuffers as system
> +	  framebuffers so the generic simpledrm driver can be used. If the
> +	  framebuffer is not compatible with the generic modes, it is
> +	  advertised as fallback platform framebuffer so regular drivers like
> +	  efidrm, vesadrm can pick it up.

[Severity: Medium]
Is this fallback behavior accurate for efidrm and vesadrm?

Looking at DRM_EFIDRM in drivers/gpu/drm/sysfb/Kconfig, it has a mutual
exclusion dependency:

config DRM_EFIDRM
    depends on DRM && MMU && EFI && (!SYSFB_SIMPLEFB || COMPILE_TEST)

Since both DRM_EFIDRM and DRM_VESADRM depend on !SYSFB_SIMPLEFB, it appears
they cannot be enabled alongside SYSFB_SIMPLEFB in a standard build to act
as fallbacks.

> +
> +	  This option is deprecated and will be removed in the near future. If
> +	  unsure, say N and select efidrm, vesadrm instead. The dedicated DRM
> +	  drivers provide the same functionality plus additional features.

[Severity: Medium]
Does the DRM_SIMPLEDRM documentation also need an update to resolve a
conflict with this deprecation?

While this instructs users to say N to SYSFB_SIMPLEFB, the help text for
DRM_SIMPLEDRM in drivers/gpu/drm/sysfb/Kconfig still explicitly instructs
users to select it:

config DRM_SIMPLEDRM
    help
      ...
      On x86 BIOS or UEFI systems, you should also select SYSFB_SIMPLEFB
      to use UEFI and VESA framebuffers.

Leaving the DRM_SIMPLEDRM help text unmodified might leave users with
conflicting instructions on how to configure system framebuffers.

> =20
>  config TH1520_AON_PROTOCOL
>  	tristate "Always-On firmware protocol"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617081810.2181=
68-1-tzimmermann@suse.de?part=3D1
