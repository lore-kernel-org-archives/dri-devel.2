Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C81606A330
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=EtpsssLR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A80510E687;
	Tue, 20 Oct 2026 15:36:54 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 977D510E687;
 Tue, 20 Oct 2026 15:36:47 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j8Gjl1SPmzMltS;
 Tue, 20 Oct 2026 17:36:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1792510603; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yh+jXE2+lBWIpXl4CuFT/FWpTnGLk8SkwfDgjsSI1pI=;
 b=EtpsssLREdhha6u+FTlxRw9InWvYReNP+6y8AWy+2wedIiJhHJBP3Kf58xuSuToHOL/d4h
 xrZ0euzCKdgFIUegwG0suaq7SHWoEgr6y3mnW9jD8rspOFLigJC3bxraqbro1v7qQ0wl3D
 /9yzuP0QI3YhM2nKYOHGy2O+eMcEDnq4PxnskVL/nBPsdj+MknrRWdStHSdfaCd+SjHPyu
 HfUwcES9fwJ6WdAZx5x939e2COHqlPOeuWll/oyrzhHcj8lYq0CZBR5upiJDJ6RGt1ZHFs
 SZZmKPre3vN9fAdloUqb1/we+jSbFTc1QA4GuwAmd5OuS5l3D+x9ra/WKJ3fCA==
Message-ID: <4a7294da65c8744ba6355730e304b5250d0ca351.camel@mailbox.org>
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
Date: Tue, 20 Oct 2026 17:36:35 +0200
In-Reply-To: <ed2728bd-1df4-478e-9e6f-a96dfd172b48@amd.com>
References: <20261020100034.759183-2-phasta@kernel.org>
 <3e8bc11d-6f90-47a4-ae63-cf2ff37f1ff6@amd.com>
 <ca78cdb7c24a9be9b640db782168cdcc5fe30b60.camel@mailbox.org>
 <ed2728bd-1df4-478e-9e6f-a96dfd172b48@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 9b1f1927d5e8646b2c1
X-MBO-RS-META: fuxnfzpkekdedxcod5h8gys5pduiy8tm
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

On Tue, 2026-10-20 at 17:07 +0200, Christian K=C3=B6nig wrote:
> On 10/20/26 16:41, Philipp Stanner wrote:
> > On Tue, 2026-10-20 at 14:02 +0200, Christian K=C3=B6nig wrote:
> > > On 10/20/26 12:00, Philipp Stanner wrote:
> > > > In our Rust code bases, I'm currently experiencing what we also
> > > > experience in C at many places: that the dma_fence contract's RCU
> > > > requirements make the API more fragile and put an unnecessary burde=
n on
> > > > the API user. Most notably, in C the API behaving correctly now dep=
ends
> > > > on the API *user* waiting before free()s, waiting before unloads =
=E2=80=93 all
> > > > because dma_fence is not properly synchronized.
> > > >=20
> > > > The patches commit messages give more details about where I want to=
 go
> > > > with this particular RFC.
> > > >=20
> > > > My rough "vision" for dma_fence, where I think it should develop to=
, can
> > > > be described like this:
> > > >=20
> > > > 1. All users should use inline-lock.
> > > > 2. The fence-signaled state should be our decoupling point.
> > > > 3. The fence state must be consistently locked.
> > >=20
> > >=20
> > > > 4. This means all callbacks are only invoked for unsignaled fences,=
 and
> > > > =C2=A0=C2=A0 the fence cannot signal while a callback runs.
> > >=20
> > > First of all that prevents concurrent execution of the callbacks
> > > which for a lot of use cases is a must have.
> >=20
> > Currently only set_deadline() can execute in parallel.
>=20
> Especially the is_signaling() callback is executed in parallel by tons of=
 use cases.

ops->signaled() you mean.

