Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1E7C624D4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:30:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B404810E0AA;
	Thu,  3 Sep 2026 07:30:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iniOuM4c";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F02910E09B
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 07:30:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 19CE741273;
 Thu,  3 Sep 2026 07:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DF41F000E9;
 Thu,  3 Sep 2026 07:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788420634;
 bh=yU9EExdERkcxg1QRZ5KGbN16DgdlGuNVXcpOEfS7kLo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iniOuM4c8rZ3giIxwRs7IToPPHmcDlfiSpC06nvvBeNL0kJMoc7d74YfirQ8Jr3WI
 +Th53jdBVIGvMv6u67GvCYg52ahOdIc67+lt7/v2iIbLhWl/P52DGY5uCfoirQ+E0x
 587RwwXVJ0EXEtQ+wLkzeBhijoRnetOrYf+6OJg2fal2b0Ge2TlfzjxBn0wJkfnsSx
 AQyFgyHYQlSt2zHZlIP5uHl0Ky05GK19ws6lhddYlpi2spWgnoeJ55B93zflHy9/8v
 VaZrN4XH4i5MnmWQBET7nbA9dcJxbKdOORmaxhOO88waks0D9whk5HZ0x3K5PVQeOE
 FLNKoCjkQqIzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/gma500: Create the primary plane in the driver
To: oushixiong1025@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260903071149.423579-1-oushixiong1025@163.com>
References: <20260903071149.423579-1-oushixiong1025@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 07:30:33 +0000
Message-Id: <20260903073033.C6DF41F000E9@smtp.kernel.org>
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
- [High] Freeing `gma_crtc` on `drm_crtc_init_with_planes()` failure causes=
 a Use-After-Free because the CRTC remains linked in `dev->mode_config.crtc=
_list`.
--

commit 2d329a448a74770c14b7d09aef862579fa99672e
Author: Shixiong Ou <oushixiong@kylinos.cn>

drm/gma500: Create the primary plane in the driver

drm_crtc_init() creates the primary plane from a fixed format list
that includes ARGB8888. The display engine programs the primary plane
with DISPPLANE_32BPP_NO_ALPHA, so it does not support per-pixel alpha
and must not advertise alpha formats. This commit replaces drm_crtc_init()
with a driver-owned primary plane that advertises only XRGB8888.

> diff --git a/drivers/gpu/drm/gma500/psb_intel_display.c b/drivers/gpu/drm=
/gma500/psb_intel_display.c
> index 0df75a4a77396..f79484b9d593e 100644
> --- a/drivers/gpu/drm/gma500/psb_intel_display.c
> +++ b/drivers/gpu/drm/gma500/psb_intel_display.c
[ ... ]
> @@ -494,7 +511,17 @@ void psb_intel_crtc_init(struct drm_device *dev, int=
 pipe,
>  		return;
>  	}
> =20
> -	drm_crtc_init(dev, &gma_crtc->base, &gma_crtc_funcs);
> +	primary =3D drmm_universal_plane_alloc(dev, struct drm_plane, dev, 0,
> +					     &gma_primary_plane_funcs,
> +					     gma_primary_formats,
> +					     ARRAY_SIZE(gma_primary_formats),
> +					     NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
> +	if (IS_ERR(primary))
> +		goto err_free_crtc;
> +
> +	if (drm_crtc_init_with_planes(dev, &gma_crtc->base, primary, NULL,
> +				      &gma_crtc_funcs, NULL))
> +		goto err_free_crtc;

[Severity: High]
Could this error handling path leave a freed pointer linked in the DRM core?

Looking at __drm_crtc_init_with_planes(), the CRTC is added to the list ear=
ly
in the function:

	list_add_tail(&crtc->head, &config->crtc_list);
	crtc->index =3D config->num_crtc++;

If a subsequent initialization step fails (such as drm_crtc_crc_init()),
__drm_crtc_init_with_planes() returns an error without removing the CRTC fr=
om
the list.

When jumping to err_free_crtc here, gma_crtc is freed via kfree() below. Mi=
ght
this create a use-after-free condition when dev->mode_config.crtc_list is l=
ater
traversed?

[ ... ]
> @@ -524,6 +551,11 @@ void psb_intel_crtc_init(struct drm_device *dev, int=
 pipe,
> =20
>  	/* Set to true so that the pipe is forced off on initial config. */
>  	gma_crtc->active =3D true;
> +	return;
> +
> +err_free_crtc:
> +	kfree(gma_crtc->crtc_state);
> +	kfree(gma_crtc);
>  }
> =20
>  struct drm_crtc *psb_intel_get_crtc_from_pipe(struct drm_device *dev, in=
t pipe)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903071149.4235=
79-1-oushixiong1025@163.com?part=3D1
