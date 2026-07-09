Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BBEC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:04:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0523710F4F6;
	Thu,  9 Jul 2026 11:04:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CmeV6wry";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01B8810E6AA
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:04:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 07AE86001A;
 Thu,  9 Jul 2026 11:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882601F000E9;
 Thu,  9 Jul 2026 11:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783595051;
 bh=+ljhLo7oIl9kdde7FbrwqTadpHO0cDWydqH0jGuygNk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CmeV6wryVJ3epwK4XWQ30crXTxV/LU6hLfGgYbu6i2sTQW7UopLQrgiO0IvSVIDvj
 utcZZ80m5DTnZd2O4akloM2drSzsdWAqoQTIG8+p2PVg0bDwcpA0MtXUCiPfH+onFZ
 6wzp6Km+ceKm/4HIciWEoBSIwl5c0+cZUfnwyqZtc1Z27W5IxUo05kYF2po+ToaBMW
 cpqogCOniiiEC1qTmoF9Em3xEFqMCkuLpaMTpS/Y8C0217nYH0C4GpubgV4ZBMSqAa
 Z/NXjjG0+cnACdH8bc0CFA5h8AkwAJYv/IGlL6m8IpFbUReuKzjviCQdgAJ1lLQESh
 BtHL753qJSy+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/solomon: remove unneeded variables in blit functions
To: "Iker Pedrosa" <ikerpedrosam@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260709-fix-ssd130x-v1-1-1272cb3dc85e@gmail.com>
References: <20260709-fix-ssd130x-v1-1-1272cb3dc85e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 11:04:11 +0000
Message-Id: <20260709110411.882601F000E9@smtp.kernel.org>
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
- [High] The format conversion state buffer is drastically under-allocated =
(or not allocated at all) in `atomic_check`, forcing `GFP_KERNEL` reallocat=
ion during the `atomic_update` phase.
--

--- Patch [1]: [PATCH] drm/solomon: remove unneeded variables in blit funct=
ions ---
commit 8b406f12f83f8bdc420f079608108a65e9772103
Author: Iker Pedrosa <ikerpedrosam@gmail.com>

drm/solomon: remove unneeded variables in blit functions

Remove unneeded 'ret' variables in ssd130x_fb_blit_rect(),
ssd132x_fb_blit_rect(), and ssd133x_fb_blit_rect() functions.
These functions initialize ret to 0 and return it unchanged,
so return 0 directly instead.

Closes: https://lore.kernel.org/oe-kbuild-all/202606301409.I0ctsf41-lkp@int=
el.com/

> diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/=
ssd130x.c
> index 4907be694aecb..0940eae7a2e49 100644
> --- a/drivers/gpu/drm/solomon/ssd130x.c
> +++ b/drivers/gpu/drm/solomon/ssd130x.c
[ ... ]
> @@ -960,7 +957,7 @@ static int ssd133x_fb_blit_rect(struct drm_framebuffe=
r *fb,
> =20
>  	ssd133x_update_rect(ssd130x, rect, data_array, dst_pitch);
> =20
> -	return ret;
> +	return 0;
>  }
> =20
>  static int ssd130x_primary_plane_atomic_check(struct drm_plane *plane,

[Severity: High]
This isn't a bug introduced by this patch, but does the format conversion
state buffer get drastically under-allocated (or not allocated at all) in
the atomic_check functions, forcing a GFP_KERNEL reallocation during the
atomic_update phase?

Looking at ssd130x_primary_plane_atomic_check(), it reserves memory based on
the much smaller destination format pitch instead of the XRGB8888 source
format requirement:

	if (plane_state->fb->format !=3D fi) {
		void *buf;

		/* format conversion necessary; reserve buffer */
		buf =3D drm_format_conv_state_reserve(&shadow_plane_state->fmtcnv_state,
						    pitch, GFP_KERNEL);
		if (!buf)
			return -ENOMEM;
	}

Later, during the non-blocking atomic_update phase, conversion helpers like
drm_fb_xrgb8888_to_mono() request a much larger buffer:

	src32 =3D drm_format_conv_state_reserve(state, len_src32 + linepixels, GFP=
_KERNEL);

Since the newly requested size exceeds the previously reserved size, won't
this force drm_format_conv_state_reserve() to execute a sleeping krealloc
with GFP_KERNEL in atomic context?

This same pattern appears in ssd132x_primary_plane_atomic_check(), and
ssd133x_primary_plane_atomic_check() completely omits calling
drm_format_conv_state_reserve() which guarantees a 0 size reserve.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-fix-ssd130=
x-v1-1-1272cb3dc85e@gmail.com?part=3D1
