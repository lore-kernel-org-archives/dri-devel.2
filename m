Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E315606A31B
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 12:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=c/2LEONi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A57B10E120;
	Wed, 21 Oct 2026 12:49:50 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACBB310E120;
 Wed, 21 Oct 2026 12:49:44 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4j8pyX5smMzKnB7;
 Wed, 21 Oct 2026 14:49:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1792586980; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lfnYZLKIiZVXPHMfsSfYR3WNLa/4FyJKqBCOhOsvSoQ=;
 b=c/2LEONi60z6Kz54vZJJL3DkDd/VneNflB8WzwpZzMxF+lm6XWQWwFGN7Y9x7XCdU62lFq
 iieAL/UWCA9ebw+oXGyYtmBpdvyA4Gw3vMDGCC/nQY9qnEr3dGExjjp2LZ8mhSh1xGaZqu
 y1wCAH/47Ojer+whhr1G2oEQpBaiYTgE7pSreffhKRRTikTLs1j1ohn+nN06XZWJLPbQhr
 kZYCPz2D/pUTCXipUsz2RpX6QZAgJo5tfixMCt8Ta7/7HFsH1hlibyOLYt730jj4/eCqWl
 1GHHpOfDqk7QgH6BMY4+HBMIrDBvkGGBc6Si5etuCYbWXMONtw4p+1VsRkVtFw==
Message-ID: <320b6e7c75da6f05c015e89df0e2c7d11f20d70a.camel@mailbox.org>
Subject: Re: [RFC PATCH v2 0/3] Solve dma_fence's problems by locking
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 phasta@kernel.org, Sumit Semwal <sumit.semwal@linaro.org>, Jani Nikula	
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>,  Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun
 Feng <boqun@kernel.org>,  Gary Guo <gary@garyguo.net>,
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,  Benno
 Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>,  Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Daniel Almeida	
 <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Onur =?ISO-8859-1?Q?=D6zkan?=
 <work@onurozkan.dev>, Boris Brezillon	 <boris.brezillon@collabora.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Date: Wed, 21 Oct 2026 14:49:34 +0200
In-Reply-To: <d13d1a6e-bba2-4275-984b-145e0252eb0f@amd.com>
References: <20261020100034.759183-2-phasta@kernel.org>
 <3e8bc11d-6f90-47a4-ae63-cf2ff37f1ff6@amd.com>
 <ca78cdb7c24a9be9b640db782168cdcc5fe30b60.camel@mailbox.org>
 <ed2728bd-1df4-478e-9e6f-a96dfd172b48@amd.com>
 <4a7294da65c8744ba6355730e304b5250d0ca351.camel@mailbox.org>
 <d13d1a6e-bba2-4275-984b-145e0252eb0f@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: 3bmg6dk9gyqm43c5y7c8ggghkg156yj5
X-MBO-RS-ID: 29c0397ed4351857f79
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: phasta@kernel.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-10-21 at 13:53 +0200, Christian K=C3=B6nig wrote:
> On 10/20/26 17:36, Philipp Stanner wrote:
> ...
> > > > > First of all that prevents concurrent execution of the callbacks
> > > > > which for a lot of use cases is a must have.
> > > >=20
> > > > Currently only set_deadline() can execute in parallel.
> > >=20
> > > Especially the is_signaling() callback is executed in parallel by ton=
s of use cases.
> >=20
> > ops->signaled() you mean.
> >=20
> > Anyways, only one will succeed at having the fence marked as signaled
> > anyways, and then all other callers of dma_fence_is_signaled() will be
> > guarded by the fastpath bit-check (which btw is also broken; but we
> > want to address that in a different patch. For now my series proposes
> > keeping the fastpath).
>=20
> What should be broken here? As far as I know the signaling path works per=
fectly fine.
>=20
> What we have problems with is the lifetime of things.

The signaled bit is set under lock-protection, fully ordered. Reading
is just racing. See my other patch series, I linked two bugs that could
have been avoided if it were ordered.

Anyways, I was just answering your point. These functions' parallelism
is unchanged.


> > > >=20

[=E2=80=A6]

> >=20
> > Nope, I want to protect shared data, which is the signaled-state. Which
> > is currently a race-condition worked around with RCU (and sometimes
> > with manually doing the right thing (locking!)) [1], stemming from the
> > fact that the fence's spinlock is not used consistently.
>=20
> The fence spinlock is consistently used for protecting the fence
> signaling, in other words it always happens with the spinlock held,
> same for adding callbacks.
>=20
> The only thing which happens without the spinlock held is the fast
> path checking of the signaled and enable_signaling bits and as far as
> I can see that is ok as well.

No, it isn't. It makes the API fragile.

	commit c8a5d5ea3ba6 ("nouveau: fix client work fence deletion race")
	commit 7c703a7d3f2b ("drm/amdgpu: Fix one use-after-free of VM")

There are certainly more related bugs around.

Also think of the various ordering issues between signaled-bit and ops
pointer that you and I observed.

> The problem here is not about the state of the fence, but if the
> callbacks are still executed or not. And that is not a good task for
> a lock, instead what is usually used for that is a barrier and that
> is exactly what RCU provides.

Locks are for mutual exclusion. Which is what you want here: you want
to exclude someone from signaling the fence while you are working on
it.

