Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0655B606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZN0ld8io
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 696FE89089;
	Wed, 11 Nov 2026 09:47:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F44489089
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:47:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6AE86611A1;
 Wed, 11 Nov 2026 09:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD931F00A05;
 Wed, 11 Nov 2026 09:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794390439;
 bh=50UVVcnmBdHgB+lmBw1YgHc4t5p+24h7KwXR469yz6A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZN0ld8iozfo8tBqzwVg9jDhiVGoK27zgBP2X8ojJN+XvHobU1AuqUWLaZhASCuO/9
 M0Bh+0mcGOGXSrE7I98r5dk4115nZeC9svuaLDGaZ4bgjKU/emS3fe3l0TGwh2LCl+
 T4FpCYFqDVxmNBwNd5z23Lj4W9VFtTGGS1EE7iGOR8YZJb92T4S9Tpi9m13v8h67iU
 loPNgaqpCX9aKgBwY3hWLokwKAKjTxAElGfPR72CF3mJBc7cevc27SXYSkeiqjPjUD
 uJDFZH1WlDMAtiFfmX6ZYR994+Txar0HYTYW0XmILOogA+1zZ8Gi+eC+Bel5L87/Y2
 WuG8t354yNdbg==
Message-ID: <sashiko-outbox-208718@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/imagination: re-check firmware idle state before
 runtime suspend
To: "Baihui Liang" <liangbaihui@linux.spacemit.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261111-img-pm-autosuspend-v2-1-427689f6f2f9@linux.spacemit.com>
References: <20261111-img-pm-autosuspend-v2-1-427689f6f2f9@linux.spacemit.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 09:47:18 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/imagination: pvr_remove() fails to stop FW on non-idle
  suspend
- [Low] drm/imagination: missing Fixes trailer on runtime PM bug fix
--

commit 819e68458c31e07fc8a39ed92b923866cc2d2009
Author: Baihui Liang <liangbaihui@linux.spacemit.com>

> drm/imagination: re-check firmware idle state before runtime suspend
>
> pvr_power_device_idle() rejects runtime suspend while the firmware
> hasn't reached ROGUE_FWIF_POW_IDLE. The PM core doesn't reschedule
> idle notification after rejection, so no further pm_runtime_put()
> arrives on an idle GPU and the device stays powered indefinitely.
>
> Move the idle check into pvr_power_device_suspend() and return -EBUSY
> after pm_runtime_mark_last_busy() so the PM core reschedules the
> autosuspend timer and retries until the firmware is idle.
>
> Signed-off-by: Baihui Liang <liangbaihui@linux.spacemit.com>

[Severity: Low]
This fixes a bug in runtime PM idle handling.  Should this include:

  Fixes: 727538a4bbff ("drm/imagination: Implement power management")

[ ... ]

> diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/im=
agination/pvr_power.c
> index eb4b6ecdf4f4d..71267f714c736 100644
> --- a/drivers/gpu/drm/imagination/pvr_power.c
> +++ b/drivers/gpu/drm/imagination/pvr_power.c
> @@ -378,6 +378,18 @@ pvr_power_device_suspend(struct device *dev)
>  	if (!drm_dev_enter(drm_dev, &idx))
>  		return -EIO;
> =20
> +	if (READ_ONCE(pvr_dev->fw_dev.initialised) && !pvr_power_is_idle(pvr_de=
v)) {
> +		/*
> +		 * The firmware has not drained the GPU yet. Refresh last_busy so
> +		 * the PM core reschedules the autosuspend and retries this callback
> +		 * until the firmware becomes idle.
> +		 */
> +		pm_runtime_mark_last_busy(dev);
> +		drm_dev_exit(idx);
> +
> +		return -EBUSY;
> +	}

[Severity: High]
Can this leave the firmware processor running and the GPU powered on during
pvr_remove()?

Before this change, pvr_power_is_idle() was only checked in .runtime_idle,
so synchronous pm_runtime_suspend() in pvr_remove() bypassed that check and
called pvr_power_fw_disable() to force the firmware idle and stop it.

During driver unbind, __device_release_driver() calls pm_runtime_get_sync()
followed by pm_runtime_put_sync() right before pvr_remove():

drivers/gpu/drm/imagination/pvr_drv.c:pvr_remove() {
	...
	pm_runtime_suspend(drm_dev->dev);
	pvr_device_fini(pvr_dev);
	drm_dev_unplug(drm_dev);
	pvr_watchdog_fini(pvr_dev);
}

If the firmware has not yet transitioned to ROGUE_FWIF_POW_IDLE (for exampl=
e,
right after pm_runtime_get_sync() resumed the GPU or after a KCCB command),
pvr_power_device_suspend() now returns -EBUSY.  Because pm_runtime_suspend()
does not pass RPM_AUTO, rpm_suspend() does not retry and returns -EBUSY to
pvr_remove(), which ignores the error and runs pvr_device_fini() ->
pvr_fw_fini().

That skips pvr_power_fw_disable() and pwr_ops->power_off(), so pvr_fw_fini()
unmaps and frees the firmware structures, CCBs, code/data GEM objects, and
page tables while the firmware processor is still running, and leaves the G=
PU
clocks and power enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-img-pm-aut=
osuspend-v2-1-427689f6f2f9@linux.spacemit.com?part=3D1
