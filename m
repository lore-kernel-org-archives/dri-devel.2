Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4CCC61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 20:48:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB81A10F1C2;
	Thu, 27 Aug 2026 20:48:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aipr9OPv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B6B910F1C2
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 20:48:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F01E3434BF
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 20:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F981F000E9;
 Thu, 27 Aug 2026 20:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787863708;
 bh=8ubOQ/63Zb7w4JDJEOF8mGRdH2vtfoqpjhRZVChNqxU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aipr9OPvAE+VtfyleJvJyNt+zJPBv7aHW4TkTCkZiTjEqN21wrlQOwGJYSaGUMdxI
 rk3iY+RMH+R/cntympPBQX5f8oF4z7voTlmlpcqMo2EXdznDd0vCWxE7gD9kFblewe
 iyWA4NgDT+XdsKWw7cu2B22WWsXrxjt4b+WfaDjjz9KlqK4OKDePnyVZDcPjUVSsmx
 HsF4MytPprwWKMMhunKoLI6Z86effLKbWFyE1hUOh6CQBneOtuMm4t54qhIkoTu5sp
 UffJlXy128rYY/LCRjcvtzoq0RCaSorgCQxLXdXuQ26Hh7fbhTYW6NZAkhtvyTSxF2
 6z2yLRZXg9weQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/11] accel: ethosu: Drop IRQF_SHARED flag
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260827-ethosu-fixes-v1-2-346f9ea8791c@kernel.org>
References: <20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org>
 <20260827-ethosu-fixes-v1-2-346f9ea8791c@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 20:48:28 +0000
Message-Id: <20260827204828.B1F981F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Crash due to unconditional register access in IRQ handler while cl=
ocks are disabled
- [High] Null pointer dereference due to calling drm_sched_job_cleanup() on=
 an uninitialized structure
- [High] Permanent memory leak of done_fence on job submission error paths
- [High] Use-After-Free of DRM scheduler due to missing drm_dev_enter() pro=
tection
- [High] Asymmetric teardown allows device interrupts to trigger a Use-Afte=
r-Free on the destroyed DRM scheduler
- [High] Race condition leading to Use-After-Free of job and done_fence bet=
ween IRQ handler and timeout worker
- [High] Missing read-back / flush after clearing the interrupt via writel_=
relaxed causes an IRQ storm
--

commit 0bdd78d5a0b025f21b3dfd162dec6e0042165c19
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Drop IRQF_SHARED flag

The IRQF_SHARED flag doesn't work with runtime-pm as the IRQ handler
could run without resuming the device. This could also be fixed with
runtime-pm calls in the IRQ handler, but there is no known need for a
shared IRQ.

Cc: stable@vger.kernel.org

> diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/eth=
osu_job.c
> index 99c8812691e55..c33f2877b3850 100644
> --- a/drivers/accel/ethosu/ethosu_job.c
> +++ b/drivers/accel/ethosu/ethosu_job.c
> @@ -337,7 +337,7 @@ int ethosu_job_init(struct ethosu_device *edev)
>  	ret =3D devm_request_threaded_irq(dev, edev->irq,
>  					ethosu_job_irq_handler,
>  					ethosu_job_irq_handler_thread,
> -					IRQF_SHARED, KBUILD_MODNAME,
> +					0, KBUILD_MODNAME,
>  					edev);

[Severity: High]
This is a pre-existing issue, but I see the commit message says "This could
also be fixed with runtime-pm calls in the IRQ handler". Does this change
completely address the issue with clocks being disabled when the IRQ handler
runs?

For instance, in ethosu_probe(), the hardware IRQ is requested via
ethosu_job_init() before the device is resumed and clocks are enabled in
ethosu_init():

drivers/accel/ethosu/ethosu_drv.c:ethosu_probe() {
    ...
    ret =3D ethosu_job_init(ethosudev);
    if (ret)
        return ret;

    ret =3D ethosu_init(ethosudev);
    ...
}

If a pending interrupt fires immediately, ethosu_job_irq_handler() will acc=
ess
registers while clocks are gated, which can trigger a bus fault:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_irq_handler() {
    ...
    u32 status =3D readl_relaxed(dev->regs + NPU_REG_STATUS);
    ...
}

Similarly, in ethosu_job_timedout(), clocks are forcibly disabled without
synchronizing or disabling the IRQ:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_timedout() {
    ...
    pm_runtime_force_suspend(dev->base.dev);
    ...
}

Can a concurrent or delayed interrupt still crash the system here?


