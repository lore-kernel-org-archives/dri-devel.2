Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EC4C44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:03:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B01B210E2B4;
	Thu, 16 Jul 2026 08:03:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="d7ylZIqO";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93DA810E2B4
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 08:03:38 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4h15CB3vVMz8tRM;
 Thu, 16 Jul 2026 10:03:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1784189014; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BpFaYPtetrt6iVuAdP7Zv1c6RY+pf6snLzHLgFKGVho=;
 b=d7ylZIqOLOpdbesezTcXlBJJjttnBKt52QdAtS2OMncxEVGXnA/y+4CKhOaysHps0ygCFA
 KYMF8QpuYtpjOQI/yTpxqqTXBsNr37lEHSoUXJxFlzfg5zW0KJgNbRumFEz/s2FwBVKc+m
 B77eSD7BgwgnKIXCsMQp1z+9udXxJQLQAAi/+mVs3HZDyoaniIvhVHxDt9xDMRgWQX8JeW
 ehgB84MI6mHcCUGnBzjm/UAVDirdoPRpFYvh1fqHtwc/p/DEAKcC8khMxGBbJwnBEeQ8sn
 eucin7F0dp2i3Xky2bfT+C6FHGbpRcZYkCWikUhSlbuvMjVMvt/5gJI9Gn+cqQ==
Message-ID: <7a2cf5494824b8451824ebe82e0391df05a7cb5a.camel@mailbox.org>
Subject: Re: [PATCH v5 4/5] rust: Add dma_fence abstractions
From: Philipp Stanner <phasta@mailbox.org>
To: Daniel Almeida <daniel.almeida@collabora.com>, Philipp Stanner
 <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Sumit Semwal	 <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Asahi Lina <lina+kernel@asahilina.net>,
 Burak Emir <bqe@google.com>, Lorenzo Stoakes <ljs@kernel.org>,  Joel
 Fernandes <joelagnelf@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Krishna Ketan Rai	 <prafulrai522@gmail.com>, Tamir Duberstein
 <tamird@kernel.org>, Mirko Adzic	 <adzicmirko97@gmail.com>, Alistair
 Francis <alistair.francis@wdc.com>, Onur =?ISO-8859-1?Q?=D6zkan?=	
 <work@onurozkan.dev>, Shankari Anand <shankari.ak0208@gmail.com>, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org
Date: Thu, 16 Jul 2026 10:03:19 +0200
In-Reply-To: <046C4D44-1966-4EE9-AE86-A8F83A136771@collabora.com>
References: <20260703073141.3962604-2-phasta@kernel.org>
 <20260703073141.3962604-6-phasta@kernel.org>
 <046C4D44-1966-4EE9-AE86-A8F83A136771@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: 9wthz9wyop7snpo9j5sntg48tun6inpj
X-MBO-RS-ID: 1013fb0ea656ed17e58
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

On Wed, 2026-07-15 at 15:57 -0300, Daniel Almeida wrote:
> Hi Phillipp,

Hello, thx for the review

>=20
> >=20

[=E2=80=A6]

> > new file mode 100644
> > index 000000000000..cbe8f447a603
> > --- /dev/null
> > +++ b/rust/kernel/dma_buf/dma_fence.rs
> > @@ -0,0 +1,894 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// Copyright (T) 2025, 2026 Red Hat Inc.:
> > +//=C2=A0=C2=A0 - Philipp Stanner <pstanner@redhat.com>
>=20
> SPDX-copyrightText?

ACK.

>=20
> > +
> > +//! DriverFence support.
>=20
> This contains, Fence, DriverFence and FenceContext, along with other
> miscellaneous. I would spend a bit more time fleshing this out slightly.

OK.

>=20
> > +//!
> > +//! Reference: <https://docs.kernel.org/driver-api/dma-buf.html#c.dma_=
fence>
> > +//!
> > +//! T header: [`include/linux/dma-fence.h`](srctree/include/linux/dma-=
fence.h)
>=20
> T?

Relic. Will fix.

>=20
> > +
> > +

[=E2=80=A6]

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try_pin_init!(Self {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // =
SAFETY: `dma_fence_context_alloc()` merely works on a global atomic.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // =
Parameter `1` is the number of contexts we want to allocate.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nr:=
 unsafe { bindings::dma_fence_context_alloc(1) },
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq=
no: AtomicU64::new(0),
>=20
> Do we really need to force a 0 here? i.e.: can=E2=80=99t we take the init=
ial seqno
> as an argument?

We could. What would that be useful for?

>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dri=
ver_name,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tim=
eline_name,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dat=
a <- data,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 })
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> >=20

