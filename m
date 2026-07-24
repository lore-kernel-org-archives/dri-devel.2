Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C63C531CC
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C66C610F271;
	Fri, 24 Jul 2026 00:17:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZKSC5coL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01F2510F271
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 00:17:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CDE654048C;
 Fri, 24 Jul 2026 00:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879331F000E9;
 Fri, 24 Jul 2026 00:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784852238;
 bh=LNoBiZRIkqYaP7eETzGa30iNuatp+QWvr3IiVW15Vhg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZKSC5coLVC9XZ9u55w8+hxd9R6ZKPr5KFkScIVPjXnz1eWorrFKZNuHodiniXaFc4
 fog1LzS65PgjwQ3tMWjEirzp2qoHFVuTF17yuFHBGe97DyNTRHypI0VnfYZ4pytX/C
 QAtQDAdVuL8gG0gfMilGYjrgbir3kNhA88Mgb1LQHyCbR9EUIWFay616m1PjAzT6xq
 heFb9dWG7DVpVLuktqZ4RZNS4uulRFYAyYz3YTEDbAGeEa/6EHPbqTCrYamtYJUXj6
 LISy7lZJO9m/LOTk46YffS3N5tlT1U216yWwOY8+ynNfGroJ3P8X5bdv+58NX/ZZss
 oO0fJl8Va76hA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/13] drm/panfrost: Sync with IRQ before MMU disable
 and reset
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260724-claude-fixes-v3-7-542af61abd0f@collabora.com>
References: <20260724-claude-fixes-v3-0-542af61abd0f@collabora.com>
 <20260724-claude-fixes-v3-7-542af61abd0f@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 00:17:18 +0000
Message-Id: <20260724001718.879331F000E9@smtp.kernel.org>
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
- [High] panfrost_device_runtime_suspend unconditionally dereferences pfdev=
->js, causing a kernel panic on early probe failure.
- [High] Missing IRQ synchronization in panfrost_jm_fini and panfrost_gpu_f=
ini allows concurrent IRQ handlers to access freed memory or disabled hardw=
are.
- [High] A Time-of-Check to Time-of-Use (TOCTOU) race condition between the=
 threaded IRQ handler and the IRQ suspend function can leave MMU hardware i=
nterrupts enabled, leading to an unhandled interrupt storm.
--

--- Patch [7]: [PATCH v3 07/13] drm/panfrost: Sync with IRQ before MMU disa=
ble and reset ---
commit 50e811614859715a2c6f2e0b562e19db3f2c571c
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Sync with IRQ before MMU disable and reset

This commit synchronizes the MMU IRQ handler before disabling and resetting
the MMU, preventing HW register accesses from spurious interrupts during
device teardown or reset. It introduces panfrost_mmu_suspend_irq() to
handle the IRQ suspension sequence.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/pa=
nfrost/panfrost_mmu.c
> index bb6c1614964b1..f067bcd360a89 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -347,6 +347,7 @@ void panfrost_mmu_reset(struct panfrost_device *pfdev)
>  	struct panfrost_mmu *mmu, *mmu_tmp;
> =20
>  	clear_bit(PANFROST_COMP_BIT_MMU, pfdev->is_suspended);
> +	synchronize_irq(pfdev->mmu_irq);
> =20
>  	spin_lock(&pfdev->as_lock);

[ ... ]

> @@ -980,11 +981,6 @@ int panfrost_mmu_init(struct panfrost_device *pfdev)
>  	return 0;
>  }
> =20
> -void panfrost_mmu_fini(struct panfrost_device *pfdev)
> -{
> -	mmu_write(pfdev, MMU_INT_MASK, 0);
> -}
> -
>  void panfrost_mmu_suspend_irq(struct panfrost_device *pfdev)
>  {
>  	set_bit(PANFROST_COMP_BIT_MMU, pfdev->is_suspended);
> @@ -992,3 +988,8 @@ void panfrost_mmu_suspend_irq(struct panfrost_device =
*pfdev)
>  	mmu_write(pfdev, MMU_INT_MASK, 0);
>  	synchronize_irq(pfdev->mmu_irq);
>  }

