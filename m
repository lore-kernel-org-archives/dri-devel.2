Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E49606A32D
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=LdTYYRbv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B85010E080;
	Mon,  2 Nov 2026 09:36:12 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 952C010E080;
 Mon,  2 Nov 2026 09:36:05 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jJ65Z1smrzMlFg;
 Mon, 02 Nov 2026 10:36:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1793612162; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+/sMZYds1uhOZXW3Ia/g+6VA7auA/l8PP9TjhomiEy4=;
 b=LdTYYRbve+2a9AsrYz20m520ncMvUqWtNFNrebXBDHnKI8ybVi/PYzzpfE9c2aWuFQazCh
 Yanfhn1iktpfZnQvu6kAr70M9l9F5WvWdkfMTslOXz1AiDpwxsLPj04BF7RZ5NgJt2Mrio
 YY5bbjEEPl6bCHSmIjrPAAqY8i0x94+e6LlSve+QrM9iyCGTKdUjw9uOK33jJpYH+ZHH/Q
 ZXCFvol5foGJGa5kgTewdfkcTM6PPV/7x+yH/OVp/6tN+BAr23IGPKCZD7XpsivZOn9fCH
 C3bAI15a1dLfcj0+ibFzUcP+JhkDXEA4k6fD+tfyudO2wKsvS/NOOAMT/wbNdg==
Message-ID: <3a81450158fe5a46d76257c5018eaf5592168f18.camel@mailbox.org>
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
Date: Mon, 02 Nov 2026 10:35:57 +0100
In-Reply-To: <5d15d668-7191-4e96-922c-82982787b50c@amd.com>
References: <20261020100034.759183-2-phasta@kernel.org>
 <3e8bc11d-6f90-47a4-ae63-cf2ff37f1ff6@amd.com>
 <ca78cdb7c24a9be9b640db782168cdcc5fe30b60.camel@mailbox.org>
 <ed2728bd-1df4-478e-9e6f-a96dfd172b48@amd.com>
 <4a7294da65c8744ba6355730e304b5250d0ca351.camel@mailbox.org>
 <d13d1a6e-bba2-4275-984b-145e0252eb0f@amd.com>
 <320b6e7c75da6f05c015e89df0e2c7d11f20d70a.camel@mailbox.org>
 <22d66945-8854-442f-a69d-fe02726eccda@amd.com>
 <f9a47d563f896e0789fffa72df5847e2878cbe5e.camel@mailbox.org>
 <5d15d668-7191-4e96-922c-82982787b50c@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 9c9e0b972831da15e15
X-MBO-RS-META: rpf1r7o51nkurn4xtfgfh9p8yhndq3x9
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

On Wed, 2026-10-28 at 14:38 +0100, Christian K=C3=B6nig wrote:
> On 10/28/26 10:47, Philipp Stanner wrote:
> > > > 	commit c8a5d5ea3ba6 ("nouveau: fix client work fence deletion race=
")
> > >=20
> > > This bug is exactly what I'm trying to prevent here.
> >=20
> > What is your proposed strategy for preventing it?
>=20
> nouveau_fence_signal() is consistently used by all signaling path to
> both signal and cleanup a fence.

No, you miss the point. Look at the bug. It exists because nouveau
thinks it can drop a reference now because the fence is signaled.

I grant the point, though, that this is actually a refcounting issue.
The path that is signaling does not have its own extra reference.

> When we stop calling callbacks with locks held and signaling fences
> from dma_fence_is_signaled() and dma_fence_enable_signaling() nouveau
> can call nouveau_fence_signal() consistently from all cleanup paths
> with the proper handling.
>=20
> This makes it completely unecessary to have those cleanup hacks as
> well as the nouveau_fence_release() callback.
>=20
> Background is that you can then put the fence context directly after
> the fence is signaled=20
>=20
> > > This problem only exists because we call the backend operations with
> > > the lock held!
> >=20
> > Nope, this particular bug exists because Nouveau thought that it can
> > drop its reference when dma_fence_is_signaled() returns true, which is
> > not the case, because the fence backend has a race condition there.
>=20
> No it doesn't, the fence backend works exactly like intended.

You mean the lockless checking of a bit that is set under lock-
protection works as intended?

>=20
> I agree that we made tons of mistakes here but that is actually one
> of the few things which we got right on dma_fences from the very
> beginning.
> > A race condition that was allowed for performance reasons.
>=20
> Well it is at least partially for correctness as well.
>=20
> It is mandatory for quite a number of use cases that the signaling
> status becomes visible before the callbacks finish because otherwise
> you run into race conditions with the callbacks again.

That's not what I mean. There are two things here:

a) signaled-bit is read without lock-protection
b) signaled-bit is set before callbacks execute

fixing a) makes b) irrelevant.

