Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA47C79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 09:06:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9548810E146;
	Wed,  9 Sep 2026 09:06:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RA3c3I9g";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE8C510E146
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 09:06:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CF3FD601FF;
 Wed,  9 Sep 2026 09:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCC31F00A3D;
 Wed,  9 Sep 2026 09:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788944780;
 bh=FAL7Dm/W/QsCfNk7BhIHNon+A3YKI7/DuwahG4heNEg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RA3c3I9gVha2tIGXnRf8zpXDbn11dDXIrZs0Zycy2fMTaIuZrY/7JgcuToFtW4tQA
 A0hyt+rQ2W0ik2DAUsw+2u7qBeiCpP3bt5cpi9N9BIZmWTYNDuSCWL9gXhfZL+Suf5
 s4ACVjilcUwbkxEc0ywteTlvTjN9OsPAW/N7inbLcg1VnRmcWl1P2LoEm/K6UMTOxX
 Ooa2aWpVgGtHLnliGERUD1HIBT3qHnGIuteCVhOo/4EkmedAasmZNV+96Bj+xIGDkP
 7ryekKcn6RmX+Rphu6WmXQZZtJVRiT97ipbChU/LPhGByFcsdw3aJ58lkISGCQug9u
 szi9BycGicslA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm: split DPU core IRQ handler under
 CONFIG_PREEMPT_RT
To: vishnu.saini@oss.qualcomm.com
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260909-drm-mis-next-split-irq-v1-1-89bc9c512c53@oss.qualcomm.com>
References: <20260909-drm-mis-next-split-irq-v1-1-89bc9c512c53@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:06:19 +0000
Message-Id: <20260909090620.4DCC31F00A3D@smtp.kernel.org>
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
- [Critical] Setting `IRQF_NO_THREAD` for backends without `irq_thread` for=
ces them into hardirq context on PREEMPT_RT, causing kernel panics.
- [High] Race condition in threaded IRQ handler leading to NULL pointer der=
eference or Use-After-Free on PREEMPT_RT.
- [High] Acquiring sleepable `spinlock_t` inside `raw_spinlock_t` on non-RT=
 kernels violates wait-context rules, triggering lockdep splats.
- [High] `dpu_core_irq_read()` reads hardware registers directly without ch=
ecking `irq_pending_mask`, causing fault recovery loops to falsely timeout =
on PREEMPT_RT.
- [Medium] Primary IRQ handler incorrectly returns `IRQ_NONE` after clearin=
g masked interrupts, risking permanent IRQ disablement.
--

commit de5a98b2b15837b087edf7ff28d14a0650953129
Author: Naman S Thaker <namathak@qti.qualcomm.com>
Subject: drm/msm: split DPU core IRQ handler under CONFIG_PREEMPT_RT

