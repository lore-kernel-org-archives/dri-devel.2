Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E12C55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 09:56:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 930E610E58B;
	Mon,  3 Aug 2026 09:56:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H1M4CXb+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BFF910E58B
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 09:56:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 83C6F41ACC;
 Mon,  3 Aug 2026 09:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E861F000E9;
 Mon,  3 Aug 2026 09:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785750991;
 bh=I+F0TLFpNh816P8trLFqqvxwgMDSKzcrjwn0wQfg25Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=H1M4CXb+Yyuf2hfJyUTh/4c0AUKfIRAH2e3AwuAxvk/ImPuLn2ylQtieVPl8ozjHL
 Ys49UTOgRhf7RIJF33AbqEduIrFWi1ustjrevwdMTo8WZTkF2Mcj3SldCwJ2pTBI6c
 5AikchKnOWoSzwzlAdV3reyUqNSd3lePNCG0CfCaEUipCiVBQtN43OPSf59heLnUId
 vTClo9/O9xbU2lqQfx+HGpi53H3GeQ4+5bA/fH0vHFjuyctNIPtby8H1IES7wpbxYe
 VXrd3IjRwqdn0XuHjS0K7xMnr/ehPB4ugAsAhPF6OAGon4kiItrCvLr1N4JF4gcOl6
 9HdGUf5PBUwzg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 4/6] accel/rocket: add RK3576 NPU (RKNN) support
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260803094125.3285895-5-gahing@gahingwoo.com>
References: <20260803094125.3285895-1-gahing@gahingwoo.com>
 <20260803094125.3285895-5-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 09:56:30 +0000
Message-Id: <20260803095631.23E861F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] Arbitrary physical memory corruption in experimental debug fun=
ction rocket_sptr_patch_regcmd.
- [High] TOCTOU race in rocket_poll_work_fn leads to job corruption and pre=
mature completion.
- [High] Partial allocation failure causes NULL pointer dereference in rock=
et_snap_take.
- [High] Data race and memory leak on global variables in rocket_snap_take.
- [High] Hardware initialization is skipped after a job timeout reset, caus=
ing subsequent jobs to fail.
- [High] Teardown ordering bug: DRM scheduler is destroyed before canceling=
 polling timer and work.
- [High] Resource leak on devm_pm_domain_attach_list error path.
- [Low] Logic error: rocket_core_reset hardcodes ARRAY_SIZE instead of util=
izing the SoC-specific reset count.
--

--- Patch [4]: [RFC PATCH v4 4/6] accel/rocket: add RK3576 NPU (RKNN) suppo=
rt ---
commit 312454d18760cf447cabd81f08e885f92b5a4313
Author: Jiaxing Hu <gahing@gahingwoo.com>

accel/rocket: add RK3576 NPU (RKNN) support

This commit introduces support for the RK3576 NPU by abstracting platform
differences such as clock configurations, reset mechanisms, and power
domains. It also implements an hrtimer-based polling mechanism for job
completion since the RK3576 DPU completion interrupt does not reach the GIC.

> diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/ro=
cket_core.c
> index b3b2fa9ba645a..5738fccdbd133 100644
> --- a/drivers/accel/rocket/rocket_core.c
> +++ b/drivers/accel/rocket/rocket_core.c
[ ... ]
> @@ -21,14 +49,22 @@ int rocket_core_init(struct rocket_core *core)
>  	/* RK3576 moves the BIU reset into its power domain and takes only srst=
_a. */
>  	core->resets[0].id =3D "srst_a";
>  	core->resets[1].id =3D "srst_h";
> -	err =3D devm_reset_control_bulk_get_exclusive(&pdev->dev, ARRAY_SIZE(co=
re->resets),
> +	err =3D devm_reset_control_bulk_get_exclusive(&pdev->dev, core->soc->nu=
m_resets,
>  						    core->resets);

[Severity: Low]
Since we now fetch the resets using core->soc->num_resets, do we also need
to update rocket_core_reset() to use this count?

If rocket_core_reset() still uses ARRAY_SIZE(core->resets), it will try to
assert and deassert uninitialized elements on RK3576 where num_resets is 1:

rocket_core_reset() {
    reset_control_bulk_assert(ARRAY_SIZE(core->resets), core->resets);
    ...
}

>  	if (err)
>  		return dev_err_probe(dev, err, "failed to get resets for core %d\n", c=
ore->index);
[ ... ]
> @@ -65,6 +101,19 @@ int rocket_core_init(struct rocket_core *core)
>  		return err;
>  	}
> =20
> +	/*
> +	 * RK3576 spans two power domains, and a multi-domain device is skipped
> +	 * by the driver-core single-domain auto-attach, so attach the list her=
e.
> +	 */
> +	if (core->soc->multi_power_domain) {
> +		struct dev_pm_domain_list *pd_list;
> +
> +		err =3D devm_pm_domain_attach_list(dev, NULL, &pd_list);
> +		if (err < 0)
> +			return dev_err_probe(dev, err,
> +					     "failed to attach NPU power domains\n");

[Severity: High]
Does this error path leak the resources allocated by rocket_job_init()?

Earlier in this function, rocket_job_init() successfully sets up non-devm
resources like the ordered workqueue (core->reset.wq), initializes the DRM
scheduler, and acquires a reference to core->iommu_group.

If devm_pm_domain_attach_list() fails, we return immediately. Do we need a
cleanup path here that calls rocket_job_fini() and releases the IOMMU
group?

> +	}
> +
>  	pm_runtime_use_autosuspend(dev);
[ ... ]
> diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/roc=
ket_drv.c
> index 8bbbce594883e..95599e791e26f 100644
> --- a/drivers/accel/rocket/rocket_drv.c
> +++ b/drivers/accel/rocket/rocket_drv.c
[ ... ]
> @@ -240,12 +256,15 @@ static int rocket_device_runtime_resume(struct devi=
ce *dev)
>  	if (core < 0)
>  		return -ENODEV;
> =20
> -	err =3D clk_bulk_prepare_enable(ARRAY_SIZE(rdev->cores[core].clks), rde=
v->cores[core].clks);
> +	err =3D clk_bulk_prepare_enable(rdev->cores[core].soc->num_clks, rdev->=
cores[core].clks);
>  	if (err) {
>  		dev_err(dev, "failed to enable (%d) clocks for core %d\n", err, core);
>  		return err;
>  	}
> =20
> +	/* Vendor runs its state_init once per power-up; we never did. */
> +	rocket_core_state_init(&rdev->cores[core]);

[Severity: High]
Does the timeout reset path also need to call this state initialization?

Looking at rocket_reset() which handles job timeouts, it calls
rocket_core_reset() to wipe the hardware state and then restarts the
scheduler.

Because the device does not go through a full suspend/resume cycle before t=
he
next job executes, rocket_device_runtime_resume() is not triggered. Will
subsequent jobs fail because the hardware is left uninitialized?