Tell me one thing:
If locking is the wrong approach, then how come it was added to
literally all callbacks except for set_deadline()? Seems to me that it
must have solved some issues.


>=20
> > > > > Then as I pointed out before the second problem is that this agai=
n
> > > > > makes the existing lock inversion between the signaling by pollin=
g
> > > > > and signaling by interrupts even worse than it already is.
> > > >=20
> > > > We asked for examples in our last discussions, and the only one eve=
r
> > > > presented was the list-access requiring the fctx-lock in
> > > > nouveau_fence_no_signaling(). Nouveau is often not a good example.
> > > >=20
> > > > Can you provide examples in the kernel where deadlock would occur?
> > >=20
> > > Just exercise the simple example of a driver supporting both pull and=
 interrupt:
> > >=20
> > > Interrupt: Handler takes lock protecting a linked list, finds fence
> > > and signals it.
> > >=20
> > > Polling: is_signaled is called with fence lock held, can't take list
> > > lock and so needs to work around that somehow.
> >=20
> > signaled() neither needs a list lock nor any other lock.
>=20
> I don't think we should decide that inside the framework, this is up
> to the implementation of the dma_fence backend.
>=20
> By taking the lock for the callbacks we just move the complexity of
> handling from the framework into the dma_fence_ops implementations,
> and that is something I would *really* like to avoid.

Of course the framework needs to specify exactly what the callbacks are
about and what the driver should do in them. That's btw why many expect
Rust to result in often better driver design, because by the type
system you can define how your API can and cannot be used.

> > It needs to read a sequence number from somewhere, so a u64. And then
> > it returns true or false to the fence_backend.
> >=20
> > The u64 can easily be an atomic. Also ioremaped reads should work
> > locklessly.
> >=20
> > No need for any lock.
>=20
> It is perfectly possible that you need to take whatever lock you want
> to cleanup things. E.g. spinlock for list removal, common lock with
> the interrupt handler etc....

That's like saying it's perfectly possible that someone will want to
allocate memory in a callback. Yet we say No, you cannot do that.

>=20
> That's also why I said that the whole approach with the signaling and
> enable_signaling callback returning a boolean is broken.
>=20
> Instead what we should do is to forward the requests to the dma_fence
> implementation. And that dma_fence implementation calls
> dma_fence_signaled() as necessary.

dma_fence_signal() you mean?

I don't get your point. What you wish to happen is already the case:

dma_fence_is_signaled(struct dma_fence *fence)
{
	const struct dma_fence_ops *ops;

	if (dma_fence_test_signaled_flag(fence))
		return true;

	rcu_read_lock();
	ops =3D rcu_dereference(fence->ops);
	if (ops && ops->signaled && ops->signaled(fence)) {
		rcu_read_unlock();
		dma_fence_signal(fence);



> > >=20
> >=20
> > Where does such a driver-lock need to be held while operating on a
> > fence, opening the deadlock-path?
>=20
> In the interrupt handler.

I don't see that either. In the interrupt you will want to do:

driver_lock();
seqno =3D get_seqno();
driver_unlock();

signal_fences_up_to(seqno);

>=20
> > Note that, as I pointed out many times, all callbacks are already
> > called under lock-protection. Especially enable_signaling(), and
> > is_signaled() must be lock-resistant, proven by
> > dma_fence_is_signaled_locked() existing.
>=20
> Yes, but we clearly want to get away from that.
>=20
> See the calling order in the interrupt signaling path is driver ->
> framework.
>=20
> While in the is_signaled/enable_signaling/set_deadline path it is
> framework -> driver.
>=20
> The dma_fence framework solved this issue by using a shared external
> driver provided lock, and that lock is then taken before calling into
> the backend operations. But we want to get away from that and use an
> inline lock in each dma_fence.
>=20
> So the only two possibilities I can see is to either call the backend
> without holding locks or force the backend operations to use a
> lockless approach for their internal handling.

Right now, we do both: call callbacks with a lock *and* force all API
users to do the RCU dance.

So we have the worst of both worlds.

>=20
> > Regardless, what I propose would only make a potential difference for
> > *new* users, with inline-lock, who can then cleanly design to avoid
> > locking problems.
>=20
> Yeah, but I'm desperately trying to avoid the complexity of using a
> lockless approach in the driver implementation.
>=20
> Just take a look at amdgpu_fence.c and how complex the RCU handling
> there becomes because of this issue here.

AFAICS amdgpu only uses ops->enable_signaling(), and there it does
exactly what I would have expected: register a timer who will see the
fence gets signaled.

As I said, no reason to do list accesses like nouveau. That's just the
driver being misdesigned.

Interestingly btw amdgpu's ops->release() does a call_rcu() to free the
fence.

You do agree with me that our API being usable like this:

dma_fence_signal(f, err);
dma_fence_put(f);

would be robust and desirable, don't you?

>=20

[=E2=80=A6]

>=20
> And I still think that this is the simpler and especially more defensive =
approach.
>=20
> The dma_fence framework should not leak it's internal lock anywhere exter=
nally and that includes calls into the backend operations.
>=20

Calling a callback while holding a lock is not leaking the lock. It's
sometimes necessary. All fence callbacks are being called under lock
protection, for the same reason as I propose here: prevent the fence's
state from changing while they execute.


P.
