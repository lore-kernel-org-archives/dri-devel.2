Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51C1CA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 390CF10F7F5;
	Fri,  2 Oct 2026 09:14:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M5NXeaKb";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 395C010F7F9
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 09:14:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B0EC760A6A;
 Fri,  2 Oct 2026 09:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473D31F000FF;
 Fri,  2 Oct 2026 09:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790932483;
 bh=GeIt2uynaYBrnVuhvM47D2l2CXWrxXxR6NBRpVSyFGY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M5NXeaKbtz8YGtaIAOdIX/KvzzK4IEbgmu/DPPb/6agLTu7z2WH/WhR4YE57+h3AG
 XJ+q/OeSe0DKOwu9EVpoWBRssAEu+5YCPIGIccyFuMA5zugzQFkeTzANcta+FMt8Uo
 pyHtQXerSJoYygBXgdJ3dFx2PNOISMaKsn0Vv1nSEmaslp2G2IEwJFXOm76OMuXyFf
 Z7LRsTUgLDWH/Jq7ndoJ1aprggx4O7cYdsnvDrQ+OsTlLGvAnaVLd+XUSPACoqUMBv
 lP+gVU2c2iYy4Kegzh03c4Npz7ZFCshci/aK/t45V4RMH5E+JFkceD2TuAr9j2h+wQ
 qE/JOMZLfyNEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/trigger5: Add MCT Trigger 5 USB display driver
To: "Ho Jie Feng" <hjf3108@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261002073617.37137-1-hjf3108@gmail.com>
References: <20261002073617.37137-1-hjf3108@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:42 +0000
Message-Id: <20261002091443.473D31F000FF@smtp.kernel.org>
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
- [High] drm/trigger5: sleeping functions called from atomic context in com=
mit callbacks
--

commit 4bfd327671381f9e3b72403f14f247b30db4659a
Author: Ho Jie Feng <hjf3108@gmail.com>
Subject: drm/trigger5: Add MCT Trigger 5 USB display driver

This commit introduces a DRM driver for MCT Trigger 5 USB display adapters.=
=20
It implements modesetting, USB framebuffer updates, connector detection,=20
and EDID retrieval, utilizing reverse-engineered USB protocol structures.

> diff --git a/drivers/gpu/drm/trigger5/trigger5_drv.c b/drivers/gpu/drm/tr=
igger5/trigger5_drv.c
> --- /dev/null
> +++ b/drivers/gpu/drm/trigger5/trigger5_drv.c

[ ... ]

