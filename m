Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBD6606A326
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 07:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MMWyq2y4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A29C10E19C;
	Sun,  8 Nov 2026 07:25:43 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0E2C10E19C
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 07:25:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8BA636144B;
 Sun,  8 Nov 2026 07:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F055D1F008A1;
 Sun,  8 Nov 2026 07:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794122735;
 bh=s7vhFzJuQ5qbhbwXX4L+1KOL59IGheTCnw1BBgbgEOc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MMWyq2y4X20CJr0iu/k9ikh/UaqhJcp+1lZIQlEz77mac1oubkyNAK//7R26fKbJ4
 rjUk8OCr5Tj0DHSs9rVf4iXvXI1oCLSamgj+vHlU6UyZ0ExYUPEbOjV1STNU1dboKY
 QzAtjLc8uVwXbftvHFRxkucTQ7gAEkCWJz2eLzVTZT4kBoxGw4YojIZbrpSOhzFlWE
 9MtpPrj+soIeKL18qIiWlpQjKM6tBUj7fjYqFalbPE+fED3bpk/JWzrHWQ/nvmP6ca
 1rEgsSsa2cV+dF/zYp5lFaVFF1XJyKTFJedoebuUtaUpFkop25iuM7lK59DmPecZT9
 oBeTaLphQ97PQ==
Message-ID: <sashiko-outbox-203617@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 03/16] accel/rocket: wait for a running IRQ handler
 before resetting a core
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261108065917.135194-4-gahing@gahingwoo.com>
References: <20261108065917.135194-1-gahing@gahingwoo.com>
 <20261108065917.135194-4-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 07:25:34 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAD_CREDIT,BAYES_00,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
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

commit 5d8718b3fc39bea11cdb502012dd2c8cf6f0e560
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
This fixes a race in rocket_reset() introduced with job submission.
Should this include:

  Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 03e5f094f60bf..abef12b86d481 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -400,6 +400,16 @@ rocket_reset(struct rocket_core *core, struct drm_sc=
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
Can pm_runtime_force_suspend() disable the core clocks while
rocket_reset() is writing INTERRUPT_MASK and INTERRUPT_CLEAR?

core->reset.wq is created without WQ_FREEZABLE, so rocket_reset() can run
concurrently with system suspend.  drm_sched_stop() subtracts pending job
credits from core->sched.credit_count, which makes rocket_job_is_idle()
return true while rocket_reset() is still running:

CPU0 (core->reset.wq)             CPU1 (system suspend)
rocket_reset()
  drm_sched_stop(&core->sched, bad)
    // credit_count drops to 0
  mutex_lock(&core->job_lock)
  pm_runtime_get_if_active(core->dev)
                                  pm_runtime_force_suspend(core->dev)
                                    rocket_device_runtime_suspend()
                                      rocket_job_is_idle() -> true
                                      clk_bulk_disable_unprepare(...)
  rocket_pc_writel(core, ...)  <-- SError / bus hang with clocks off

pm_runtime_force_suspend() ignores dev->power.usage_count and
rocket_device_runtime_suspend() does not take core->job_lock.

In addition, in rocket_core_fini(), an in-flight job holds a runtime PM
reference so pm_runtime_dont_use_autosuspend() does not suspend the core,
and pm_runtime_disable() sets disable_depth > 0 before rocket_job_fini()
cancels the timeout work.  pm_runtime_get_if_active() then returns
-EINVAL and skips masking and clearing interrupts on the still-active
core before synchronize_irq().

> +
> +	synchronize_irq(core->irq);

[Severity: High]
Can an in-flight NPU task finish after INTERRUPT_CLEAR is written and
re-latch INTERRUPT_RAW_STATUS before rocket_core_reset() stops the core?

Unlike rocket_job_handle_irq(), rocket_reset() does not clear
OPERATION_ENABLE before writing INTERRUPT_CLEAR, and rocket_core_reset()
is only called after synchronize_irq() and iommu_detach_group().  Because
rocket_job_irq_handler() checks the unmasked INTERRUPT_RAW_STATUS
register on a shared IRQ line (shared with the IOMMU), a task completion
together with a shared IRQ can wake the IRQ thread after
synchronize_irq() has already returned:

CPU0                              CPU1
rocket_reset()
  rocket_pc_writel(..., INTERRUPT_MASK, 0x0)
  rocket_pc_writel(..., INTERRUPT_CLEAR, 0x1ffff)
  synchronize_irq(core->irq)
  // DPU task finishes, hardware sets
  // PC_INTERRUPT_RAW_STATUS_DPU_0
                                  <shared IOMMU hardirq>
                                  rocket_job_irq_handler()
                                    rocket_pc_readl(...,
                                      INTERRUPT_RAW_STATUS)
                                    return IRQ_WAKE_THREAD
  iommu_detach_group(...)
  rocket_core_reset(core)
                                  rocket_job_irq_handler_thread()
                                    rocket_job_handle_irq(core)
                                      <-- runs during/after reset

rocket_job_handle_irq() can then access registers while the reset lines
are asserted or after runtime suspend, or race with a new job started by
drm_sched_start().  Also, iommu_detach_group() detaches the IOMMU domain
before rocket_core_reset() has stopped the still-running NPU core.
Clearing OPERATION_ENABLE under core->job_lock before clearing
INTERRUPT_CLEAR, as rocket_job_handle_irq() does, would stop the core
before synchronize_irq() and iommu_detach_group().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108065917.1351=
94-1-gahing@gahingwoo.com?part=3D3
