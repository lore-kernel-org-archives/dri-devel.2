Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BD6C61DBD
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1C5110E9D9;
	Tue, 25 Aug 2026 10:53:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jwC+WExC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F07B210E0DE
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 10:53:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 98C63411C3;
 Tue, 25 Aug 2026 10:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2B71F000E9;
 Tue, 25 Aug 2026 10:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787655183;
 bh=WZEVpIjssNUyup30yUKV52O3rc2d4TOV2fTekTG1ysU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jwC+WExCCSmHlNgk6dvMOlVSMZxZFRTCAPtF5lUlrG/5lWmsmutuMDREgh48DxMkT
 kvLQ0yYfXEibyMWzvSWLWaQ2iucNJnmTgg0WHodzQStARIDNoC2B3GJDKH5UvNmAet
 77XhS24VFdzmJSvqvRhmA75UhbNF3zm43MXHxelipx1f2ef6hVqT63xfNJEx88Favi
 0ksZThUC5rrfJalhxlfV63Ex5OPUKAlJ5bsaK8/RcOX9rwkHNjnt8/u9kXP5j2w+F1
 rxRM1o47S9drws9aSBPr+PFwtlZ7uU66wisH6Ehcw79Lc13js+V2FOSET1RN35dtPs
 L3OBDp46NI0Mg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND] drm/sysfb: Fix atomic_disable to use dst
 coordinates instead of src
To: oushixiong1025@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260825104117.667943-1-oushixiong1025@163.com>
References: <20260825104117.667943-1-oushixiong1025@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 10:53:02 +0000
Message-Id: <20260825105303.4F2B71F000E9@smtp.kernel.org>
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
- [Critical] Using the new plane state's unclipped `dst` coordinates in `at=
omic_disable` fails to clear the actual old plane area and allows arbitrary=
 out-of-bounds memory overwrites.
--

--- Patch [1]: [PATCH RESEND] drm/sysfb: Fix atomic_disable to use dst coor=
dinates instead of src ---
commit 7865516b4b393e248319c8544570c784fcc3881b
Author: oushixiong1025@163.com <oushixiong1025@163.com>

drm/sysfb: Fix atomic_disable to use dst coordinates instead of src

This commit modifies drm_sysfb_plane_helper_atomic_disable() to use the
plane_state->dst coordinates rather than the plane_state->src_* coordinates
for constructing the clear rectangle.

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
>  	unsigned long lines, linepixels, i;
>  	int idx;
> =20
> -	drm_rect_init(&dst_clip,
> -		      plane_state->src_x >> 16, plane_state->src_y >> 16,
> -		      plane_state->src_w >> 16, plane_state->src_h >> 16);
> -
>  	lines =3D drm_rect_height(&dst_clip);
>  	linepixels =3D drm_rect_width(&dst_clip);

[Severity: Critical]
This isn't a bug introduced by this patch, but can this lead to an
out-of-bounds memory overwrite when userspace provides unclipped coordinate=
s?

During a plane disable (FB_ID =3D 0), drm_atomic_helper_check_plane_state()
populates plane_state->dst with raw, unclipped userspace values because the
framebuffer is NULL. If userspace passes negative or massive coordinates for
CRTC_X and CRTC_Y, this unclipped dst rectangle is passed to
drm_fb_clip_offset(), resulting in a large out-of-bounds pointer offset.

The driver then executes memset_io() over this invalid offset later in the
function:

	dst_vmap +=3D drm_fb_clip_offset(dst_pitch, dst_format, &dst_clip);
	for (i =3D 0; i < lines; ++i) {
		memset_io(dst_vmap, 0, linepixels * dst_format->cpp[0]);

Should the disable path use the old plane state rather than the new plane
state to safely clear the actual old plane area?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825104117.6679=
43-1-oushixiong1025@163.com?part=3D1
