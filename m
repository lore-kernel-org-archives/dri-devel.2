Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AF1C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 11:48:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EDB110E5D4;
	Fri,  3 Jul 2026 11:48:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B7FXE76x";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D85D10F7D7
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 11:48:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 543C46001A;
 Fri,  3 Jul 2026 11:48:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02311F000E9;
 Fri,  3 Jul 2026 11:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783079281;
 bh=jpcoWDOt40buvynAWTWoEPUCo/8GdcM2Ex8hxIPoQu8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=B7FXE76xNHm3lpZaZsLtJdcHV1bUZbR6036lZEmzIa6eQHbZFJSiZMAh+nmpojr5z
 eF2Ju3XEB0kmvUSf9mIoyDNXTYnQgpoYmGCayXAn2azdOpCHETY/3gi1lvclGJ5ZHy
 MgXcCUnnjGDbujPQuk51RzHCyPL1wvm95XRoE7a0l23E4p19t+Sko62aLZClW8Llxq
 au8gzvZxUSi+0Zq2+WS64YkGcx09kQiLHcuNyOK46qz2/Gthfmp2SfsAHgRe2YxQJc
 Q+VgcBb1octP2gjCIit8zWEnQX/BN4o+I/Akw+eE50W4cqVvohfgfJBagYJljcG3R7
 gdQj5wLDJ0tNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/7] drm/i915/gt: Use spin_lock_irq() instead of
 local_irq_disable() + spin_lock()
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260703113259.801374-2-dev@lankhorst.se>
References: <20260703113259.801374-1-dev@lankhorst.se>
 <20260703113259.801374-2-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 11:48:00 +0000
Message-Id: <20260703114800.D02311F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Re-enabling interrupts before `execlists_submit_ports()` violates =
the hardware ELSP submission constraint and causes premature `irq_work` flu=
shing, breaking cross-engine request execution ordering.
--

commit 2338d7dc7111f08419fa617c233f6984399c8937
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

drm/i915/gt: Use spin_lock_irq() instead of local_irq_disable() + spin_lock=
()

This patch modifies execlists_dequeue() to use spin_lock_irq() and=20
spin_unlock_irq() directly. It removes execlists_dequeue_irq() which=20
previously wrapped the entire dequeue operation in local_irq_disable().

> diff --git a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c b/drive=
rs/gpu/drm/i915/gt/intel_execlists_submission.c
> index 1359fc9cb88ef..e11db81dca9c5 100644
> --- a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
> +++ b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c

[ ... ]

> @@ -1588,7 +1588,7 @@ static void execlists_dequeue(struct intel_engine_c=
s *engine)
>  	 */
>  	sched_engine->queue_priority_hint =3D queue_prio(sched_engine);
>  	i915_sched_engine_reset_on_empty(sched_engine);
> -	spin_unlock(&sched_engine->lock);
> +	spin_unlock_irq(&sched_engine->lock);

[Severity: High]
Does re-enabling interrupts here before calling execlists_submit_ports()=20
violate the hardware ELSP submission constraints?

The original execlists_dequeue_irq() kept interrupts disabled across the
entire dequeue process, including the final MMIO writes. By changing to
spin_unlock_irq() here, interrupts are re-enabled before the execution of:

execlists_submit_ports() {
    ...
    for (n =3D execlists_num_ports(execlists); n--; ) {
        struct i915_request *rq =3D execlists->pending[n];

        write_desc(execlists,
                   rq ? execlists_update_context(rq) : 0,
                   n);
    }
}

Hardware requires these consecutive ELSP MMIO writes to be atomic without
intervening accesses. If an interrupt fires during this loop, could it
corrupt the submission sequence and cause a GPU hang?=20

Additionally, can enabling interrupts this early cause premature irq_work
flushing, breaking cross-engine request execution ordering?

> =20
>  	/*
>  	 * We can skip poking the HW if we ended up with exactly the same set

[ ... ]

> -static void execlists_dequeue_irq(struct intel_engine_cs *engine)
> -{
> -	local_irq_disable(); /* Suspend interrupts across request submission */
> -	execlists_dequeue(engine);
> -	local_irq_enable(); /* flush irq_work (e.g. breadcrumb enabling) */
> -}
> -

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703113259.8013=
74-1-dev@lankhorst.se?part=3D1
