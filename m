Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB25CC61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:52:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1124510E26A;
	Mon, 31 Aug 2026 08:52:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J7djhWba";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0048610E26A
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:52:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 107BA60120;
 Mon, 31 Aug 2026 08:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684F51F000E9;
 Mon, 31 Aug 2026 08:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788166344;
 bh=+3sxOVzytdtY94KnE2X2O2vvNv3vIC2ucrD/KO9EwrY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J7djhWbawMJ3yG9xeayXV8ihMdAOt6yIRYR2Y/ZNztWr5N6MBKQZh0B4XTj6KraMw
 R73ww5iHruZ0HIdYfLyvB7jAjg4UeyzpvKIa1gpXH9KbZ+ViX4H5VuRiyj/DLzMILV
 uzt5oxzLdwxpqrES66hEwFU3ncyKhHJeZFsxaEOa9AoToJrSPjvuEbZUQvehSfDLi8
 /A2LVrSi7E3sus7UKoflH51f8/gkdZjpLf47K3QBQ5IeHIDGO/qM/0payDMeKOjFQ1
 P4z3YsvceLiewge39k0B/Nq9TExogp7ZhJ55EX+UHnsi46KAn18WMd5OBmM0gG2HEf
 9AMMC63Hryj7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 05/14] accel/rocket: factor the completion tail out
 of the IRQ handler
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260831081956.84871-6-gahing@gahingwoo.com>
References: <20260831081956.84871-1-gahing@gahingwoo.com>
 <20260831081956.84871-6-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 08:52:23 +0000
Message-Id: <20260831085224.684F51F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Leak of IOMMU group reference in job completion path due to missin=
g iommu_group_put().
- [High] Shared IRQ handler accesses hardware registers without checking if=
 the device is active, risking crashes or spurious interrupts on suspended =
devices.
- [High] Missing synchronize_irq() in runtime suspend callback allows races=
 with shared interrupts.
--

commit 3949b3388a0eed37353941f6527bafda9857fb01
Author: Jiaxing Hu <gahing@gahingwoo.com>

accel/rocket: factor the completion tail out of the IRQ handler

This commit factors out the completion and task advancement logic from
rocket_job_handle_irq() into a new helper function rocket_job_next_locked().
This clarifies the code structure after previous locking changes and isolat=
es
the logic for easier bisection. There are no intended functional changes.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index a89ab49e17e52..69e29f40f27a0 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -341,6 +341,25 @@ static struct dma_fence *rocket_job_run(struct drm_s=
ched_job *sched_job)
>  	return ERR_PTR(ret);
>  }
> =20
> +/* Start the job's next task, or retire it. Caller holds job_lock. */
> +static void rocket_job_next_locked(struct rocket_core *core)
> +{
> +	lockdep_assert_held(&core->job_lock);
> +
> +	if (!core->in_flight_job)
> +		return;
> +
> +	if (core->in_flight_job->next_task_idx < core->in_flight_job->task_coun=
t) {
> +		rocket_job_hw_submit(core, core->in_flight_job);
> +		return;
> +	}
> +
> +	iommu_detach_group(NULL, iommu_group_get(core->dev));

[Severity: High]
This isn't a bug introduced by this patch, but does this code permanently
leak the IOMMU group reference?

iommu_group_get() increments the reference count of the IOMMU group, but
the returned pointer is passed directly to iommu_detach_group() which does
not take ownership. I don't see a matching iommu_group_put() anywhere.

Since this happens on every job completion, won't this continuously leak
kobject references until the refcount_t saturates and warns? Could this
use core->iommu_group directly without taking a new reference?

> +	dma_fence_signal(core->in_flight_job->done_fence);
> +	pm_runtime_put_autosuspend(core->dev);
> +	core->in_flight_job =3D NULL;
> +}
> +
>  static void rocket_job_handle_irq(struct rocket_core *core)
>  {
>  	pm_runtime_mark_last_busy(core->dev);
> @@ -354,17 +373,7 @@ static void rocket_job_handle_irq(struct rocket_core=
 *core)
>  		rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
>  		rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);

[Severity: High]
This is a pre-existing issue, but do these unconditional hardware register
accesses risk a system crash if the device is runtime suspended?

The interrupt handler doesn't check if the device is active before accessing
hardware:

drivers/accel/rocket/rocket_job.c:rocket_job_irq_handler() {
    ...
    u32 raw_status =3D rocket_pc_readl(core, INTERRUPT_RAW_STATUS);
    ...
}

Because the driver registers this as a shared IRQ (IRQF_SHARED), if another
device on the line triggers an interrupt while the NPU is suspended, this r=
ead
typically returns 0xffffffff.

This satisfies the interrupt mask (e.g. PC_INTERRUPT_RAW_STATUS_DPU_0),
causing the handler to wake the thread and execute rocket_job_handle_irq()
here, which writes to powered-off registers like OPERATION_ENABLE, causing
an asynchronous SError or bus fault.

Should the hardirq handler use pm_runtime_get_if_active() to check the
power state before reading INTERRUPT_RAW_STATUS?

> -		if (core->in_flight_job) {
> -			if (core->in_flight_job->next_task_idx < core->in_flight_job->task_co=
unt) {
> -				rocket_job_hw_submit(core, core->in_flight_job);
> -				return;
> -			}
> -
> -			iommu_detach_group(NULL, iommu_group_get(core->dev));
> -			dma_fence_signal(core->in_flight_job->done_fence);
> -			pm_runtime_put_autosuspend(core->dev);
> -			core->in_flight_job =3D NULL;
> -		}
> +		rocket_job_next_locked(core);
>  	}
>  }

While reviewing this, I noticed another pre-existing issue related to the
shared IRQ handling in the driver's runtime PM suspend path:

drivers/accel/rocket/rocket_drv.c:rocket_device_runtime_suspend() {
    ...
    if (!rocket_job_is_idle(&rdev->cores[core]))
        return -EBUSY;

    clk_bulk_disable_unprepare(ARRAY_SIZE(rdev->cores[core].clks),
                               rdev->cores[core].clks);
    ...
}

[Severity: High]
This is a pre-existing issue, but does this function pull hardware power
before ensuring all interrupt handlers have finished executing?

Subsystem rules state that drivers using IRQF_SHARED must call
synchronize_irq() in their runtime suspend callback before powering down
hardware. Since the IRQ is shared, rocket_job_irq_handler() could be
executing concurrently on another CPU when the clock is disabled, which
would cause a system crash.

Could a call to synchronize_irq() be added here before disabling clocks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831081956.8487=
1-1-gahing@gahingwoo.com?part=3D5
