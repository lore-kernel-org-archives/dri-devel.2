Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29454C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 08:24:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6433410E475;
	Thu,  2 Jul 2026 08:24:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JGNCdQJF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81B1010E475
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 08:24:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AA7C26001D;
 Thu,  2 Jul 2026 08:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021A11F000E9;
 Thu,  2 Jul 2026 08:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782980691;
 bh=LX5J8Pfr2YEfi2wal6Vl+98+IxyS1kQpWEexH1DUOBQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JGNCdQJFycWNKkwhle7JNzlqbM7ia6Nf18xXPXZgs3MXHiat6iFWiJEGJug948tyD
 SGSBvZffdf3r45Tv/2iRGXouaYz+5jyuq4UaCO0WQvIphSm9bbnmDCF3NiduECKN32
 eYhbg8hiPZaQKvbyvOuWqN2xT7iw5cbATVrhio7qOVcDzKWkrOR2gVai3+YezlX6Ct
 /fyjTPAqN1EOjpRk5wc4rpOPkawDShAZaoNP71V8ibywAyPi8hKUvNTmzJR6UfN9h/
 fHYQ3eTdrP1SPQ4wUr9Oep7Shu8HP+ToEMfE26cSLQ0lqLy5GuBYgohp4OMKL+PiFB
 QJX/FA8nZhedQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] drm/i915/gt: Add a spinlock to prevent starvation
 of irq_work.
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702080913.434121-8-dev@lankhorst.se>
References: <20260702080913.434121-1-dev@lankhorst.se>
 <20260702080913.434121-8-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 08:24:50 +0000
Message-Id: <20260702082451.021A11F000E9@smtp.kernel.org>
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
- [High] Acquiring `b->signaler_active_sync` with `spin_lock()` in `intel_c=
ontext_remove_breadcrumbs()` without disabling interrupts creates a deadloc=
k vulnerability and Lockdep splat on non-RT kernels.
--

commit b2f8f390d7421e899486c8f32c2c91c29a783338
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

drm/i915/gt: Add a spinlock to prevent starvation of irq_work.

This commit introduces a new spinlock, signaler_active_sync, to prevent
starvation of irq-work. It acquires this lock in both signal_irq_work()
and intel_context_remove_breadcrumbs() to force completion and synchronize
signaler state.

> diff --git a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c b/drivers/gpu/dr=
m/i915/gt/intel_breadcrumbs.c
> --- a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
> +++ b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
> @@ -209,6 +209,7 @@ static void signal_irq_work(struct irq_work *work)
>  		intel_breadcrumbs_disarm_irq(b);
> =20
>  	rcu_read_lock();
> +	spin_lock(&b->signaler_active_sync);
>  	atomic_inc(&b->signaler_active);
>  	list_for_each_entry_rcu(ce, &b->signalers, signal_link) {

[ ... ]

> @@ -487,8 +490,11 @@ void intel_context_remove_breadcrumbs(struct intel_c=
ontext *ce,
>  	if (release)
>  		intel_context_put(ce);
> =20
> -	while (atomic_read(&b->signaler_active))
> +	while (atomic_read(&b->signaler_active)) {
> +		spin_lock(&b->signaler_active_sync);
> +		spin_unlock(&b->signaler_active_sync);

[Severity: High]
Can this cause a deadlock on non-RT kernels?

Because signal_irq_work() runs in hardirq context as an irq_work callback,
acquiring signaler_active_sync here in intel_context_remove_breadcrumbs()=20
without disabling interrupts creates a window for a self-deadlock.

If a hardware interrupt occurs on the same CPU while this spinlock is=20
momentarily held, the local irq_work will trigger and signal_irq_work()=20
will try to acquire the already-held lock. Lockdep will also flag this as=20
an inconsistent lock state (HARDIRQ-ON-W vs IN-HARDIRQ-W) on its first=20
execution.

Does this need to use spin_lock_irq() or spin_lock_irqsave() to safely=20
synchronize against the irq_work?

>  		cpu_relax();
> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702080913.4341=
21-1-dev@lankhorst.se?part=3D7
