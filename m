Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B84CD8C9F
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:15:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B744010F596;
	Mon,  8 Jun 2026 15:15:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KGZ86xKG";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6EBF10F596
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 15:15:12 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gYwZj0Jdgz9tjp;
 Mon,  8 Jun 2026 17:15:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1780931709; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NGMAEytpCVVrGQO+yuNUspVUEHL6UKNWHZvBLk9ZY4A=;
 b=KGZ86xKGuh+qSN8H4mSCZgQqB+PPvD/DrYkFXqkEMMl7JBhtJ4aJctZpjTOyOShrxWc7fQ
 gM4Z0Gj7iV9sM9KWHvuc0J9s+CrsrGRJc6ibRaq+g7FLyujHpZPeyTm2zS/MWVj7KPHgv3
 epnP8Qw9LtsAmXoF51sFQQ6Btt3SEzSKRzoc3kSTdzO0dzp3TMduirBgOV0iIZqb75IJXA
 to+CxOA8CrppeM9aw0gwxAMoIB31eEjPAfgAgiiVuv0AfgR5XRNRKD+U8lAjrveCnJp++h
 FTYyQagJ/gJUWf+7itph2Y4/tJvyMHbTTypgNJBm+Daa1M/8am5f8Qjtv/rAIA==
Message-ID: <f5f5e75336f0b4cf766b78ae4f2df12cc3f59252.camel@mailbox.org>
Subject: Re: [RFC PATCH] dma-fence: Fix races of fence callbacks versus
 destructors by locking
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Philipp Stanner	
 <phasta@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Boris Brezillon
 <boris.brezillon@collabora.com>,  Alice Ryhl <aliceryhl@google.com>, Daniel
 Almeida <dwlsalmeida@gmail.com>, Gary Guo <gary@garyguo.net>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>
Date: Mon, 08 Jun 2026 17:15:00 +0200
In-Reply-To: <e5f81f4f-ac0c-49c0-a9d1-85f372d65971@igalia.com>
References: <20260608142436.265820-2-phasta@kernel.org>
 <e5f81f4f-ac0c-49c0-a9d1-85f372d65971@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: dc4d9658c8da65643ec
X-MBO-RS-META: r6xupidihic93x8bxi8mjfyzoqt7qb7n
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon, 2026-06-08 at 16:07 +0100, Tvrtko Ursulin wrote:
>=20
> On 08/06/2026 15:24, Philipp Stanner wrote:
> > The dma_fence backend_ops can access a fence. Hereby, a driver callback
> > will be running which likely will access driver specific data through
> > container_of(). If now, simultaneously, a driver signals the fence and
> > afterwards expects to run a driver specific destructor (using the same
> > data accessed through container_of()), there can be a race.
> >=20
> > A driver very likely trusts that once it has signaled a fence, no one
> > will be accessing it anymore. Moreover, it might already want to free u=
p
> > resources, making UAF bugs possible.
>=20
> Can you explain this race a bit differently? I am struggling to=20
> understand the scenario.

driver:                               fence consumer:

dma_fence_signal(f)                   backend_ops() starts running, slightl=
y misses the signaled-bit
do_sth_with_data(container_of(f))     backend_ops() accesses container_of(f=
)

^ race


backend_ops callbacks must not be invoked after a fence was signaled.
Right now, that is racing.

re: free(), OK, yes, that is the documented rule. Fair. But:

>=20
> Are you talking about driver freeing the data immediately after=20
> signalling? That is not allowed as per the "DOC: Safe external access to=
=20
> driver provided object members", ie. divers must ensure a RCU grace=20
> period between signalling and freeing any data which can be reached by=
=20
> any external caller.

This is the documented rule mostly because this isn't solved through
locking. If the lock were to grant full synchronization, you could
immediately do your driver cleanup after signaling, because all
potential accessors would be gone.


P.

