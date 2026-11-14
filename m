Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CECD606A884
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 03:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=opnvwktI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F2F210ED27;
	Sat, 14 Nov 2026 03:31:13 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EFFD10ED2C
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 03:31:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 28BA9620E0;
 Sat, 14 Nov 2026 03:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A98E1F000C4;
 Sat, 14 Nov 2026 03:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794627065;
 bh=SeNA25RLTTM6AhK2d0DTC//UL0WeQKsx2DC3v0cqtM8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=opnvwktIFUvJMwHjj3jW2RmfUPb++7CxjuwOtaEWuIyYJbh9Dipo5uvZ9SY/74Osj
 4CUiN/3RvLHgUt5jjMBo+TRlQHbf6RDkw15pZtHVC5lnZvVEX+Qt4x+IYSZzHqOq//
 o8fMhpcc7e9vaR+7wB0SSXEMKyuUtg8ShmspmNdR9HNTtFrvmUL3meqgf2MVi96F9q
 /B2uvaDVY6Wqef+w72yHWS0Hs46uM7ke5/2iKJ40Ro2reFiQry+HiASQ5cixAzHOsr
 FVSFqb8+w7AumV9kcWB17qb/rRd4vz3zCSLghDI2t5hnpqyQrRa0VDm5dHz9QzJ7iI
 2rsg7XgIVD43w==
Message-ID: <sashiko-outbox-214115@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 03/12] accel/rocket: wait for a running IRQ handler
 before resetting a core
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <18667b2afdcaae217fa1038f5348ab23ed756bdc.1794615323.git.gahing@gahingwoo.com>
References: <cover.1794615324.git.gahing@gahingwoo.com>
 <18667b2afdcaae217fa1038f5348ab23ed756bdc.1794615323.git.gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 03:31:05 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] accel/rocket: raw IRQ status can re-latch before reset in
  rocket_reset()
- [High] accel/rocket: race with pm_runtime_force_suspend() in
  rocket_reset()
- [Low] accel/rocket: missing Fixes trailer for IRQ race fix in
  rocket_reset()
--

commit 9e5305abf9afea9e1a362f158ce4e7b07f213cce
Author: Jiaxing Hu <gahing@gahingwoo.com>

> accel/rocket: wait for a running IRQ handler before resetting a core
>
> drm_sched_stop() does not wait for a threaded IRQ handler that is already
> running, so call synchronize_irq() after it to make sure the handler has
> finished before the reset.
>
> Before synchronize_irq(), mask the interrupt and clear the raw status, so
> that the NPU core cannot report a completion afterwards.
>
> Do this under job_lock, because the submit path sets the interrupt mask
> under the same lock.
>
> Only touch these registers when the device is powered: check with
> pm_runtime_get_if_active(), so that a register access with the power
> domain off cannot raise an SError.
>
> Suggested-by: Igor Paunovic <royalnet026@gmail.com>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, i=
nduced reset, JOB_TIMEOUT_MS=3D2

[Severity: Low]
This fixes the IRQ race in rocket_reset() introduced with job submission.
Should this include:

  Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index b61bb4d242ce3..8b4ad028bc9b2 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -402,6 +402,16 @@ rocket_reset(struct rocket_core *core, struct drm_sc=
hed_job *bad)
> =20
>  	drm_sched_stop(&core->sched, bad);
> =20
> +	scoped_guard(mutex, &core->job_lock) {
> +		if (pm_runtime_get_if_active(core->dev) > 0) {
> +			rocket_pc_writel(core, INTERRUPT_MASK, 0x0);
> +			rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
> +			pm_runtime_put_autosuspend(core->dev);
> +		}
> +	}

[Severity: High]
Can pm_runtime_force_suspend() disable the core clocks while rocket_reset()
writes INTERRUPT_MASK and INTERRUPT_CLEAR?

core->reset.wq is not WQ_FREEZABLE, and drm_sched_stop() drops
sched.credit_count to 0, making rocket_job_is_idle() return true while
rocket_reset() is still running.  Because pm_runtime_force_suspend() ignores
dev->power.usage_count and rocket_device_runtime_suspend() does not take
core->job_lock, system suspend can disable the clocks concurrently:

kworker (core->reset.wq)          system suspend
rocket_reset()
  drm_sched_stop()
    credit_count -> 0
  mutex_lock(&core->job_lock)
  pm_runtime_get_if_active() > 0
                                  pm_runtime_force_suspend()
                                    rocket_device_runtime_suspend()
                                      rocket_job_is_idle() -> true
                                      clk_bulk_disable_unprepare()
  rocket_pc_writel(...)
    <-- unclocked MMIO access (SError / bus hang)

In addition, in rocket_core_fini(), an in-flight job holds a runtime PM
reference that keeps the core active across pm_runtime_disable() before
rocket_job_fini() cancels the reset worker.  pm_runtime_get_if_active() then
returns -EINVAL and skips masking and clearing interrupts on the active core
before synchronize_irq().

> +
> +	synchronize_irq(core->irq);

[Severity: High]
Can an active DPU task complete after INTERRUPT_CLEAR is written and re-lat=
ch
INTERRUPT_RAW_STATUS before rocket_core_reset() stops the hardware?

Unlike rocket_job_handle_irq(), which writes 0x0 to OPERATION_ENABLE before
writing INTERRUPT_CLEAR, rocket_reset() leaves the core running across
synchronize_irq() and iommu_detach_group() until rocket_core_reset() asserts
the reset lines.  And because rocket_job_irq_handler() checks the unmasked
INTERRUPT_RAW_STATUS register on a shared IRQ line (shared with the IOMMU):

drivers/accel/rocket/rocket_job.c:rocket_job_irq_handler() {
	u32 raw_status =3D rocket_pc_readl(core, INTERRUPT_RAW_STATUS);
...
	if (!(raw_status & PC_INTERRUPT_RAW_STATUS_DPU_0 ||
	      raw_status & PC_INTERRUPT_RAW_STATUS_DPU_1))
		return IRQ_NONE;

	rocket_pc_writel(core, INTERRUPT_MASK, 0x0);

	return IRQ_WAKE_THREAD;
}

a task finishing in that window sets PC_INTERRUPT_RAW_STATUS_DPU_0/1 again,
and a shared IOMMU interrupt on core->irq can wake
rocket_job_irq_handler_thread() after synchronize_irq() has already returne=
d:

kworker (core->reset.wq)          <hardirq> / irq thread
rocket_reset()
  rocket_pc_writel(INTERRUPT_MASK, 0x0)
  rocket_pc_writel(INTERRUPT_CLEAR, 0x1ffff)
  [DPU finishes, re-latches INTERRUPT_RAW_STATUS]
  synchronize_irq(core->irq)
                                  [shared IOMMU IRQ fires]
                                  rocket_job_irq_handler()
                                    reads INTERRUPT_RAW_STATUS
                                    returns IRQ_WAKE_THREAD
  iommu_detach_group()
  rocket_core_reset()
                                  rocket_job_irq_handler_thread()
                                    rocket_job_handle_irq()  <-- races with=
 reset

This also detaches the IOMMU group in iommu_detach_group() while
OPERATION_ENABLE is still set and the NPU has not yet been reset.  Clearing
OPERATION_ENABLE before INTERRUPT_CLEAR (or reading the masked
INTERRUPT_STATUS register in rocket_job_irq_handler()) would prevent the raw
status from re-triggering the IRQ thread.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794615324.gi=
t.gahing@gahingwoo.com?part=3D3
