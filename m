Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851ABCA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:28:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EED7810F084;
	Mon, 12 Oct 2026 13:28:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B55710F084
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:28:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8E68560AB0;
 Mon, 12 Oct 2026 13:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3711F0089B;
 Mon, 12 Oct 2026 13:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791811699;
 bh=5RkYw1jUMSO9K0oMx9m8+VLrq0jZMPyp0e0LrhGjpLM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=I3LRRz1JwRXFHwlmDQwWAro/hmRYC2kZeGGfNz23WfWPoUgrvwTKcaMVMK/yqCgp6
 NRvHqrIFEbKV8z+rDIfWmBN4cGap5HRE7ibNtEdF3+KSpbmhK5B57ZsRSLyFUefiUr
 9R4Z9mdI6COx7+vrqYFQ44o7KJhvmLy+/b9PaQFYnYXhu54XvOuLzNVbAom+KRvGGI
 SPIlziqWUT/AufAsTAGD2hRa1YQDJzoRnkqB94Kw/YrR5XzbNNSezZ8XvX4jtEwSHk
 K9a3z5kaVpQ1zRoBtv2nBYw2n043rLHdhg/OPJXILQDhzS+Oo6fDmcYN/5OxmKy9kF
 aELJnwI4BpYtQ==
Message-ID: <sashiko-outbox-168180@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] drm/trigger5: Add MCT Trigger 5 USB display driver
To: "Ho Jie Feng" <hjf3108@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261012131539.67790-1-hjf3108@gmail.com>
References: <20261012131539.67790-1-hjf3108@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:28:18 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm: sleeping in atomic context in plane and CRTC callbacks
- [Medium] drm/trigger5: deferred display damage is never flushed if usersp=
ace goes idle
--

commit 12d04056078c58dc5db832cf84f326c797a58e7c
Author: Ho Jie Feng <hjf3108@gmail.com>

drm/trigger5: Add MCT Trigger 5 USB display driver

This commit introduces a new DRM driver for MCT Trigger 5 USB display adapt=
ers.
It implements modesetting, USB framebuffer updates, connector detection, and
EDID retrieval based on reverse-engineered protocols.

> diff --git a/drivers/gpu/drm/tiny/trigger5.c b/drivers/gpu/drm/tiny/trigg=
er5.c
> new file mode 100644
> index 0000000000000..d0ab06bab8d73
> --- /dev/null
> +++ b/drivers/gpu/drm/tiny/trigger5.c
[ ... ]
> +static void trigger5_transfer_work(struct work_struct *work)
> +{
[ ... ]
> +	if (transfer->sgr.status)
> +		drm_err_ratelimited(&trigger5->drm,
> +				    "USB transfer failed: %d\n",
> +				    transfer->sgr.status);
> +	else if (transfer->sgr.bytes !=3D transfer->frame_len)
> +		drm_err_ratelimited(&trigger5->drm,
> +				    "short USB transfer: %zu/%zu bytes\n",
> +				    transfer->sgr.bytes, transfer->frame_len);
> +	else if (READ_ONCE(trigger5->display_enabled))
> +		/* Keepalive must only be sent after a frame has been sent */
> +		queue_delayed_work(trigger5->transfer_wq,
> +				   &trigger5->keepalive_work,
> +				   msecs_to_jiffies(TRIGGER5_KEEPALIVE_INTERVAL_MS));
> +
> +exit:
> +	drm_dev_exit(idx);
> +complete:
> +	complete(&transfer->frame_complete);
> +}

[Severity: Medium]
Does this transfer completion need to check for or schedule any work to han=
dle
damage deferred in pending_rect?

If userspace stops sending new frames (e.g., when the system goes idle), the
deferred damage might never get flushed to the screen.

[ ... ]
> +static void trigger5_crtc_atomic_enable(struct drm_crtc *crtc,
> +					struct drm_atomic_commit *state)
> +{
[ ... ]
> +	trigger5_stop_io(trigger5);
> +
> +	/* Sequence recovered from USB captures. */
> +	ret =3D usb_control_msg_recv(udev, 0,
> +				   TRIGGER5_REQUEST_FIRMWARE_RESET,
> +				   USB_DIR_IN | USB_TYPE_VENDOR |
> +					   USB_RECIP_DEVICE,
> +				   0x0000, 0x0000, data, 1,
> +				   USB_CTRL_GET_TIMEOUT, GFP_KERNEL);

[Severity: High]
Is it safe to use GFP_KERNEL and blocking USB functions here?

CRTC atomic enable callbacks are atomic context paths where sleeping is
strictly forbidden. Calling blocking USB transfers with the GFP_KERNEL flag
in this path violates DRM invariants and can cause kernel warnings or
deadlocks.

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
Similarly to the atomic enable callback, is it safe to use a blocking USB
function with GFP_KERNEL allocation here?

CRTC atomic disable callbacks are also atomic contexts where sleeping is
prohibited.

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
> +		goto exit_save_pending;

[Severity: High]
Can wait_for_completion_timeout() sleep in this context?

Plane atomic update callbacks execute in atomic context where sleeping is
forbidden. Blocking for up to 20ms here will cause system instability.

[Severity: Medium]
When this timeout occurs, the damage is saved to pending_rect, but no
asynchronous flush is queued to present it later.

As mentioned above in trigger5_transfer_work(), if the display update aborts
here and userspace stops sending new frames, the screen might permanently
display stale content.

[ ... ]
> +	iosys_map_set_vaddr(&data_map,
> +			    current_transfer->buf.data + sizeof(*header));
> +
> +	ret =3D drm_gem_fb_begin_cpu_access(state->fb, DMA_FROM_DEVICE);

[Severity: High]
Could this function acquire DMA reservation locks that might sleep?

Since this is still within the plane atomic update callback, calling a
function that can sleep violates the DRM atomic context rules.

> +	if (ret < 0) {
> +		complete(&current_transfer->frame_complete);
> +		goto exit_save_pending;
> +	}
> +
> +	drm_fb_xrgb8888_to_rgb888(&data_map, NULL,
> +				  &shadow_plane_state->data[0],
> +				  state->fb, &current_rect,
> +				  &shadow_plane_state->fmtcnv_state);
> +
> +	drm_gem_fb_end_cpu_access(state->fb, DMA_FROM_DEVICE);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012131539.6779=
0-1-hjf3108@gmail.com?part=3D1
