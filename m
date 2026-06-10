Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E940CD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 06:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2F1C10E733;
	Wed, 10 Jun 2026 06:19:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J0A89omY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C19B10E754
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 06:19:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 803A36001A;
 Wed, 10 Jun 2026 06:19:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA281F00893;
 Wed, 10 Jun 2026 06:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781072355;
 bh=nlb3rOA92tsgQ+aspbVt1nWONyvMxPmdg3OX6peU1GM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J0A89omYdkyVvPfcQxu+IBoAJFbbp45E0xE+dBINypiaaIkBgr1mzFDplyM77Efrv
 b/Q6nf53c2TGh0MbhN0/3NUF6saS+hhu8rAsMhkFJvgNcWhq+WqIibB2QHfz5woh2b
 vzXN+X4PVitxuy1R7900jairqZA/cguw8422x0/eGH9gzkdUHsZrP5muMFDKxPBhmi
 VGWFrrJfjzkmABwlHCCAILNCsh9TX1e3YgrPVBP3F1mO1R+d/dJXLeoRmQDu3zHd5t
 sCRKSCoVq2/rEvewWWJnew+EMTKe/gve1hI7JEn/VbWKJKeWgYUlG8c3HPdA8oKn78
 pJUozqhMnFGTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] accel/rocket: Fix iommu_group leak and unsafe
 IRQ register access
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260610060132.3239648-2-zhaojinming@uniontech.com>
References: <20260610060132.3239648-2-zhaojinming@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 06:19:14 +0000
Message-Id: <20260610061915.1CA281F00893@smtp.kernel.org>
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

New issues:
- [High] Unhandled interrupt storm during device removal due to `pm_runtime=
_get_if_active()`.
- [High] NULL pointer dereference in the IRQ thread during teardown (Use-Af=
ter-Free).

Pre-existing issues:
- [Critical] Double free of `rjob->tasks` array during job submission error=
 handling.
- [High] NULL pointer dereference when freeing an uninitialized `job->domai=
n`.
--

commit 7c59a4d5e2e74264bcfe7bc8aa7c903516b1c1c0
Author: ZhaoJinming <zhaojinming@uniontech.com>

accel/rocket: Fix iommu_group leak and unsafe IRQ register access

This commit replaces iommu_group_get() with the cached core->iommu_group
to prevent a reference leak. It also adds pm_runtime_get_if_active() checks
in the IRQ handler and thread to prevent unsafe hardware register accesses
when the device is suspended.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index cf9f61682dd8b..21b433826b479 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -349,7 +349,7 @@ static void rocket_job_handle_irq(struct rocket_core =
*core)
>  				return;
>  			}
> =20
> -			iommu_detach_group(NULL, iommu_group_get(core->dev));
> +			iommu_detach_group(NULL, core->iommu_group);

[Severity: High]
Could this lead to a NULL pointer dereference during device teardown?

In rocket_core_fini(), core->iommu_group is set to NULL without acquiring
core->job_lock or waiting for the IRQ thread to finish:

rocket_core_fini()
    ...
    core->iommu_group =3D NULL;

If the threaded IRQ handler runs concurrently after passing the runtime PM
check, it will pass this newly nulled pointer to iommu_detach_group(),
causing the IOMMU core to dereference a NULL pointer when acquiring the
group's mutex.

>  			dma_fence_signal(core->in_flight_job->done_fence);
>  			pm_runtime_put_autosuspend(core->dev);
>  			core->in_flight_job =3D NULL;

[ ... ]

> @@ -428,16 +431,24 @@ static irqreturn_t rocket_job_irq_handler_thread(in=
t irq, void *data)
>  static irqreturn_t rocket_job_irq_handler(int irq, void *data)
>  {
>  	struct rocket_core *core =3D data;
> -	u32 raw_status =3D rocket_pc_readl(core, INTERRUPT_RAW_STATUS);
> +	u32 raw_status;
> +
> +	if (pm_runtime_get_if_active(core->dev) !=3D 1)
> +		return IRQ_NONE;

[Severity: High]
Will this cause an unhandled interrupt storm during module removal?

During module removal, rocket_core_fini() disables runtime PM:

rocket_core_fini()
    pm_runtime_disable(core->dev);

This happens before the hardware is stopped. If a hardware job completes
subsequently, the device raises a level-triggered interrupt. Since runtime
PM is disabled, pm_runtime_get_if_active() returns -EINVAL.

The handler then unconditionally returns IRQ_NONE without clearing the
interrupt. Because the IRQ is level-triggered, the unacknowledged interrupt
will immediately refire upon handler exit, potentially causing an infinite
interrupt storm that deadlocks the CPU.

[Severity: Critical]
This isn't a bug introduced by this patch, but does the error handling in
rocket_copy_tasks() cause a double free of the tasks array?

If validation of the incoming tasks fails, the array is freed but the
pointer is not cleared:

rocket_copy_tasks() {
    ...
fail:
    kvfree(rjob->tasks);
    return ret;
}

The caller then jumps to the error label and invokes rocket_job_put(),
which triggers rocket_job_cleanup(). This cleanup function frees the
dangling pointer again:

rocket_job_cleanup() {
    ...
    kvfree(job->tasks);
}

Can a local unprivileged attacker exploit this via the submit ioctl to
corrupt kernel memory?

[Severity: High]
This isn't a bug introduced by this patch, but is there a NULL pointer
dereference when freeing an uninitialized domain?

When the job structure is allocated, all fields are initialized to zero.
If setup fails early (for example, in drm_sched_job_init() or
rocket_copy_tasks()), job->domain remains NULL.

The error handling path invokes rocket_job_cleanup(), which unconditionally
releases the domain:

rocket_job_cleanup() {
    ...
    rocket_iommu_domain_put(job->domain);
}

This function immediately dereferences the pointer:

rocket_iommu_domain_put() {
    ...
    kref_put(&domain->kref, rocket_iommu_domain_destroy);
}

Could this cause a kernel panic if an unprivileged user passes invalid
arguments?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610060132.3239=
648-1-zhaojinming@uniontech.com?part=3D2
