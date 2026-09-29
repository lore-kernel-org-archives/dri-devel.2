Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13407CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 14:32:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5567D10EF29;
	Tue, 29 Sep 2026 14:32:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="sAjqq+QF";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46EE410E0F4
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 14:32:49 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hvLHd37HmzMlMZ;
 Tue, 29 Sep 2026 16:32:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1790692365; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eVPHcNKEnZbCUM6JPhhPFFrAPt2luGsLtj/T1FhlUww=;
 b=sAjqq+QFsRWG4O8Ysdhye6ymk/YJpItyiAVQAOVpRMOvGZ74lyjGudKliWAOMPap0n5mKB
 dpFmtgMR8tY+9Uj/3UCPK/yfi9XUbuu621WiuC/G55qt5fZEXAERBv0mHowPxJ8Hb8esO6
 2uk6hOywYa0FXkSGksUJglhaveT3yGMmfkhlx6WlRj9Q7VHeeNfGdflD8hKFmiJVQmY+pS
 DqUoWaX+2DB2CJrVvnjGOz55FPNbo5DyxL+Bvc8ssLnBRTrFsNUZ2NpJpjp/4Ik84lMBEE
 d7isf4Qknjqu3VwAmMgYOxH5CMhI3W3yjFFDK2AVoTX4F2G58FIY0zFzFSgkLg==
Message-ID: <cc55db30a4a7ca274c95ff3351644515a404de67.camel@mailbox.org>
Subject: Re: [PATCH] dma-buf/dma-fence: Mark two callbacks as deprecated
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 phasta@kernel.org, Sumit Semwal <sumit.semwal@linaro.org>, Danilo Krummrich
 <dakr@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Date: Tue, 29 Sep 2026 16:32:43 +0200
In-Reply-To: <3f00c8e4-b52d-4b8f-9eb1-30c05b02eb30@amd.com>
References: <20260923150308.1294592-2-phasta@kernel.org>
 <3983b2de-b6ee-4674-be22-9ecb2525a055@amd.com>
 <469d5deb2ef644b5d77d21bc2d700443f00c0b4d.camel@mailbox.org>
 <c400f12a-04db-45eb-853b-629f19e3060e@amd.com>
 <a4655e4ab7a2477b75351a0e83b98e0cb0396fdb.camel@mailbox.org>
 <c7d9c659-d903-456f-87f2-d75aafb8de3b@amd.com>
 <7b8942e29f6c714979415a59b42af450afa101e4.camel@mailbox.org>
 <3f00c8e4-b52d-4b8f-9eb1-30c05b02eb30@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
MIME-Version: 1.0
X-MBO-RS-META: 3b9ebjbwdr95psixijzyfucgu5xndqwe
X-MBO-RS-ID: 0ea9bc353001fd077be
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

+Cc Danilo

On Tue, 2026-09-29 at 15:32 +0200, Christian K=C3=B6nig wrote:
> On 9/25/26 10:42, Philipp Stanner wrote:
> > On Fri, 2026-09-25 at 10:21 +0200, Christian K=C3=B6nig wrote:
> > > Some problems like the locking design are still WIP, but we are
> > > slowly moving towards that.
> >=20
> > The question will be whether we can reach common ground with that
> > one.
>=20
> I haven't had a chance to look into your alternative to using RCU,

That was just a nasty, still half broken RFC that doesn't really work
(yet), just to see how the rough idea might resonate.

Basically, I think that at the heart of fence's problems are these
issues:

a) fence and fence_context can share a lock
b) thus, the driver often protects driver data with that lock
c) drivers now are allowed to take the fence-lock manually
d) thus, the fence-state cannot consistently be protected with the lock

The fundamental problems were IMO worked around with RCU.

I think if we re-designed dma_fence today, we would do it like that:

a) each fence has its own lock
b) the driver cannot (legally) access a fence-lock
c) the entire fence state is protected by the lock
d) the fence lifetime is completely covered by refcounting
e) signaling is the decoupling point. Signaled-state is guarded by the lock
f) fence->ops access is, through the signaled-state guard, also guarded by =
the lock.
g) all fence API functions are locking-atomic. For example,
   dme_fence_set_error() should not exist, but dma_fence_signal(err)
   should take the code and do all operations while holding the
   lock.

If the driver can never take the lock, then there cannot be a lock
inversion (unless the driver would signal while holding its own lock,
which should be avoidable).


