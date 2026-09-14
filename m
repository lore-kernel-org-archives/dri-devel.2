Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72E9C88E5C
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 02:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F73010E4BC;
	Mon, 14 Sep 2026 02:29:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YEiVw+tC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A730C10EAE4
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 02:29:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E4CFE61099;
 Mon, 14 Sep 2026 02:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3FC1F000FF;
 Mon, 14 Sep 2026 02:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789352968;
 bh=32F/YfLl4zc/aHD8vkSjJFRBdlZ4Q/uvj1sS/QdmmCw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YEiVw+tCWkTILrThO2pHucujMPkGduPFDXAxUEkAc6z1VyUdYpsHAKM1QbgiyNSAE
 Ei2JFuDrI13bpbGIYCKyBATvl7XXWMursjzS62dO1xn/XwImSgd3JM0k6LlwwOLoLs
 klkEDH58IVOVsK5vCTYf4m8X9vt19SWizCW0bvwVtyz95lUV6jSLff1SrMOIdMGGpc
 vhlSRy+ufHR8S24fpdjuyI53c0ruter+nU7EiO1DyuHGeVamRZL9AbFci3N+nRIViJ
 HxQ8WCLiYyS2dcRXqahawQWzgtauWcKX9A/GIr6SpOPaQdOyi4q7Eymt4YfK3v7y7a
 SYg40pstJMjAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] drm/imagination: don't gate the runtime PM
 callbacks on drm_dev_enter()
To: "Ryan Brue" <ryanbrue.dev@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-1-674b907d0652@gmail.com>
References: <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-0-674b907d0652@gmail.com>
 <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-1-674b907d0652@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 02:29:27 +0000
Message-Id: <20260914022928.6F3FC1F000FF@smtp.kernel.org>
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

Pre-existing issues:
- [High] AB-BA Deadlock between soft reset in IRQ handler and watchdog work=
er
- [High] Watchdog worker is left permanently cancelled if firmware disable =
fails during suspend
--

commit 492c71c98e6c2dced455b7063ec9414f76434f9f
Author: Ryan Brue <ryanbrue.dev@gmail.com>
drm/imagination: don't gate the runtime PM callbacks on drm_dev_enter()

This commit removes drm_dev_enter() and drm_dev_exit() gating from the=20
system sleep and runtime PM suspend/resume callbacks. Instead, it relies
on checking pvr_dev->lost to prevent a deadlock between the watchdog=20
worker and the system sleep paths.

> diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/im=
agination/pvr_power.c
> index eb4b6ecdf4f4d..8d82b9a79daf8 100644
> --- a/drivers/gpu/drm/imagination/pvr_power.c
> +++ b/drivers/gpu/drm/imagination/pvr_power.c
> @@ -97,6 +97,10 @@ pvr_power_fw_disable(struct pvr_device *pvr_dev, bool =
hard_reset, bool rpm_suspe
>  	if (!hard_reset) {
>  		cancel_delayed_work_sync(&pvr_dev->watchdog.work);

[Severity: High]
This isn't a bug introduced by this patch, but is there an AB-BA deadlock
between the soft reset in the IRQ handler and the watchdog worker here?

If the firmware requests a soft reset in process_fwccb_command
(ROGUE_FWIF_FWCCB_CMD_REQUEST_GPU_RESTART), the IRQ handler calls
pvr_power_reset() and acquires the reset semaphore:

pvr_power_reset()
    down_write(&pvr_dev->reset_sem);
    ...
    pvr_power_fw_disable();

Then pvr_power_fw_disable() blocks here waiting for the watchdog worker to
finish via cancel_delayed_work_sync().

If the watchdog worker (pvr_watchdog_worker) detects a stall concurrently,
it calls pvr_power_reset(), which blocks trying to acquire the same
reset_sem, causing both the kernel workqueue thread and the GPU IRQ thread
to hang permanently.

> =20
> +		/* The worker just cancelled may have lost the device. */
> +		if (pvr_dev->lost)
> +			return -EIO;
> +
>  		err =3D pvr_power_request_idle(pvr_dev);
>  		if (err)
>  			return err;

[Severity: High]
This is also a pre-existing issue, but does this leave the watchdog worker
permanently cancelled if the firmware disable fails during suspend?

When pvr_power_device_suspend() calls pvr_power_fw_disable(), the watchdog
worker is cancelled synchronously above. We then send a forced idle request
here in pvr_power_request_idle().

If the firmware is stalled, this KCCB command times out and returns an
error. We then return that error immediately, which aborts the suspend.
The PM core leaves the device in the RPM_ACTIVE state, but the watchdog
worker is never restarted on this error path. Because the firmware is
stalled and the watchdog is disabled, it seems the GPU will never recover.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913-rbrue-suez=
-upstreaming-pvr-suspend-gpu-system-sleep-v3-0-674b907d0652@gmail.com?part=
=3D1