But that's not even my point in this mail.


I'm still interested btw in who is busy-polling on a fence, waiting
until the signaled-bit gets true (that would be the "performance"
argument).

If you want to know when a fence changes from unsignaled to signaled,
use this function:

dma_fence_add_callback()

problem solved.

> > What signaling handler are you referring to?
>=20
> Take a look at the hack nouveau_fence_is_signaled() does for example.
> The cleanup part the other signaling call path do is completely
> missing here because the function can't take the fctx->lock.

Again, ops->signaled() merely has to read an atomic64_t and return a
bool. Driver locks are not required here.

>=20
> Yes, but if we want to get away from the external lock concept in
> dma_fence we must allow drivers to take their own fctx->lock inside
> the enable_signaling callback.
>=20
> Just take a look at what nouveau_fence_enable_signaling() does, that
> is only possible because the dma_fence framework has grabbed fctx-
> >lock before calling this function.
>=20
> The alternative is forcing drivers to use lockless approaches for
> their internal handling, and that is much much worse than that a
> dma_fence signaling status is visible without taking the lock.

[=E2=80=A6]

> Just take nouveau_fence_enable_signaling() as an example, if we don't
> use fctx->lock as external dma_fence lock then the whole approach
> used here doesn't work any more.

My entire point is that the driver does not need any driver-lock
conflicting with the fence-lock-order at all.

I tried to point this out several times, but you keep iterating back to
"this is what nouveau does".

That nouveau does it does not proof that it's necessary. It just proofs
that nouveau does it.

> > >=20
> > My impression was more that central design criteria for dma_fence (like
> > module unload of the driver who issued your fence, which is designed to
> > live arbitrarily long) were ignored, there was no clear guidance for
> > drivers how they should use what callback, and then driver problems
> > were solved in dma_fence, for instance with this shared lock. So same
> > story as with drm_sched.
>=20
> Yes, exactly that.

Good!

So we agree that the dma_fence backend should give clear guidance about
what a driver must, must not and should do in its backend_ops
implementations.

Right?

Because so far the conversation sounded to me like "the driver must be
able to do whatever it wants and therefore needs to be able to grab
whatever locks".

>=20
>=20
> And that is strong evidence. Nouveau is actually the perfect example
> of why this approach causes so much trouble for driver
> implementations.

Calling Nouveau a "perfect example" is like calling Ronald McDonald a
role model in dietary choices.

Nova is being written right now, for reasons.

>=20
> And such guidance should not exist in the first place.
>=20
> It is up to the driver if they want to use locks for their internal
> state protection and the dma_fence framework should absolutely not
> enforce anything it doesn't need to deal with.
>=20
> That the dma_fence lock should protect the state of the dma_fence is
> something I can perfectly agree on, but that does not include the ops
> call chain because that isn't dma_fence state in the first place.
>=20
> > The only evidence I have ever seen is the fence-list-lock, and it's
> > just not clear at all why any callback would need access to that.
>=20
> Because they need to clean things up after signaling.
>=20
> > Let's walk it through together, shall we?
> >=20
> > ops->release() and ->wait(): deprecated
> >=20
> > ops->get_XXX_name() -> never needs driver locks
> >=20
> > ops->signaled(): "Driver, here you read an atomic integer, the sequence
> > number, and tell the fence backend whether this fence shall be regarded
> > as completed"
> > No need for any driver lock.
>=20
> Incorrect, you can only work without driver locks here when you delegate =
the cleanup.
>=20
> In other words either to a worker or the ->release callback, both are thi=
ngs we try to avoid.
>=20
> Again see nouveau as a perfect example of the problem.
>=20
> > If this particular driver also signals fences through an interrupt
> > handler, it can take a list lock, then signal the fence. The ops must
> > not do that.
> > Why would a driver need both modes, sw *and* hw signaling? And why then
> > is it supposedly the case that both paths need to keep a list updated?
>=20
> Because the signaling through the interrupt is mandatory for correct,
> the signaling through the is_signaled callback is then on top for
> performance optimizations.

is_signaled() never conflicts with any lock, see my list above.

I think at this point you and I should really first get in sync
regarding what the backend_ops are supposed to do, because we seem to
turn in circles a bit in our discussion.

And the only ops that seems to be controversial and that informs the
nouveau argument is ops->enable_signaling()

What should enable_signaling() do, in your mind? What should we tell
the driver to do in there?

And why does nouveau even implement it, when its interrupt handler will
ultimately signal the fence anyways. Since, as usual, nothing is
documented, and one enable_signaling function carries literally the
name "no_signaling", I don't give it the benefit of the doubt and just
assume that this is broken, bad design.


My impression is that ops->enable_signaling() and having an interrupt
handler signaling fences is mutually exclusive design-wise.


P.
>=20
