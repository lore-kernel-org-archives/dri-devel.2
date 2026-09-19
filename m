Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB93C982D7
	for <dri-devel@archiver.kernel.org>; Sat, 19 Sep 2026 22:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46EBF10E802;
	Sat, 19 Sep 2026 22:58:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Npiz+ev/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7776610E802
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 22:58:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 353F142BCF;
 Sat, 19 Sep 2026 22:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8451F000FF;
 Sat, 19 Sep 2026 22:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789858726;
 bh=wsDuRXzz3Bepu4ARlpIgrQgEg/WWG2h/A9rqB88+E8g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Npiz+ev/mNrDvp7Vu0yXOIgJvOQ+j/xwaNrdGSPrkEn5/2uzQP/mHhvvF4TspkHxb
 dSD0ISoKcYK9PhGULUvc3ulOTzbWiLNJ3uIML7zYwzxmuqb6EoHYhHVwL6Q1wuEn+W
 LcDV0Y3nxLKqGUhPIyZqfYK4GZG5gc/Bayz+J+p9oLhzUlz/gjIGNSzOb7uKiz/++W
 hL+Cd5pfujdB4E5Il/sNxUwOkX9q4mfE4SbuNbPmhuagFM4dcClUTr6oAt5f64lJQZ
 s+LUnN9AI7lhhEwkfHE3js82wZGIYBjpiZ3gDRIDCd+WOj9sK3kHMwZ5drlNkCfS4E
 CniAacRHAgBgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/tiny: fix VRAM/EDID/transfer bounds in bochs,
 gm12u320, pixpaper, and sharp-memory
To: "Hui Peng" <benquike@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260919223513.3889412-1-benquike@gmail.com>
References: <20260919223513.3889412-1-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 22:58:45 +0000
Message-Id: <20260919225845.EB8451F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] drm/gm12u320: fb offset dropped due to redundant drm_gem_fb_vmap c=
all
- [High] drm/gm12u320: sleeping in atomic context via gm12u320_stop_fb_upda=
te
- [Medium] drm/gm12u320: redundant logic for FB swaps improperly executes f=
or invisible planes
- [Medium] drm/tiny: commit message claims to fix EDID extension count but =
no code changes exist
--

commit f388ed102067844063cbe52109b60321de9bfe2f
Author: Hui Peng <benquike@gmail.com>

drm/tiny: fix VRAM/EDID/transfer bounds in bochs, gm12u320, pixpaper, and s=
harp-memory

This commit aims to fix framebuffer size, EDID extension count, and transfer
buffer bounds checks across several tiny DRM drivers.

> Fix framebuffer size, EDID extension count, and transfer buffer bounds
> checks across drivers/gpu/drm/tiny/ (bochs.c, gm12u320.c, pixpaper.c,
> and sharp-memory.c).

[Severity: Medium]
Is the commit message missing some context, or were the EDID extension
count changes left out of this patch? The diff modifies framebuffer
bounds and buffer maps, but it doesn't appear to contain any changes
related to EDID parsing or EDID extension counts.

> diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u=
320.c
> index 4ad074337af07..9dfbfc6bb1b64 100644
> --- a/drivers/gpu/drm/tiny/gm12u320.c
> +++ b/drivers/gpu/drm/tiny/gm12u320.c
> @@ -268,12 +268,18 @@ static void gm12u320_copy_fb_to_blocks(struct gm12u=
320_device *gm12u320)
>  	x2 =3D gm12u320->fb_update.rect.x2;
>  	y1 =3D gm12u320->fb_update.rect.y1;
>  	y2 =3D gm12u320->fb_update.rect.y2;
> -	vaddr =3D gm12u320->fb_update.src_map.vaddr; /* TODO: Use mapping abstr=
action properly */
> +
> +	ret =3D drm_gem_fb_vmap(fb, &gm12u320->fb_update.src_map, NULL);

[Severity: High]
Does this redundant mapping overwrite the correct mapping provided by the
shadow plane helper and drop the framebuffer offset?

The shadow plane helpers already map the framebuffer and apply the offset
into the shadow plane state data, which gets passed to gm12u320_fb_mark_dir=
ty()
and saved in gm12u320->fb_update.src_map.

By calling drm_gem_fb_vmap() here in gm12u320_copy_fb_to_blocks() with a NU=
LL
data parameter, doesn't it bypass the offset calculation, causing the driver
to read from the base GEM address instead of the correct offset address?

[ ... ]

> @@ -583,8 +592,17 @@ static void gm12u320_pipe_update(struct drm_simple_d=
isplay_pipe *pipe,
>  	struct drm_shadow_plane_state *shadow_plane_state =3D to_drm_shadow_pla=
ne_state(state);
>  	struct drm_rect rect;
> =20
> -	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
> +	if (!state->fb) {
> +		gm12u320_stop_fb_update(to_gm12u320(pipe->crtc.dev));
> +		return;
> +	}

[Severity: High]
Can this sequence cause us to sleep in an atomic context?

gm12u320_pipe_update() implements the plane's atomic_update callback, which
runs in atomic context where sleeping is forbidden. However, this patch
introduces a call to gm12u320_stop_fb_update(), which directly calls
cancel_delayed_work_sync() and mutex_lock() - both of which can sleep.

> +
> +	if (drm_atomic_helper_damage_merged(old_state, state, &rect)) {
>  		gm12u320_fb_mark_dirty(state->fb, &shadow_plane_state->data[0], &rect);
> +	} else if (old_state->fb !=3D state->fb) {
> +		drm_rect_init(&rect, 0, 0, state->fb->width, state->fb->height);
> +		gm12u320_fb_mark_dirty(state->fb, &shadow_plane_state->data[0], &rect);
> +	}
>  }

[Severity: Medium]
Will this fallback logic bypass visibility checks and incorrectly trigger
redundant full updates?

For visible planes, drm_atomic_helper_damage_merged() detects FB swaps and
returns true, making this else-if block dead code. But if the plane
transitions to invisible (state->visible =3D=3D false), the helper returns =
false.
Won't this else-if block then incorrectly trigger and queue a full frame
transfer for an invisible plane?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919223513.3889=
412-1-benquike@gmail.com?part=3D1
