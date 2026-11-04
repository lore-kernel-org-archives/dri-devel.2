Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0793C606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IgSTM9tc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2808310FCC8;
	Wed,  4 Nov 2026 16:11:20 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE51D10FCC8
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 16:11:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0A3816022B;
 Wed,  4 Nov 2026 16:11:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9949A1F000C1;
 Wed,  4 Nov 2026 16:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793808672;
 bh=hz9B7bVRYk0DuEF9JM8LNaTKrTabfofd6sN4pUbGYgU=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=IgSTM9tcFB1XTJnSYm1wG4U8srXPaqU/oK8Wz9zfbmZQBarKkT0QiMsjN3/phfSVE
 JMlfn0qtm6heh6PGhLsBwlvC/U4hFeiQxS+LtWpybCtp5Es5bbsrwu3051bCWc48Qi
 ZPnrJjgvihp2kAx8PDQ+tsP33DA3lrzzH2wGf21w/R0HgGRjvBfm6u2lYgZj8ehw/g
 YS9fOnQWdx0D18M4lG9EBk6EiSYcT5XotLLjDM733Rb3NROCRz/t9MR5Zv6WNeFqgj
 gPY4z0RI+FvWMyLGz49hQ4zpXG99SLSStQOHctj4jVAELbF4h5WhmxAyivxrjcVYeu
 En00nPl9Yv+dA==
Message-ID: <sashiko-outbox-197582@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] drm/ms91xx: Add atomic modesetting and USB
 framebuffer transfers
To: "Ho Jie Feng" <hjf3108@gmail.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261104151652.59135-4-hjf3108@gmail.com>
References: <20261104151652.59135-1-hjf3108@gmail.com>
 <20261104151652.59135-4-hjf3108@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:11:12 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/ms91xx: lost damage rects in ms91xx_plane_atomic_update()
- [High] drm/ms91xx: unaligned odd x1 and dropped edge damage in ms91xx_fb_=
send_rect()
- [Medium] drm/ms91xx: devm vs drmm lifetime mismatch for ctrl_lock in ms91=
xx_usb_probe()
--

commit 1cde8302b787ba6feaf5820dd66da0d09c56074d
Author: Ho Jie Feng <hjf3108@gmail.com>

drm/ms91xx: Add atomic modesetting and USB framebuffer transfers

This commit adds the atomic display pipeline, USB driver probe/disconnect
handling, and double-buffered USB framebuffer transfers with XRGB8888 to
UYVY conversion for MacroSilicon ms91xx display adapters.

> diff --git a/drivers/gpu/drm/ms91xx/ms91xx_drv.c b/drivers/gpu/drm/ms91xx=
/ms91xx_drv.c
> new file mode 100644
> index 0000000000000..7b8d1f1e30e9d
> --- /dev/null
> +++ b/drivers/gpu/drm/ms91xx/ms91xx_drv.c

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

[Severity: High]
Can ms91xx_plane_atomic_update() drop damage rectangles from one of the
device's two hardware framebuffers when a queued work item is cancelled or
when ms91xx_fb_send_rect() fails?

Because the hardware double-buffers frame updates, each damage rectangle mu=
st
be sent in two consecutive completed USB transfers:

1. Frame 1 (damage R1) sets requests[0].transfer_rect =3D R1, queues
   requests[0].work (which starts executing usb_sg_wait() to update hardware
   buffer A), flips ms91xx->current_request to 1, and sets
   ms91xx->update_rect =3D R1.

2. Frame 2 (damage R2) arrives while requests[0].work is still running.
   cancel_work(&requests[0].work) returns false. requests[1].transfer_rect =
is
   set to R2, rect is computed as R2 union R1, requests[1].work is queued
   behind requests[0].work on the ordered workqueue, ms91xx->current_request
   becomes 0, and ms91xx->update_rect is overwritten with R2.

3. Frame 3 (damage R3) arrives while requests[0].work is still running and
   requests[1].work is still pending. cancel_work(&previous_request->work)
   cancels requests[1].work before R2 union R1 is sent to hardware buffer B.
   ms91xx_plane_atomic_update() merges current_rect (R3) with
   previous_request->transfer_rect (R2) and then merges that with
   ms91xx->update_rect (which is also R2). R1 is lost and never sent to
   hardware buffer B.

In addition, current_request->transfer_rect =3D current_rect is written bef=
ore
ms91xx_fb_send_rect() waits on wait_for_completion_timeout(&current_request=
->done, ...),
so a timeout overwrites the in-flight request's transfer_rect. And when
ms91xx_fb_send_rect() fails, merging rect into ms91xx->update_rect only sen=
ds
that failed frame's damage in the single next transfer before
ms91xx->update_rect =3D current_rect overwrites it, leaving the second hard=
ware
buffer stale on the following frame.

