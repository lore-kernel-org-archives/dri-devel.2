Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C2FC54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 11:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9AC910E1EB;
	Fri, 31 Jul 2026 11:24:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fJ5M0Lw5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48DE710E1EB
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 11:24:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 52404600BB;
 Fri, 31 Jul 2026 11:24:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D4C1F000E9;
 Fri, 31 Jul 2026 11:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785497068;
 bh=FmXv3490GjjQ+J/rmIRLmkwzO5cTFUg847cyr6EriaA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fJ5M0Lw5CYlNZXpoU/5lWCnotqUXNfuZczsBojxJBCXJfC2gJW/uaVJ6fXIKzwKvb
 07koizUq1AjHs1ZssnFv7HfyVx/L4CvS14xsZSGsqlD359Vqod1t+REqtsPJ3OOksw
 1JhwM8r37AtDJp3jLM7uk/nBbk83FEp7K3x6SyFmqEZW7YDHf3NUE58OKFj94s+cFN
 lHKm/nzKqbGzOfTmeyIE1L4PD5saRZFPX8RR7n9AGUGZgMaCL5DcceFw2Yv5gSWZU2
 x0uoegf7PiLNtpEVn8DBzpoP73WY2hpDAk/cnnsKM/6b2qy+EJ/fsM82UHCllC1+QE
 z3EfREpiDKoxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/sysfb: Fix atomic_disable to use dst coordinates
 instead of src
To: oushixiong1025@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260731111155.695390-1-oushixiong1025@163.com>
References: <20260731111155.695390-1-oushixiong1025@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 11:24:27 +0000
Message-Id: <20260731112427.D1D4C1F000E9@smtp.kernel.org>
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
- [Critical] In `drm_sysfb_plane_helper_atomic_disable()`, using the new pl=
ane state's `dst` rectangle allows an attacker to supply arbitrary, unclipp=
ed coordinates, leading to out-of-bounds writes of zeroes in kernel or I/O =
memory.
--

--- Patch [1]: [PATCH] drm/sysfb: Fix atomic_disable to use dst coordinates=
 instead of src ---
commit b1c860517627fd82ea2b305a0494871f248ccba6
Author: oushixiong1025@163.com <oushixiong1025@163.com>

drm/sysfb: Fix atomic_disable to use dst coordinates instead of src

This patch updates drm_sysfb_plane_helper_atomic_disable() to use the=20
plane_state->dst coordinates for constructing the clear rectangle. This=20
makes the behavior consistent with drm_sysfb_plane_helper_atomic_update()=20
which already uses the destination rectangle computed by the DRM core.

> diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c b/drivers/gpu/drm/=
sysfb/drm_sysfb_modeset.c
> index d2de29caf89eb..18466de886aaa 100644
> --- a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
> +++ b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
> @@ -380,14 +380,10 @@ void drm_sysfb_plane_helper_atomic_disable(struct d=
rm_plane *plane,
>  	void __iomem *dst_vmap =3D dst.vaddr_iomem; /* TODO: Use mapping abstra=
ction */
>  	unsigned int dst_pitch =3D sysfb->fb_pitch;
>  	const struct drm_format_info *dst_format =3D sysfb->fb_format;
> -	struct drm_rect dst_clip;
> +	struct drm_rect dst_clip =3D plane_state->dst;

[Severity: Critical]
This is a pre-existing issue, but does using the new plane state's dst
rectangle allow userspace to supply arbitrary, unclipped coordinates?

If userspace with DRM_MASTER privilege issues an atomic modeset with FB_ID =
=3D 0
(disabling the plane) while supplying arbitrary CRTC_X and CRTC_Y propertie=
s,
drm_atomic_helper_check_plane_state() detects !fb and returns early. This
bypasses coordinate bounds checking and clipping, leaving plane_state->dst
set to the unclipped, userspace-controlled values.

Then, drm_sysfb_plane_helper_atomic_disable() calculates a memory offset us=
ing
drm_fb_clip_offset(dst_pitch, dst_format, &dst_clip), which translates dire=
ctly
to the userspace-supplied coordinates. This offset is used in a loop calling
memset_io(), which could lead to out-of-bounds physical or I/O memory writes
of zeroes.

>  	unsigned long lines, linepixels, i;
>  	int idx;
> =20
> -	drm_rect_init(&dst_clip,
> -		      plane_state->src_x >> 16, plane_state->src_y >> 16,
> -		      plane_state->src_w >> 16, plane_state->src_h >> 16);
> -
>  	lines =3D drm_rect_height(&dst_clip);
>  	linepixels =3D drm_rect_width(&dst_clip);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731111155.6953=
90-1-oushixiong1025@163.com?part=3D1
