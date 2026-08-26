Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E115BC5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:34:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ADD210E5FE;
	Wed, 26 Aug 2026 21:34:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kHYPTXQF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13D3610E5FE
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 21:34:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8B92060254;
 Wed, 26 Aug 2026 21:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDA61F000E9;
 Wed, 26 Aug 2026 21:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787780074;
 bh=/HScJawnOdF1O7Mq703ZG7YtaTlSTHxfRQGgbUHZt/E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kHYPTXQFWV68qrGzkiU79pwIHA/ThvQlebWJbhnIbm9PsBdPDP81RyBqHhDLEqBwV
 J0F/75fSMBxutvmkbFYvx1HI6Q87j/hKuFK6q9dCgiDFDqgCtBCnCY3YZjV9qWWK6I
 Prr+FNRMTsMOb7k3J8af/GtSAAgIAScReKi5+igqo/NEChFSdXMN6vcvDLmmun3f14
 wI07SayF9uyeq1V+lNdPKoU8If1mSXiOa9HFkh7O0m0Lt1gBGvQM15Bvy+iu1bAD4L
 VLIgQkbhzWk6PoX7e97u+qxQYdbbZBVgitsNe1BVfaIz1TpBm//JWoOQ2uacM2e3on
 zba5URXCFFtxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/16] drm/panfrost: Split subsystem init/reset from
 interrupt enablement
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260826-claude-fixes-v6-7-78119af409e7@collabora.com>
References: <20260826-claude-fixes-v6-0-78119af409e7@collabora.com>
 <20260826-claude-fixes-v6-7-78119af409e7@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 21:34:33 +0000
Message-Id: <20260826213434.2EDA61F000E9@smtp.kernel.org>
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

New issues:
- [High] Masking GPU interrupts during device teardown creates an interrupt=
 storm deadlock if jobs are actively running.

Pre-existing issues:
- [High] Race condition during device teardown where a pending reset work i=
tem executes concurrently with or after scheduler destruction, causing a Us=
e-After-Free and erroneously re-enabling interrupts.
--

commit a45fd41d29f7c5d2faeeffea961ca1caad97ff77
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Split subsystem init/reset from interrupt enablement

Because MMU interrupts are only enabled when the device is reset, it
happened that after DRM device registration, the very first job targeting
the tiler heap BO would always time out. The reason is the reset sequence
is only part of PM runtime resume, which is not called explicitly at driver
probe time, and an actual reset work item manually triggered after a HW
error.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 9549ddb7854a3..0cc277efb5850 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
[ ... ]
> @@ -341,6 +365,8 @@ void panfrost_device_fini(struct panfrost_device *pfd=
ev)
>  	pm_runtime_get_sync(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
> =20
> +	panfrost_device_disable_hw(pfdev);
> +

[Severity: High]
Does calling panfrost_device_disable_hw() unconditionally on driver unload
create an interrupt storm risk?

Since jobs are not guaranteed to be stopped yet, the GPU may generate a fau=
lt
or completion interrupt in panfrost_gpu_suspend_irq() right after setting
the software flag but before masking the hardware interrupt:

drivers/gpu/drm/panfrost/panfrost_gpu.c:panfrost_gpu_suspend_irq() {
    set_bit(PANFROST_COMP_BIT_GPU, pfdev->is_suspended);
    <-- interrupt fires here
    gpu_write(pfdev, GPU_INT_MASK, 0);
}

The panfrost_gpu_irq_handler() sees is_suspended set and returns IRQ_NONE
without clearing the hardware interrupt. Because the IRQ is level-triggered,
it would re-fire immediately upon exit, leading to a soft lockup and forcing
the kernel to permanently disable the shared IRQ line.

>  	panfrost_gem_fini(pfdev);
>  	panfrost_perfcnt_fini(pfdev);
>  	panfrost_jm_fini(pfdev);
[ ... ]
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/pa=
nfrost/panfrost_job.c
> index 5016d2d53da26..087905cd347a5 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
[ ... ]
> @@ -753,8 +753,8 @@ panfrost_reset(struct panfrost_device *pfdev,
>  	for (i =3D 0; i < NUM_JOB_SLOTS; i++)
>  		drm_sched_start(&pfdev->js->queue[i].sched, 0);
> =20
> -	/* Re-enable job interrupts now that everything has been restarted. */
> -	panfrost_jm_enable_interrupts(pfdev);
> +	/* Re-enable interrupts now that everything has been restarted. */
> +	panfrost_device_enable_int(pfdev);

[Severity: High]
This is a pre-existing issue, but does adding panfrost_device_enable_int()
here exacerbate a teardown race with the reset workqueue?

During teardown, panfrost_device_fini() disables hardware and then calls
panfrost_jm_fini(), which destroys the schedulers before synchronizing the
reset workqueue:

drivers/gpu/drm/panfrost/panfrost_job.c:panfrost_jm_fini() {
    for (j =3D 0; j < NUM_JOB_SLOTS; j++) {
        drm_sched_fini(&js->queue[j].sched);
    }
    cancel_work_sync(&pfdev->reset.work);
}

If a job timeout occurs before or during panfrost_device_fini(), the
concurrent reset work item can execute after scheduler destruction, causing
a use-after-free.

Furthermore, because this patch adds panfrost_device_enable_int() to the end
of the reset sequence, the racing reset work could erroneously clear the
is_suspended bits and re-enable hardware interrupts right before the clocks
are turned off in teardown.

> =20
>  	dma_fence_end_signalling(cookie);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-claude-fix=
es-v6-0-78119af409e7@collabora.com?part=3D7
