Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858D7C44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 17:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E75B710E430;
	Fri, 17 Jul 2026 17:14:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="ON/y666p";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 653A510E430
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 17:14:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784308474; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=eHSXv93a+kLpfBPuV4XMN8saZzYgi7LA9SX9dc4napdLK7TOM75b0ikWgjSdhFjMxf8T6NHIrl4jUk3Nbed9reiUA59QGvqJN4qvpYUCux9jRk0zf4ttQdEtXL6S/oetUReuLjVZPSSNkMtJgaJ1fgrSKQ+ZlA32Sf/iJjls8xo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784308474;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Obi2JLsftJUNdtXpRvd5RDFm/4pvc5YPTAdtbeGx+vk=; 
 b=i0+Namg8tF78Le2WotK25lOY2P8X0lSJW/H5/ZmF3DJlbKkk/dAVi+gU19zjbJ1hcSDwNMiayT6NwRmiOn8bxSM6fhXwth5lbwJ94pA1DhrGL3kiI3Eal3D82XlB/KcxNebb/ZLbKSdm5zV83d5RdRNDcDpGs987uSgcmws7Y1s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784308474; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=Obi2JLsftJUNdtXpRvd5RDFm/4pvc5YPTAdtbeGx+vk=;
 b=ON/y666pE9jZgsoD56Zvsw63/zP4PdKAAGcKl5v0e5J44MOe+wE8Dq9rEXJ+G7+e
 BNMPMW+cM/7MeIxN/Ze8XYP3UJGclhKjVhdy9/9wEP+XU6fw8xcVcNfgjOId/2V9hH8
 M6jGT8qP8b8uO4toAivQCLeu+/How3SbepeOm42I=
Received: by mx.zohomail.com with SMTPS id 1784308473066294.55527821713736;
 Fri, 17 Jul 2026 10:14:33 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v5 4/5] rust: Add dma_fence abstractions
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <7a2cf5494824b8451824ebe82e0391df05a7cb5a.camel@mailbox.org>
Date: Fri, 17 Jul 2026 14:14:12 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Asahi Lina <lina+kernel@asahilina.net>, Burak Emir <bqe@google.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Krishna Ketan Rai <prafulrai522@gmail.com>,
 Tamir Duberstein <tamird@kernel.org>, Mirko Adzic <adzicmirko97@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Shankari Anand <shankari.ak0208@gmail.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F72EFF33-E4F8-4E9B-B966-58BCCBA495C4@collabora.com>
References: <20260703073141.3962604-2-phasta@kernel.org>
 <20260703073141.3962604-6-phasta@kernel.org>
 <046C4D44-1966-4EE9-AE86-A8F83A136771@collabora.com>
 <7a2cf5494824b8451824ebe82e0391df05a7cb5a.camel@mailbox.org>
To: phasta@kernel.org
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

