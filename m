Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE742606A322
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=wxh7nxPZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E46810E5E2;
	Wed, 28 Oct 2026 09:47:34 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 001FA10E5E2;
 Wed, 28 Oct 2026 09:47:27 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jF2b05FVDzKnB8;
 Wed, 28 Oct 2026 10:47:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1793180844; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nKYFxQRH1vuVIe7/MLAy4kkLQU+A9Me4O9WKmx61f9U=;
 b=wxh7nxPZ3iBUYyzqOmx2XDE76ZphfykyCRuAosYPWP47z0Pzf1bVpl04m5X6WPVpxqDb76
 C9IMwFNXAO0Bc/rF0AAjmptGHmYtscrD+MmJRaj/SMYdBhD9TAhIG4oNy7QPVoISU0+tSj
 562hrglSu9820+OAFhoF3wrPOV73urXb1ouVgfb5bJhZdcOcsMoyOXcAKr1+nU1H2xdUCj
 ukuSIDc2A/mpXaPld+JwbzLD3X9yYXpOQPYSOTLZX1z3YZZv6pKWrKVn0s2f0PVZWxFC96
 6SS7e7Jgkb/AWiKJedqhGOu5sXW+OwHfal+83mB+gJZ1DHVXpTo7rR+UsLY3ow==
Message-ID: <f9a47d563f896e0789fffa72df5847e2878cbe5e.camel@mailbox.org>
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
Date: Wed, 28 Oct 2026 10:47:18 +0100
In-Reply-To: <22d66945-8854-442f-a69d-fe02726eccda@amd.com>
References: <20261020100034.759183-2-phasta@kernel.org>
 <3e8bc11d-6f90-47a4-ae63-cf2ff37f1ff6@amd.com>
 <ca78cdb7c24a9be9b640db782168cdcc5fe30b60.camel@mailbox.org>
 <ed2728bd-1df4-478e-9e6f-a96dfd172b48@amd.com>
 <4a7294da65c8744ba6355730e304b5250d0ca351.camel@mailbox.org>
 <d13d1a6e-bba2-4275-984b-145e0252eb0f@amd.com>
 <320b6e7c75da6f05c015e89df0e2c7d11f20d70a.camel@mailbox.org>
 <22d66945-8854-442f-a69d-fe02726eccda@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 16b7de5af4c5b86025a
X-MBO-RS-META: rb53xxngg1k75mcmbijsukd3yebomd1t
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

On Tue, 2026-10-27 at 15:59 +0100, Christian K=C3=B6nig wrote:
> On 10/21/26 14:49, Philipp Stanner wrote:
> > On Wed, 2026-10-21 at 13:53 +0200, Christian K=C3=B6nig wrote:
> > > On 10/20/26 17:36, Philipp Stanner wrote:
> > [=E2=80=A6]
> >=20
> > > >=20
> > > > Nope, I want to protect shared data, which is the signaled-state. W=
hich
> > > > is currently a race-condition worked around with RCU (and sometimes
> > > > with manually doing the right thing (locking!)) [1], stemming from =
the
> > > > fact that the fence's spinlock is not used consistently.
> > >=20
> > > The fence spinlock is consistently used for protecting the fence
> > > signaling, in other words it always happens with the spinlock held,
> > > same for adding callbacks.
> > >=20
> > > The only thing which happens without the spinlock held is the fast
> > > path checking of the signaled and enable_signaling bits and as far as
> > > I can see that is ok as well.
> >=20
> > No, it isn't. It makes the API fragile.
> >=20
> > 	commit c8a5d5ea3ba6 ("nouveau: fix client work fence deletion race")
>=20
> This bug is exactly what I'm trying to prevent here.

What is your proposed strategy for preventing it?

>=20
> This problem only exists because we call the backend operations with
> the lock held!

Nope, this particular bug exists because Nouveau thought that it can
drop its reference when dma_fence_is_signaled() returns true, which is
not the case, because the fence backend has a race condition there.

A race condition that was allowed for performance reasons.


> What nouveau does is to delegate the cleanup since it can't do that
> in the signaling handler because of the lock inversion.

What signaling handler are you referring to?

>=20
> This problem doesn't happen any more if you just completely drop the
> approach of calling the backend operations with the fence lock held
> and then re-structure the cleanup handling in Nouveau.

ops->signaled() is typically not called with the lock held. You might
be referring to ops->enable_signaling(), which is consistently locked.