> +static void trigger5_atomic_commit_tail(struct drm_atomic_commit *state)
> +{
> +	struct trigger5_device *trigger5 =3D to_trigger5(state->dev);
> +	struct drm_crtc_state *crtc_state;
> +	struct trigger5_crtc_state *tstate;
> +	int idx, i;
> +
> +	crtc_state =3D drm_atomic_get_new_crtc_state(state, &trigger5->crtc);
> +	if (!crtc_state)
> +		goto commit;
> +
> +	tstate =3D to_trigger5_crtc_state(crtc_state);
> +	if (!tstate->bufs[0].data)
> +		goto commit;
> +
> +	if (!drm_dev_enter(state->dev, &idx))
> +		goto commit;
> +
> +	trigger5_stop_io(trigger5);

[Severity: High]
Is it safe to call trigger5_stop_io() from trigger5_atomic_commit_tail()?=20
trigger5_stop_io() invokes flush_workqueue() and cancel_delayed_work_sync(),
both of which sleep. Calling sleeping functions from atomic commit paths ca=
n=20
lead to system deadlocks and "sleeping function called from invalid context=
"=20
kernel panics.

[ ... ]

> +static void trigger5_crtc_atomic_enable(struct drm_crtc *crtc,
> +					struct drm_atomic_commit *state)
> +{
> +	struct trigger5_device *trigger5 =3D to_trigger5(crtc->dev);
> +	struct usb_device *udev =3D interface_to_usbdev(trigger5->intf);
> +	struct drm_crtc_state *crtc_state =3D
> +		drm_atomic_get_new_crtc_state(state, crtc);
> +	struct drm_display_mode *mode =3D &crtc_state->mode;
> +	struct trigger5_mode_request request =3D {};
> +	u8 data[4];
> +	u64 clk;
> +	int idx, ret;
> +
> +	if (!drm_dev_enter(crtc->dev, &idx))
> +		return;
> +
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
Could this usb_control_msg_recv() call sleep in atomic context? The=20
trigger5_crtc_atomic_enable() callback executes in atomic context where
sleeping is forbidden. However, it performs synchronous USB I/O and uses a
GFP_KERNEL allocation, both of which sleep and may cause instability.

[ ... ]

> +	trigger5_calculate_pll(&request.pll, mode->clock);
> +	clk =3D div_u64(10000000ULL * request.pll.mul1 * request.pll.mul2,
> +		      (u32)request.pll.prediv * request.pll.div1 *
> +			      request.pll.div2 * 1000);
> +	drm_dbg_kms(&trigger5->drm,
> +		    "pll: %02x %02x %02x %02x %02x -> %llu kHz (want %d kHz)\n",
> +		    request.pll.prediv, request.pll.mul1, request.pll.mul2,
> +		    request.pll.div1, request.pll.div2, clk, mode->clock);
> +
> +	/* wValue can be any value since we are sending a custom mode */
> +	ret =3D usb_control_msg_send(udev, 0, TRIGGER5_REQUEST_SET_MODE,
> +				   USB_DIR_OUT | USB_TYPE_VENDOR |
> +					   USB_RECIP_DEVICE,
> +				   0, 0, &request, sizeof(request),
> +				   USB_CTRL_SET_TIMEOUT, GFP_KERNEL);

[Severity: High]
Does this sequence trigger a sleep inside the CRTC atomic enable callback?
usb_control_msg_send() is a sleeping function and also performs a GFP_KERNEL
allocation, which can lead to deadlocks since this code path executes in=20
atomic context.

[ ... ]

> +static void trigger5_crtc_atomic_disable(struct drm_crtc *crtc,
> +					 struct drm_atomic_commit *state)
> +{
> +	struct trigger5_device *trigger5 =3D to_trigger5(crtc->dev);
> +	struct usb_device *udev =3D interface_to_usbdev(trigger5->intf);
> +	u8 data;
> +	int idx, ret;
> +
> +	if (!drm_dev_enter(crtc->dev, &idx))
> +		return;
> +
> +	trigger5_stop_io(trigger5);
> +
> +	ret =3D usb_control_msg_recv(udev, 0,
> +				   TRIGGER5_REQUEST_FIRMWARE_RESET,
> +				   USB_DIR_IN | USB_TYPE_VENDOR |
> +					   USB_RECIP_DEVICE,
> +				   0x0001, 0x0000, &data, 1,
> +				   USB_CTRL_GET_TIMEOUT, GFP_KERNEL);

[Severity: High]
Can this control message execution cause a kernel panic? Like atomic_enable,
trigger5_crtc_atomic_disable() runs in atomic context. Executing a=20
synchronous USB control message with a GFP_KERNEL allocation here will slee=
p=20
and may cause issues.

[ ... ]

> +static void trigger5_plane_atomic_update(struct drm_plane *plane,
> +					 struct drm_atomic_commit *atomic_state)
> +{
> +	struct drm_plane_state *old_state =3D
> +		drm_atomic_get_old_plane_state(atomic_state, plane);

[ ... ]

> +	/* Buffers are sized for the full mode in crtc atomic_check. */
> +	if (drm_WARN_ON_ONCE(plane->dev, frame_len > current_transfer->buf.len))
> +		goto exit;
> +
> +	/*
> +	 * This should almost never wait because we have should have a
> +	 * pending transfer ready to be de-queued above in case the transfer
> +	 * hasn't finished, but do a bounded wait just in case it gets stuck
> +	 */
> +	if (!wait_for_completion_timeout(&current_transfer->frame_complete,
> +					 msecs_to_jiffies(20)))
> +		goto exit_save_pending;

[Severity: High]
Could this bounded wait result in sleeping in atomic context?
trigger5_plane_atomic_update() runs as a plane atomic update callback, which
executes in atomic context. Calling wait_for_completion_timeout() directly=
=20
inside this path violates the DRM subsystem guidelines against sleeping in=
=20
atomic commit paths.

[ ... ]

> +	header->checksum =3D trigger5_bulk_header_checksum(header);
> +
> +	iosys_map_set_vaddr(&data_map,
> +			    current_transfer->buf.data + sizeof(*header));
> +
> +	ret =3D drm_gem_fb_begin_cpu_access(state->fb, DMA_FROM_DEVICE);

[Severity: High]
Is it possible for drm_gem_fb_begin_cpu_access() to block here?
This function takes DMA reservation locks and may sleep waiting for fences.=
=20
Because trigger5_plane_atomic_update() executes in atomic context, blocking=
=20
here might lead to instability or system deadlocks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002073617.3713=
7-1-hjf3108@gmail.com?part=3D1
