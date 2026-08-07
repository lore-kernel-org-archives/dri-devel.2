Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C02DC5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 11:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 994EA10F49C;
	Fri,  7 Aug 2026 11:58:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U5mOQ1Sq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D73910F498
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 11:57:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BFD694078B;
 Fri,  7 Aug 2026 11:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82ED71F000E9;
 Fri,  7 Aug 2026 11:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786103878;
 bh=X9r0dQDrMEO78kHDH9Wl5wD7ZyinhdJttvcVaI8JSIU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=U5mOQ1SqY/R+lmzWulZFWbdbzgFTseVn5hTyrGPpDPJo0JwOWfeZqjC89cK1+O8vT
 fqybRHnc3xfiaRiRaepjsP0LYcJYDzopDr9OyJLnBnhC9JNPYReelRpdyUb2jz1LDp
 H1jJsHM6JQyiywBFJxLdWSjLD1/h86oReBkS1kTGzFz3ZilR5BDsdL/pqDpY0sFcnF
 1iWlUYX/cLf3CuPzkUc+Q+FOVQcC0qoFWD7aThvPkqA8bXlUHmFF/h1zjOMuq3IeFA
 Jg0sW4g3ydRxTnFv5bzdaBwSgS6Z2CVKUbOxaAwOLKuCTHXJ44SuToIOJWD73Duluf
 0E9esAdonIwgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2] drm/verisilicon: Switch to drm_fb_dma_get_addr()
 for framebuffer addresses
To: "Chen-Yu Tsai" <wenst@chromium.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260807114654.1373305-1-wenst@chromium.org>
References: <20260807114654.1373305-1-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 11:57:58 +0000
Message-Id: <20260807115758.82ED71F000E9@smtp.kernel.org>
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

New issues:
- [Medium] Removing software clipping for the cursor plane exposes a preexi=
sting register programming bug, completely breaking cursor clipping.
- [Low] Dangling prototype for `vs_fb_get_dma_addr()`.

Pre-existing issues:
- [High] NULL pointer dereference in plane atomic_disable functions when a =
plane is newly assigned but invisible.
- [High] `vs_primary_plane_atomic_disable` incorrectly enables the plane in=
stead of disabling it.
--

--- Patch [1]: [PATCH RFC v2] drm/verisilicon: Switch to drm_fb_dma_get_add=
r() for framebuffer addresses ---
commit d8f5b888e2f48aaf1e83d6bb5aee579fe194f0ab
Author: Chen-Yu Tsai <wenst@chromium.org>

drm/verisilicon: Switch to drm_fb_dma_get_addr() for framebuffer addresses

The verisilicon driver has a custom framebuffer address calculating
helper that the common drm_fb_dma_get_addr() can substitute.

> diff --git a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c b/drivers/gpu/=
drm/verisilicon/vs_cursor_plane.c
> index fa4f601dd0c87..59778433ae843 100644
> --- a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> +++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c

[ ... ]

> @@ -176,7 +177,8 @@ static void vs_cursor_plane_atomic_update(struct drm_=
plane *plane,
>  		break;
>  	}
> =20
> -	dma_addr =3D vs_fb_get_dma_addr(fb, &state->src);
> +	/* hardware handles clipping as seen below */
> +	dma_addr =3D drm_fb_dma_get_gem_addr(fb, state, 0);

[Severity: Medium]
Since we are removing the software clipping workaround, does the hardware
clipping actually work correctly here?

Looking further down in vs_cursor_plane_atomic_update(), the hardware
offsets are programmed without using the shift macros:

    regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
                       VSDC_CURSOR_CONFIG_X_OFF_MASK,
                       -state->crtc_x);

    regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
                       VSDC_CURSOR_CONFIG_Y_OFF_MASK,
                       -state->crtc_y);

Because the unshifted small negative integer falls outside the masks, won't
this evaluate to 0 during the bitwise AND, permanently programming the
offsets to 0 and completely breaking cursor clipping?

[Severity: High]
This is a pre-existing issue, but I noticed a potential NULL pointer
dereference in the disable path that gets called just above this snippet.

If userspace binds a previously unbound plane where old_plane_state->crtc
is NULL, but places it entirely off-screen, the DRM core sets
new_plane_state->visible =3D false and calls vs_cursor_plane_atomic_update(=
).

The code then calls vs_cursor_plane_atomic_disable():

    if (!state->visible) {
        vs_cursor_plane_atomic_disable(plane, atomic_state);
        return;
    }

Inside vs_cursor_plane_atomic_disable(), and identically in
vs_primary_plane_atomic_disable(), it fetches the CRTC from the old state,
which is NULL, and directly dereferences it:

    struct drm_crtc *crtc =3D state->crtc;
    struct vs_crtc *vcrtc =3D drm_crtc_to_vs_crtc(crtc);
    unsigned int output =3D vcrtc->id;

Could this trigger a kernel panic if a malicious or buggy userspace
submits this type of atomic modeset?

[Severity: High]
This is also a pre-existing issue, but looking at
vs_primary_plane_atomic_disable(), the hardware appears to be enabled
instead of disabled:

    regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
                    VSDC_FB_CONFIG_EX_FB_EN);

Because regmap_set_bits() turns the plane on, won't the primary plane
remain actively rendering when the DRM core disables it, causing the
hardware state to diverge from the kernel state?

> diff --git a/drivers/gpu/drm/verisilicon/vs_plane.c b/drivers/gpu/drm/ver=
isilicon/vs_plane.c
> index d81f7b8f4c650..38b8b536eccbd 100644
> --- a/drivers/gpu/drm/verisilicon/vs_plane.c
> +++ b/drivers/gpu/drm/verisilicon/vs_plane.c

[ ... ]

> @@ -107,26 +107,6 @@ int drm_format_to_vs_format(u32 drm_format, struct v=
s_format *vs_format)
>  	return 0;
>  }
> =20
> -dma_addr_t vs_fb_get_dma_addr(struct drm_framebuffer *fb,
> -			      const struct drm_rect *src_rect)
> -{
> -	struct drm_gem_dma_object *gem;
> -	dma_addr_t dma_addr;

[Severity: Low]
Is the prototype for vs_fb_get_dma_addr() still declared in vs_plane.h?

Should we remove it from drivers/gpu/drm/verisilicon/vs_plane.h as well
to avoid leaving a dangling prototype?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807114654.1373=
305-1-wenst@chromium.org?part=3D1