>=20
> > 	commit 7c703a7d3f2b ("drm/amdgpu: Fix one use-after-free
> > of VM")
>=20
> I already discussed that with Simona back then. Simona actually
> explicitly rejected my approach to take the spinlock to check for
> signaling. Pointing out that amdgpu is using the API in a wrong way.
>=20
> The problem is that amdgpu doesn't track the callback structure and
> so can't remove the callback. It's on my TODO list every since to fix
> that miss use of the API.

You mean the issue is that amdgpu cannot deregister callbacks?

I don't see how that's related. The lock-unlock-cycle clearly ensures
that amdgpu cannot continue while the fence is signaling.

To clarify: our conversation circles around two partially independent
topics:

a) the signaled-bit is read without lock-protection as a fast path in
dma_fence_is_signaled() and

b) the ops are not consistently called with the lock held.

>=20
> > Tell me one thing:
> > If locking is the wrong approach, then how come it was added to
> > literally all callbacks except for set_deadline()? Seems to me that it
> > must have solved some issues.
>=20
> Well, it's because concerns with the lock inversion brought up by
> Alex and me was ignored and the patches merged anyway.
>=20
> This is just another one of those DMA-buf design problems which would
> have been fully preventable if I would have clearly NAKed that stuff
> from the very beginning.

My impression was more that central design criteria for dma_fence (like
module unload of the driver who issued your fence, which is designed to
live arbitrarily long) were ignored, there was no clear guidance for
drivers how they should use what callback, and then driver problems
were solved in dma_fence, for instance with this shared lock. So same
story as with drm_sched.

If *everything* would have been locked from the get-go, that would have
forced drivers to design their locking correctly, and decide wisely
what tasks they want to perform where.

>=20
> Back then I made the mistake to believe the argumentation you come up
> here as well and so I don't explicitly rejected that approach, but by
> now we have strong evidence that this was a mistake and I'm trying to
> fix that mistake ever since.

Well, I am a different person with my own background that informs my
thinking. Please keep that in mind.

The "strong evidence" you claim to exist has still not been shown to
me. I show you concrete bugs that we could have prevented, but the only
piece of code you ever showed me where something would break is the
list_del() in nouveau.

>=20
> We should have never taken the lock for the callbacks in the first
> place, this just made the implementation much more complicated and
> caused way more problems than the few raised by putting the ops
> pointer under RCU.

Lock-inversions are not being solved by just not taking the lock, they
are addressed by having good lock design. We recently solved exactly
that in the Rust JobQueue, where drivers also reported lock-inversions,
but we could eliminate them with just a few discussions, discovering
that the driver does not need these locks when interacting with the
JobQueue.

Often enough btw the only object the driver really needs is the
sequence number anyways, which can trivially be passed and shared
around.

Now with dma_fence, I strongly suspect that the problem came to be
because of no clear guidance by dma_fence as to what the driver must
and must not do in its ops implementation.

The only evidence I have ever seen is the fence-list-lock, and it's
just not clear at all why any callback would need access to that.


Let's walk it through together, shall we?

ops->release() and ->wait(): deprecated

ops->get_XXX_name() -> never needs driver locks

ops->signaled(): "Driver, here you read an atomic integer, the sequence
number, and tell the fence backend whether this fence shall be regarded
as completed"
No need for any driver lock.
If this particular driver also signals fences through an interrupt
handler, it can take a list lock, then signal the fence. The ops must
not do that.
Why would a driver need both modes, sw *and* hw signaling? And why then
is it supposedly the case that both paths need to keep a list updated?


ops->enable_signaling(): "Make sure that this fence will get signaled.
Register an interrupt or schedule a work item". These locks also don't
interfere with the fence-lock.

ops->set_deadline(): clock up the CPU frequency. The only implementor
trivially does that through a work item, too =E2=80=93 after voluntarily ta=
king
the fence lock over the entire section.


As you saw from our recent amdgpu discussions, the confusion of what a
ops is even good for caused drivers to mess around with the fence
directly in their callbacks, checking for the signaled state etc.

It was too much freedom that has caused the trouble. There are no
canonical solutions now.


So except for updating the linked list in ops, can you show me any code
example where a lock inversion would occur? I'm quite confident that it
will turn out that the driver has no good justification for performing
the related acts in the ops in the first place.


P.
