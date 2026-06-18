Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4975CD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 106CD10EE15;
	Thu, 18 Jun 2026 12:48:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eQSoFqCa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 836C410EE15
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 12:48:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 610944192F;
 Thu, 18 Jun 2026 12:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0BE1F000E9;
 Thu, 18 Jun 2026 12:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781786897;
 bh=gCKqU0FCSYSCMLg5Ck4TgFDpI2RHJKfGf40GgomWDLw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eQSoFqCaid84X0Rp7z5AbajPV6FRRlbtUfbnFogDrpZvXuvaIrM8B+5Keyb2tQv96
 WDaFWjyUKOyDTkv0r81niVFmpWDKQn2qG6O5VBKxT8+hCvA53myW6gamoCkou+XyJw
 F+CBXtyfF4YPV/ajJJFZTO/+ohSLhtEfwucPI8QLnFo8610u9LGFnbSAHdXwGVKGjJ
 Urnn9A3gpc97Wc+drSN7w71D4ywOBAaa7rRE86OuO6JrqAqzL47SoeFXxbzbtjy8Oe
 roFEavULIrFg6M5qFZSt+vF5+bYP5lSGoFF97XNBkHXs7W95BHGAdi64PMGKXDfKsm
 gqAy5n2630U9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/6] drm/hibmc: Use
 drm_atomic_helper_check_plane_state()
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260618123142.92298-2-tzimmermann@suse.de>
References: <20260618123142.92298-1-tzimmermann@suse.de>
 <20260618123142.92298-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 12:48:16 +0000
Message-Id: <20260618124817.1D0BE1F000E9@smtp.kernel.org>
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
- [High] Relaxing plane bounds checking allows configurations that the hard=
ware programming function (`hibmc_plane_atomic_update`) does not support, c=
ausing the plane to be rendered incorrectly.
--

commit 4786b7e1e5ba6fbcc8a7b196d600f9e14eb06bb6
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/hibmc: Use drm_atomic_helper_check_plane_state()

This commit replaces custom plane boundary checks with the shared
drm_atomic_helper_check_plane_state() helper.

> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu=
/drm/hisilicon/hibmc/hibmc_drm_de.c
> index 3066dc9ebc647..7c0b88c774b5e 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> @@ -72,46 +72,28 @@ static int hibmc_get_best_clock_idx(const struct drm_=
display_mode *mode)
>  static int hibmc_plane_atomic_check(struct drm_plane *plane,
>  				    struct drm_atomic_commit *state)
>  {
[ ... ]
> +	ret =3D drm_atomic_helper_check_plane_state(new_plane_state, new_crtc_s=
tate,
> +						  DRM_PLANE_NO_SCALING,
> +						  DRM_PLANE_NO_SCALING,
> +						  false, true);
> +	if (ret)
> +		return ret;
> +	else if (!new_plane_state->visible)
> +		return 0;

[Severity: High]
Does this introduce a mismatch with the hardware update logic?

The atomic helper permits planes larger than the CRTC by adjusting the sour=
ce
offsets (src_x and src_y), and also permits completely off-screen planes by
setting visible to false.

However, looking at hibmc_plane_atomic_update(), it appears the hardware
programming function unconditionally scans out from the base address of the
framebuffer. It does not seem to check if the plane is visible to skip
programming, nor does it appear to account for src_x and src_y offsets.

If userspace submits an off-screen plane or a plane with a panning offset,
will the hardware incorrectly scan out the unshifted framebuffer, causing
display corruption?

>  	if (new_plane_state->fb->pitches[0] % 128 !=3D 0) {
>  		drm_dbg_atomic(plane->dev, "wrong stride with 128-byte aligned\n");
>  		return -EINVAL;
>  	}
> +
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618123142.9229=
8-1-tzimmermann@suse.de?part=3D1
