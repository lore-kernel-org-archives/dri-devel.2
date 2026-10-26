Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E1A606A33E
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bwueTXKD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8761E10EE9D;
	Mon, 26 Oct 2026 12:05:58 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C317A10EE9D
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 12:05:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8D1374037D;
 Mon, 26 Oct 2026 12:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9481F01829;
 Mon, 26 Oct 2026 12:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793016351;
 bh=b/EoxHgXxoHVV1sbCTy9DmUFrIlP1/Xin6XKHVoZKPA=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=bwueTXKDQb6+EFsVWh2+YeUQ1ZemmTQZa71Fgrjnl4XhIR9r4eddio9x0YiLaIetz
 VQfkozV7vgE+VgQKdyLfJbnbOjBMceYgp+lhwjgrMP7ZKEXa80JEBmiE8uwLraYekm
 Bz9WbmAsHU1N6cCmxhD/lcBngby+24ZJVjaR8N/csQn2m2v744a0qCC9ACHhCD2qq4
 xR3olW2KsKfidTCxFeoyo00/1/f2zpTG5HV00noUIuIGLN6cTznpFfLE3Mr81KBeG8
 nMRdVaHqZzm+4b+T48C9iXu6iiUfPLlBuPPmGCPYxcPKXKug+wvsV+y5TFWe87g8WR
 JSzk0BJORX5Pg==
Message-ID: <sashiko-outbox-185159@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] drm/tiny: trigger5: Add MCT Trigger 5 USB display
 driver
To: "Ho Jie Feng" <hjf3108@gmail.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261026112843.69795-1-hjf3108@gmail.com>
References: <20261026112843.69795-1-hjf3108@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 12:05:50 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/tiny: trigger5: unclipped src rect in trigger5_plane_atomic_=
update()
--

commit 56412e719e880a97ad42bea1ca53d34f2a12fdb6
Author: Ho Jie Feng <hjf3108@gmail.com>

drm/tiny: trigger5: Add MCT Trigger 5 USB display driver

This commit adds a DRM driver for USB 3 to HDMI and VGA display adapters ba=
sed
on the MCT Trigger 5 chipset, implementing modesetting, USB framebuffer
updates, connector detection, and EDID retrieval.

