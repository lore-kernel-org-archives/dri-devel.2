Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D18606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S3jhyzPN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B0B510E2CE;
	Wed,  4 Nov 2026 16:37:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4057710FD25
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 16:36:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C094E42A13;
 Wed,  4 Nov 2026 16:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852E11F00A18;
 Wed,  4 Nov 2026 16:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793810213;
 bh=pXVT/9gcOu5VE9ndfR6M7TWCYP8mVwiDyfRaffl0aRY=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=S3jhyzPNcNip5dOTgKbvcHB7Z6gbfw+exfFruKNkOMGqTPxobakUB+wV2cMTSHSVg
 I6Or2TudqS+HqO8UjkXlyTxy5VgmwPDuk8h8uyZq4F/yUbCa0Z05dzoxWX9GUzeSNU
 +5Vfw24JdVWFnHz4hHQeJ/8iD6++v89NPcN/yhfVsFjLVVe/zp+8gHDmRM1ekdAjQK
 K15BRu1vCFeLFk0pAM+Mz3+elKTE1ueDN9ZeqQBw2IaH4zOnYagG3xmS1Q/GFPg45I
 GZUK9cn5DwnH5ivumdjN55UnXDSO50cV6RGWFhiVGQGLg8WdRL5+VoIvzuy2TIIEZQ
 Jzm7+FlTSjBUg==
Message-ID: <sashiko-outbox-197630@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] drm/ms91xx: Add Kconfig and Makefile integration
To: "Ho Jie Feng" <hjf3108@gmail.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261104151652.59135-5-hjf3108@gmail.com>
References: <20261104151652.59135-1-hjf3108@gmail.com>
 <20261104151652.59135-5-hjf3108@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:36:53 +0000
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
- [Medium] drm/ms91xx: missing rect->x1 even alignment in ms91xx_fb_send_re=
ct()
- [Medium] drm/ms91xx: lost frame damage on cancel_work() in ms91xx_plane_a=
tomic_update()
- [Medium] drm/ms91xx: devm_mutex_init() destroys ctrl_lock before drmm pol=
l teardown
--

commit 1cde8302b787ba6feaf5820dd66da0d09c56074d
Author: Ho Jie Feng <hjf3108@gmail.com>

drm/ms91xx: Add atomic modesetting and USB framebuffer transfers

This commit adds the atomic modesetting pipeline, double-buffered USB
framebuffer transfer handling, and USB probe/disconnect lifecycle for
MacroSilicon MS912x/MS913x display adapters.

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
[ ... ]
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
Can cancelling a pending work item here lose the damage rectangle from the
earlier in-flight frame on a double-buffered device?

Consider three consecutive atomic updates arriving while the first transfer=
 is
still running usb_sg_wait() on the ordered workqueue:

1. Frame 1 (damage R1) queues requests[0].work with transfer_rect =3D R1 and
   sets ms91xx->update_rect =3D R1. requests[0].work starts executing on the
   workqueue.

2. Frame 2 (damage R2) arrives while requests[0].work is still running.
   cancel_work(&requests[0].work) returns false, so requests[1].work is
   queued behind requests[0].work with transfer_rect =3D R2, and
   ms91xx->update_rect is overwritten with R2.

3. Frame 3 (damage R3) arrives while requests[0].work is still running and
   requests[1].work is still pending. cancel_work(&requests[1].work) returns
   true and cancels Frame 2 before it is sent to the device.

At that point, ms91xx_plane_atomic_update() merges requests[1].transfer_rect
(R2) into current_rect (producing R2 union R3), and then merges current_rect
with ms91xx->update_rect. Because ms91xx->update_rect was already overwritt=
en
with R2 during Frame 2, R1 (which was only written to the first hardware
buffer by requests[0]) is never included in the transfer for the second
hardware buffer, leaving that buffer with stale pixels in R1.

Should ms91xx->update_rect retain the damage of the last frame that was not
cancelled, or also merge the in-flight request's transfer_rect when a queued
request is cancelled?

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
Does initializing ms91xx->ctrl_lock with devm_mutex_init() after
devm_drm_dev_alloc() allow ctrl_lock to be destroyed before the DRM output
poll worker is stopped?

In ms91xx_usb_probe(), devm_drm_dev_alloc() registers its devres release
action on interface->dev first, and devm_mutex_init() registers the mutex
destruction action on interface->dev second. Later in ms91xx_usb_probe(),
drmm_kms_helper_poll_init(dev) starts output_poll_work and registers
drm_kms_helper_poll_fini() as a DRM-managed (drmm) cleanup action.

Because devres actions run in reverse registration order, if
drm_dev_register() fails (or during device teardown before the final
drm_dev_put()), devres destroys ms91xx->ctrl_lock before
devm_drm_dev_init_release() invokes drm_managed_release() and
drm_kms_helper_poll_fini(). While output_poll_work is still active,
output_poll_execute() -> ms91xx_detect() -> ms91xx_read_byte() can lock
ms91xx->ctrl_lock after it has been destroyed.

Should ms91xx->ctrl_lock be initialized with drmm_mutex_init(dev,
&ms91xx->ctrl_lock) instead so its lifetime is tied to the DRM device and
ordered ahead of drmm_kms_helper_poll_init(dev)?

> diff --git a/drivers/gpu/drm/ms91xx/ms91xx_transfer.c b/drivers/gpu/drm/m=
s91xx/ms91xx_transfer.c
> new file mode 100644
> index 0000000000000..0e26d5d7aab97
> --- /dev/null
> +++ b/drivers/gpu/drm/ms91xx/ms91xx_transfer.c
[ ... ]
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

[Severity: Medium]
What happens in ms91xx_fb_send_rect() when userspace submits a damage clip
where rect->x1 is odd?

UYVY packs horizontal pixel pairs at even-odd coordinates (2k, 2k + 1), and
drm_fb_xrgb8888_to_uyvy() requires both clip->x1 and clip->x2 to be even.
Here, x is assigned rect->x1 without rounding down to an even pixel boundar=
y,
and width is aligned to a multiple of 2, so both rect->x1 and rect->x2 rema=
in
odd when rect->x1 is odd.

In addition, if rect->x1 is odd and rect->x2 reaches fb->width (which is ev=
en
for all supported modes), fb->width - x is odd, so ALIGN(fb->width - x, 2)
produces fb->width - x + 1. The check:

	if (x + width > fb->width)
		width -=3D 2;

then subtracts 2 from width, setting rect->x2 =3D fb->width - 1 and droppin=
g the
rightmost column of damaged pixels. In the case of a 1-pixel-wide damage cl=
ip
at the right edge of the framebuffer (rect->x1 =3D=3D fb->width - 1,
rect->x2 =3D=3D fb->width), width becomes 0 and the pixel update is lost wh=
ile a
0-width transfer is queued.

Should rect->x1 be rounded down to an even coordinate first (for example wi=
th
ALIGN_DOWN(rect->x1, 2)) before computing width and rect->x2?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104151652.5913=
5-1-hjf3108@gmail.com?part=3D4
