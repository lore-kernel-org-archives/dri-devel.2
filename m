Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F225C79FBF
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 17:31:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 603E710E0F0;
	Thu, 10 Sep 2026 17:31:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iTvTXd4d";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0AA610E0F0
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 17:31:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B409560209;
 Thu, 10 Sep 2026 17:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DCE1F000FF;
 Thu, 10 Sep 2026 17:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789061480;
 bh=AT7RHzuy5xTiDByRI32+1XWGXhAGqA41yifIec9uja0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iTvTXd4d1iHWaOUmBgbgXKYN2j49cVQLaaJuRA66LWilF02VB3EOu2D+rePl8FYB0
 o5QLEX5u1VLUZ36RXSKbI7vPn3F9AoF2VXaI/ExuOhQcCgq+xkECcMbI2/jYz1lK/w
 ENGtg3UfgXFmtBNUpc3iSiqjhykKOVuacrRQhJ2xTsbr6dduNI0ujoxfYuUXZkPVfQ
 sUuwFaLb+XLWTAzG7pAgMH6w1Lf2bMfWZY33mbXBpeXSlwOOvhwfSDLHqhC03m68f8
 cHLHP+oHSCiLMW+5Kz/ZOb3ls7g4kYURuZXcqhlAI3T7MJoFlTq1IZyEoUyNhKjLgh
 DLY2WlL4xwhPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/trigger5: Add MCT Trigger 5 USB display driver
To: "Ho Jie Feng" <hjf3108@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260910171709.396071-1-hjf3108@gmail.com>
References: <20260910171709.396071-1-hjf3108@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 17:31:19 +0000
Message-Id: <20260910173120.49DCE1F000FF@smtp.kernel.org>
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
- [High] Sleeping functions and blocking waits are called from atomic DRM c=
allbacks (plane update, CRTC enable/disable), violating KMS atomic context =
rules.
--

commit d1b842a91c5fa632149bc045bac81f4636faed1b
Author: Ho Jie Feng <hjf3108@gmail.com>
drm/trigger5: Add MCT Trigger 5 USB display driver

This commit adds a DRM driver for MCT Trigger 5 USB display adapters. It
implements modesetting, USB framebuffer updates, connector detection, and
EDID retrieval.

> diff --git a/drivers/gpu/drm/trigger5/trigger5_drv.c b/drivers/gpu/drm/tr=
igger5/trigger5_drv.c
> --- /dev/null
> +++ b/drivers/gpu/drm/trigger5/trigger5_drv.c
[ ... ]
> +static void trigger5_crtc_atomic_enable(struct drm_crtc *crtc,
> +					struct drm_atomic_commit *state)
> +{
[ ... ]
> +	if (!drm_dev_enter(crtc->dev, &idx))
> +		return;
> +
> +	trigger5_stop_io(trigger5);

[Severity: High]
Can this cause a "scheduling while atomic" bug? The CRTC atomic enable=20
callback runs in atomic context, but trigger5_stop_io() calls=20
flush_workqueue() and cancel_delayed_work_sync(), both of which can sleep.

> +
> +	/* Sequence recovered from USB captures. */
> +	ret =3D usb_control_msg_recv(udev, 0,
> +				   TRIGGER5_REQUEST_FIRMWARE_RESET,
> +				   USB_DIR_IN | USB_TYPE_VENDOR |
> +					   USB_RECIP_DEVICE,
> +				   0x0000, 0x0000, data, 1,
> +				   USB_CTRL_GET_TIMEOUT, GFP_KERNEL);

[Severity: High]
Does this synchronous USB transfer sleep? usb_control_msg_recv() allocates=
=20
with GFP_KERNEL and blocks for the transfer. Running this in the CRTC=20
atomic enable path violates the non-blocking requirement of atomic context.

[ ... ]
> +static void trigger5_crtc_atomic_disable(struct drm_crtc *crtc,
> +					 struct drm_atomic_commit *state)
> +{
[ ... ]
> +	trigger5_stop_io(trigger5);
> +
> +	ret =3D usb_control_msg_recv(udev, 0,
> +				   TRIGGER5_REQUEST_FIRMWARE_RESET,
> +				   USB_DIR_IN | USB_TYPE_VENDOR |
> +					   USB_RECIP_DEVICE,
> +				   0x0001, 0x0000, &data, 1,
> +				   USB_CTRL_GET_TIMEOUT, GFP_KERNEL);

[Severity: High]
Similarly, could this cause a deadlock or crash? The CRTC atomic disable=20
callback runs in atomic context, but this executes a blocking USB transfer=
=20
and uses GFP_KERNEL allocations.

[ ... ]
> +static void trigger5_plane_atomic_update(struct drm_plane *plane,
> +					 struct drm_atomic_commit *atomic_state)
> +{
[ ... ]
> +	/*
> +	 * This should almost never wait because we have should have a
> +	 * pending transfer ready to be de-queued above in case the transfer
> +	 * hasn't finished, but do a bounded wait just in case it gets stuck
> +	 */
> +	if (!wait_for_completion_timeout(&current_transfer->frame_complete,
> +					 msecs_to_jiffies(20)))

[Severity: High]
Is it safe to perform a blocking wait directly inside the plane's atomic=20
update callback? Plane atomic updates run in atomic context and must not=20
sleep.

[ ... ]
> +	/* Resize buffer to the current resolution for lower memory footprint */
> +	max_len =3D array3_size(drm_rect_width(&src_rect),
> +			      drm_rect_height(&src_rect), 3);
> +	max_len =3D size_add(max_len, sizeof(*header));
> +
> +	/*
> +	 * Allocation failure leaves the old buffer available for smaller
> +	 * partial updates.
> +	 */
> +	if (max_len !=3D current_transfer->frame_alloc_len)
> +		trigger5_resize_bulk_buffer(current_transfer, max_len);

[Severity: High]
Does this invoke memory allocations from an atomic context?=20
trigger5_resize_bulk_buffer() calls vmalloc_32() and kmalloc_array() with=20
GFP_KERNEL, which will sleep and lead to system instability in the atomic=20
update path.

[ ... ]
> +	iosys_map_set_vaddr(&data_map,
> +			    current_transfer->frame_data + sizeof(*header));
> +
> +	ret =3D drm_gem_fb_begin_cpu_access(state->fb, DMA_FROM_DEVICE);

[Severity: High]
Can this attempt to take dma_resv locks and wait for fences in atomic=20
context? Also, is this call redundant here since the=20
DRM_GEM_SHADOW_PLANE_HELPER_FUNCS prepare_fb callback already maps it=20
asynchronously?

> +	if (ret < 0) {
> +		complete(&current_transfer->frame_complete);
> +		goto exit_save_pending;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910171709.3960=
71-1-hjf3108@gmail.com?part=3D1
