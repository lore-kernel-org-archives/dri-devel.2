Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61119606A323
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NnCHur+3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9518A10E33D;
	Thu, 12 Nov 2026 16:15:26 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8A5210E33D
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 16:15:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7F84A43A64;
 Thu, 12 Nov 2026 16:15:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439F21F000C7;
 Thu, 12 Nov 2026 16:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794500119;
 bh=u3fE95M3yt7xSQVPIVW0CdAAIehcJT8c/d6cX5om6RQ=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=NnCHur+3Ag4E/s81ImGBgSCllCZRFdlGUPItCB/hypJDT45uVDb/3RQfHFAKtanW9
 Ak3DzuJTYI+JzZ408cDLhLkFgY8HELnV5GUCZuPKRJjSxrEdTCJ/2Xp6U57jHFk+tn
 ec33xOVaMGw4NA7mq4Npi6j09db66Exxh9gdO4yOLNt+u1Yq+QpzeyGwSCoPshRg8V
 6gzyxezBVz3Xb1mfcbZvcaOxnNeetysw+gPGqDbDDHeL/ce7cagtPy0r/rbfvkRq8Y
 jqCjqR29Ylj+soV08ePe94beEE+DVOUjxUu7WINzrDmC1Rp11yNiD33zw2M74kRVR4
 j2/GODl9kPiCQ==
Message-ID: <sashiko-outbox-211483@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] drm/tiny: trigger5: Add MCT Trigger 5 USB display
 driver
To: "Jie Feng" <hjf3108@gmail.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261112154520.151617-1-hjf3108@gmail.com>
References: <20261112154520.151617-1-hjf3108@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 16:15:18 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] drm/tiny: trigger5: broken USB reset lifecycle in
  trigger5_reset()
- [Medium] drm/tiny: trigger5: unclipped src_rect in
  trigger5_plane_atomic_update()
- [Medium] drm/tiny: trigger5: bulk stream desync on mid-frame
  trigger5_submit_urb() error
--

commit efc535dee28f1fcc3c108a02e819d423382ef63b
Author: Ho Jie Feng <hjf3108@gmail.com>

drm/tiny: trigger5: Add MCT Trigger 5 USB display driver

This commit adds a DRM driver for MCT Trigger 5 USB 3 to HDMI/VGA display
adapters, implementing modesetting, EDID retrieval, and bulk URB frame
updates.

> diff --git a/drivers/gpu/drm/tiny/trigger5.c b/drivers/gpu/drm/tiny/trigg=
er5.c
> new file mode 100644
> index 0000000000000..46fa6e6babe9c
> --- /dev/null
> +++ b/drivers/gpu/drm/tiny/trigger5.c

[ ... ]

> +static void trigger5_reset(struct trigger5_device *trigger5, int err)
> +{
> +	if (!atomic_xchg(&trigger5->needs_reset, 1))
> +		usb_queue_reset_device(trigger5->intf);
> +
> +	drm_err(&trigger5->drm, "USB transfer failed: %d, resetting adapter\n",
> +		err);
> +}
> +
> +static void trigger5_urb_complete(struct urb *urb)
> +{
> +	struct trigger5_transfer *transfer =3D urb->context;
> +	struct trigger5_device *trigger5 =3D transfer->trigger5;
> +
> +	switch (urb->status) {
> +	case -ENOENT:
> +	case -ECONNRESET:
> +	case -ESHUTDOWN:
> +		break;
> +	case 0:
> +		if (urb->actual_length =3D=3D urb->transfer_buffer_length)
> +			break;
> +		fallthrough;
> +	default:
> +		trigger5_reset(trigger5, urb->status);
> +		break;
> +	}
> +
> +	complete(&transfer->done);
> +}
> +
> +static struct trigger5_transfer *
> +trigger5_get_next_urb(struct trigger5_device *trigger5)
> +{
> +	struct trigger5_transfer *transfer =3D
> +		&trigger5->transfers[trigger5->next_transfer];
> +
> +	if (atomic_read(&trigger5->needs_reset))
> +		return ERR_PTR(-EIO);
> +
> +	if (!wait_for_completion_timeout(&transfer->done,
> +					 msecs_to_jiffies(TRIGGER5_BULK_TIMEOUT_MS))) {
> +		trigger5_reset(trigger5, -ETIMEDOUT);
> +		return ERR_PTR(-ETIMEDOUT);
> +	}
> +
> +	trigger5->next_transfer =3D
> +		(trigger5->next_transfer + 1) % TRIGGER5_NUM_URBS;
> +
> +	return transfer;
> +}

[Severity: High]
Does trigger5_reset() cause the active DRM device to be permanently
unplugged or stuck returning -EIO after any USB transfer failure?

trigger5_driver does not define .pre_reset and .post_reset callbacks
(.reset_resume is only used when resuming a suspended device), so
usb_reset_device() falls back to usb_forced_unbind_intf(), which runs
trigger5_usb_disconnect() -> drm_dev_unplug() and kills the active DRM
device instead of resetting the adapter in place.

In addition, nothing in the driver ever clears trigger5->needs_reset once
trigger5_reset() sets it to 1, so if the queued reset does not unbind the
device (for example if usb_lock_device_for_reset() fails or after a
reset_resume), trigger5_get_next_urb() rejects all future display updates
with -EIO.

