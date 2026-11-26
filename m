Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECBD606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dfxZLm/I
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAC4E10E174;
	Thu, 26 Nov 2026 07:27:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F53D10E174
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 07:27:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 57C6441A72;
 Thu, 26 Nov 2026 07:27:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0906F1F000C4;
 Thu, 26 Nov 2026 07:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795678045;
 bh=yZwJyJmVqd2Mosyi3avlWDhDjjzcOVllfyisjfC451Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dfxZLm/IFOfRo3Q43QNR7vIm8DoAKNrOEcShHlpDhkOd+6kWtlMRgUPVrY9p4o11h
 i0lGsgLI8QS+PWSOBJP40p82vGqfEBZwEZW2TmoxFoZR93fvQgIKHSD1OijBkcmVWW
 6CdORKcqOwfk+0soJ2cCdHNO8wtC9CX71CwW6bvuwa0C7J7YhuZcO1wdewdABzDYVE
 yDycOJezbSliKwmvKMKbT/uFOZk8+E+IYIYfpaKehoxBzimTPjdZl9VymeLmcDoOyl
 JLmIfJV/l7JNebxqtKSu2z+tzhyQzYi/hIgjaHLMa1uQBBD2bMikIugL+Y89XLvBi/
 XBsERRQXsV63A==
Message-ID: <sashiko-outbox-234954@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFT v4 4/5] drm/imx/dc: plane: Switch to
 drm_fb_dma_get_gem_clipped_addr()
To: "Chen-Yu Tsai" <wenst@chromium.org>
Cc: linux-sunxi@lists.linux.dev, imx@lists.linux.dev,
 dri-devel@lists.freedesktop.org, Frank.Li@kernel.org
In-Reply-To: <20261126071314.253890-5-wenst@chromium.org>
References: <20261126071314.253890-1-wenst@chromium.org>
 <20261126071314.253890-5-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 07:27:24 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/imx/dc: off-screen plane programs out-of-bounds DMA
  address and 0 size
--

commit cf4b0408a88e14e3a67afb3b4cd1719d2796a174
Author: Chen-Yu Tsai <wenst@chromium.org>

drm/imx/dc: plane: Switch to drm_fb_dma_get_gem_clipped_addr()

This commit switches dc_plane_check_fb() and dc_plane_atomic_update() to
drm_fb_dma_get_gem_clipped_addr() so the framebuffer DMA base address uses
clipped source coordinates.

> diff --git a/drivers/gpu/drm/imx/dc/dc-plane.c b/drivers/gpu/drm/imx/dc/d=
c-plane.c
> index 62dd0576fadcb..35eb5039f5acf 100644
> --- a/drivers/gpu/drm/imx/dc/dc-plane.c
> +++ b/drivers/gpu/drm/imx/dc/dc-plane.c
> @@ -65,7 +65,7 @@ static int dc_plane_check_max_source_resolution(struct =
drm_plane_state *state)
>  static int dc_plane_check_fb(struct drm_plane_state *state)
>  {
>  	struct drm_framebuffer *fb =3D state->fb;
> -	dma_addr_t baseaddr =3D drm_fb_dma_get_gem_addr(fb, state, 0);
> +	dma_addr_t baseaddr =3D drm_fb_dma_get_gem_clipped_addr(fb, state, 0);
> =20
>  	/* base address alignment */
>  	if (baseaddr & 0x3) {
> @@ -146,7 +146,7 @@ dc_plane_atomic_update(struct drm_plane *plane, struc=
t drm_atomic_commit *state)
>  	src_w =3D drm_rect_width(&new_state->src) >> 16;
>  	src_h =3D drm_rect_height(&new_state->src) >> 16;
> =20
> -	baseaddr =3D drm_fb_dma_get_gem_addr(fb, new_state, 0);
> +	baseaddr =3D drm_fb_dma_get_gem_clipped_addr(fb, new_state, 0);

[Severity: Medium]
Can drm_fb_dma_get_gem_clipped_addr() compute an out-of-bounds DMA address
when the plane is positioned completely off-screen?

dc_plane_atomic_check() calls drm_atomic_helper_check_plane_state() with
can_position =3D true.  When a plane is moved completely outside the CRTC
bounds, drm_rect_clip_scaled() sets plane_state->visible =3D false and clips
src.x1 =3D=3D src.x2 (up to fb->width << 16) or src.y1 =3D=3D src.y2 (up to
fb->height << 16), while drm_atomic_helper_check_plane_state() still
returns 0.

Because neither dc_plane_atomic_check() nor dc_plane_atomic_update() checks
plane_state->visible, drm_fb_dma_get_gem_clipped_addr() computes baseaddr
at (src.x1 >> 16, src.y1 >> 16), which can point past the end of the
framebuffer GEM object, and dc_plane_atomic_update() programs that address
along with zero src_w or src_h into the FetchUnit while enabling the source
buffer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126071314.2538=
90-1-wenst@chromium.org?part=3D4
