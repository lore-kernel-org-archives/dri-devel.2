Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C4ECA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AA5110E170;
	Thu,  1 Oct 2026 13:47:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F+1DAjwp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6BF510E170
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 13:47:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A302E409D2;
 Thu,  1 Oct 2026 13:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EF61F00898;
 Thu,  1 Oct 2026 13:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790862434;
 bh=ibcALN1EJ+0KVwiY3CBUoc5+FfG4Mql04yoa427V1C8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F+1DAjwpN93i6Ep4fk1F+3fMBiA3nGamRj+KV5fFyp910Aq/7xmcsF9JiOcGtr6hO
 AKzBcZEmmw9Tv9CHnRKVmnGZVSqMh1gWTUbSPhH/NU+xTurCRSjDh8pthUuG6NKpWG
 MG34mOx6fxZsM5QkAK7ufbJq+3shqw0LW/9JsjnAEym7FSplKkS7KNih96zLPU09P+
 qa7ZX5vPaB+NWGsVOjzTOy2rkVsiQiSwWZWKJrJwMu+RT+zxQtisR60t3qbDBMhE1Q
 415Z5HOw2KxQ3ZSOZ4XM1p/StMNzRO9mezfDrZyT/wi4hEW6+hPXCEavdcqmymZ63m
 zEzkVvnQIkWrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/kms-helper: Remove struct
 drm_simple_display_pipe and helpers
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261001133736.802604-3-tzimmermann@suse.de>
References: <20261001133736.802604-1-tzimmermann@suse.de>
 <20261001133736.802604-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 13:47:14 +0000
Message-Id: <20261001134714.67EF61F00898@smtp.kernel.org>
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
- [Low] drm/kms-helper: build breakage in imx-lcdc due to removed drm_simpl=
e_display_pipe
- [Low] doc: spelling mistake introduced in fbtft/TODO
--

commit d4d7a38057f45dc5b1cce9536154c93423caeae1
Author: Thomas Zimmermann <tzimmermann@suse.de>
Subject: drm/kms-helper: Remove struct drm_simple_display_pipe and helpers

This commit removes the struct drm_simple_display_pipe data type and its
associated helper functions from the DRM subsystem. It cleans up the
remaining TODO items related to simple-pipe, under the premise that all
drivers have been updated to use regular atomic helpers.

>     There are no drivers using struct drm_simple_display_pipe. Remove
>     the data type and all related helpers.

[Severity: Low]
Is this description accurate?

The imx-lcdc driver appears to still use struct drm_simple_display_pipe and
its helper functions. Compiling with CONFIG_DRM_IMX_LCDC enabled will result
in a build failure because the driver still relies on this structure in its
device setup:

drivers/gpu/drm/imx/lcdc/imx-lcdc.c:imx_lcdc() {
	...
	struct drm_simple_display_pipe pipe;
	...
}

As well as during initialization:

drivers/gpu/drm/imx/lcdc/imx-lcdc.c:imx_lcdc_probe() {
	...
	ret =3D drm_simple_display_pipe_init(drm, &lcdc->pipe,
					   &imx_lcdc_pipe_funcs,
					   imx_lcdc_formats,
					   ARRAY_SIZE(imx_lcdc_formats), NULL, NULL);
	...
}

> diff --git a/drivers/staging/fbtft/TODO b/drivers/staging/fbtft/TODO
> index e72a08bf221cf..72df3ea3a52ce 100644
> --- a/drivers/staging/fbtft/TODO
> +++ b/drivers/staging/fbtft/TODO
> @@ -1,3 +1,3 @@
> -* convert all these over to drm_simple_display_pipe and submit for inclu=
sion
> -  into the DRM subsystem under drivers/gpu/drm - fbdev doesn't take any =
new
> -  drivers anymore.
> +* convert all these over to DRM and submit thme for inclusion into
                                              ^^^^

[Severity: Low]
This isn't a bug, but there is a typo here (thme instead of them).

> +  the DRM subsystem under drivers/gpu/drm - fbdev doesn't take any
> +  new drivers anymore.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001133736.8026=
04-1-tzimmermann@suse.de?part=3D2
