Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60149C79FA1
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 22:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F0F410EDCC;
	Tue,  8 Sep 2026 22:18:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Rqvsp2ep";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E397210EDCC
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:18:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CD2C141639
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:18:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927AF1F00A3A;
 Tue,  8 Sep 2026 22:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788905903;
 bh=wfsBmdFAySsvGk3lfeNwqwIsh2Jn2nSDGzG1yWDWNNw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Rqvsp2epKNoKgMdMiFd2zV++i09fVeMDPpukJV2QteU1Myp3adXvR0+MSpeD4Jpov
 HuhD997p0ASV4k7wdUFDXF/jf5zto4ipegYP3N0TLl7+EeqwAnbC9+IGs/fN1opUst
 0WXwajry5oKJDUkRTuDa1ORnYp2bB7Ks5+GGLqgYTVrd9Smzu1xGv82v+GuyzhUaIr
 b3xFtUp66f18NgGX6Q0IU5C3mAEpNmw2UbfM8lhZtp6/qvLxTF3iQZw5QiNFBzH237
 2HoGWDaNG0ZC+bu6UCfKdD3jsEo4fcXjEd0Xbg1r5EZ2hjJEQw9QRhWKQlsN9C2g5x
 qixNpowbghY3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/22] accel: ethosu: Fix probe error cleanup
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260908-ethosu-fixes-v3-3-490fe215286f@kernel.org>
References: <20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org>
 <20260908-ethosu-fixes-v3-3-490fe215286f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 22:18:23 +0000
Message-Id: <20260908221823.927AF1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The IRQ is requested and enabled before the DRM scheduler is fully=
 initialized and before device clocks are enabled, causing potential crashe=
s or bus stalls on spurious/pending interrupts.
- [High] The DRM scheduler is torn down while the device IRQ is still activ=
e, allowing the IRQ handler to access destroyed scheduler structures.
- [High] `ethosu_job_fini()` clears the `in_flight_job` without signaling i=
ts `done_fence`, causing tasks waiting on the fence to hang indefinitely.
- [High] Use-After-Free during device removal due to missing `drm_dev_enter=
()`/`drm_dev_exit()` in ioctls.
--

commit cee294332b061aafaf416ab459f70a84d756797f
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Fix probe error cleanup
   =20
This commit fixes a probe error path bug in the Ethos-U NPU driver.
If ethosu_init() or drm_dev_register() fails, the probe function returns
without tearing down the job scheduler or freeing the SRAM pool.
The commit adds proper resource unwinding for these failure paths.

Cc: stable@vger.kernel.org

> diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/eth=
osu_drv.c
> index 1f6fb5d18cf22..2c8d735767b2a 100644
> --- a/drivers/accel/ethosu/ethosu_drv.c
> +++ b/drivers/accel/ethosu/ethosu_drv.c
> @@ -375,9 +375,20 @@ static int ethosu_probe(struct platform_device *pdev)
> =20
>  	ret =3D ethosu_init(ethosudev);
>  	if (ret)
> -		return ret;
> +		goto err_job_fini;

[Severity: High]
This is a pre-existing issue, but does calling ethosu_job_init() before
ethosu_init() leave us vulnerable to spurious interrupts?

In ethosu_probe(), the IRQ is requested and enabled via
devm_request_threaded_irq() (without IRQF_NO_AUTOEN) during
ethosu_job_init(). However, device clocks are not enabled until
ethosu_init() runs.

If a pending or spurious interrupt fires immediately before clocks are enab=
led:

ethosu_job_irq_handler() {
    u32 status =3D readl_relaxed(dev->regs + NPU_REG_STATUS);
    ...
}

Can reading from memory-mapped registers with disabled clocks stall the bus
or cause a synchronous external abort? Furthermore, if the thread handler
executes, it calls drm_sched_fault() on a scheduler that may not be fully
initialized yet.

>  	ret =3D drm_dev_register(&ethosudev->base, 0);
> +	if (ret)
> +		goto err_sram_free;
> +
> +	return 0;
> +
> +err_sram_free:
> +	if (ethosudev->sram)
> +		gen_pool_free(ethosudev->srampool, (unsigned long)ethosudev->sram,
> +			      ethosudev->npu_info.sram_size);
> +err_job_fini:
> +	ethosu_job_fini(ethosudev);

[Severity: High]
This is a pre-existing issue, but does calling ethosu_job_fini() here tear
down the scheduler while the device IRQ is still active?

ethosu_job_fini() calls synchronize_irq() to wait for executing handlers,
but does not disable the IRQ line before calling drm_sched_fini().

Because the IRQ is managed by devres, it remains enabled until devres
teardown, which happens after the probe error path completes. If the device
generates an interrupt in this window, the thread handler can execute:

ethosu_job_handle_irq() {
    ...
    drm_sched_fault(&dev->sched);
}

Could this result in a use-after-free by accessing the already-destroyed
DRM scheduler?

[Severity: High]
This is also a pre-existing issue, but does ethosu_job_fini() clear the
in-flight job without signaling its completion fence?

When ethosu_job_fini() checks READ_ONCE(dev->in_flight_job), if it is
populated, it clears the pointer and resets the hardware:

ethosu_job_fini() {
    ...
    if (READ_ONCE(dev->in_flight_job)) {
        WRITE_ONCE(dev->in_flight_job, NULL);
        ethosu_device_reset(dev);
    }
    ...
}

Because the hardware is reset, the completion interrupt will never arrive.
Without extracting the job and signaling its done_fence (e.g., with
-ECANCELED), could this cause userspace or kernel tasks waiting on the
fence to hang indefinitely during probe failure or driver unbind?

>  	return ret;
>  }
> =20
> diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/eth=
osu_job.c
> index 8dce74db0cb48..ec65305e0cd7d 100644
> --- a/drivers/accel/ethosu/ethosu_job.c
> +++ b/drivers/accel/ethosu/ethosu_job.c

[ ... ]

> @@ -355,14 +355,10 @@ int ethosu_job_init(struct ethosu_device *edev)
>  	ret =3D drm_sched_init(&edev->sched, &args);
>  	if (ret) {
>  		dev_err(dev, "Failed to create scheduler: %d\n", ret);
> -		goto err_sched;
> +		return ret;
>  	}
> =20
>  	return 0;
> -
> -err_sched:
> -	drm_sched_fini(&edev->sched);
> -	return ret;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but are the driver's ioctls
missing drm_dev_enter() and drm_dev_exit() protections?

During a hot-unplug event, ethosu_remove() calls drm_dev_unregister(),
which stops new opens but allows existing file descriptors to persist. It
then tears down the DRM scheduler via ethosu_job_fini().

However, ethosu_ioctl_submit() and the ETHOSU_PERFMON_* ioctls do not verify
the device plug state. A concurrent userspace process holding the file
descriptor can still issue the ETHOSU_SUBMIT ioctl:

ethosu_ioctl_submit_job() {
    ...
    ret =3D drm_sched_job_init(&ejob->base, &file_priv->sched_entity, ...);
    ...
}

Can this lead to a use-after-free if userspace calls into the DRM scheduler
after dev->sched has been destroyed during device removal?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-ethosu-fix=
es-v3-0-490fe215286f@kernel.org?part=3D3