[Severity: High]
This is a pre-existing issue, but is there a Time-of-Check to Time-of-Use
(TOCTOU) race condition between this suspend function and the threaded IRQ
handler?

If the threaded handler panfrost_mmu_irq_handler_thread() checks
PANFROST_COMP_BIT_MMU without holding locks:

	if (!test_bit(PANFROST_COMP_BIT_MMU, pfdev->is_suspended)) {
		spin_lock(&pfdev->as_lock);
		mmu_write(pfdev, MMU_INT_MASK, ~pfdev->as_faulty_mask);
		spin_unlock(&pfdev->as_lock);
	}

Concurrently, panfrost_mmu_suspend_irq() sets the bit, writes 0 to
MMU_INT_MASK, and calls synchronize_irq().

If the threaded handler performs the test_bit() check just before the bit
is set, it evaluates to true. Then suspend_irq() masks interrupts and
waits, and finally the threaded handler overwrites the 0 with
~pfdev->as_faulty_mask, re-enabling interrupts.

Could this lead to an unhandled interrupt storm if the device asserts the
interrupt and panfrost_mmu_irq_handler() returns IRQ_NONE?

> +
> +void panfrost_mmu_fini(struct panfrost_device *pfdev)
> +{
> +	panfrost_mmu_suspend_irq(pfdev);
> +}


[Severity: High]
This isn't a bug introduced by this patch, but does early probe failure
cause a kernel panic due to a NULL pointer dereference?

If the device probe fails early (e.g., in panfrost_gpu_init() or
panfrost_mmu_init()), panfrost_jm_init() is never reached, leaving
pfdev->js as NULL. The error unwinding path calls
panfrost_try_suspend_device(), which synchronously triggers
panfrost_device_runtime_suspend().

This suspend handler unconditionally calls panfrost_jm_is_idle(pfdev):

drivers/gpu/drm/panfrost/panfrost_device.c:panfrost_device_runtime_suspend(=
) {
    ...
    if (!panfrost_jm_is_idle(pfdev))
        return -EBUSY;
    ...
}

Which then dereferences pfdev->js->queue:

drivers/gpu/drm/panfrost/panfrost_job.c:panfrost_jm_is_idle() {
    struct panfrost_job_slot *js =3D pfdev->js;
    ...
    if (atomic_read(&js->queue[i].sched.credit_count))
    ...
}

Can we safely call panfrost_jm_is_idle() before verifying if the job
manager is initialized?


[Severity: High]
This is a pre-existing issue, but are there missing IRQ synchronizations in
panfrost_jm_fini() and panfrost_gpu_fini() that could allow concurrent IRQ
handlers to access freed memory or disabled hardware?

In panfrost_jm_fini(), the driver masks job interrupts but fails to set the
suspend bit (PANFROST_COMP_BIT_JOB) or wait for executing threaded handlers:

drivers/gpu/drm/panfrost/panfrost_job.c:panfrost_jm_fini() {
    ...
    job_write(pfdev, JOB_INT_MASK, 0);

    for (j =3D 0; j < NUM_JOB_SLOTS; j++) {
        drm_sched_fini(&js->queue[j].sched);
    }
    ...
}

Could a concurrently running IRQ thread access the destroyed scheduler
queues or re-enable the interrupts?

Similarly, in panfrost_gpu_fini(), the GPU is powered off without
synchronizing or suspending the shared GPU IRQ:

drivers/gpu/drm/panfrost/panfrost_gpu.c:panfrost_gpu_fini() {
    panfrost_gpu_power_off(pfdev);
}

If a shared interrupt fires, panfrost_gpu_irq_handler() will read
GPU_FAULT_STATUS from powered-off hardware. Could this cause a bus fault?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-claude-fix=
es-v3-0-542af61abd0f@collabora.com?part=3D7
