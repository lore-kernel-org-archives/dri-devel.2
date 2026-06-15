Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FE4CD98DA
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:39:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 711E710E707;
	Mon, 15 Jun 2026 20:39:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jY7Y1UcH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54B0010E704
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 20:39:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3CCA44393B;
 Mon, 15 Jun 2026 20:39:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC82C1F00A3A;
 Mon, 15 Jun 2026 20:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781555961;
 bh=iL0+LzwDzKicZ+OepsYbjZLaoKTKwCI5GYrCq0JYgQ0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jY7Y1UcH+h02udWSHlm5YQK3XEp2d4v8q+EAaZNB1OuSR4Lag99eG8b2HbA4mwMCq
 lgdDyfxICaYx3qSY5RdEoPRBB9D4TgHgSCEWNGGn3ztrAyqYFZl76VShE78UaOAcuM
 Zsxzq8Qd26/kyJZcKWH8y0s4MIZNSYGotvbalc2CgrjaAVyinjoLXg9v+4gKdXKWDo
 kPYNj6Mz9qK7SWBkU8wqgFJMsVda6uCTh5gu58Ja5BngMa0ybMgUHLAIIRnGX4GItV
 c3sFpe1Bw557J4OokN3rFM1D3xo4He/5swhNuJnrDuVLGEgphjb7gQtPQ9luV5i0dK
 O2vm7MwmytARA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 15/27] drm/i915/gt: Use spin_lock_irq() instead of
 local_irq_disable() + spin_lock()
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260615201846.307297-16-dev@lankhorst.se>
References: <20260615201846.307297-16-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 20:39:20 +0000
Message-Id: <20260615203920.EC82C1F00A3A@smtp.kernel.org>
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
- [High] Removing local_irq_disable() exposes the ELSP (ExecList Submit Por=
t) MMIO writes to hardirq preemption, risking hardware hangs due to interle=
aved MMIO accesses.
--

commit 417d04153bfb15dc2291029341c85c1b4a51d8bb
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
drm/i915/gt: Use spin_lock_irq() instead of local_irq_disable() + spin_lock=
()

This patch modifies the execlists dequeue paths by replacing the explicit
local_irq_disable() wrapper with spin_lock_irq() semantics on the schedule
engine lock.

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

[Severity: High]
Does removing the local_irq_disable() wrapper expose the ELSP MMIO writes
to hardirq preemption?

With the move to spin_unlock_irq() earlier in the function, hardware=20
interrupts are re-enabled before execlists_submit_ports() is called at the
end of execlists_dequeue().

Inside the submission path, write_desc() performs multiple 32-bit writel()=
=20
operations to the ELSP register:

	writel(upper_32_bits(desc), execlists->submit_reg);
	writel(lower_32_bits(desc), execlists->submit_reg);

If an interrupt occurs between these consecutive MMIO writes and performs
other GPU MMIO accesses, could this disrupt the hardware submission state
machine and lead to GPU hangs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615201846.3072=
97-1-dev@lankhorst.se?part=3D15
