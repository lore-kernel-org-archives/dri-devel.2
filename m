Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3350BC61DFD
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:36:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EC7510E725;
	Mon, 31 Aug 2026 08:36:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HEsUXAeP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E119410E725
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:36:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 866A243AC0;
 Mon, 31 Aug 2026 08:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174D91F00A3D;
 Mon, 31 Aug 2026 08:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788165372;
 bh=jxxXUVn4/lGGpzaLAK/Ft56dEmXWpstHAHf2AgHScrw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HEsUXAePoyqYJQgHpsE44U/Ls+npndLepc9E0zczCwoNH+mFm5CgdSBgyCrNvMC9y
 yH5HmgRgyYIT3ychabYS8hCjd64Hcs9YwSMU/h7MYHWgcXrRabWR+9rRWFcCEhFCal
 PkJaqpxIVOtQZElDdGpFs0R/hFLmCxgyiYDu4Dec1pFbAt83Nocrq12LhQVoZGB0ky
 YjGa4SPMd6QcmlBIbmh8UbIeRQRKL+MAKQkNnhEBAvrZF1v7NxEPL68XJVewmpPrdG
 Y1VJ7lY2e84Y8D5igBqXuwpXIxhiCeH5dI4KTXw2lrwNuGSX9JRJTxB9DFt1u+55Rm
 BJgu8DUbcnzyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 02/14] accel/rocket: take the completion register
 writes under job_lock
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260831081956.84871-3-gahing@gahingwoo.com>
References: <20260831081956.84871-1-gahing@gahingwoo.com>
 <20260831081956.84871-3-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 08:36:11 +0000
Message-Id: <20260831083612.174D91F00A3D@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Reference count leak of the IOMMU group in rocket_job_handle_irq().
- [High] The hardirq handler accesses hardware registers without ensuring t=
he device is active, causing invalid register reads or bus faults when a sh=
ared IRQ fires while the device is runtime-suspended.
- [High] Threaded IRQ handler accesses hardware registers without a PM refe=
rence if there is no in-flight job, causing a bus fault.
- [High] Missing `synchronize_irq()` in runtime suspend callback for a shar=
ed IRQ, risking mid-flight handler execution.
- [High] Calling drm_sched_fini() on a failed scheduler initialization caus=
es a null pointer dereference.
--

commit 873cb013be0f4784d0270a98eec1dd55e8a02c68
Author: Jiaxing Hu <gahing@gahingwoo.com>

accel/rocket: take the completion register writes under job_lock

This commit moves the OPERATION_ENABLE and INTERRUPT_CLEAR register writes
inside the job_lock scoped_guard block in rocket_job_handle_irq(). It fixes
a race condition where a completion being handled could overwrite a newly
submitted task's enable bit.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 3141f210fcd1b..5f0f9682e57ca 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -345,10 +345,15 @@ static void rocket_job_handle_irq(struct rocket_cor=
e *core)
>  {
>  	pm_runtime_mark_last_busy(core->dev);
> =20
> -	rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
> -	rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
> +	scoped_guard(mutex, &core->job_lock) {
> +		/*
> +		 * Stopping the block belongs under the lock. hw_submit() writes
> +		 * OPERATION_ENABLE too, and outside the lock this zero can land
> +		 * after that one and stop a task that has only just started.
> +		 */
> +		rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
> +		rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);

[Severity: High]
This is a pre-existing issue, but do these unconditional hardware writes ri=
sk
causing a bus fault?

If a shared interrupt fires while the NPU is runtime-suspended, the threaded
handler will execute with core->in_flight_job =3D=3D NULL. Because no PM re=
ference
is held in that case, the hardware is powered down, and writing to these
registers could cause an async SError.

> =20
> -	scoped_guard(mutex, &core->job_lock)
>  		if (core->in_flight_job) {
>  			if (core->in_flight_job->next_task_idx < core->in_flight_job->task_co=
unt) {
>  				rocket_job_hw_submit(core, core->in_flight_job);
> @@ -360,6 +365,7 @@ static void rocket_job_handle_irq(struct rocket_core =
*core)
>  			pm_runtime_put_autosuspend(core->dev);
>  			core->in_flight_job =3D NULL;
>  		}

[Severity: High]
This isn't a bug introduced by this patch, but does this code leak a refere=
nce
to the IOMMU group?

drivers/accel/rocket/rocket_job.c:rocket_job_handle_irq() {
    ...
    if (core->in_flight_job) {
        ...
        iommu_detach_group(NULL, iommu_group_get(core->dev));
        dma_fence_signal(core->in_flight_job->done_fence);
        ...
}

The call to iommu_group_get() increments the kobject reference count for the
group, but its result is leaked without a corresponding put. Over time on t=
he
hot success path, could this overflow the refcount and prevent the IOMMU gr=
oup
from ever being freed?

> +	}
>  }

[ ... ]

[Severity: High]
This is a pre-existing issue, but can the hardirq handler access hardware
registers while the device is runtime-suspended?

drivers/accel/rocket/rocket_job.c:rocket_job_irq_handler() {
    struct rocket_core *core =3D data;
    u32 raw_status =3D rocket_pc_readl(core, INTERRUPT_RAW_STATUS);
    ...
}

Since the driver registers a shared IRQ (IRQF_SHARED), another device on the
same IRQ line can trigger an interrupt. The handler will unconditionally re=
ad
INTERRUPT_RAW_STATUS without calling pm_runtime_get_if_active(). Could this
cause invalid register reads or a bus fault if the NPU's power domain is do=
wn?

[ ... ]

[Severity: High]
This is a pre-existing issue, but is it safe to disable the device clocks h=
ere
without synchronizing the shared IRQ line?

drivers/accel/rocket/rocket_drv.c:rocket_device_runtime_suspend() {
    ...
    if (!rocket_job_is_idle(&rdev->cores[core]))
        return -EBUSY;

    clk_bulk_disable_unprepare(ARRAY_SIZE(rdev->cores[core].clks), rdev->co=
res[core].clks);
    return 0;
}

Because the interrupt line is shared, an IRQ handler could be executing on
another CPU mid-flight. Does this need a synchronize_irq() before powering
down hardware to prevent the handler from accessing hardware whose clocks h=
ave
just been disabled?

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but will drm_sched_fini() cause a
null pointer dereference if scheduler initialization fails?

drivers/accel/rocket/rocket_job.c:rocket_job_init() {
    ...
    ret =3D drm_sched_init(&core->sched, &args);
    if (ret) {
        dev_err(core->dev, "Failed to create scheduler: %d.", ret);
        goto err_sched;
    }
    return 0;

err_sched:
    drm_sched_fini(&core->sched);
    ...
}

If drm_sched_init() fails (e.g. due to memory allocation failure), it frees
its internal structures and leaves sched->sched_rq as NULL but leaves
sched->num_rqs > 0. Would calling drm_sched_fini() on the error path attempt
to dereference the NULL sched->sched_rq array?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831081956.8487=
1-1-gahing@gahingwoo.com?part=3D2