>=20
> Regards,
>=20
> Tvrtko
>=20
> > The race occurs because there are only pragmatic checks for the signale=
d
> > flag of a fence, without taking the fence lock. RCU guards exist, but
> > their purpose is to guard accesses through the backend_ops callbacks
> > against the driver (which implements the TEXT segment these callbacks
> > live in) from unloading.
> >=20
> > Proper synchronization can be ensured by taking the fence lock. RCU is
> > still simultaneously required to guard against the unload.
> >=20
> > Fix the races by taking the lock for all non-deprecated backend_ops
> > callbacks.
> >=20
> > Conveniently, this also fixes a race where backend_ops->set_deadline()
> > might try to set a deadline for an already signaled fence.
> >=20
> > Suggested-by: Danilo Krummrich <dakr@kernel.org>
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > ---
> > We discovered this problem through our Rust abstractions, but it can
> > also occur in C.
> >=20
> > The by far cleanest solution seems to be to use the fence lock. This RF=
C
> > serves to discuss whether there is anything preventing that.
> >=20
> > (Patch so far just compile tested, to have some groundlayer for the
> > rough idea, to discuss it first)
> > ---
> > =C2=A0 drivers/dma-buf/dma-fence.c | 39 ++++++++++++++++++++++++++++---=
------
> > =C2=A0 include/linux/dma-fence.h=C2=A0=C2=A0 | 17 ++++++++++++----
> > =C2=A0 2 files changed, 43 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> > index c7ea1e75d38a..b74f02f3cca8 100644
> > --- a/drivers/dma-buf/dma-fence.c
> > +++ b/drivers/dma-buf/dma-fence.c
> > @@ -629,7 +629,8 @@ EXPORT_SYMBOL(dma_fence_free);
> > =C2=A0 static bool __dma_fence_enable_signaling(struct dma_fence *fence=
)
> > =C2=A0 {
> > =C2=A0=C2=A0	const struct dma_fence_ops *ops;
> > -	bool was_set;
> > +	bool was_set, success;
> > +	unsigned long flags;
> > =C2=A0=20
> > =C2=A0=C2=A0	dma_fence_assert_held(fence);
> > =C2=A0=20
> > @@ -644,7 +645,10 @@ static bool __dma_fence_enable_signaling(struct dm=
a_fence *fence)
> > =C2=A0=C2=A0	if (!was_set && ops && ops->enable_signaling) {
> > =C2=A0=C2=A0		trace_dma_fence_enable_signal(fence);
> > =C2=A0=20
> > -		if (!ops->enable_signaling(fence)) {
> > +		dma_fence_lock_irqsave(fence, flags);
> > +		success =3D ops->enable_signaling(fence);
> > +		dma_fence_unlock_irqrestore(fence, flags);
> > +		if (!success) {
> > =C2=A0=C2=A0			rcu_read_unlock();
> > =C2=A0=C2=A0			dma_fence_signal_locked(fence);
> > =C2=A0=C2=A0			return false;
> > @@ -1020,11 +1024,20 @@ EXPORT_SYMBOL(dma_fence_wait_any_timeout);
> > =C2=A0 void dma_fence_set_deadline(struct dma_fence *fence, ktime_t dea=
dline)
> > =C2=A0 {
> > =C2=A0=C2=A0	const struct dma_fence_ops *ops;
> > +	unsigned long flags;
> > =C2=A0=20
> > =C2=A0=C2=A0	rcu_read_lock();
> > =C2=A0=C2=A0	ops =3D rcu_dereference(fence->ops);
> > -	if (ops && ops->set_deadline && !dma_fence_is_signaled(fence))
> > +	if (!ops || !ops->set_deadline) {
> > +		rcu_read_unlock();
> > +		return;
> > +	}
> > +
> > +	dma_fence_lock_irqsave(fence, flags);
> > +	if (!dma_fence_is_signaled_locked(fence))
> > =C2=A0=C2=A0		ops->set_deadline(fence, deadline);
> > +
> > +	dma_fence_unlock_irqrestore(fence, flags);
> > =C2=A0=C2=A0	rcu_read_unlock();
> > =C2=A0 }
> > =C2=A0 EXPORT_SYMBOL(dma_fence_set_deadline);
> > @@ -1166,14 +1179,18 @@ EXPORT_SYMBOL(dma_fence_init64);
> > =C2=A0=C2=A0 */
> > =C2=A0 const char __rcu *dma_fence_driver_name(struct dma_fence *fence)
> > =C2=A0 {
> > +	const char __rcu *name =3D "detached-driver";
> > =C2=A0=C2=A0	const struct dma_fence_ops *ops;
> > +	unsigned long flags;
> > =C2=A0=20
> > =C2=A0=C2=A0	/* RCU protection is required for safe access to returned =
string */
> > =C2=A0=C2=A0	ops =3D rcu_dereference(fence->ops);
> > +	dma_fence_lock_irqsave(fence, flags);
> > =C2=A0=C2=A0	if (!dma_fence_test_signaled_flag(fence))
> > -		return (const char __rcu *)ops->get_driver_name(fence);
> > -	else
> > -		return (const char __rcu *)"detached-driver";
> > +		name =3D ops->get_driver_name(fence);
> > +	dma_fence_unlock_irqrestore(fence, flags);
> > +
> > +	return name;
> > =C2=A0 }
> > =C2=A0 EXPORT_SYMBOL(dma_fence_driver_name);
> > =C2=A0=20
> > @@ -1199,13 +1216,17 @@ EXPORT_SYMBOL(dma_fence_driver_name);
> > =C2=A0=C2=A0 */
> > =C2=A0 const char __rcu *dma_fence_timeline_name(struct dma_fence *fenc=
e)
> > =C2=A0 {
> > +	const char __rcu *name =3D "signaled-timeline";
> > =C2=A0=C2=A0	const struct dma_fence_ops *ops;
> > +	unsigned long flags;
> > =C2=A0=20
> > =C2=A0=C2=A0	/* RCU protection is required for safe access to returned =
string */
> > =C2=A0=C2=A0	ops =3D rcu_dereference(fence->ops);
> > +	dma_fence_lock_irqsave(fence, flags);
> > =C2=A0=C2=A0	if (!dma_fence_test_signaled_flag(fence))
> > -		return (const char __rcu *)ops->get_driver_name(fence);
> > -	else
> > -		return (const char __rcu *)"signaled-timeline";
> > +		name =3D ops->get_driver_name(fence);
> > +	dma_fence_unlock_irqrestore(fence, flags);
> > +
> > +	return name;
> > =C2=A0 }
> > =C2=A0 EXPORT_SYMBOL(dma_fence_timeline_name);
> > diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> > index b52ab692b22e..b93c3f7f69fb 100644
> > --- a/include/linux/dma-fence.h
> > +++ b/include/linux/dma-fence.h
> > @@ -547,20 +547,29 @@ static inline bool
> > =C2=A0 dma_fence_is_signaled(struct dma_fence *fence)
> > =C2=A0 {
> > =C2=A0=C2=A0	const struct dma_fence_ops *ops;
> > +	unsigned long flags;
> > +	bool signaled;
> > =C2=A0=20
> > =C2=A0=C2=A0	if (dma_fence_test_signaled_flag(fence))
> > =C2=A0=C2=A0		return true;
> > =C2=A0=20
> > =C2=A0=C2=A0	rcu_read_lock();
> > =C2=A0=C2=A0	ops =3D rcu_dereference(fence->ops);
> > -	if (ops && ops->signaled && ops->signaled(fence)) {
> > +	if (!ops || !ops->signaled) {
> > =C2=A0=C2=A0		rcu_read_unlock();
> > -		dma_fence_signal(fence);
> > -		return true;
> > +		return false;
> > =C2=A0=C2=A0	}
> > +
> > +	dma_fence_lock_irqsave(fence, flags);
> > +	signaled =3D ops->signaled(fence);
> > +
> > +	if (signaled)
> > +		dma_fence_signal_locked(fence);
> > +
> > +	dma_fence_unlock_irqrestore(fence, flags);
> > =C2=A0=C2=A0	rcu_read_unlock();
> > =C2=A0=20
> > -	return false;
> > +	return signaled;
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 /**