[Severity: High]
This is a pre-existing issue, but can returning IRQ_WAKE_THREAD immediately
after a relaxed write lead to an IRQ storm?

drivers/accel/ethosu/ethosu_job.c:ethosu_job_irq_handler() {
    ...
    writel_relaxed(CMD_CLEAR_IRQ, dev->regs + NPU_REG_CMD);
    return IRQ_WAKE_THREAD;
}

Since the relaxed write is posted asynchronously and the interrupt is not
requested with IRQF_ONESHOT, the generic IRQ core will unmask the interrupt
line immediately.

If the write hasn't reached the hardware to deassert the line, won't the CPU
immediately take the interrupt again? Would adding a dummy register read-ba=
ck
ensure the interrupt is cleared before returning?


[Severity: High]
This is a pre-existing issue, but is it safe to bind the IRQ lifetime to
devres while manually destroying the DRM scheduler in ethosu_remove()?

drivers/accel/ethosu/ethosu_drv.c:ethosu_remove() {
    ...
    ethosu_job_fini(ethosudev);
    ...
}

Since the IRQ remains active until the devres teardown phase, if an interru=
pt
fires after ethosu_job_fini(), ethosu_job_handle_irq() could call
drm_sched_fault() on the already destroyed scheduler:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_handle_irq() {
    ...
    drm_sched_fault(&dev->sched);
    ...
}

Could this lead to a use-after-free during device unbind?


[Severity: High]
This is a pre-existing issue, but can the threaded IRQ handler race with the
timeout worker causing a use-after-free?

The threaded IRQ handler reads dev->in_flight_job and can be preempted:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_handle_irq() {
    ...
    job =3D READ_ONCE(dev->in_flight_job);
    if (job) {
        WRITE_ONCE(dev->in_flight_job, NULL);
        dma_fence_signal(job->done_fence);
    }
    ...
}

If ethosu_job_timedout() executes concurrently, it stops the scheduler and
sets dev->in_flight_job to NULL, freeing the job independently:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_timedout() {
    ...
    drm_sched_stop(&dev->sched, bad);
    ...
    WRITE_ONCE(dev->in_flight_job, NULL);
    ...
}

When the asynchronous IRQ handler resumes, will it call dma_fence_signal()
using the stale job pointer and its nested fence?


[Severity: High]
This is a pre-existing issue, but can a failed allocation in
ethosu_ioctl_submit_job() lead to a NULL pointer dereference?

drivers/accel/ethosu/ethosu_job.c:ethosu_ioctl_submit_job() {
    ...
    ejob->done_fence =3D kzalloc_obj(*ejob->done_fence);
    if (!ejob->done_fence) {
        ...
        goto out_cleanup_job;
    }
    ...
out_cleanup_job:
    drm_sched_job_cleanup(&ejob->base);
    ...
}

Because drm_sched_job_init() hasn't been called yet, ejob->base.s_fence is
NULL. Won't drm_sched_job_cleanup() blindly dereference this pointer during
the error path?


[Severity: High]
This is a pre-existing issue, but does ethosu_job_err_cleanup() leak the
done_fence allocation?

In ethosu_ioctl_submit_job(), done_fence is dynamically allocated:

drivers/accel/ethosu/ethosu_job.c:ethosu_ioctl_submit_job() {
    ...
    ejob->done_fence =3D kzalloc_obj(*ejob->done_fence);
    ...
}

If validation fails later (e.g., invalid BO handles), the code falls through
to ethosu_job_err_cleanup(), which frees the job object but doesn't appear
to free done_fence:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_err_cleanup() {
    ...
    kfree(job);
}

Could this lead to a memory leak when users submit invalid jobs?


[Severity: High]
This is a pre-existing issue, but is the ETHOSU_SUBMIT ioctl handler missing
drm_dev_enter() / drm_dev_exit() protection?

drivers/accel/ethosu/ethosu_job.c:ethosu_ioctl_submit() {
    int ethosu_ioctl_submit(struct drm_device *dev, void *data,
                            struct drm_file *file)
    ...
}

If the device is unbound (e.g., via sysfs or hot-unplug), ethosu_remove()
tears down the DRM scheduler:

drivers/accel/ethosu/ethosu_drv.c:ethosu_remove() {
    ...
    ethosu_job_fini(ethosudev);
    ...
}

If a concurrent job submission from a process holding the DRM fd continues
executing, could it access the destroyed scheduler and cause a use-after-fr=
ee?

>  	if (ret) {
>  		dev_err(dev, "failed to request irq\n");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-ethosu-fix=
es-v1-0-346f9ea8791c@kernel.org?part=3D2
