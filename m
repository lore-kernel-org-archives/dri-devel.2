Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAA2C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:53:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EDBD10E281;
	Mon,  6 Jul 2026 10:53:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gGxaVXJz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21A7110E281
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 10:53:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 972824375B;
 Mon,  6 Jul 2026 10:53:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59EE71F000E9;
 Mon,  6 Jul 2026 10:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783335186;
 bh=h8Y+d6TleIy8jJy6iOX6aWvCxmJJDZDtZ1mQEDK4e7I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gGxaVXJzylJZd6/tPcD0LR21o1e1IZgmkr+tqz/SH0UQlCe2SE4FRO4NJPCUxRQ8u
 uzwq6LcNgn2UfMtG2m7fScU7WNlY31tw98Rb3ozBD+wa2bmWkhB+OTdigRP0NV6ZfP
 vJU8Xhwq/jU/8YtHry4rSkEGXTZHl9+6nC17LgJKHN1IaG4W4Z+vXMZH42eA6bCJ1H
 dNkj7PTpuMDJUFtuupbuSU5RZ58xs2YsB/H0cuguwerQwinGPP9Zc3U+OFmNy+mz5/
 yDl4e3Rp72GBNXW4kMwYsKeAaQp8rY08XXlGnaEPUKptGb6qGXmR1Th/LySys1HsJx
 9kshiJq3+qO8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/7] drm/i915/gt: Use signalers_lock to prevent
 starvation of irq_work.
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260706104043.726178-8-dev@lankhorst.se>
References: <20260706104043.726178-1-dev@lankhorst.se>
 <20260706104043.726178-8-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 10:53:05 +0000
Message-Id: <20260706105306.59EE71F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] Missing `spin_unlock_irqrestore` in the early return path leav=
es local interrupts disabled.
- [High] Uninitialized variable `add_context` may be evaluated and lead to =
undefined behavior.
- [High] Data race / list corruption when iterating `ce->signals` without h=
olding `ce->signal_lock`.
- [High] Double `list_add` in `add_signaling_context` causes list corruptio=
n due to race condition.
- [High] Queueing `irq_work` before adding the context to the signalers lis=
t causes missed wakeups.
- [High] Unconditional call to `list_empty` and `list_del_init` on a potent=
ially uninitialized list node causes NULL pointer dereference.
--

commit 84930541bab063f0b3f4b8114a287062a6526adc
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

drm/i915/gt: Use signalers_lock to prevent starvation of irq_work.

This commit replaces RCU with a global spinlock to manage the signalers list
in order to prevent IRQ-Work starvation and support PREEMPT_RT.

> diff --git a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c b/drivers/gpu/dr=
m/i915/gt/intel_breadcrumbs.c
> index c10ac0ab3bfa8..be87c8d0ae922 100644
> --- a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
> +++ b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
> @@ -88,24 +88,25 @@ static void add_signaling_context(struct intel_breadc=
rumbs *b,
>  				  struct intel_context *ce)
>  {
>  	lockdep_assert_held(&ce->signal_lock);
> +	lockdep_assert_held(&b->signalers_lock);
> =20
> -	spin_lock(&b->signalers_lock);
> -	list_add_rcu(&ce->signal_link, &b->signalers);
> -	spin_unlock(&b->signalers_lock);
> +	if (list_empty(&ce->signals))
> +		return;
> +
> +	intel_context_get(ce);
> +	list_add(&ce->signal_link, &b->signalers);

[Severity: High]
Could this unconditionally add a node that is already linked?

In unlock_context_remove_signaling(), if spin_trylock() fails,
ce->signal_lock is dropped while the context remains linked in b->signalers:

    if (list_empty(&ce->signals)) {
        if (spin_trylock(&b->signalers_lock)) {
            // ...
        } else {
            retry =3D true;
        }
    }
    spin_unlock_irqrestore(&ce->signal_lock, flags);

If another thread concurrently submits a new request to this context via
i915_request_enable_breadcrumb(), it sees an empty ce->signals list, inserts
the request, and calls add_signaling_context().

Because ce->signals is now non-empty, add_signaling_context() unconditional=
ly
executes list_add(&ce->signal_link, &b->signalers). Since the node is alrea=
dy
linked, this would corrupt the doubly-linked list.

>  }
> =20
>  static bool remove_signaling_context(struct intel_breadcrumbs *b,
>  				     struct intel_context *ce)
>  {
>  	lockdep_assert_held(&ce->signal_lock);
> +	lockdep_assert_held(&b->signalers_lock);
> =20
> -	if (!list_empty(&ce->signals))
> +	if (!list_empty(&ce->signals) || list_empty(&ce->signal_link))
>  		return false;
> =20
> -	spin_lock(&b->signalers_lock);
> -	list_del_rcu(&ce->signal_link);
> -	spin_unlock(&b->signalers_lock);
> -
> +	list_del_init(&ce->signal_link);

[Severity: High]
Can remove_signaling_context() dereference a NULL pointer if the list node
is zero-initialized?

The patch introduces logic in unlock_context_remove_signaling() that calls
remove_signaling_context() even if ce->signals was empty and the context
was never added to b->signalers.

If ce->signal_link is zero-initialized rather than initialized via
INIT_LIST_HEAD, list_empty(&ce->signal_link) evaluates to
NULL =3D=3D &ce->signal_link (returning false). It then proceeds to call
list_del_init(&ce->signal_link), which dereferences the NULL pointers inside
the zeroed list head.

>  	return true;
>  }