> +
>  	return 0;
>  }
[ ... ]
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index bb77b6bf0f231..c21310ef78c7f 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
[ ... ]
> +static void rocket_snap_take(struct rocket_core *core)
> +{
> +	void __iomem *blk[ROCKET_SNAP_NBLK];
> +	unsigned int slot, b, i, w =3D 0, diffs =3D 0;
> +	u32 *cur;
> +
> +	if (!rocket_snap)
> +		return;
> +
> +	if (!rocket_snap_buf[0]) {

[Severity: High]
Are these global static variables safe from concurrent access?

RK3576 and RK3588 have multiple independent NPU cores. If two cores finish
jobs simultaneously and enter rocket_snap_take(), both might see
!rocket_snap_buf[0] as true. Could this result in double allocations and
leaked memory, as well as corrupted snapshot data from concurrent writes?

> +		rocket_snap_buf[0] =3D kmalloc_array(ROCKET_SNAP_WORDS, 4, GFP_KERNEL);
> +		rocket_snap_buf[1] =3D kmalloc_array(ROCKET_SNAP_WORDS, 4, GFP_KERNEL);
> +		if (!rocket_snap_buf[0] || !rocket_snap_buf[1])
> +			return;

[Severity: High]
Can this error path lead to a NULL pointer dereference on subsequent calls?

If rocket_snap_buf[0] allocates successfully but rocket_snap_buf[1] fails,
we return without freeing rocket_snap_buf[0].

The next time this function runs, !rocket_snap_buf[0] will be false, so it
skips the allocation block entirely. Later in the function, it will try to
use rocket_snap_buf[1], which is still NULL.

> +	}
> +
[ ... ]
> +static void rocket_sptr_patch_regcmd(struct rocket_core *core, struct ro=
cket_job *job,
> +				     struct rocket_task *task, u32 bank)
> +{
> +	phys_addr_t phys =3D iommu_iova_to_phys(job->domain->domain, task->regc=
md);
> +	unsigned int i, patched =3D 0;
> +	struct scatterlist sg;
> +	struct page *page;
> +	u64 *rv;
> +
> +	if (!phys || !pfn_valid(PFN_DOWN(phys)))
> +		return;
> +
> +	rv =3D phys_to_virt(phys);
> +	for (i =3D 0; i < task->regcmd_count; i++) {

[Severity: Critical]
Does this sequence allow userspace to overwrite arbitrary kernel physical
memory?

iommu_iova_to_phys() gives us a physical address, but phys_to_virt() is only
valid for direct-mapped memory, and the physical pages backing the IOVA are
not guaranteed to be contiguous.

Since task->regcmd_count is user-controlled, can an attacker provide a large
count that causes the loop to scan past the page boundary and overwrite mem=
ory
outside the intended buffer?

> +		u16 reg =3D rv[i] & 0xffff;
[ ... ]
> +static void rocket_poll_work_fn(struct work_struct *work)
> +{
> +	struct rocket_core *core =3D container_of(work, struct rocket_core, pol=
l_work);
> +
> +	/*
> +	 * The interrupt can land while this work is already queued, finalise t=
he
> +	 * job and let the next one start. Without this the stale work would th=
en
> +	 * finalise that new job as well.
> +	 */
> +	if (core->poll_work_seq !=3D core->poll_seq)
> +		return;
> +
> +	rocket_job_handle_irq(core);

[Severity: High]
Is this lockless sequence check vulnerable to a race condition?

If rocket_poll_work_fn() evaluates the condition to false but is preempted
immediately after, a physical IRQ could fire. That IRQ would complete the
current job and submit a new one (incrementing poll_seq).

When rocket_poll_work_fn() resumes, it will unconditionally execute
rocket_job_handle_irq(). Could this abruptly kill the newly submitted job
and prematurely signal its completion fence?

> +}
[ ... ]
> @@ -503,6 +803,12 @@ void rocket_job_fini(struct rocket_core *core)
>  {
>  	drm_sched_fini(&core->sched);
> =20
> +	if (core->soc->poll_completion) {
> +		atomic_set(&core->poll_active, 0);
> +		hrtimer_cancel(&core->poll_timer);
> +		cancel_work_sync(&core->poll_work);
> +	}

[Severity: High]
Should the polling timer and work be stopped before destroying the schedule=
r?

drm_sched_fini() halts the scheduler, but any already-queued poll_work can
still execute immediately after. If it does, rocket_job_handle_irq() might
submit the next task to the hardware.

As teardown continues, clocks are disabled and memory is unmapped. If the N=
PU
is actively executing a newly started job when this happens, could it cause
bus hangs or IOMMU faults?

> +
>  	cancel_work_sync(&core->reset.work);
>  	destroy_workqueue(core->reset.wq);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803094125.3285=
895-1-gahing@gahingwoo.com?part=3D4
