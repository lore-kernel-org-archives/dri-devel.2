Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0487CD98CE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:38:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2765010E6FF;
	Mon, 15 Jun 2026 20:38:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iD33FqAh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20AB910E6FF
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 20:38:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ED70243F32;
 Mon, 15 Jun 2026 20:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8951F000E9;
 Mon, 15 Jun 2026 20:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781555894;
 bh=FmBuQrdKuBJ/kqDkTizJrSpFuBfEntizZQLajhcdyLw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iD33FqAhgzx/JhpsCfn8N7q5B8HO8HEGsbKrExzFZVF0Y/vlYI0xO4jLzBM7fxkIS
 p69zB0F1JyNQB9ftO/0U2t5WEK5yjKWmg7dRORvoQ5in1ODth+xV7Dj7p6GbxaIPw4
 Q5Lphv/fFI758HYFrDNKys0xNIJjo9qSgI0e7ZtZ2qd2ESqWS4EbBVruMHoJmjF5cn
 PAvMhM/gZd6jgZ6zVQtqAZlkPkYM9moJzaVF0XqyrqCmu6Xh5chDpNVRUgkzAxY+lo
 uxNyGXZj8IcQatObmbh6Hh+DI3ML3ymTFM4Re12x6NWd0PY+oskkfZwIvR8EOsD4P/
 Qos8e17UfY8zA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 25/27] drm/i915/gt: Add a spinlock to prevent
 starvation of irq_work.
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260615201846.307297-26-dev@lankhorst.se>
References: <20260615201846.307297-26-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 20:38:13 +0000
Message-Id: <20260615203814.AB8951F000E9@smtp.kernel.org>
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
- [High] Missing hardirq disable when acquiring the `signaler_active_sync` =
spinlock in `intel_context_remove_breadcrumbs()`, leading to a hard deadloc=
k and lockdep splat on non-RT kernels.
--

commit c441a60da28f5ef8bb16a4ea0dbdd666e51caed6
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

drm/i915/gt: Add a spinlock to prevent starvation of irq_work.

This commit adds the signaler_active_sync spinlock to prevent irq_work
starvation and force completion.

> diff --git a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c b/drivers/gpu/dr=
m/i915/gt/intel_breadcrumbs.c
> --- a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
> +++ b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
> @@ -209,6 +209,7 @@ static void signal_irq_work(struct irq_work *work)
>  		intel_breadcrumbs_disarm_irq(b);
> =20
>  	rcu_read_lock();
> +	spin_lock(&b->signaler_active_sync);

[Severity: High]
Because signal_irq_work() executes as an irq_work, this lock is acquired in
hardirq context on non-RT kernels. Doesn't this establish a requirement that
all other takers must disable hardware interrupts?

>  	atomic_inc(&b->signaler_active);

[ ... ]

> @@ -487,8 +490,11 @@ void intel_context_remove_breadcrumbs(struct intel_c=
ontext *ce,
>  	if (release)
>  		intel_context_put(ce);
> =20
> -	while (atomic_read(&b->signaler_active))
> +	while (atomic_read(&b->signaler_active)) {
> +		spin_lock(&b->signaler_active_sync);

[Severity: High]
Can this cause a deadlock if a hardware interrupt fires while we hold this
lock?

Since intel_context_remove_breadcrumbs() acquires the lock using a plain
spin_lock(), it leaves hardware interrupts enabled.

If a hardware interrupt fires on the same CPU while the lock is held,
and triggers the irq_work, would we see a scenario like this:

CPU0
intel_context_remove_breadcrumbs()
   spin_lock(&b->signaler_active_sync);
   <hardware interrupt fires>
   signal_irq_work()
      spin_lock(&b->signaler_active_sync);  <- deadlock
     =20
Should this use spin_lock_irq() or spin_lock_irqsave() instead?

> +		spin_unlock(&b->signaler_active_sync);
>  		cpu_relax();
> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615201846.3072=
97-1-dev@lankhorst.se?part=3D25