> diff --git a/drivers/gpu/drm/tiny/trigger5.c b/drivers/gpu/drm/tiny/trigg=
er5.c
> new file mode 100644
> index 0000000000000..d0ab06bab8d73
> --- /dev/null
> +++ b/drivers/gpu/drm/tiny/trigger5.c
[ ... ]
> +static enum drm_mode_status
> +trigger5_crtc_mode_valid(struct drm_crtc *crtc,
> +			 const struct drm_display_mode *mode)
> +{
> +	struct trigger5_pll pll;
> +	u64 err, ppm;
> +
> +	if (mode->hsync_end <=3D mode->hsync_start ||
> +	    mode->htotal <=3D mode->hsync_end ||
> +	    mode->htotal > U16_MAX + 1)
> +		return MODE_H_ILLEGAL;
> +
> +	if (mode->vsync_end <=3D mode->vsync_start ||
> +	    mode->vtotal <=3D mode->vsync_end ||
> +	    mode->vtotal > U16_MAX + 1)
> +		return MODE_V_ILLEGAL;
> +
> +	if (trigger5_mode_buf_len(mode) > TRIGGER5_TRANSFER_BUF_SIZE)
> +		return MODE_MEM;
[ ... ]
> +static int trigger5_plane_atomic_check(struct drm_plane *plane,
> +				       struct drm_atomic_commit *state)
> +{
[ ... ]
> +	ret =3D drm_atomic_helper_check_plane_state(new_plane_state,
> +						  new_crtc_state,
> +						  DRM_PLANE_NO_SCALING,
> +						  DRM_PLANE_NO_SCALING,
> +						  false, false);
> +	if (ret || !new_plane_state->visible)
> +		return ret;
[ ... ]
> +static void trigger5_plane_atomic_update(struct drm_plane *plane,
> +					 struct drm_atomic_commit *atomic_state)
> +{
[ ... ]
> +	current_transfer =3D
> +		&trigger5->transfers[trigger5->current_transfer];
> +	previous_transfer =3D &trigger5->transfers[1 - trigger5->current_transf=
er];
> +
> +	src_rect =3D drm_plane_state_src(state);
> +
> +	/* Match drm_atomic_helper_damage_iter_init() rounding. */
> +	src_rect.x1 >>=3D 16;
> +	src_rect.y1 >>=3D 16;
> +	src_rect.x2 =3D (src_rect.x2 >> 16) + !!(src_rect.x2 & 0xffff);
> +	src_rect.y2 =3D (src_rect.y2 >> 16) + !!(src_rect.y2 & 0xffff);
> +
> +	/* Latency reduction: requeue with the latest frame data. */
> +	if (cancel_work(&previous_transfer->transfer_work)) {
> +		complete(&previous_transfer->frame_complete);
> +
> +		trigger5_merge_rect(&current_rect, &previous_transfer->transfer_rect);
> +
> +		current_transfer =3D previous_transfer;
> +		trigger5->current_transfer =3D !trigger5->current_transfer;
> +	}
> +
> +	/* Damage deferred by an earlier failed update. */
> +	trigger5_merge_rect(&current_rect, &trigger5->pending_rect);
> +	trigger5_clear_rect(&trigger5->pending_rect);
> +
> +	/* Clip merged damage to the new resolution. */
> +	if (!drm_rect_intersect(&current_rect, &src_rect))
> +		goto exit;
> +
> +	width =3D drm_rect_width(&current_rect);
> +	height =3D drm_rect_height(&current_rect);
> +	payload_len =3D array3_size(width, height, 3);
> +	frame_len =3D size_add(payload_len, sizeof(*header));
> +
> +	if (drm_WARN_ON_ONCE(plane->dev, frame_len > current_transfer->buf.len))
> +		goto exit;

[Severity: Medium]
Can src_rect in trigger5_plane_atomic_update() exceed the active CRTC mode
dimensions and overflow the 8 MiB limit checked in trigger5_crtc_mode_valid=
()?

In trigger5_plane_atomic_check(), drm_atomic_helper_check_plane_state() cli=
ps
new_plane_state->dst to (0, 0)-(mode->hdisplay, mode->vdisplay) and stores =
the
clipped source coordinates in new_plane_state->src, while leaving the
unclipped new_plane_state->src_x, src_y, src_w, and src_h unchanged. Because
drm_atomic_helper_check_plane_state() checks drm_rect_equals(dst, &clip) af=
ter
clipping dst, a plane update on a larger framebuffer with crtc_x <=3D 0,
crtc_y <=3D 0, and unclipped src_w/src_h larger than mode->hdisplay and
mode->vdisplay passes validation.

In addition, drm_atomic_helper_check_plane_state() does not reject non-zero
16.16 fixed-point fractional bits in src_x or src_y when panning within a
larger framebuffer. Rounding src_rect.x1/y1 down and src_rect.x2/y2 up expa=
nds
the dimensions of src_rect by an extra pixel to mode->hdisplay + 1 and
mode->vdisplay + 1.

Because trigger5_plane_atomic_update() builds src_rect from the unclipped
drm_plane_state_src(state) rather than the clipped state->src, current_rect
after drm_rect_intersect(&current_rect, &src_rect) can exceed mode->hdispla=
y x
mode->vdisplay. When frame_len exceeds current_transfer->buf.len, this
triggers drm_WARN_ON_ONCE() and jumps to exit after trigger5->pending_rect =
was
already cleared and previous_transfer->transfer_work was potentially
cancelled, dropping that damage. When frame_len still fits within
current_transfer->buf.len, the bulk header is sent with width and height
larger than the configured mode and offsets computed relative to the unclip=
ped
off-screen src_rect.x1/y1.

Should trigger5_plane_atomic_update() use state->src instead of
drm_plane_state_src(state), and should trigger5_plane_atomic_check() reject
fractional source coordinates or unclipped planes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026112843.6979=
5-1-hjf3108@gmail.com?part=3D1
