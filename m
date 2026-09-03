Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A088BC624D4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 06:15:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D75CF10F01E;
	Thu,  3 Sep 2026 06:15:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZynYxGFV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A4C310E537
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 06:15:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 405C8600C8;
 Thu,  3 Sep 2026 06:15:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0E51F000E9;
 Thu,  3 Sep 2026 06:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788416108;
 bh=3kkBg+r/uOwoAsNuEFvVXQy+DR1ofiuEOPQZWpKf9vk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZynYxGFVud7RuctuizyO6BMEVEqhFwO3TajEIMaBmr0YD/+d+hQCjxJCNjKLatqH2
 TyN7cRs81tojKFrglWEBPk0DOBXa0sfaUBikM5bXJYk8/LlHt4qAzG0GwI1msSzeDp
 W6NCtryTujQv2m8q9swQXkNWLAYnjvYkone1cqu3KQUioLPKQx/VmlZo9qeuIlEA+f
 uZjUtwRJSgud7RjLZ01wd2GqiuhbvP4hTYEujSO3th8gW45heAqdQxH1zCRHkOIh5c
 MLlYF3GAsheMisAmKWx4e3GAfBKnMcHWKy4xkjO50QdhD06gcw6HAZNJWTuKRifFPS
 66x4ZPj+TxUtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/sysfb: Use iosys_map_memset() to clear buffer
To: "Chen-Yu Tsai" <wenst@chromium.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260903060651.3724163-1-wenst@chromium.org>
References: <20260903060651.3724163-1-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 06:15:07 +0000
Message-Id: <20260903061507.BF0E51F000E9@smtp.kernel.org>
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
- [High] The atomic_disable callback uses the new plane state to determine =
the screen area to clear, which may be zeroed out and fail to clear the scr=
een.
--

commit cdbf0de82b5bf761696ff2cc3c658a3d090a02c8
Author: Chen-Yu Tsai <wenst@chromium.org>

drm/sysfb: Use iosys_map_memset() to clear buffer

This patch updates the sysfb atomic disable routine to use
iosys_map_memset() with an offset, rather than directly extracting the
virtual address for memory clearing.

> diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c b/drivers/gpu/drm/=
sysfb/drm_sysfb_modeset.c
> index d2de29caf89eb..99b13af4e391c 100644
> --- a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
> +++ b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
> @@ -375,13 +375,11 @@ void drm_sysfb_plane_helper_atomic_disable(struct d=
rm_plane *plane,
>  {
>  	struct drm_device *dev =3D plane->dev;
>  	struct drm_sysfb_device *sysfb =3D to_drm_sysfb_device(dev);
> -	struct iosys_map dst =3D sysfb->fb_addr;
>  	struct drm_plane_state *plane_state =3D drm_atomic_get_new_plane_state(=
state, plane);
> -	void __iomem *dst_vmap =3D dst.vaddr_iomem; /* TODO: Use mapping abstra=
ction */
>  	unsigned int dst_pitch =3D sysfb->fb_pitch;
>  	const struct drm_format_info *dst_format =3D sysfb->fb_format;
>  	struct drm_rect dst_clip;
> -	unsigned long lines, linepixels, i;
> +	unsigned long lines, linepixels, i, offset;
>  	int idx;
> =20
>  	drm_rect_init(&dst_clip,
>  		      plane_state->src_x >> 16, plane_state->src_y >> 16,
>  		      plane_state->src_w >> 16, plane_state->src_h >> 16);
> =20
>  	lines =3D drm_rect_height(&dst_clip);
>  	linepixels =3D drm_rect_width(&dst_clip);

[Severity: High]
This isn't a bug introduced by this patch, but does using the new plane sta=
te
to calculate the clear area result in a failure to clear the screen?

Because drm_sysfb_plane_helper_atomic_disable() fetches the new plane state
above, it uses the state properties after the plane is disabled. If a
userspace display server zeroes out SRC_W and SRC_H when setting FB_ID =3D 0
to disable the plane, both lines and linepixels will evaluate to 0 here.

Could this cause the clearing loop to be completely skipped, leaving stale
framebuffer data visible on the screen?

Should this code use drm_atomic_get_old_plane_state() instead to ensure it
always correctly clears the area previously occupied by the plane?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903060651.3724=
163-1-wenst@chromium.org?part=3D1