Two smaller issues in this path: trigger5_get_next_urb() only checks
trigger5->needs_reset before wait_for_completion_timeout(), so if the URB
being waited on completes with an error it still returns the transfer to
the caller; and on a short transfer in trigger5_urb_complete(), falling
through from case 0 passes urb->status (0) to trigger5_reset().

[ ... ]

> +static void trigger5_plane_atomic_update(struct drm_plane *plane,
> +					 struct drm_atomic_commit *atomic_state)
> +{

[ ... ]

> +	src_rect =3D drm_plane_state_src(state);
> +
> +	/* Match drm_atomic_helper_damage_iter_init() rounding. */
> +	src_rect.x1 >>=3D 16;
> +	src_rect.y1 >>=3D 16;
> +	src_rect.x2 =3D (src_rect.x2 >> 16) + !!(src_rect.x2 & 0xffff);
> +	src_rect.y2 =3D (src_rect.y2 >> 16) + !!(src_rect.y2 & 0xffff);
> +
> +	/* Clip merged damage to the new resolution. */
> +	if (!drm_rect_intersect(&current_rect, &src_rect))
> +		goto exit;
> +
> +	width =3D drm_rect_width(&current_rect);
> +	height =3D drm_rect_height(&current_rect);
> +	payload_len =3D array3_size(width, height, 3);
> +	lines_per_urb =3D TRIGGER5_URB_BUF_SIZE / (width * 3);
> +
> +	if (drm_gem_fb_begin_cpu_access(state->fb, DMA_FROM_DEVICE) < 0)
> +		goto exit;
> +
> +	transfer =3D trigger5_get_next_urb(trigger5);
> +	if (IS_ERR(transfer))
> +		goto exit_end_cpu_access;
> +
> +	header =3D transfer->urb->transfer_buffer;
> +	header->magic =3D 0xfb;
> +	header->length =3D 0x14;
> +	/* flags 0: uncompressed 24-bit RGB888. */
> +	header->counter =3D
> +		cpu_to_le16((trigger5->frame_counter++) & 0xfff);
> +	header->horizontal_offset =3D cpu_to_le16(current_rect.x1 - src_rect.x1=
);
> +	header->vertical_offset =3D cpu_to_le16(current_rect.y1 - src_rect.y1);
> +	header->width =3D cpu_to_le16(width);
> +	header->height =3D cpu_to_le16(height);
> +	header->payload_length =3D cpu_to_le32((u32)payload_len);

[Severity: Medium]
Should src_rect come from the clipped state->src (via
drm_rect_fp_to_int(&src_rect, &state->src)) rather than the unclipped
drm_plane_state_src(state)?

In trigger5_plane_atomic_check(), drm_atomic_helper_check_plane_state()
clips state->dst to the active CRTC mode and stores the visible source
rectangle in state->src, while leaving state->src_x/y/w/h unclipped.
Because drm_atomic_helper_damage_iter_init() also initializes its plane_src
from the unclipped drm_plane_state_src(state), intersecting current_rect
with drm_plane_state_src(state) here does not clip damage to the active
CRTC mode when a larger framebuffer (up to 8191x8191) is panned with
negative crtc_x/crtc_y, and outward rounding of fractional 16.16 src
coordinates expands src_rect by an extra pixel.  This computes
horizontal_offset and vertical_offset relative to the off-screen origin and
can send frame dimensions and payload_length exceeding the active display
mode and TRIGGER5_MAX_FRAME_SIZE.

> +	header->flags =3D 0x1;
> +	header->unknown1 =3D 0;
> +	header->unknown2 =3D 0;
> +	header->checksum =3D trigger5_bulk_header_checksum(header);
> +
> +	if (trigger5_submit_urb(transfer, sizeof(*header)))
> +		goto exit_end_cpu_access;
> +
> +	clip =3D current_rect;
> +	for (y =3D current_rect.y1; y < current_rect.y2; y +=3D lines_per_urb) {
> +		clip.y1 =3D y;
> +		clip.y2 =3D min(y + lines_per_urb, current_rect.y2);
> +
> +		transfer =3D trigger5_get_next_urb(trigger5);
> +		if (IS_ERR(transfer))
> +			break;
> +
> +		iosys_map_set_vaddr(&data_map, transfer->urb->transfer_buffer);
> +		drm_fb_xrgb8888_to_rgb888(&data_map, NULL,
> +					  &shadow_plane_state->data[0],
> +					  state->fb, &clip,
> +					  &shadow_plane_state->fmtcnv_state);
> +
> +		if (trigger5_submit_urb(transfer,
> +					width * 3 * drm_rect_height(&clip)))
> +			break;
> +	}

[Severity: Medium]
Does breaking out of this loop when trigger5_submit_urb() fails leave the
adapter's bulk stream out of sync?

At that point the 20-byte trigger5_bulk_header URB declaring
header->payload_length bytes has already been submitted, and unlike
trigger5_urb_complete() or trigger5_get_next_urb(), trigger5_submit_urb()
does not call trigger5_reset() on usb_submit_urb() failure.  The device
will keep waiting for the remaining bytes of the aborted frame and treat
subsequent frame headers and pixel data as part of the old payload.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112154520.1516=
17-1-hjf3108@gmail.com?part=3D1
