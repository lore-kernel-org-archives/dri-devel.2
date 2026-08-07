Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D29C5AC7C
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 10:59:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A20F10F46A;
	Fri,  7 Aug 2026 10:59:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gaEJE3wO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5B8310F485
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 10:59:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 27C5760AAB;
 Fri,  7 Aug 2026 10:59:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853B11F000E9;
 Fri,  7 Aug 2026 10:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786100387;
 bh=o1j82BQE/SNz2+niaufTcFyCYONc7q5x3mTFZPYkVtQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gaEJE3wOSVIvMovM96kxQqP/bUH5caVqUuroxe4/t0gsLdIVp9TTHkYSnQ8ka63HZ
 yx+EJsPE7CkDBNP6KQBP/1Gee+4Wfcnka6/0GIfwJltXTYTFtSlfrDqA08FYGk1uem
 A77k4pAVS+DgCZWGj69LkRcbbTVZ1vf4dHbv57TYd6W/nSNey5lGYxo2VUI5TOtr/u
 FRL1qIRQ88XJ/iYIIply0EGmRxLmR3Wd5GnTKhtQpOoglrD0VNi8g3VHcmH6+vRzJh
 GgBUAkr4o8+bcgSmMFNBYwryoqUrmAuGbh54xhlDbWMxCA5GNI70qLoDzPz+AWRZqX
 d+hn6xOu8hHjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC] drm/verisilicon: Switch to drm_fb_dma_get_addr()
 for framebuffer addresses
To: "Chen-Yu Tsai" <wenst@chromium.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260807104819.1295812-1-wenst@chromium.org>
References: <20260807104819.1295812-1-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 10:59:46 +0000
Message-Id: <20260807105947.853B11F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The patch introduces a build failure and a potential deterministic=
 NULL pointer dereference due to API misuse of `drm_fb_dma_get_gem_addr()`.
- [Low] A dangling function prototype for `vs_fb_get_dma_addr()` is left in=
 `vs_plane.h`.

Pre-existing issues:
- [High] A pre-existing bug causes the hardware display controller to read =
out-of-bounds physical memory when the cursor is clipped, potentially leaki=
ng adjacent kernel memory to the screen.
--

--- Patch [1]: [PATCH RFC] drm/verisilicon: Switch to drm_fb_dma_get_addr()=
 for framebuffer addresses ---
commit 236e399ed29b505c46a162513a0a121f26bb52bf
Author: Chen-Yu Tsai <wenst@chromium.org>

drm/verisilicon: Switch to drm_fb_dma_get_addr() for framebuffer addresses

The verisilicon driver has a custom framebuffer address calculating
helper that the common drm_fb_dma_get_addr() can substitute.

> diff --git a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c b/drivers/gpu/=
drm/verisilicon/vs_cursor_plane.c
> index fa4f601dd0c87..ae03d415d66b0 100644
> --- a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> +++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c

[ ... ]

> @@ -176,7 +176,8 @@ static void vs_cursor_plane_atomic_update(struct drm_=
plane *plane,
>  		break;
>  	}
> =20
> -	dma_addr =3D vs_fb_get_dma_addr(fb, &state->src);
> +	/* hardware handles clipping as seen below */
> +	dma_addr =3D drm_fb_dma_get_gem_addr(fb, 0);

[Severity: High]
Does this compile with modern compilers? The drm_fb_dma_get_gem_addr()
function is defined in drm_fb_dma_helper.c as taking three arguments:

drm_fb_dma_helper.c:
dma_addr_t drm_fb_dma_get_gem_addr(struct drm_framebuffer *fb,
                                   struct drm_plane_state *state,
                                   unsigned int plane)

It looks like this call passes only two arguments. If the compiler permits
this due to a missing include, the 0 would map to the state pointer.

Since drm_fb_dma_get_gem_addr() unconditionally dereferences the state
pointer for sample_x and sample_y:

drm_fb_dma_helper.c:drm_fb_dma_get_gem_addr() {
        ...
        sample_x =3D (state->src_x >> 16) / h_div;
        sample_y =3D (state->src_y >> 16) / v_div;
        ...
}

Could this lead to a deterministic NULL pointer dereference when updating
the cursor plane?


[Severity: High]
This isn't a bug introduced by this patch, but does the cursor clipping
implementation properly shift the offsets when moving the cursor off the
left or top edges?

Looking at vs_cursor_plane_atomic_update() right below this address update:

vs_cursor_plane.c:vs_cursor_plane_atomic_update() {
        ...
        } else {
                regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
                                   VSDC_CURSOR_CONFIG_X_OFF_MASK,
                                   -state->crtc_x);
        ...
}

Since the -state->crtc_x value is passed directly without applying a shift
macro, could the mask clear the unshifted value and write a 0 offset to
the hardware?

If the DRM core already clipped the source coordinates, might this cause
the hardware to overshoot the end of the cursor buffer and read
out-of-bounds physical memory?

>  	regmap_write(dc->regs, VSDC_CURSOR_ADDRESS(output),
>  		     lower_32_bits(dma_addr));

[ ... ]

> diff --git a/drivers/gpu/drm/verisilicon/vs_plane.c b/drivers/gpu/drm/ver=
isilicon/vs_plane.c
> index d81f7b8f4c650..38b8b536eccbd 100644
> --- a/drivers/gpu/drm/verisilicon/vs_plane.c
> +++ b/drivers/gpu/drm/verisilicon/vs_plane.c
> @@ -107,26 +107,6 @@ int drm_format_to_vs_format(u32 drm_format, struct v=
s_format *vs_format)
>  	return 0;
>  }
> =20
> -dma_addr_t vs_fb_get_dma_addr(struct drm_framebuffer *fb,
> -			      const struct drm_rect *src_rect)
> -{

[ ... ]

> -	return dma_addr;
> -}
> -

[Severity: Low]
Since vs_fb_get_dma_addr() is being removed here, should its function
prototype also be removed from drivers/gpu/drm/verisilicon/vs_plane.h to
avoid leaving a dangling declaration?

>  struct drm_plane_state *vs_plane_duplicate_state(struct drm_plane *plane)

[ ... ]

> diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c b/drivers/gpu=
/drm/verisilicon/vs_primary_plane.c
> index 1f2be41ae496c..46653469caaf7 100644
> --- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> +++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> @@ -126,7 +126,11 @@ static void vs_primary_plane_atomic_update(struct dr=
m_plane *plane,
>  			   VSDC_FB_CONFIG_UV_SWIZZLE_EN,
>  			   vs_state->format.uv_swizzle);
> =20
> -	dma_addr =3D vs_fb_get_dma_addr(fb, &state->src);
> +	/*
> +	 * Primary plane cannot be moved, no clipping is involved,
> +	 * so the non-clipped framebuffer address can be used.
> +	 */
> +	dma_addr =3D drm_fb_dma_get_gem_addr(fb, 0);

[Severity: High]
Similar to the cursor plane, this call to drm_fb_dma_get_gem_addr() appears
to be missing the state argument, which might cause the same build failure
or runtime NULL pointer dereference.

> =20
>  	regmap_write(dc->regs, VSDC_FB_ADDRESS(output),
>  		     lower_32_bits(dma_addr));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807104819.1295=
812-1-wenst@chromium.org?part=3D1