This commit splits dpu_core_irq() into a minimal hardirq handler and a new
dpu_core_irq_thread() to dispatch per-encoder callbacks on PREEMPT_RT
kernels. It also changes irq_lock to raw_spinlock_t and drops IRQF_NO_THREAD
where threaded handlers are not implemented.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c b/drivers/=
gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> index 5b7cd5241f450..95b016e8d7df1 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> @@ -322,6 +322,52 @@ static void dpu_core_irq_callback_handler(struct dpu=
_kms *dpu_kms, unsigned int
>  	irq_entry->cb(irq_entry->arg);
>  }
> =20
> +/*
> + * dpu_core_irq_dispatch() runs the fired bits for @reg_idx through their
> + * registered callbacks directly. Only used on non-PREEMPT_RT kernels, w=
here
> + * dpu_core_irq() itself is allowed to take the sleepable locks reached =
via
> + * those callbacks.
> + */
> +static void dpu_core_irq_dispatch(struct dpu_kms *dpu_kms, int reg_idx, =
u32 irq_status)
> +{
> +	unsigned int irq_idx;
> +	int bit;
> +
> +	/*
> +	 * Search through matching intr status.
> +	 */
> +	while ((bit =3D ffs(irq_status)) !=3D 0) {
> +		irq_idx =3D DPU_IRQ_IDX(reg_idx, bit - 1);
> +
> +		dpu_core_irq_callback_handler(dpu_kms, irq_idx);

[Severity: High]
On non-RT kernels, this dispatch happens while holding the raw_spin_lock=20
acquired in dpu_core_irq(). Does this violate wait-context rules?

The dispatched callbacks (e.g., DRM vblank event handlers) acquire standard
spinlock_t locks. Acquiring a spinlock_t (wait context LD_WAIT_CONFIG) while
holding a raw_spinlock_t (wait context LD_WAIT_SPIN) constitutes an invalid
wait context and triggers a lockdep splat on non-RT kernels.

[ ... ]

> @@ -332,16 +378,14 @@ irqreturn_t dpu_core_irq(struct msm_kms *kms)
>  	struct dpu_kms *dpu_kms =3D to_dpu_kms(kms);
>  	struct dpu_hw_intr *intr =3D dpu_kms->hw_intr;
>  	int reg_idx;
> -	unsigned int irq_idx;
>  	u32 irq_status;
>  	u32 enable_mask;
> -	int bit;
> -	unsigned long irq_flags;
> +	bool wake_thread =3D false;
> =20
>  	if (!intr)
>  		return IRQ_NONE;
> =20
> -	spin_lock_irqsave(&intr->irq_lock, irq_flags);
> +	raw_spin_lock(&intr->irq_lock);
>  	for (reg_idx =3D 0; reg_idx < MDP_INTR_MAX; reg_idx++) {
>  		if (!test_bit(reg_idx, &intr->irq_mask))
>  			continue;
> @@ -363,6 +407,52 @@ irqreturn_t dpu_core_irq(struct msm_kms *kms)
>  		if (!irq_status)
>  			continue;

[Severity: Medium]
Will this lead to the generic IRQ subsystem permanently disabling the displ=
ay
IRQ line?

If an interrupt fires but is filtered out by enable_mask, the hardware
interrupt is actively cleared a few lines above this, but irq_status
becomes 0, meaning the loop continues and wake_thread remains false.

> =20
> +		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +			dpu_core_irq_defer_to_thread(intr, reg_idx, irq_status);
> +			wake_thread =3D true;
> +		} else {
> +			dpu_core_irq_dispatch(dpu_kms, reg_idx, irq_status);
> +		}
> +	}
> +
> +	/* ensure register writes go through */
> +	wmb();
> +
> +	raw_spin_unlock(&intr->irq_lock);
> +
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +		return wake_thread ? IRQ_WAKE_THREAD : IRQ_NONE;

[Severity: Medium]
(Continued from above)
On PREEMPT_RT, returning IRQ_NONE after actively clearing a masked interrupt
falsely tells the generic IRQ subsystem that the interrupt was unhandled.
This could cause the spurious interrupt detector to disable the IRQ line.

> +
> +	return IRQ_HANDLED;
> +}
> +
> +#ifdef CONFIG_PREEMPT_RT
> +/*
> + * dpu_core_irq_thread() runs in a genuine preemptible IRQ thread (woken=
 via
> + * IRQ_WAKE_THREAD from dpu_core_irq() above), so it's safe for it -- an=
d the
> + * per-encoder callbacks it dispatches to -- to take spinlock_t/rt_mutex
> + * locks such as enc_spinlock, dpu_crtc::spin_lock, and the various DRM-=
core
> + * locks reached via vblank/CRC/writeback handling.
> + */
> +irqreturn_t dpu_core_irq_thread(struct msm_kms *kms)
> +{
> +	struct dpu_kms *dpu_kms =3D to_dpu_kms(kms);
> +	struct dpu_hw_intr *intr =3D dpu_kms->hw_intr;
> +	int reg_idx;
> +	unsigned int irq_idx;
> +	u32 irq_status;
> +	unsigned long irq_flags;
> +	int bit;
> +
> +	if (!intr)
> +		return IRQ_NONE;
> +
> +	for (reg_idx =3D 0; reg_idx < MDP_INTR_MAX; reg_idx++) {
> +		raw_spin_lock_irqsave(&intr->irq_lock, irq_flags);
> +		irq_status =3D intr->irq_pending_mask[reg_idx];
> +		intr->irq_pending_mask[reg_idx] =3D 0;
> +		raw_spin_unlock_irqrestore(&intr->irq_lock, irq_flags);
> +
>  		/*
>  		 * Search through matching intr status.
>  		 */

[Severity: High]
Does this leave the callback dispatch completely unprotected from concurrent
modifications?

Since raw_spin_unlock_irqrestore() is called before iterating over the bits,
the callback pointers can be concurrently set to NULL by
dpu_core_irq_unregister_callback() (which acquires irq_lock).=20

This allows the callback pointer to be zeroed between the check and executi=
on
in the thread, which could lead to a deterministic NULL pointer dereference.
Furthermore, if the caller frees the callback context immediately after
unregistering, it causes a Use-After-Free since no synchronization prevents
the thread from executing the concurrently running callback.

[ ... ]

> @@ -554,7 +640,7 @@ u32 dpu_core_irq_read(struct dpu_kms *dpu_kms,
>  		return 0;
>  	}
> =20
> -	spin_lock_irqsave(&intr->irq_lock, irq_flags);
> +	raw_spin_lock_irqsave(&intr->irq_lock, irq_flags);
> =20
>  	reg_idx =3D DPU_IRQ_REG(irq_idx);
>  	intr_status =3D DPU_REG_READ(&intr->hw,
> @@ -567,7 +653,7 @@ u32 dpu_core_irq_read(struct dpu_kms *dpu_kms,
>  	/* ensure register writes go through */
>  	wmb();
> =20
> -	spin_unlock_irqrestore(&intr->irq_lock, irq_flags);
> +	raw_spin_unlock_irqrestore(&intr->irq_lock, irq_flags);
> =20
>  	return intr_status;
>  }

[Severity: High]
Could this result in false timeout errors on PREEMPT_RT?

dpu_core_irq_read() is used by driver wait paths to verify if a hardware ev=
ent
fired but the software callback was delayed. Because it reads the hardware
register directly (which reads as 0 because the hardirq already cleared it)
and ignores the new irq_pending_mask, it could falsely conclude that the
interrupt never fired.

[ ... ]

> diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
> index e5d0ea6294484..f7d045f283ad9 100644
> --- a/drivers/gpu/drm/msm/msm_kms.c
> +++ b/drivers/gpu/drm/msm/msm_kms.c
> @@ -76,7 +90,25 @@ static int msm_irq_install(struct drm_device *dev, uns=
igned int irq)
> =20
>  	msm_irq_preinstall(dev);
> =20
> +#ifdef CONFIG_PREEMPT_RT
> +	/*
> +	 * Some KMS backends (e.g. dpu1) split their handler into a minimal
> +	 * hardirq primary handler that only acks hardware and a threaded
> +	 * handler that does the actual (sleep-capable) callback dispatch.
> +	 * IRQF_ONESHOT keeps the primary handler running as a true hardirq
> +	 * even under PREEMPT_RT's forced-threading (see
> +	 * irq_setup_forced_threading() in kernel/irq/manage.c), the same
> +	 * property IRQF_NO_THREAD gives the backends that don't split their
> +	 * handler and must run their whole ->irq() in hardirq context.
> +	 */
> +	if (kms->funcs->irq_thread)
> +		ret =3D request_threaded_irq(irq, msm_irq, msm_irq_thread,
> +					   IRQF_ONESHOT, dev->driver->name, dev);
> +	else
> +		ret =3D request_irq(irq, msm_irq, IRQF_NO_THREAD, dev->driver->name, d=
ev);

[Severity: Critical]
Will setting IRQF_NO_THREAD force legacy backends into hardirq context on
PREEMPT_RT, causing kernel panics?

The patch sets IRQF_NO_THREAD for legacy KMS backends (e.g., MDP5, MDP4)
because they don't implement the new irq_thread callback. However, this
explicitly disables forced-threading on PREEMPT_RT. Because these legacy
handlers acquire standard spinlock_t locks (which are sleepable rt_mutexes
on RT), running them strictly in hardirq context is invalid and will result
in a "scheduling while atomic" crash.

> +#else
>  	ret =3D request_irq(irq, msm_irq, 0, dev->driver->name, dev);
> +#endif
>  	if (ret)
>  		return ret;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-drm-mis-ne=
xt-split-irq-v1-1-89bc9c512c53@oss.qualcomm.com?part=3D1