Anyways, only one will succeed at having the fence marked as signaled
anyways, and then all other callers of dma_fence_is_signaled() will be
guarded by the fastpath bit-check (which btw is also broken; but we
want to address that in a different patch. For now my series proposes
keeping the fastpath).

>=20
> >=20
> > IIUC in our past discussions, your wish has been that the driver can
> > take its own locks with free locking-order in the callbacks.
> >=20
> > Thus, the callback is invoked under lock in any case, just a few
> > instructions earlier or later. Thus, no callback ever truly executes
> > concurrently.
>=20
> And that is fine. Taking the look when you actually need it to
> protect data structures is perfectly correct.
>=20
> But what you propose here is to abuse the look as a barrier, e.g. to
> find out if something has finished or not and that is a completely
> different story.

Nope, I want to protect shared data, which is the signaled-state. Which
is currently a race-condition worked around with RCU (and sometimes
with manually doing the right thing (locking!)) [1], stemming from the
fact that the fence's spinlock is not used consistently.

>=20
> > >=20
> > > Then as I pointed out before the second problem is that this again
> > > makes the existing lock inversion between the signaling by polling
> > > and signaling by interrupts even worse than it already is.
> >=20
> > We asked for examples in our last discussions, and the only one ever
> > presented was the list-access requiring the fctx-lock in
> > nouveau_fence_no_signaling(). Nouveau is often not a good example.
> >=20
> > Can you provide examples in the kernel where deadlock would occur?
>=20
> Just exercise the simple example of a driver supporting both pull and int=
errupt:
>=20
> Interrupt: Handler takes lock protecting a linked list, finds fence
> and signals it.
>=20
> Polling: is_signaled is called with fence lock held, can't take list
> lock and so needs to work around that somehow.

signaled() neither needs a list lock nor any other lock.

It needs to read a sequence number from somewhere, so a u64. And then
it returns true or false to the fence_backend.

The u64 can easily be an atomic. Also ioremaped reads should work
locklessly.

No need for any lock.

>=20
> This pattern repeats multiple times all over the different dma_fence
> implementation. Nouveu is just the tip of the iceberg, we have cases
> of this in amdgpu as well as i915 as well as XE.

I guess my question then becomes what complicated locked tasks someone
has to do within its callback that locks are required, locks that
cannot be partitioned in a smart way to avoid that.

We have 3 callbacks that are relevant and not deprecated (the name-
functions are trivially solved by copying the data):

- is_signaled() =E2=87=92 solved, see above
- enable_signaling()
- set_deadline()

The latter two might want to talk to their hardware, either enabling an
interrupt or telling it to clock the frequency up (see MSM). They might
need a driver-lock for that, fair enough.

Where does such a driver-lock need to be held while operating on a
fence, opening the deadlock-path?


Note that, as I pointed out many times, all callbacks are already
called under lock-protection. Especially enable_signaling(), and
is_signaled() must be lock-resistant, proven by
dma_fence_is_signaled_locked() existing.

Regardless, what I propose would only make a potential difference for
*new* users, with inline-lock, who can then cleanly design to avoid
locking problems.


>=20
> > Note that I pointed out that all callbacks are already invoked with the
> > lock taken, which proofs that it's doable.
>=20
> Again, no it isn't. The shared lock was invented exactly because
> drivers ran into this problem.
>=20
> The common pattern is the same, implementations just dance around the
> fact that the callbacks are called with the fence lock held by
> delegating cleanup work and/or using lockless containers etc...

I suspect more that drivers attempt to do unnecessarily many things in
their callbacks which are not supposed to be done there.

> A common component like dma_fence should never enforce users to do
> such workarounds just to solve it's own lifetime issues.

Our common component forces all users to take our locks manually and
plaster everything with RCU. If they forget an RCU delay, outside our
API, things explode :(


P.


[1] https://elixir.bootlin.com/linux/v7.3/source/drivers/gpu/drm/amd/amdgpu=
/amdgpu_vm.c#L2787

>=20
