Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09940C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:56:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FC7410E8A8;
	Mon,  6 Jul 2026 10:56:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H4k6nZBA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9267F10E13C
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 10:56:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AED7B600DA;
 Mon,  6 Jul 2026 10:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A36A1F000E9;
 Mon,  6 Jul 2026 10:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783335377;
 bh=KQusbeXKb82PIQAkGvVbnDYAwSw2GIfz1MEi7IaChIc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=H4k6nZBAzdKyaNEz/gCELJukrr6Hd9L9m5uqF75XhaWqLkMn9rMW5N8mXJnomePjQ
 J+S0OdBTkeVdlmGgiabqY7CScSOqrgnVGbjU3D2aFAjTr6QEITjqFoh/+RFJZ72NTi
 1/gAG8qsiXca45xqHpYcEywsVhJouI5isJ7MJ978hO1v9tYMA0aIkyoyPSGBMwOXWG
 XE3MX072Qh7DeN4sOwZs129fEU975kocat1NxhssUBxuhETkXRI6n2hLE3pSML+iiY
 rgHeqABe18XbHuQUtD/XoZb2MAloWBc2oihSH+KXTkxZa1J4hrAz7qpvexSMqlIf9G
 cfD8cJMt+iHmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/7] drm/i915/gt: Use spin_lock_irq() instead of
 local_irq_disable() + spin_lock()
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260706104043.726178-2-dev@lankhorst.se>
References: <20260706104043.726178-1-dev@lankhorst.se>
 <20260706104043.726178-2-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 10:56:16 +0000
Message-Id: <20260706105617.3A36A1F000E9@smtp.kernel.org>
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
- [High] Removing local_irq_disable() re-enables interrupts before and duri=
ng ELSP hardware writes, risking incomplete submissions and GPU hangs.
--

commit ff9840660b858aab1bd255c1588d895283bda28f
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
   =20
drm/i915/gt: Use spin_lock_irq() instead of local_irq_disable() + spin_lock=
()

This commit replaces local_irq_disable() and spin_lock() with spin_lock_irq=
()
in the execlists submission path to improve PREEMPT_RT compatibility.
However, releasing the lock earlier in the function leaves the hardware ELSP
MMIO writes exposed to interrupts and preemption.

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
Does this change leave the hardware ELSP writes exposed to interrupts and
preemption?

By removing local_irq_disable() around the entire execlists_dequeue() call
and replacing it with spin_lock_irq() internally, interrupts are now
re-enabled at this spin_unlock_irq() call.

This means the subsequent hardware writes in execlists_submit_ports() now
occur with interrupts enabled:

execlists_dequeue() {
    ...
    spin_unlock_irq(&sched_engine->lock);
   =20
    /* ... */
    if (submit && ...) {
        ...
        execlists_submit_ports(engine);
    }
}

Since execlists_submit_ports() performs 4-DWord MMIO writes to the ELSP
that must remain strictly atomic, could being interrupted or preempted
during these writes result in incomplete context descriptors being fetched,
potentially causing GPU hangs?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706104043.7261=
78-1-dev@lankhorst.se?part=3D1