[ ... ]

> @@ -427,30 +424,88 @@ bool i915_request_enable_breadcrumb(struct i915_req=
uest *rq)
>  		return true;
> =20
>  	spin_lock(&ce->signal_lock);
> +	b =3D READ_ONCE(rq->engine)->breadcrumbs;
> +
>  	if (test_bit(I915_FENCE_FLAG_ACTIVE, &rq->fence.flags))
> -		insert_breadcrumb(rq);
> +		add_context =3D insert_breadcrumb(rq, b);
> +
> +	if (add_context && spin_trylock(&b->signalers_lock)) {

[Severity: High]
Can add_context be used uninitialized here?

If test_bit(I915_FENCE_FLAG_ACTIVE, &rq->fence.flags) evaluates to false=20
(e.g., if the bit was cleared concurrently after the lockless check above),
add_context is never assigned.

It is then evaluated in the condition:

    if (add_context && spin_trylock(&b->signalers_lock)) {

If the uninitialized stack variable evaluates to true, it could lead to
incorrectly calling add_signaling_context() and list corruption.

> +		add_signaling_context(b, ce);
> +		spin_unlock(&b->signalers_lock);
> +		add_context =3D false;
> +	}
> +
> +	/*
> +	 * Defer enabling the interrupt to after HW submission and recheck
> +	 * the request as it may have completed and raised the interrupt as
> +	 * we were attaching it into the lists.
> +	 */
> +	if (!READ_ONCE(b->irq_armed) || __i915_request_is_complete(rq))
> +		irq_work_queue(&b->irq_work);
> +
>  	spin_unlock(&ce->signal_lock);
> =20
> +	if (add_context) {

[Severity: High]
Does queuing irq_work before the context is added to the signalers list
create a TOCTOU race?

If the fast path spin_trylock() fails in i915_request_enable_breadcrumb(),
adding the context to b->signalers is deferred to the slow path here. Howev=
er,
irq_work_queue() is executed immediately before the slow path block.

If the irq_work executes before the slow path adds the context, it sees an
empty list and finishes without arming the hardware interrupt. Once the
context is subsequently added, no further IRQ work is queued, and the
interrupt remains disarmed forever, causing system hangs.

> +		/*
> +		 * Fast trylock didn't work, use slow locking.
> +		 *
> +		 * Dropping the lock to solve the inversion is safe, since
> +		 * no race is possible against remove_signaling_context()
> +		 * without being added as signaling context.
> +		 */
> +		spin_lock(&b->signalers_lock);
> +		spin_lock(&ce->signal_lock);
> +		add_signaling_context(b, ce);
> +		spin_unlock(&ce->signal_lock);
> +		spin_unlock(&b->signalers_lock);
> +	}
> +
>  	return true;
>  }

[ ... ]

>  void i915_request_cancel_breadcrumb(struct i915_request *rq)
>  {
>  	struct intel_breadcrumbs *b =3D READ_ONCE(rq->engine)->breadcrumbs;
>  	struct intel_context *ce =3D rq->context;
> -	bool release;
> +	unsigned long flags;
> =20
> -	spin_lock(&ce->signal_lock);
> +	spin_lock_irqsave(&ce->signal_lock, flags);
>  	if (!test_and_clear_bit(I915_FENCE_FLAG_SIGNAL, &rq->fence.flags)) {
>  		spin_unlock(&ce->signal_lock);

[Severity: Critical]
Are local interrupts left disabled in this early return path?

The lock acquisition was changed to spin_lock_irqsave(&ce->signal_lock, fla=
gs),
but the early return still uses spin_unlock(&ce->signal_lock), which fails =
to
restore the CPU's interrupt state.

>  		return;
>  	}

[ ... ]

> @@ -508,7 +557,7 @@ static void print_signals(struct intel_breadcrumbs *b=
, struct drm_printer *p)
>  {
>  	struct intel_context *ce;
>  	struct i915_request *rq;
> +	unsigned long flags;
> =20
>  	drm_printf(p, "Signals:\n");
> =20
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(ce, &b->signalers, signal_link) {
> -		list_for_each_entry_rcu(rq, &ce->signals, signal_link)
> +	spin_lock_irqsave(&b->signalers_lock, flags);
> +	list_for_each_entry(ce, &b->signalers, signal_link) {
> +		list_for_each_entry(rq, &ce->signals, signal_link)

[Severity: High]
Is it safe to iterate over ce->signals without holding ce->signal_lock?

Since RCU is removed, ce->signals is a standard doubly-linked list. Writers
(e.g., i915_request_cancel_breadcrumb) modify ce->signals holding only
ce->signal_lock.

Iterating over it here while only holding b->signalers_lock exposes a data
race where concurrent modifications could cause the iteration to dereference
LIST_POISON1.

>  			drm_printf(p, "\t[%llx:%llx%s] @ %dms\n",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706104043.7261=
78-1-dev@lankhorst.se?part=3D7