[=E2=80=A6]

> > +=C2=A0=C2=A0=C2=A0 /// Create a new fence, consuming `data`.
> > +=C2=A0=C2=A0=C2=A0 ///
> > +=C2=A0=C2=A0=C2=A0 /// The fence will increment the refcount of the fe=
nce context associated with this
> > +=C2=A0=C2=A0=C2=A0 /// [`FenceCtx`].
> > +=C2=A0=C2=A0=C2=A0 pub fn new_fence(&self, memory: DriverFenceAllocati=
on<'a, T>) -> DriverFence<'a, T> {
>=20
> Do we ever check if the allocation was really made by =E2=80=9Cself=E2=80=
=9D ? Apparently not :/

Hm, no, we don't.

For the most part that's irrelevant, since all critical components then
only get set in new_fence(). Correct typization is enforced through T.

The notable exception is the fence_ctx reference itself.

What should we do about it?

We could keep the fctx field as a MaybeUninit and set it later. Or we
check through the fctx identifier number whether it's the correct one
in new_fence(), but then new_fence() could fail with some error, and
it's probably better to have it be completely fail-free.

>=20
> >=20

[=E2=80=A6]

> > +pub trait FenceCb: Send + 'static {
>=20
> IMHO these acronyms make the code harder to read for no gain. I don=E2=80=
=99t think
> we have to carry that over from C.
>=20
> FenceCb -> FenceCallback

No principle objections from me. But do you believe *all* of them are
bad? I really like `let fctx =3D =E2=80=A6` for instance.


>=20
> > +=C2=A0=C2=A0=C2=A0 /// Called when the fence is signaled.
> > +=C2=A0=C2=A0=C2=A0 ///
> > +=C2=A0=C2=A0=C2=A0 /// This is called from the fence signaling path, w=
hich may be in interrupt
> > +=C2=A0=C2=A0=C2=A0 /// context or with locks held, which is why `self`=
 is only borrowed, so that
> > +=C2=A0=C2=A0=C2=A0 /// it cannot drop. Implementations must not sleep =
or perform
> > +=C2=A0=C2=A0=C2=A0 /// long-running operations.
> > +=C2=A0=C2=A0=C2=A0 ///
> > +=C2=A0=C2=A0=C2=A0 /// An implementation likely wants to inform itself=
 (e.g., through a work item)
> > +=C2=A0=C2=A0=C2=A0 /// within this callback that the associated [`Fenc=
eCbRegistration`] can now be
> > +=C2=A0=C2=A0=C2=A0 /// dropped.
> > +=C2=A0=C2=A0=C2=A0 fn called(&mut self);
>=20
> I think =E2=80=9Csignaled=E2=80=9D is more descriptive than =E2=80=9Ccall=
ed=E2=80=9D.

Here I disagree. A callback does not get signaled. It gets called once
the fence gets signaled.

>=20
> > +}
> > +
> >=20

[=E2=80=A6]

> > +
> > +/// The receiving counterpart of a [`DriverFence`], designed to regist=
er callbacks
> > +/// on, check the signalled state etc. A [`Fence`] cannot be signalled=
.
> > +/// A [`Fence`] is always refcounted.
>=20
> I would explain this a tad better.

What exactly? The refcounting? The dualism between DriverFence and
Fence? :)

>=20
> > +#[repr(transparent)]
> > +pub struct Fence {
> > +=C2=A0=C2=A0=C2=A0 /// The actual dma_fence passed to C.
> > +=C2=A0=C2=A0=C2=A0 inner: Opaque<bindings::dma_fence>,
> > +}
> > +
> > +// SAFETY: Fences are literally designed to be shared between threads.
> > +unsafe impl Send for Fence {}
> > +// SAFETY: Fences are literally designed to be shared between threads.
> > +unsafe impl Sync for Fence {}
> > +
> > +impl Fence {
> > +=C2=A0=C2=A0=C2=A0 /// Check whether the fence was signalled at the mo=
ment of the function call.
> > +=C2=A0=C2=A0=C2=A0 ///
> > +=C2=A0=C2=A0=C2=A0 /// Note that this can return `true` for a [`Fence`=
] whose [`DriverFence`]
> > +=C2=A0=C2=A0=C2=A0 /// has not yet been dropped. The reason is that th=
e fence ops callbacks can
> > +=C2=A0=C2=A0=C2=A0 /// cause the fence to get signaled by the C backen=
d.
> > +=C2=A0=C2=A0=C2=A0 pub fn is_signaled(&self) -> bool {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let fence =3D self.as_raw()=
;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let mut fence_flags: usize =
=3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let flag_ptr =3D &raw mut f=
ence_flags;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // We shouuld not use `dma_=
fence_is_signaled_locked()` here, because
>=20
> typo

ACK.

>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // according to the C backe=
nd's recommendations, that function is problematic
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // and we should avoid call=
ing that function with a lock held.
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `self` is valid =
by definition. We take the spinlock above.
>=20
> Where?

The safety comment is wrong / outdated. See below.

>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let ret =3D unsafe { bindin=
gs::dma_fence_is_signaled(fence) };
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // To guarantee that an API=
 caller can 100% rely on the signalling being
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // completed (i.e., all fen=
ce callbacks ran), we have to take the lock.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // The reason is that the C=
 dma_fence backend currently does not carefully
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // synchronize the `dma_fen=
ce_is_signaled()` function with the proper
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // spinlock. This can lead =
to the function returning `true` while fence
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // callbacks are still bein=
g executed. This can be mitigated by guarding
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // the entire function with=
 the spinlock.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // See commit c8a5d5ea3ba6a=
.
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `fence` is valid=
 because `self` is valid. `flag_ptr` is
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // merely a pointer to an i=
nteger, which lives as long as this function.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { bindings::dma_fenc=
e_lock_irqsave(fence, flag_ptr) };
>=20
> Shouldn=E2=80=99t this be before the =E2=80=9Cis_signaled=E2=80=9D ffi ca=
ll? Or is this
> only about ensuring all callbacks have run? i.e.: is =E2=80=9Cret=E2=80=
=9D valid even
> though it was computed before taking the lock?

OK, this is where it gets ugly.

So during the last weeks I've been struggling to get the C backend into
better shape. One issue from my POV is that the C dma_fence spinlock
does not protect the fence state; there is insistence that the lock
shall only protect the callback list.

The function dma_fence_is_signaled() has an unlocked fast path check:

https://elixir.bootlin.com/linux/v7.2-rc3/source/include/linux/dma-fence.h#=
L551

whereas setting of that bit is done under lock-protection:

https://elixir.bootlin.com/linux/v7.2-rc3/source/drivers/dma-buf/dma-fence.=
c#L362


This can lead to funny races like in the commit mentioned in the
comment block above (c8a5d5ea3ba6a).

And it also leads to weird hacks like this:

https://elixir.bootlin.com/linux/v7.2-rc3/source/drivers/gpu/drm/amd/amdgpu=
/amdgpu_vm.c#L2775


Now, in principle I agree with you that a pattern like this:

dma_fence_lock_irqsave(=E2=80=A6);
let signaled =3D dma_fence_is_signaled_locked(=E2=80=A6);
dma_fence_unlock_irqrestore(=E2=80=A6);

would be better.

However, lengthy discussions with Christian seem to settle at the point
where Christian sees the very strict requirement of never calling fence
callbacks under lock protection, and where he views
dma_fence_is_signaled_locked() as a broken function that should be
removed.

He's currently working on removing all bits where fence callbacks are
invoked under lock protection:

https://lore.kernel.org/dri-devel/20260624122917.2483-1-christian.koenig@am=
d.com/

There's been a ton of discussions and proposals about that in recent
weeks

https://lore.kernel.org/dri-devel/20260608142436.265820-2-phasta@kernel.org=
/
https://lore.kernel.org/dri-devel/20260612104251.2264707-2-phasta@kernel.or=
g/


So tl;dr: The weird code you're commenting on above ensures that

a) the fence->ops->is_signaled() callback is not called under lock
protection and
b) taking and releasing the lock guarantees that all callbacks are
really finished, i.e. they have run.


(I continue to believe that setting the bit under lock protection and
reading it without lock is fundamentally broken and needs to be fixed,
but fixes are being rejected because of claimed performance regressions
years ago when this was tried, because checking the bit is some sort of
fast path check for.. parties that spin on dma_fence_is_signaled() ??)

>=20
> >=20

[=E2=80=A6]

> > +}
> > +// Necessary to guarantee that `inner` always comes first and can be f=
reed by C.
> > +// Also useful for using casts instead of container_of().
> > +#[repr(C)]
> > +#[pin_data]
> > +struct DriverFenceData<'a, T: Send + Sync + FenceCtxOps> {
> > +=C2=A0=C2=A0=C2=A0 #[pin]
> > +=C2=A0=C2=A0=C2=A0 /// The inner fence.
> > +=C2=A0=C2=A0=C2=A0 // Must always be the first member so that unsafe c=
asting works; but also
> > +=C2=A0=C2=A0=C2=A0 // necessary so that the C backend can free the all=
ocation (coming from our
> > +=C2=A0=C2=A0=C2=A0 // Rust code) with kfree_rcu().
> > +=C2=A0=C2=A0=C2=A0 inner: Fence,
> > +=C2=A0=C2=A0=C2=A0 /// Callback head for dropping this in a deferred m=
anner through RCU.
> > +=C2=A0=C2=A0=C2=A0 rcu_head: bindings::callback_head,
> > +=C2=A0=C2=A0=C2=A0 /// Reference to access the FenceCtx. Useful for ob=
taining name parameters.
> > +=C2=A0=C2=A0=C2=A0 fctx: &'a FenceCtx<T>,
>=20
> This creates a self-referential borrow in the JobQueue, since it holds bo=
th (a) the
> context to mint new seqnos from and (b) the xarray with fences which borr=
ow from
> that same context. This issue does not exist with the Arc and we should r=
eally
> fix it before moving with this series.

Can you detail that a bit more. So your JobQueue version has a `data:
T` where T holds both the xarray and a jobqueue. The xarray contains
fences that hold references to the FenceCtx. But shouldn't that be fine
since the life time ensures that the drop order is correct?


btw we are recently coming up with a proposal on how JobQueue could
store DriverFences for the driver. I want to present some RFC for that
soonish.

>=20
>=20
> > +=C2=A0=C2=A0=C2=A0 /// The API user's data. This must either not need =
drop, or must delay its
> > +=C2=A0=C2=A0=C2=A0 /// drop by a grace period. It is essential that th=
e data only performs
> > +=C2=A0=C2=A0=C2=A0 /// operations legal in atomic context in its [`Dro=
p`] implementation.
> > +=C2=A0=C2=A0=C2=A0 #[pin]
> > +=C2=A0=C2=A0=C2=A0 data: T::FenceDataType,
> > +}
> > +
> >=20

[=E2=80=A6]

> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // DriverFenceData is repr(=
C) and a Fence is its first member.
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let fence_data_ptr =3D fenc=
e_ptr as *mut DriverFenceData<'a, T>;
>=20
> Without a =E2=80=9CCAST:=E2=80=9D keyword, I think this will trigger the =
linter?
>=20

Didn't see a complaint from clippy nor compiler.

>=20
> > +
> >=20

[=E2=80=A6]

>=20
> lifetime is a single word.

ACK.

>=20
> > +}
> > +
> > +impl<'a, T: Send + Sync + FenceCtxOps> Deref for DriverFenceBorrow<'a,=
 T> {
> > +=C2=A0=C2=A0=C2=A0 type Target =3D DriverFence<'a, T>;
> > +
> > +=C2=A0=C2=A0=C2=A0 fn deref(&self) -> &Self::Target {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.driver_fence.deref()
> > +=C2=A0=C2=A0=C2=A0 }
> > +}
> > +
> > +// SAFETY: The Rust dma_fence abstractions are already designed around=
 the inner
> > +// C `dma_fence`, which can serve safely as the identification point w=
hen being
> > +// owned by C. Moreover, safety is ensured by not dropping `DriverFenc=
e` and by
> > +// only allowing operations without side effects on the Borrowed type.
> > +unsafe impl<'b, T: Send + Sync + FenceCtxOps + 'static> ForeignOwnable=
 for DriverFence<'b, T> {
> > +=C2=A0=C2=A0=C2=A0 type Borrowed<'a>
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D DriverFenceBorrow<'a, T=
>
> > +=C2=A0=C2=A0=C2=A0 where
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Self: 'a;
> > +=C2=A0=C2=A0=C2=A0 type BorrowedMut<'a>
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D DriverFenceBorrow<'a, T=
>
>=20
> We should have a separate type for mutable borrows, IMHO.

No hard objections. But because it's convention, or because you see
other advantages?



Thanks

P.
>=20
