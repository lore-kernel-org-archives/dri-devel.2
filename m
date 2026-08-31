Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7C0C61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14A5410E742;
	Mon, 31 Aug 2026 08:37:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QSesg+oN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE8D610E72D
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:37:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 72BDA60120;
 Mon, 31 Aug 2026 08:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F901F000E9;
 Mon, 31 Aug 2026 08:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788165469;
 bh=zPK7G2skHSMGvmLHpUDRvOBrUyC5UZqXT8/pjHHg2MQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QSesg+oNEZ7FU0A+t44evcvdpgOn4MLH3LrwKCP+3GuaUml8sowd1NKnV7tbsKBgA
 H0eM5Bxfcb8VLhYEsom1BoHzIAJedfFO+BgL4oE/4qFK2uR3v2t+Ln96M20wltK0bt
 lMry+n8+Gu5ww1scqrGdGFARgjCCkZhRRdeWygtvqaXmzmAweVA4/Ka6Y8dvh1szdF
 20LSpoV6Buj4qqO/Vo0RJ6ritBBz9GO8YUVnlyRM1xGe4NG4atcAD+JDgdASJfKghx
 X/jgiuqf2OJSIzAVkdUIhpb5O18W5yqzzxRYgY6FlJfmCDA7q0pTpPT4g6L2iE/F/h
 tYwbVjE4b/dDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 03/14] accel/rocket: wait for a running IRQ handler
 before resetting a core
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260831081956.84871-4-gahing@gahingwoo.com>
References: <20260831081956.84871-1-gahing@gahingwoo.com>
 <20260831081956.84871-4-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 08:37:48 +0000
Message-Id: <20260831083748.C8F901F000E9@smtp.kernel.org>
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
- [High] Lockless modification of INTERRUPT_MASK in rocket_reset() races wi=
th concurrent task submission in the IRQ handler, potentially leaving inter=
rupts enabled.
- [Medium] Fails to mask interrupts when Runtime PM is disabled, incorrectl=
y treating -EINVAL as an inactive state.

Pre-existing issues:
- [High] Missing iommu_group_put() leaks the IOMMU group reference on every=
 completed job.
- [High] The threaded IRQ handler unconditionally accesses hardware registe=
rs without ensuring the device is active, causing an async SError on spurio=
us or delayed interrupts.
--

commit dafaccb47666f525ef9a0018c8357108f3591b85
Author: Jiaxing Hu <gahing@gahingwoo.com>

accel/rocket: wait for a running IRQ handler before resetting a core

rocket_reset() calls drm_sched_stop(), which stops the scheduler and
returns. It does not wait for a threaded handler that is already
running, so the comment that follows, "Remaining interrupts have been
handled", states an assumption rather than something the code arranges.

[ ... ]

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 5f0f9682e57ca..3c0ed46050669 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -377,9 +377,37 @@ rocket_reset(struct rocket_core *core, struct drm_sc=
hed_job *bad)
>  	drm_sched_stop(&core->sched, bad);
> =20
>  	/*
> -	 * Remaining interrupts have been handled, but we might still have
> -	 * stuck jobs. Let's make sure the PM counters stay balanced by
> -	 * manually calling pm_runtime_put_noidle().
> +	 * Mask the block before waiting. hw_submit() arms INTERRUPT_MASK on
> +	 * every submit and only the hardirq clears it, so on an ordinary
> +	 * timeout it is still live and a completion can arrive after the sync
> +	 * returns. The next submit re-arms it, so nothing is lost here.
> +	 *
> +	 * Only when the device is already awake, though. This function holds no
> +	 * runtime PM reference of its own: the only one in the window belongs =
to
> +	 * in_flight_job, and the completion path may have put it and cleared t=
he
> +	 * pointer before the timeout worker got here. drm_sched_stop() above c=
an
> +	 * block for a long time, and it drops every pending job's credits, so
> +	 * rocket_job_is_idle() is true and nothing keeps the core resumed. On
> +	 * this hardware a register access with the domain down takes an async
> +	 * SError, so a reset must not be the thing that causes one.
> +	 */
> +	if (pm_runtime_get_if_active(core->dev) > 0) {

[Severity: Medium]
Does this condition fail to account for the -EINVAL return value when
Runtime PM is disabled?

pm_runtime_get_if_active() returns -EINVAL when Runtime PM is disabled.
The condition > 0 evaluates to false, causing the interrupt masking to
be skipped. Even though the device is always awake when PM is disabled,
the mask is still required to prevent concurrent access during reset.

[Severity: High]
Does this lockless register write race with the IRQ handler's hardware
submission?

If rocket_reset() checks pm_runtime_get_if_active() and writes 0x0 to
INTERRUPT_MASK concurrently while the threaded IRQ handler calls
rocket_job_hw_submit() (holding core->job_lock) after reading
reset.pending =3D=3D 0:

IRQ Handler:
rocket_job_hw_submit()
    rocket_pc_writel(core, INTERRUPT_MASK, PC_INTERRUPT_MASK_DPU_0 | PC_INT=
ERRUPT_MASK_DPU_1);

If this write occurs after rocket_reset()'s write, the interrupt is left
enabled. This could allow the IRQ handler to execute while the device is
suspended, triggering an async SError.

> +		rocket_pc_writel(core, INTERRUPT_MASK, 0x0);
> +		pm_runtime_put_autosuspend(core->dev);
> +	}
> +
> +	/*
> +	 * drm_sched_stop() returns without waiting for a threaded handler that
> +	 * is already running, so wait for one here. This has to stay outside
> +	 * job_lock: the handler takes that lock, so waiting for it while
> +	 * holding it would deadlock instead of fencing anything.
> +	 */
> +	synchronize_irq(core->irq);

[ ... ]

[Severity: High]
This is a pre-existing issue, but does this code leak the IOMMU group refer=
ence
on every completed job?

drivers/accel/rocket/rocket_job.c:rocket_job_next_locked() {
    ...
	iommu_detach_group(NULL, iommu_group_get(core->dev));
    ...
}

iommu_group_get() increments the kobject reference counter, but
iommu_detach_group() does not consume the reference. Without a matching
call to iommu_group_put(), this causes a permanent resource leak that
could prevent device unbinding.

[Severity: High]
This is a pre-existing issue, but does this unconditional register access r=
isk
an async SError on spurious or delayed interrupts?

drivers/accel/rocket/rocket_job.c:rocket_job_handle_irq() {
    ...
	scoped_guard(mutex, &core->job_lock) {
		/*
		 * Stopping the block belongs under the lock. hw_submit() writes
		 * OPERATION_ENABLE too, and outside the lock this zero can land
		 * after that one and stop a task that has only just started.
		 */
		rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
		rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
    ...
}

The threaded IRQ handler unconditionally accesses hardware registers without
verifying if the device is active (e.g., using pm_runtime_get_if_active()).
If a spurious or delayed interrupt runs after the device has suspended,
writing to powered-off hardware will trigger an async SError and kernel
panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831081956.8487=
1-1-gahing@gahingwoo.com?part=3D3
