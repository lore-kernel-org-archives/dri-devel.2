Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6267EC61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 20:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5F9910F1BA;
	Thu, 27 Aug 2026 20:45:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ay8CeYBm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7303810F1BA
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 20:45:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EAC91601F1
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 20:45:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C60E1F00A3A;
 Thu, 27 Aug 2026 20:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787863536;
 bh=hfnN1Yb1aGf8kCfByhGAN+tLm0JVYfx86WY1W0Eov6o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ay8CeYBmQAMeVWTl8x9DP1rIxNdn9tuWNSW50usMSciKuH6XFmflQVznOd1QLewbd
 c/i/LHtlSM/qV9utI91A0E7OYL+951UTdpPh1aEBPUJpufV3FHVfLoV47iCo9rsJKJ
 yiCp8RbIWDHcPCMXoMwD5LVpfWU+u1PovCsoZFvDkfCIS4HpBzoct31UWOT4IjZEsi
 ZJKuHbqlb/g7/+zOj2vaThjyhRvpVA2av76ZQ30kpmdeKb57OkTYiFiNOgDmGG8Jcz
 yMus4NaZD4QnCwhN4YcF4pSCJYX+JtA3T7PSnSB5i7jcmR/aArYZxgtDelZYlxyQv7
 KdxJAbTdAF+8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/11] accel: ethosu: Fix probe error cleanup
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260827-ethosu-fixes-v1-6-346f9ea8791c@kernel.org>
References: <20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org>
 <20260827-ethosu-fixes-v1-6-346f9ea8791c@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 20:45:36 +0000
Message-Id: <20260827204536.8C60E1F00A3A@smtp.kernel.org>
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
- [High] Asynchronous Runtime PM put on probe error path causes device to r=
emain powered on.
- [High] IRQ remains active while the DRM scheduler is destroyed on probe e=
rror and unbind, risking Use-After-Free.
- [High] IRQ handler accesses hardware registers without PM runtime protect=
ion, causing bus faults.
- [High] Memory leak of `done_fence` via user-controlled ioctl error path.
--

commit 929da42114076da83041012a4812042cd457402a
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Fix probe error cleanup

This commit unwinds initialized resources on probe error paths to prevent
leaks and leaves the hardware cleanly. It also prevents calling
drm_sched_fini() on a failed scheduler initialization.

> diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/eth=
osu_drv.c
> index f1af7b3ea0385..41ecfc623d425 100644
> --- a/drivers/accel/ethosu/ethosu_drv.c
> +++ b/drivers/accel/ethosu/ethosu_drv.c
> @@ -371,13 +371,23 @@ static int ethosu_probe(struct platform_device *pde=
v)
> =20
>  	ret =3D ethosu_init(ethosudev);
>  	if (ret)
> -		return ret;
> +		goto err_job_fini;

[Severity: High]
This isn't a bug introduced by this patch, but does the initialization order
risk a bus fault if a spurious interrupt arrives early?

In ethosu_probe(), ethosu_job_init() requests and unmasks the IRQ before
ethosu_init() is called to enable the device clocks.

If a spurious interrupt fires while the device is still powered off (or in
autosuspend), the handler executes unconditionally:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_irq_handler() {
    ...
    u32 status =3D readl_relaxed(dev->regs + NPU_REG_STATUS);
    ...
}

Can reading these unclocked memory-mapped registers cause a synchronous
external abort?

> =20
>  	ret =3D drm_dev_register(&ethosudev->base, 0);
>  	if (ret)
> -		pm_runtime_dont_use_autosuspend(ethosudev->base.dev);
> +		goto err_pm_runtime;
> +
> +	pm_runtime_put_autosuspend(ethosudev->base.dev);
> +	return 0;
> =20
> +err_pm_runtime:
> +	pm_runtime_dont_use_autosuspend(ethosudev->base.dev);
>  	pm_runtime_put_autosuspend(ethosudev->base.dev);

[Severity: High]
This isn't a bug introduced by this patch, but does using
pm_runtime_put_autosuspend() here cause a problem with devres cleanup?

When the probe function fails and returns, devres will immediately call
pm_runtime_disable().

According to the PM subsystem guidelines, using an asynchronous
pm_runtime_put() like pm_runtime_put_autosuspend() when
pm_runtime_disable() follows immediately causes the pending suspend work
to be cancelled.

Can this leave the NPU hardware powered on and in an incorrect PM state?

> +	if (ethosudev->sram)
> +		gen_pool_free(ethosudev->srampool, (unsigned long)ethosudev->sram,
> +			      ethosudev->npu_info.sram_size);
> +err_job_fini:
> +	ethosu_job_fini(ethosudev);

[Severity: High]
This isn't a bug introduced by this patch, but could this error path lead to
a use-after-free regression due to the interrupt handler remaining active?

In ethosu_job_init(), the hardware interrupt is requested via
devm_request_threaded_irq().

Because it is devres-managed, the IRQ is not disabled until after the probe
function completely finishes and devres runs.

However, ethosu_job_fini() synchronously destroys the DRM scheduler here.

If a spurious or delayed interrupt fires in the window between
drm_sched_fini() and devres cleanup:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_irq_handler() {
    ...
    drm_sched_fault(&edev->sched);
    ...
}

Will the IRQ handler access the freed scheduler structures?

>  	return ret;
>  }


[Severity: High]
This is a pre-existing issue, but does the error path in
ethosu_ioctl_submit_job() leak the done_fence allocation?

In ethosu_ioctl_submit_job(), ejob->done_fence is dynamically allocated:

drivers/accel/ethosu/ethosu_job.c:ethosu_ioctl_submit_job() {
    ...
    ejob->done_fence =3D kzalloc_obj(*ejob->done_fence);
    ...
}

If a subsequent step fails (such as drm_gem_object_lookup failing due to an
invalid command stream buffer handle), the code jumps to out_cleanup_job.=20

The cleanup function ethosu_job_err_cleanup() frees the job struct and BO
references, but it doesn't appear to call kfree() on ejob->done_fence.

Could unprivileged userspace trigger this repeatedly to drain kernel memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-ethosu-fix=
es-v1-0-346f9ea8791c@kernel.org?part=3D6
