Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A304606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQE/4LvX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C987E10E072;
	Mon, 19 Oct 2026 16:21:50 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ED6010E072
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 16:21:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BEF9F60210;
 Mon, 19 Oct 2026 16:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B451F000C4;
 Mon, 19 Oct 2026 16:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792426903;
 bh=Nle/nsQwTuwofxrriMYNsN/2USkupqa1YrGeYtGA5rs=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=AQE/4LvXOLQA56YU7GL7lH0/i4QNycp360Hqf8o13pKeXL7QK6nW0ChjIxeweZ/ch
 IAaZYq5Ak/b6fR6ijpSdvo63mpKVA7FPcXYMCkyqAbQZ8Yf6zDZS8Rna0dLsAyAhh2
 XjaTZZ9mayke5jF4CN83zNcRzjnngInJk4fMXUptYKKe6Y2MwisQrFrLJAujipcwwb
 2EsBnB9oDFw4wFLUrVTYrXCWOkhYodu/T+5l2aeUA4v0wGTUYcIOFunc20NEPqM1m0
 8Cf0xXjAG4ydGHtWtDGfD4X/Qhd6Q3nw5vBumGQpoBL1TErm1Eo/ODg/JDvRVmpwd7
 9wgYn5NkjphIA==
Message-ID: <sashiko-outbox-177868@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/4] drm/ms91xx: Add atomic modesetting and USB
 framebuffer transfers
To: "Ho Jie Feng" <hjf3108@gmail.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261019154820.68659-4-hjf3108@gmail.com>
References: <20261019154820.68659-1-hjf3108@gmail.com>
 <20261019154820.68659-4-hjf3108@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 16:21:42 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] drm/ms91xx: lost frame damage in ms91xx_plane_atomic_update()
- [Medium] drm/ms91xx: uninitialized USB transfer data in ms91xx_fb_send_re=
ct()
--

commit 0984404c243e6ff2131df1188521aaa6fa5626e8
Author: Ho Jie Feng <hjf3108@gmail.com>

drm/ms91xx: Add atomic modesetting and USB framebuffer transfers

This commit adds DRM core modesetting support, USB driver probing, and
double-buffered USB framebuffer transfers with damage tracking for
MacroSilicon MS91xx display adapters.

> diff --git a/drivers/gpu/drm/ms91xx/ms91xx_drv.c b/drivers/gpu/drm/ms91xx=
/ms91xx_drv.c
> new file mode 100644
> index 0000000000000..2ca855f2363c8
> --- /dev/null
> +++ b/drivers/gpu/drm/ms91xx/ms91xx_drv.c
> @@ -0,0 +1,518 @@

[ ... ]

> +static void ms91xx_plane_atomic_update(struct drm_plane *plane,
> +				       struct drm_atomic_commit *state)
> +{
> +	struct drm_plane_state *old_plane_state;
> +	struct drm_plane_state *new_plane_state;
> +	struct drm_crtc_state *new_crtc_state;
> +	struct drm_shadow_plane_state *shadow_plane_state;
> +	struct ms91xx_device *ms91xx =3D to_ms91xx(plane->dev);
> +	struct ms91xx_usb_request *current_request, *previous_request;
> +	struct drm_rect current_rect, rect;
> +
> +	old_plane_state =3D drm_atomic_get_old_plane_state(state, plane);
> +	new_plane_state =3D drm_atomic_get_new_plane_state(state, plane);
> +
> +	if (!new_plane_state->fb)
> +		return;
> +	new_crtc_state =3D drm_atomic_get_new_crtc_state(state,
> +						       new_plane_state->crtc);
> +	shadow_plane_state =3D to_drm_shadow_plane_state(new_plane_state);
> +
> +	/* Damage from the previous mode may not fit the new framebuffer. */
> +	if (drm_atomic_crtc_needs_modeset(new_crtc_state))
> +		ms91xx_clear_rect(&ms91xx->update_rect);
> +
> +	if (drm_atomic_helper_damage_merged(old_plane_state, new_plane_state,
> +					    &current_rect)) {
> +		current_request =3D &ms91xx->requests[ms91xx->current_request];
> +		previous_request =3D &ms91xx->requests[!ms91xx->current_request];
> +
> +		/* Latency reduction: requeue with the latest frame data. */
> +		if (cancel_work(&previous_request->work)) {
> +			complete(&previous_request->done);
> +			ms91xx_merge_rects(&current_rect, &current_rect,
> +					   &previous_request->transfer_rect);
> +			current_request =3D previous_request;
> +			ms91xx->current_request =3D !ms91xx->current_request;
> +		}
> +
> +		current_request->transfer_rect =3D current_rect;
> +
> +		/*
> +		 * The device double buffers, so we need to send the update
> +		 * rects of the last two frames.
> +		 */
> +		ms91xx_merge_rects(&rect, &current_rect, &ms91xx->update_rect);
> +		if (ms91xx_fb_send_rect(new_plane_state->fb,
> +					&shadow_plane_state->data[0],
> +					&shadow_plane_state->fmtcnv_state,
> +					&rect)) {
> +			/* In case of error, merge the rects to update later */
> +			ms91xx_merge_rects(&ms91xx->update_rect,
> +					   &ms91xx->update_rect, &rect);
> +		} else {
> +			ms91xx->update_rect =3D current_rect;
> +		}
> +	}
> +}

[Severity: Medium]
Can ms91xx_plane_atomic_update() drop damage for one of the device's two
buffers when pending work is canceled or after a failed transfer?

