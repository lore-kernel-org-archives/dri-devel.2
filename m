Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE37EC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 08:27:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F34110E4A4;
	Thu,  2 Jul 2026 08:27:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZSSfaaK2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A56610E4A4
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 08:27:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4CA5F4060B;
 Thu,  2 Jul 2026 08:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3781F00A3D;
 Thu,  2 Jul 2026 08:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782980827;
 bh=IOfaXTno552t6PJwBzn/wQ/Xg7QgGCI+d2jK0TvZJ0o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZSSfaaK2mdrQEx6dg7MlLwRyi4N2SrlQG0G9xvPbNSXrzcxU8pr3Spah0lrLO0RX3
 OxXFZWOhZpYbRImAkP47EQR0fVQxxOTTMRcUFiymCjSXuNtBmk3c66n2dBsTp3BDvH
 mfMJ7zmZqQoAvQp/tFHFFrRWOhyWtKtUZq3xPlGy3kVAaoaDye404DK5GQSAhdwFsD
 QJLOCphJAADVAUDiQMw3nqTYTdvHub0w8drw0lyLW5WDlZ0WrPl4p1mP1OHo8ynMFo
 8BkZTxHj4CJPuhGLqw/YhGCe2qHhDvDQ0hgE6x70pfQ6GcTn16qlgWPW0nGydsq4QI
 TOiQhwmS+uiTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] drm/i915/gt: Use spin_lock_irq() instead of
 local_irq_disable() + spin_lock()
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702080913.434121-2-dev@lankhorst.se>
References: <20260702080913.434121-1-dev@lankhorst.se>
 <20260702080913.434121-2-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 08:27:06 +0000
Message-Id: <20260702082707.0F3781F00A3D@smtp.kernel.org>
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
- [High] Request submission to the ELSP hardware is executed with interrupt=
s enabled, violating hardware constraints for tightly packed MMIO sequences=
 and risking GPU hangs.
--

commit 03bdcff0829362b8c38fdcf058920884f728b511
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
drm/i915/gt: Use spin_lock_irq() instead of local_irq_disable() + spin_lock=
()

This commit replaces the local_irq_disable() wrapper around
execlists_dequeue() with spin_lock_irq() inside the function, to resolve a
PREEMPT_RT incompatibility.

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
> @@ -1614,13 +1614,6 @@ static void execlists_dequeue(struct intel_engine_=
cs *engine)
>  	}
>  }
> =20
> -static void execlists_dequeue_irq(struct intel_engine_cs *engine)
> -{
> -	local_irq_disable(); /* Suspend interrupts across request submission */
> -	execlists_dequeue(engine);
> -	local_irq_enable(); /* flush irq_work (e.g. breadcrumb enabling) */
> -}

[Severity: High]
Does removing the local_irq_disable() wrapper leave the hardware submission
sequence exposed to interruptions?

In the original code, local_irq_disable() inside execlists_dequeue_irq()
protected the entire execlists_dequeue() function. Now that
spin_unlock_irq() is used instead, interrupts are re-enabled before the
function finishes:

	spin_unlock_irq(&sched_engine->lock);

	/* ... */
	if (submit && ...) {
		/* ... */
		execlists_submit_ports(engine);
	}

Because interrupts are now enabled prior to calling execlists_submit_ports(=
),
an interrupt or thread preemption event could occur during the ELSP MMIO
writes. Since the ELSP hardware requires tightly packed writes without
excessive delays, could this interruption cause a hardware state machine
timeout and result in a GPU hang?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702080913.4341=
21-1-dev@lankhorst.se?part=3D1