>=20
>>> +        try_pin_init!(Self {
>>> +            // SAFETY: `dma_fence_context_alloc()` merely works on =
a global atomic.
>>> +            // Parameter `1` is the number of contexts we want to =
allocate.
>>> +            nr: unsafe { bindings::dma_fence_context_alloc(1) },
>>> +            seqno: AtomicU64::new(0),
>>=20
>> Do we really need to force a 0 here? i.e.: can=E2=80=99t we take the =
initial seqno
>> as an argument?
>=20
> We could. What would that be useful for?


On Mali, the hardware syncobj starts at 0. If you see a 0, is this the =
default
state, or should you signal seqno 0?

This problem goes away if we can have seqnos starting at a custom value, =
like
1. It seems like the C machinery also special-cases 0 in a few other =
places too.

>=20
>>=20
>>> +            driver_name,
>>> +            timeline_name,
>>> +            data <- data,
>>> +        })
>>> +    }
>>> +
>>>=20
>=20
> [=E2=80=A6]
>=20
>>> +    /// Create a new fence, consuming `data`.
>>> +    ///
>>> +    /// The fence will increment the refcount of the fence context =
associated with this
>>> +    /// [`FenceCtx`].
>>> +    pub fn new_fence(&self, memory: DriverFenceAllocation<'a, T>) =
-> DriverFence<'a, T> {
>>=20
>> Do we ever check if the allocation was really made by =E2=80=9Cself=E2=80=
=9D ? Apparently not :/
>=20
> Hm, no, we don't.
>=20
> For the most part that's irrelevant, since all critical components =
then
> only get set in new_fence(). Correct typization is enforced through T.
>=20
> The notable exception is the fence_ctx reference itself.
>=20
> What should we do about it?
>=20
> We could keep the fctx field as a MaybeUninit and set it later. Or we
> check through the fctx identifier number whether it's the correct one
> in new_fence(), but then new_fence() could fail with some error, and
> it's probably better to have it be completely fail-free.

Agree about the fail-free part.

The problem I see here is that new_fence() will use "seqno" and "nr" =
from
whatever context called new_fence(), but DriverFenceAllocation has some =
other
(possibly unrelated) context as its DriverFenceData::fctx.

The lifetimes are apparently broken too, because 'a is the lifetime of =
the
context where new_fence_allocation was called, meaning that the context =
that
actually called new_fence() can drop, even though it provided the state =
for
dma_fence_init().

I guess this can be solved by moving new_fence() to impl =
DriverFenceAllocation?
That already has a context, and most importantly, the right context.

>=20
>>=20
>>>=20
>=20
> [=E2=80=A6]
>=20
>>> +pub trait FenceCb: Send + 'static {
>>=20
>> IMHO these acronyms make the code harder to read for no gain. I =
don=E2=80=99t think
>> we have to carry that over from C.
>>=20
>> FenceCb -> FenceCallback
>=20
> No principle objections from me. But do you believe *all* of them are
> bad? I really like `let fctx =3D =E2=80=A6` for instance.

No, variable names are fine IMHO. It=E2=80=99s only types where I think =
we should be a bit
more verbose.

>=20
>=20
>>=20
>>> +    /// Called when the fence is signaled.
>>> +    ///
>>> +    /// This is called from the fence signaling path, which may be =
in interrupt
>>> +    /// context or with locks held, which is why `self` is only =
borrowed, so that
>>> +    /// it cannot drop. Implementations must not sleep or perform
>>> +    /// long-running operations.
>>> +    ///
>>> +    /// An implementation likely wants to inform itself (e.g., =
through a work item)
>>> +    /// within this callback that the associated =
[`FenceCbRegistration`] can now be
>>> +    /// dropped.
>>> +    fn called(&mut self);
>>=20
>> I think =E2=80=9Csignaled=E2=80=9D is more descriptive than =
=E2=80=9Ccalled=E2=80=9D.
>=20
> Here I disagree. A callback does not get signaled. It gets called once
> the fence gets signaled.

Is the information that a callback was called more important than the =
fact that
it was called because a fence was signaled? I think that a driver author =
would
rather implement =E2=80=9Cwhat happens when the fence is signaled=E2=80=9D=
 versus
=E2=80=9Cwhat happens when the callback is called=E2=80=9D. But this is =
pretty minor.
If you still think that called is better, I don=E2=80=99t object either =
:)

>=20
>>=20
>>> +}
>>> +
>>>=20
>=20
> [=E2=80=A6]
>=20
>>> +
>>> +/// The receiving counterpart of a [`DriverFence`], designed to =
register callbacks
>>> +/// on, check the signalled state etc. A [`Fence`] cannot be =
signalled.
>>> +/// A [`Fence`] is always refcounted.
>>=20
>> I would explain this a tad better.
>=20
> What exactly? The refcounting? The dualism between DriverFence and
> Fence? :)

For example, you say =E2=80=9Ca Fence cannot be signaled=E2=80=9D. A =
person seeing this
code for the first time might ask why. Specially if they start by =
reading the
docs for Fence first.

I think explaining a bit more about the DriverFence/Fence/refcounting as =
you
said is already enough to settle it.