So my idea would have been that, similarly to how you added the
inline_lock a year ago, we add another super_lock to dma_fence, which
is always present, for all users.

We could then add this lock as a second locking layer around the
existing inline / shared lock and implement the rules listed above with
it.

This is just a crazy idea =E2=80=93 it's obviously horribly dangerous and
fragile because of locking order. So I'm not sure if it's worth
exploring further.

But if we had a time-machine I think that's what we would tell
ourselves to do.


> but you mentioned that you found a solution to the problem on the
> RUST side so it sounded to me that we at least have a path forward.

In Rust we just obey 100% to the current dma_fence contract. We do use
RCU, and establish the signaled-state as strict decoupling point for
driver-unload.

Since all the code is new, we just don't implement deprecated
callbacks, and we use inline_lock.

I take the fence lock manually where necessary, and sometimes where
half-necessary.

Fence::is_signaled() for example takes and releases the lock like you
do in the AMD code example below, so that all future API users know
with 100% certainty that all callbacks have run once the function
returns true.

(what our Rust design, ironically, solves is ops->signaled() not being
usable for users of drm_sched, because of drm_sched_fence being in
between)

>=20
> > >=20
> > > But some problems like parts of the dma_fence uAPI are unfixable
> > > without time travel.
> >=20
> > I would be especially interested in learning about who the party is
> > that apparently is spinning on dma_fence_is_signaled(), supposedly
> > preventing us from getting the memory ordering right.
>=20
> Well there isn't spinning on it. It's just that in a SMP system it
> takes some time for state to transfer between CPU cores and that
> communication channel often becomes a bottleneck.

No no, that's not what I mean. Having ops->signaled() is unrelated to
my question.

I'm asking about this:

static inline bool
dma_fence_is_signaled(struct dma_fence *fence)
{
	const struct dma_fence_ops *ops;

	if (dma_fence_test_signaled_flag(fence))
		return true;


You said once that I cannot add lock protection to that if-evaluation.
And IIRC the reason was that someone would complain about performance.
Who is that someone?

That's what I meant: that someone would have to be looping on
dma_fence_is_signaled() to feel the lock.

The reason I want the lock there is that I want to get rid of things
like that:

void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
{
	[=E2=80=A6]

	/* Make sure that all fence callbacks have completed */
	dma_fence_lock_irqsave(vm->last_tlb_flush, flags);
	dma_fence_unlock_irqrestore(vm->last_tlb_flush, flags);


>=20
> By implementing the is_signaled callback you avoid that device->CPU
> core A->CPU core B signaling making things much more responsive.
>=20
> Even on ancient drivers like radeon people start to complain when the
> is_signaled callback is removed, so it is definitely necessary.

We can keep the callback, I think it being there is not a decisive
issue.

Though I don't get why it being there would make things faster. My
understanding so far was that it's only good for parties that do not
signal fences via interrupt.

Who triggers the check via ops->is_signaled()? You once said it's
typically the compositor.

Since you mention Radeon I suppose it can indeed only be drivers that
don't use drm_sched.

> > Also learning more about the users that definitely *need* ops-
> > > signaled() and ops->enable_signaling() would be interesting.
> > > drm_sched
> > users cannot make use of these, since the sched-fence does not pass
> > the
> > request through to the hardware fence.
> >=20
> > So who are the users? Parties like Nouveau implement these
> > callbacks,
> > but it's not clear whether they actually need them.
>=20
> The eviction fence and KFD fence in amdgpu as well as the preemption
> fence in XE and i915 depend on that to note whenever somebody starts
> depending on the fence.
>=20
> Additional to that I just last week have talked with some Qualcomm
> folks who desperately want device to device signaling without waking
> up the CPU. The enabling_signaling callback is necessary for that as
> well.
>=20
> For Nouveau I think that it is pretty much pointless to implement
> those callbacks, but I'm not 100% sure.

I tried to remove them 1-2 years ago and then ran into massive
performance degradations, which indicates that Nouveau uses them for
some performance trick, maybe to reduce interrupt load. Didn't explore
it further.


P.

>=20
> Regards,
> Christian.
>=20
> >=20
> > (btw, funnily enough, with the Rust-fence design we finally have
> > the
> > ability to fully support all callbacks with or without a scheduler,
> > since the need for an intermediate fence disappeared)
> >=20
> >=20
> > P.