Consider three consecutive updates while requests[0].work is still running
usb_sg_wait() on the ordered workqueue:

1. Frame 1 (damage R1) queues requests[0].work and sets
   ms91xx->update_rect =3D R1.
2. Frame 2 (damage R2) sees cancel_work(&requests[0].work) return false,
   sets requests[1].transfer_rect =3D R2, queues requests[1].work with
   R1 U R2, and immediately overwrites ms91xx->update_rect =3D R2 before
   requests[1].work runs.
3. Frame 3 (damage R3) arrives while requests[0].work is still running and
   requests[1].work is still pending. cancel_work(&requests[1].work)
   succeeds, merging R3 with previous_request->transfer_rect (R2) and then
   with ms91xx->update_rect (also R2).

Because Frame 2 already overwrote ms91xx->update_rect with R2 and its
transfer was canceled, R1 is never sent in Frame 3 and the second hardware
buffer never receives R1.

Similarly, if ms91xx_fb_send_rect() fails on Frame 1 (for example, timing
out on current_request->done), R1 is merged into ms91xx->update_rect and no
USB transfer takes place. When Frame 2 (damage R2) succeeds, it sends
R1 U R2 to only one hardware buffer and then sets
ms91xx->update_rect =3D R2, so Frame 3 only sends R2 U R3 to the other
hardware buffer, leaving it without R1.

[ ... ]

> diff --git a/drivers/gpu/drm/ms91xx/ms91xx_transfer.c b/drivers/gpu/drm/m=
s91xx/ms91xx_transfer.c
> new file mode 100644
> index 0000000000000..8b88b2206ce3d
> --- /dev/null
> +++ b/drivers/gpu/drm/ms91xx/ms91xx_transfer.c
> @@ -0,0 +1,218 @@

[ ... ]

> +int ms91xx_init_request(struct ms91xx_device *ms91xx,
> +			struct ms91xx_usb_request *request, size_t len)
> +{
> +	int ret;
> +	unsigned int i, num_pages;
> +	void *data;
> +	struct page **pages;
> +	void *ptr;
> +
> +	data =3D vmalloc_32(len);
> +	if (!data)
> +		return -ENOMEM;

[ ... ]

> +static void ms91xx_fb_xrgb8888_to_yuv422(void *dst,
> +					 const struct iosys_map *src,
> +					 struct drm_framebuffer *fb,
> +					 const struct drm_rect *rect,
> +					 struct drm_format_conv_state *fmtcnv_state)
> +{
> +	struct ms91xx_frame_update_header *header =3D dst;
> +	struct iosys_map dst_map;
> +	u32 position, dimensions;
> +	int x, y1, width;
> +
> +	y1 =3D rect->y1;
> +	x =3D rect->x1;
> +	width =3D drm_rect_width(rect);
> +
> +	header->marker =3D cpu_to_be16(0xff00);
> +	position =3D ((x & 0xfff) << 12) | (y1 & 0xfff);
> +	dimensions =3D ((width & 0xfff) << 12) |
> +		     (drm_rect_height(rect) & 0xfff);
> +	put_unaligned_be24(position, header->position);
> +	put_unaligned_be24(dimensions, header->dimensions);
> +	dst +=3D sizeof(*header);
> +
> +	iosys_map_set_vaddr(&dst_map, dst);
> +	drm_fb_xrgb8888_to_uyvy(&dst_map, NULL, src, fb, rect, fmtcnv_state);
> +	dst +=3D width * drm_rect_height(rect) * 2;
> +
> +	memcpy(dst, ms91xx_end_of_buffer, sizeof(ms91xx_end_of_buffer));
> +}
> +
> +int ms91xx_fb_send_rect(struct drm_framebuffer *fb, const struct iosys_m=
ap *map,
> +			struct drm_format_conv_state *fmtcnv_state,
> +			struct drm_rect *rect)
> +{
> +	int ret =3D 0, idx;
> +	struct ms91xx_device *ms91xx =3D to_ms91xx(fb->dev);
> +	struct drm_device *drm =3D &ms91xx->drm;
> +	struct ms91xx_usb_request *current_request;
> +	int x, width;
> +
> +	/* UYVY stores pixels in pairs. Expand damage to a complete pair. */
> +	x =3D ALIGN_DOWN(rect->x1, 2);
> +	width =3D min_t(int, ALIGN(rect->x2, 2), fb->width) - x;
> +	rect->x1 =3D x;
> +	rect->x2 =3D x + width;
> +	rect->y2 =3D min_t(unsigned int, rect->y2, fb->height);

[Severity: Medium]
What happens in ms91xx_fb_send_rect() when userspace creates a framebuffer
with an odd fb->width (for example, fb->width =3D 641 scanned out at 640x480
with a 1-pixel source X offset) and a damage clip reaches the right edge of
the framebuffer?

Here, min_t(int, ALIGN(rect->x2, 2), fb->width) clamps to the odd fb->width,
leaving both width and rect->x2 odd.

When ms91xx_fb_xrgb8888_to_yuv422() then calls drm_fb_xrgb8888_to_uyvy(),
drm_fb_xrgb8888_to_uyvy_line() only converts round_down(pixels, 2) pixels p=
er
line while drm_fb_xfrm() advances dst by width * 2 bytes per line. Because
request->transfer_buffer was allocated with vmalloc_32() in
ms91xx_init_request() without zeroing, doesn't this leave 2 bytes of
uninitialized vmalloc memory per scanline that get sent over USB?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019154820.6865=
9-1-hjf3108@gmail.com?part=3D3