>=20
>>=20
>>> +#[repr(transparent)]
>>> +pub struct Fence {
>>> +    /// The actual dma_fence passed to C.
>>> +    inner: Opaque<bindings::dma_fence>,
>>> +}
>>> +
>>> +// SAFETY: Fences are literally designed to be shared between =
threads.
>>> +unsafe impl Send for Fence {}
>>> +// SAFETY: Fences are literally designed to be shared between =
threads.
>>> +unsafe impl Sync for Fence {}
>>> +
>>> +impl Fence {
>>> +    /// Check whether the fence was signalled at the moment of the =
function call.
>>> +    ///
>>> +    /// Note that this can return `true` for a [`Fence`] whose =
[`DriverFence`]
>>> +    /// has not yet been dropped. The reason is that the fence ops =
callbacks can
>>> +    /// cause the fence to get signaled by the C backend.
>>> +    pub fn is_signaled(&self) -> bool {
>>> +        let fence =3D self.as_raw();
>>> +        let mut fence_flags: usize =3D 0;
>>> +        let flag_ptr =3D &raw mut fence_flags;
>>> +
>>> +        // We shouuld not use `dma_fence_is_signaled_locked()` =
here, because
>>=20
>> typo
>=20
> ACK.
>=20
>>=20
>>> +        // according to the C backend's recommendations, that =
function is problematic
>>> +        // and we should avoid calling that function with a lock =
held.
>>> +
>>> +        // SAFETY: `self` is valid by definition. We take the =
spinlock above.
>>=20
>> Where?
>=20
> The safety comment is wrong / outdated. See below.
>=20
>>=20
>>> +        let ret =3D unsafe { bindings::dma_fence_is_signaled(fence) =
};
>>> +
>>> +        // To guarantee that an API caller can 100% rely on the =
signalling being
>>> +        // completed (i.e., all fence callbacks ran), we have to =
take the lock.
>>> +        //
>>> +        // The reason is that the C dma_fence backend currently =
does not carefully
>>> +        // synchronize the `dma_fence_is_signaled()` function with =
the proper
>>> +        // spinlock. This can lead to the function returning `true` =
while fence
>>> +        // callbacks are still being executed. This can be =
mitigated by guarding
>>> +        // the entire function with the spinlock.
>>> +        //
>>> +        // See commit c8a5d5ea3ba6a.
>>> +
>>> +        // SAFETY: `fence` is valid because `self` is valid. =
`flag_ptr` is
>>> +        // merely a pointer to an integer, which lives as long as =
this function.
>>> +        unsafe { bindings::dma_fence_lock_irqsave(fence, flag_ptr) =
};
>>=20
>> Shouldn=E2=80=99t this be before the =E2=80=9Cis_signaled=E2=80=9D =
ffi call? Or is this
>> only about ensuring all callbacks have run? i.e.: is =E2=80=9Cret=E2=80=
=9D valid even
>> though it was computed before taking the lock?
>=20
> OK, this is where it gets ugly.
>=20
> So during the last weeks I've been struggling to get the C backend =
into
> better shape. One issue from my POV is that the C dma_fence spinlock
> does not protect the fence state; there is insistence that the lock
> shall only protect the callback list.
>=20
> The function dma_fence_is_signaled() has an unlocked fast path check:
>=20
> =
https://elixir.bootlin.com/linux/v7.2-rc3/source/include/linux/dma-fence.h=
#L551
>=20
> whereas setting of that bit is done under lock-protection:
>=20
> =
https://elixir.bootlin.com/linux/v7.2-rc3/source/drivers/dma-buf/dma-fence=
.c#L362
>=20
>=20
> This can lead to funny races like in the commit mentioned in the
> comment block above (c8a5d5ea3ba6a).
>=20
> And it also leads to weird hacks like this:
>=20
> =
https://elixir.bootlin.com/linux/v7.2-rc3/source/drivers/gpu/drm/amd/amdgp=
u/amdgpu_vm.c#L2775
>=20
>=20
> Now, in principle I agree with you that a pattern like this:
>=20
> dma_fence_lock_irqsave(=E2=80=A6);
> let signaled =3D dma_fence_is_signaled_locked(=E2=80=A6);
> dma_fence_unlock_irqrestore(=E2=80=A6);
>=20
> would be better.
>=20
> However, lengthy discussions with Christian seem to settle at the =
point
> where Christian sees the very strict requirement of never calling =
fence
> callbacks under lock protection, and where he views
> dma_fence_is_signaled_locked() as a broken function that should be
> removed.
>=20
> He's currently working on removing all bits where fence callbacks are
> invoked under lock protection:
>=20
> =
https://lore.kernel.org/dri-devel/20260624122917.2483-1-christian.koenig@a=
md.com/
>=20
> There's been a ton of discussions and proposals about that in recent
> weeks
>=20
> =
https://lore.kernel.org/dri-devel/20260608142436.265820-2-phasta@kernel.or=
g/
> =
https://lore.kernel.org/dri-devel/20260612104251.2264707-2-phasta@kernel.o=
rg/
>=20
>=20
> So tl;dr: The weird code you're commenting on above ensures that
>=20
> a) the fence->ops->is_signaled() callback is not called under lock
> protection and
> b) taking and releasing the lock guarantees that all callbacks are
> really finished, i.e. they have run.
>=20
>=20
> (I continue to believe that setting the bit under lock protection and
> reading it without lock is fundamentally broken and needs to be fixed,
> but fixes are being rejected because of claimed performance =
regressions
> years ago when this was tried, because checking the bit is some sort =
of
> fast path check for.. parties that spin on dma_fence_is_signaled() ??)

