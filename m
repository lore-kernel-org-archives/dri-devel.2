Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BF3C5AC80
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 08:50:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74BB610E10B;
	Sun,  9 Aug 2026 08:50:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J2X17oR5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E11D10E10B
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 08:50:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8E4E440517;
 Sun,  9 Aug 2026 08:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4792C1F000E9;
 Sun,  9 Aug 2026 08:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786265427;
 bh=Y25WcIyB0JY//OBnDkJ5/PAmkOpdtEA6d1hh8r2LkW8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J2X17oR53pD+x0PwEerTU2ahNkFSOyBM5fTSl3e8OOMQtRQSbX0o3xdh7JlEPMD8V
 ux/8dQVC5Iay6DiASR3BvkiCyKo/rKWoeLLL5n9LoLgDb6JSjHMhzTOFDXob2Giq95
 LHsPhNc5oWD9fi0HSGTA8LEmNdu0ZX1IuesVchdUS2tjY5QD8F3AQLDRqtdk6GFZFB
 hJtV76mer0A34hv82HYp94DGTj/Bo4x5u0wU6nwRNPu5fKNQtda89YCyePqmwI+X/l
 RySW2ioOYYcBCge8aUy9G4VsQv8ZeqiRKSigBa7e4cGi+Vz3yoe9fnYBvMBgEp1SpU
 +Rn+jzFOvYAtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] drm/exynos: remove simplefb nodes before init
To: "Kaustabh Chakraborty" <kauschluss@disroot.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260809-exynos-dsim-fixes-v4-3-ca67c51e61b7@disroot.org>
References: <20260809-exynos-dsim-fixes-v4-0-ca67c51e61b7@disroot.org>
 <20260809-exynos-dsim-fixes-v4-3-ca67c51e61b7@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 08:50:26 +0000
Message-Id: <20260809085027.4792C1F000E9@smtp.kernel.org>
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
- [Medium] Incorrect error handling path for aperture_remove_all_conflictin=
g_devices() triggers WARN_ON() storms by attempting to unbind unbound compo=
nents.

Pre-existing issues:
- [Medium] The setup loop for `possible_clones` iterates over an empty `enc=
oder_list` because encoders are not registered until sub-components are bou=
nd.
--

--- Patch [3]: [PATCH v4 3/3] drm/exynos: remove simplefb nodes before init=
 ---
commit 9e7932152628258cc8174577476729d0609085e6
Author: Kaustabh Chakraborty <kauschluss@disroot.org>

drm/exynos: remove simplefb nodes before init

This commit uses aperture_remove_all_conflicting_devices() to remove
simple-framebuffer devices before initializing the DSI and FIMD/DECON stack.
This ensures memory regions do not overlap during display transitions.

> diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/ex=
ynos/exynos_drm_drv.c
> index 9ee30086879f9..e05e520449edc 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
[ ... ]
> @@ -268,6 +269,11 @@ static int exynos_drm_bind(struct device *dev)
>  	list_for_each_entry(encoder, &drm->mode_config.encoder_list, head)
>  		encoder->possible_clones =3D clone_mask;
> =20

[Severity: Medium]
This is a pre-existing issue, but does this loop successfully find any
encoders?

In the Exynos DRM architecture, encoders are registered by sub-components
during their bind phase, which is triggered by component_bind_all().
Since this setup block is placed before component_bind_all(), the
encoder_list is always empty, making this dead code and leaving
possible_clones unconfigured for all encoders.

> +	/* Remove existing devices which own the framebuffer memory. */
> +	ret =3D aperture_remove_all_conflicting_devices(exynos_drm_driver.name);
> +	if (ret)
> +		goto err_unbind_all;
                ^^^^

[Severity: Medium]
Will this error path trigger WARN_ON() storms?

If aperture_remove_all_conflicting_devices() fails, the code jumps to
err_unbind_all, which executes component_unbind_all().

Since component_bind_all() has not yet been executed, all matched components
have component->bound =3D=3D false. For each component, component_unbind()
evaluates WARN_ON(!component->bound) and triggers a kernel warning stack
trace.

Could this jump to err_mode_config_cleanup instead, similar to the failure
path for component_bind_all()?

> +
>  	/* Try to bind all sub drivers. */
>  	ret =3D component_bind_all(drm->dev, drm);
>  	if (ret)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809-exynos-dsi=
m-fixes-v4-0-ca67c51e61b7@disroot.org?part=3D3