[ ... ]

> +static int ms91xx_usb_probe(struct usb_interface *interface,
> +			    const struct usb_device_id *id)
> +{
> +	int ret;
> +	unsigned int i;
> +	struct ms91xx_device *ms91xx;
> +	struct drm_device *dev;
> +	struct device *dma_dev;
> +	struct usb_device *usbdev;
> +
> +	ms91xx =3D devm_drm_dev_alloc(&interface->dev, &ms91xx_drm_driver,
> +				    struct ms91xx_device, drm);
> +	if (IS_ERR(ms91xx))
> +		return PTR_ERR(ms91xx);
> +
> +	ms91xx->intf =3D interface;
> +	ret =3D devm_mutex_init(&interface->dev, &ms91xx->ctrl_lock);
> +	if (ret)
> +		return ret;

[ ... ]

> +	drmm_kms_helper_poll_init(dev);
> +
> +	ret =3D drm_dev_register(dev, 0);
> +	if (ret)
> +		goto err_free_request_1;

[Severity: Medium]
Should ms91xx->ctrl_lock be initialized with drmm_mutex_init() instead of
devm_mutex_init() in ms91xx_usb_probe()?

In ms91xx_usb_probe(), devm_drm_dev_alloc(&interface->dev, ...) is register=
ed
first on interface->dev, followed by devm_mutex_init(&interface->dev,
&ms91xx->ctrl_lock). Later, drmm_kms_helper_poll_init(dev) starts
dev->mode_config.output_poll_work, whose cleanup is tied to the drm_device
via drm_managed_release().

If drm_dev_register(dev, 0) fails, devres unwinds interface->dev in reverse
order: devm_mutex_release destroys ms91xx->ctrl_lock before
devm_drm_dev_init_release runs drm_dev_put() -> drm_managed_release() ->
drm_kms_helper_poll_init_release() to cancel output_poll_work. If
output_poll_work runs ms91xx_detect() -> ms91xx_read_byte() during that
window, it will lock ms91xx->ctrl_lock after it has already been destroyed.

> diff --git a/drivers/gpu/drm/ms91xx/ms91xx_transfer.c b/drivers/gpu/drm/m=
s91xx/ms91xx_transfer.c
> new file mode 100644
> index 0000000000000..0e26d5d7aab97
> --- /dev/null
> +++ b/drivers/gpu/drm/ms91xx/ms91xx_transfer.c

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
> +	x =3D rect->x1;
> +	width =3D ALIGN(min_t(int, rect->x2, fb->width) - x, 2);
> +	if (x + width > fb->width)
> +		width -=3D 2;
> +	rect->x2 =3D x + width;

[Severity: High]
What happens in ms91xx_fb_send_rect() when rect->x1 is odd?

UYVY packs horizontal pixel pairs (2k, 2k + 1) into 4-byte macropixels, and
drm_fb_xrgb8888_to_uyvy() requires clip->x1 and clip->x2 to be even.

In ms91xx_fb_send_rect(), x =3D rect->x1 is not aligned down to an even pix=
el
boundary, and only width is aligned to a multiple of 2. When rect->x1 is od=
d:

1. Both rect->x1 and rect->x2 remain odd when passed to
   ms91xx_fb_xrgb8888_to_yuv422() -> drm_fb_xrgb8888_to_uyvy(), pairing
   misaligned pixels (2k + 1, 2k + 2) instead of (2k, 2k + 1).

2. When the damage clip reaches the right edge of the framebuffer
   (rect->x2 =3D=3D fb->width, where fb->width is even), fb->width - x is o=
dd, so
   ALIGN(fb->width - x, 2) rounds up to fb->width - x + 1 and x + width
   becomes fb->width + 1. The check:

	if (x + width > fb->width)
		width -=3D 2;

   then subtracts 2 from width, setting rect->x2 =3D fb->width - 1 and drop=
ping
   the rightmost pixel column. In particular, if a 1-pixel damage clip is at
   the right edge (rect->x1 =3D=3D fb->width - 1, rect->x2 =3D=3D fb->width=
), width
   becomes 0 and a 0-width frame update is queued over USB.

Should rect->x1 be rounded down to an even coordinate (for example with
round_down(rect->x1, 2)) and rect->x2 be aligned up with ALIGN(min_t(int,
rect->x2, fb->width), 2)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104151652.5913=
5-1-hjf3108@gmail.com?part=3D3