I see, there is a lot more context on this then. Can you merely add a =
comment
saying it=E2=80=99s ok to call dma_fence_is_signaled() without the =
locks? Otherwise
people might try to =E2=80=9Cfix=E2=80=9D this down the line...

>=20
>>=20
>>>=20
>=20
> [=E2=80=A6]
>>=20
>>=20
>>> +    /// The API user's data. This must either not need drop, or =
must delay its
>>> +    /// drop by a grace period. It is essential that the data only =
performs
>>> +    /// operations legal in atomic context in its [`Drop`] =
implementation.
>>> +    #[pin]
>>> +    data: T::FenceDataType,
>>> +}
>>> +
>>>=20
>=20
> [=E2=80=A6]
>=20
>>> +
>>> +        // DriverFenceData is repr(C) and a Fence is its first =
member.
>>=20
>>> +        let fence_data_ptr =3D fence_ptr as *mut =
DriverFenceData<'a, T>;
>>=20
>> Without a =E2=80=9CCAST:=E2=80=9D keyword, I think this will trigger =
the linter?
>>=20
>=20
> Didn't see a complaint from clippy nor compiler.

I recommend the CAST thing anyways. It=E2=80=99s being adopted in other =
parts of the kernel
crate.

>=20
>>=20
>>> +
>>>=20
>=20
> [=E2=80=A6]
>=20
>>=20
>> lifetime is a single word.
>=20
> ACK.
>=20
>>=20
>>> +}
>>> +
>>> +impl<'a, T: Send + Sync + FenceCtxOps> Deref for =
DriverFenceBorrow<'a, T> {
>>> +    type Target =3D DriverFence<'a, T>;
>>> +
>>> +    fn deref(&self) -> &Self::Target {
>>> +        self.driver_fence.deref()
>>> +    }
>>> +}
>>> +
>>> +// SAFETY: The Rust dma_fence abstractions are already designed =
around the inner
>>> +// C `dma_fence`, which can serve safely as the identification =
point when being
>>> +// owned by C. Moreover, safety is ensured by not dropping =
`DriverFence` and by
>>> +// only allowing operations without side effects on the Borrowed =
type.
>>> +unsafe impl<'b, T: Send + Sync + FenceCtxOps + 'static> =
ForeignOwnable for DriverFence<'b, T> {
>>> +    type Borrowed<'a>
>>> +        =3D DriverFenceBorrow<'a, T>
>>> +    where
>>> +        Self: 'a;
>>> +    type BorrowedMut<'a>
>>> +        =3D DriverFenceBorrow<'a, T>
>>=20
>> We should have a separate type for mutable borrows, IMHO.
>=20
> No hard objections. But because it's convention, or because you see
> other advantages?

Actually, when I first made this comment, I think pointers were being =
used.
Back then I wanted one type to deref to *const and the other one to =
deref to
*mut. This does not seem to be the case anymore, so please forget what I =
just
said :)

>=20
>=20
>=20
> Thanks
>=20
> P.
>>=20

