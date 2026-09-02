Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9363CC61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:12:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD89F10E20C;
	Wed,  2 Sep 2026 10:12:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QLwlu1ic";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B82FD10E20C
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 10:12:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F1DBF600D1;
 Wed,  2 Sep 2026 10:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3941F000E9;
 Wed,  2 Sep 2026 10:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788343969;
 bh=eFlamcdT7qZnGpbajHaU0WzsXW0rzTfDJ7w83lle1j0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QLwlu1icsrFJmvre3x4xdM/eBEBJAGkU34/dNbUMdxxqJscwT7PnVACVFtCLJYUkB
 HNoIxI/vw91bXjmJgBRBfgaxDoTc1nbgRvq0Gtuaemrmivgn2wKmiHb9xto+uu/ism
 G0a+48g3XXW4x10cxlTCeofqN1h4m7mkCnZV/9WB761byq6s0n5LUAw8M31DhdvJ7t
 PRVDk2z6Jhxdv1LaAlGEfXe/Y2xGeC7TsDW0DZsP+WdE9LCLHWQ2Olk7CsXgjXHFs7
 7qR6x2QzELCEeBMdc9ndYx7RyT//mdKfaPcxE0v+eatyBRM2c0kBhCsOc5L5ubGcAO
 G0u9OjnUqAk7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/gma500: Create the primary plane in the driver
To: oushixiong1025@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260902100427.622166-1-oushixiong1025@163.com>
References: <20260902100427.622166-1-oushixiong1025@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 10:12:49 +0000
Message-Id: <20260902101249.8A3941F000E9@smtp.kernel.org>
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
- [Medium] Missing `kfree(gma_crtc)` in the error handling path for `drm_cr=
tc_init_with_planes()` causes a memory leak.
--

commit 3a480bbcb082382b05d96a88db66494d625ba890
Author: Shixiong Ou <oushixiong@kylinos.cn>

drm/gma500: Create the primary plane in the driver

This commit replaces drm_crtc_init() with a driver-owned primary plane
that advertises only XRGB8888, preventing a warning about unsupported
per-pixel alpha formats.

> diff --git a/drivers/gpu/drm/gma500/psb_intel_display.c b/drivers/gpu/drm=
/gma500/psb_intel_display.c
> --- a/drivers/gpu/drm/gma500/psb_intel_display.c
> +++ b/drivers/gpu/drm/gma500/psb_intel_display.c

[ ... ]

> @@ -494,7 +510,27 @@ void psb_intel_crtc_init(struct drm_device *dev, int=
 pipe,
>  		return;
>  	}
> =20
> -	drm_crtc_init(dev, &gma_crtc->base, &gma_crtc_funcs);
> +	primary =3D __drm_universal_plane_alloc(dev, sizeof(*primary), 0, 0,
> +					      &gma_primary_plane_funcs,
> +					      gma_primary_formats,
> +					      ARRAY_SIZE(gma_primary_formats),
> +					      NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
> +	if (IS_ERR(primary)) {
> +		dev_err(dev->dev, "Failed to allocate primary plane: %pe\n",
> +			primary);
> +		kfree(gma_crtc->crtc_state);
> +		kfree(gma_crtc);
> +		return;
> +	}
> +
> +	if (drm_crtc_init_with_planes(dev, &gma_crtc->base, primary, NULL,
> +				      &gma_crtc_funcs, NULL)) {
> +		dev_err(dev->dev, "Failed to init CRTC %d\n", pipe);
> +		drm_plane_cleanup(primary);
> +		kfree(primary);
> +		kfree(gma_crtc->crtc_state);

[Severity: Medium]
Does this error path leak the gma_crtc structure?

The gma_crtc structure is allocated via kzalloc() at the beginning of
psb_intel_crtc_init(). While the primary plane allocation error path
above correctly cleans it up, this error path appears to be missing a
kfree(gma_crtc) before returning.

> +		return;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902100427.6221=
66-1-oushixiong1025@163.com?part=3D1
