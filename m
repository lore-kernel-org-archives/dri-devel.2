Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68832C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:04:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C116310E935;
	Mon,  6 Jul 2026 12:04:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MmR8SA7N";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC4DF10E935
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:04:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 307AE600BB;
 Mon,  6 Jul 2026 12:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CBE1F000E9;
 Mon,  6 Jul 2026 12:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783339451;
 bh=CArvANqm9nEL5vitwwn2e+EYq3pDfItDct7OpDgPMLs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MmR8SA7NZNk1HXx2NL/iD6LyTU7k09gzMGGRrsu8zXK4STfSVSHiC1vV0llKNaSTw
 c5O3L9rVooy7XTXNqXHNGX+6IdybqDLR67m+QP8YKJr2N/kqDe8fy1Zwh5f0wmMDUd
 3/zp0doiiV4Lz7gI5jwddgT009zNgPQHXYunxFLuHdaRG/edPCyxVURmwVpJuS42iD
 EcAjJ2CrD6tbpyA68fgNwj0NTdO1ELjnOO5sEHPtp+IeRo/7D98zPxMjVYZY0hTx1f
 K70kS3esFVLrDmSEA3PVaz0gWNKH6WVtbK77qVId/gOw9A4EGo5NFwUpxyA6ZEafVq
 I+C9eDoBIXMuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/7] drm/i915/gt: Use signalers_lock to prevent
 starvation of irq_work.
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260706114823.752313-8-dev@lankhorst.se>
References: <20260706114823.752313-1-dev@lankhorst.se>
 <20260706114823.752313-8-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 12:04:11 +0000
Message-Id: <20260706120411.B8CBE1F000E9@smtp.kernel.org>
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
- [Critical] Dropping `ce->signal_lock` to avoid lock inversion in `i915_re=
quest_enable_breadcrumb` allows concurrent threads to double-add a context =
to the `b->signalers` list, corrupting the list and leaking `intel_context`=
 references.
--

commit 51101492996df475bcd91b7f36bd0af9680441f1
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

drm/i915/gt: Use signalers_lock to prevent starvation of irq_work.

This patch adds a global spinlock to prevent starvation of irq_work by the
threaded interrupt and removes the existing RCU handling.

> diff --git a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c b/drivers/gpu/dr=
m/i915/gt/intel_breadcrumbs.c
> index c10ac0ab3bfa8..0ae7759dc74a3 100644
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
>  }

[Severity: Critical]
Could this unconditionally corrupt the signalers list?=20

If add_signaling_context() is called concurrently for the same context, it
will call list_add() without verifying whether ce->signal_link is already
linked, leading to list corruption and a leak of intel_context objects.

[ ... ]

> @@ -427,30 +424,87 @@ bool i915_request_enable_breadcrumb(struct i915_req=
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
> +		add_signaling_context(b, ce);
> +		spin_unlock(&b->signalers_lock);
> +		add_context =3D false;
> +	}
>  	spin_unlock(&ce->signal_lock);
> =20
> +	if (add_context) {
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

[Severity: Critical]
Does dropping ce->signal_lock here create a race condition that leads to the
double-add in add_signaling_context()?

If multiple threads attempt to enable breadcrumbs for the same context and
fail the fast trylock, they will drop ce->signal_lock and enter the slow pa=
th.
This can allow a sequence where:

Thread 1 calls i915_request_enable_breadcrumb() for rq1, gets
add_context =3D true, fails the trylock, drops ce->signal_lock, and waits
on the slow path.

Thread 2 cancels rq1, making ce->signals empty again.

Thread 3 calls i915_request_enable_breadcrumb() for rq3. Because ce->signals
is empty, it also gets add_context =3D true. It fails the trylock, drops the
lock, and waits on the slow path.

Thread 1 and Thread 3 sequentially acquire the locks in the slow path and b=
oth
call add_signaling_context(). Since Thread 3 added rq3, ce->signals is not
empty. Both threads will then execute intel_context_get() and list_add()
unconditionally, permanently corrupting the doubly-linked list.

Should add_signaling_context() verify that list_empty(&ce->signal_link) is
true before calling list_add() to prevent this regression?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706114823.7523=
13-1-dev@lankhorst.se?part=3D7
