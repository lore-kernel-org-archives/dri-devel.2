Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA763C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46CBB10E733;
	Tue, 21 Jul 2026 08:25:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UksD+XCn";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 883D110E739
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 08:25:20 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4h49Rw4PrVz8sYd;
 Tue, 21 Jul 2026 10:25:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1784622316; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L5YKxCPFIITOB3AAzpsrNVFKyhv95E3nU3TRkHrZrxg=;
 b=UksD+XCnamdnqxVh5dol8RPV+pHhpUqJXmpAqgRSObUiKuHJDntw8xf7NUNh+NRCmwenCp
 HymDoO3CjJE+oQafVS4FOL1+SD7N8dhRLvHG7gW8WWpcEYTcnvHByNAv2lkD+uyLji0pLu
 U8W0In9tLlH3isx/tBpuQC8MLCtyMUuv6/Nmj3vyfO55lxGXbJ6G+/pveszCA6eEfOpVIm
 4skM40F4/mnVTKxxdQF5IV0TwnxriQl6akUD3DIasFn9fqxjAjkFFjWP8+Q8RbxKXN6pKo
 9D1sAmkg7gVTupPY2enaxIHkJhn3N5DAfFtkQZWtNJnAVf5YrbZrXDhM+qWvLg==
Message-ID: <e6b51fd8eedfe18be5d7aa4e0007f932920d9fac.camel@mailbox.org>
Subject: Re: [PATCH v5 4/5] rust: Add dma_fence abstractions
From: Philipp Stanner <phasta@mailbox.org>
To: Daniel Almeida <daniel.almeida@collabora.com>, phasta@kernel.org
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
Date: Tue, 21 Jul 2026 10:25:06 +0200
In-Reply-To: <F72EFF33-E4F8-4E9B-B966-58BCCBA495C4@collabora.com>
References: <20260703073141.3962604-2-phasta@kernel.org>
 <20260703073141.3962604-6-phasta@kernel.org>
 <046C4D44-1966-4EE9-AE86-A8F83A136771@collabora.com>
 <7a2cf5494824b8451824ebe82e0391df05a7cb5a.camel@mailbox.org>
 <F72EFF33-E4F8-4E9B-B966-58BCCBA495C4@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 1914ef1328700d3862a
X-MBO-RS-META: md733ttmoctpshqfcrn3aqejj3fm8zpc
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

On Fri, 2026-07-17 at 14:14 -0300, Daniel Almeida wrote:
> >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try_pin_init!(Self {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 // SAFETY: `dma_fence_context_alloc()` merely works on a global atomic.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 // Parameter `1` is the number of contexts we want to allocate.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 nr: unsafe { bindings::dma_fence_context_alloc(1) },
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 seqno: AtomicU64::new(0),
> > >=20
> > > Do we really need to force a 0 here? i.e.: can=E2=80=99t we take the =
initial seqno
> > > as an argument?
> >=20
> > We could. What would that be useful for?
>=20
>=20
> On Mali, the hardware syncobj starts at 0. If you see a 0, is this the de=
fault
> state, or should you signal seqno 0?
>=20
> This problem goes away if we can have seqnos starting at a custom value, =
like
> 1. It seems like the C machinery also special-cases 0 in a few other plac=
es too.

ACK.

>=20
> >=20
> > Hm, no, we don't.
> >=20
> > For the most part that's irrelevant, since all critical components then
> > only get set in new_fence(). Correct typization is enforced through T.
> >=20
> > The notable exception is the fence_ctx reference itself.
> >=20
> > What should we do about it?
> >=20
> > We could keep the fctx field as a MaybeUninit and set it later. Or we
> > check through the fctx identifier number whether it's the correct one
> > in new_fence(), but then new_fence() could fail with some error, and
> > it's probably better to have it be completely fail-free.
>=20
> Agree about the fail-free part.
>=20
> The problem I see here is that new_fence() will use "seqno" and "nr" from
> whatever context called new_fence(), but DriverFenceAllocation has some o=
ther
> (possibly unrelated) context as its DriverFenceData::fctx.
>=20
> The lifetimes are apparently broken too, because 'a is the lifetime of th=
e
> context where new_fence_allocation was called, meaning that the context t=
hat
> actually called new_fence() can drop, even though it provided the state f=
or
> dma_fence_init().
>=20
> I guess this can be solved by moving new_fence() to impl DriverFenceAlloc=
ation?
> That already has a context, and most importantly, the right context.

Yes that is / was broken. Having the wrong fctx would cause wrong
container_of() calls and therefore explode.

Fixed it locally following your suggestion of creating fences on the
allocation object.

> >=20

[=E2=80=A6]

> > > > +
> > > > +/// The receiving counterpart of a [`DriverFence`], designed to re=
gister callbacks
> > > > +/// on, check the signalled state etc. A [`Fence`] cannot be signa=
lled.
> > > > +/// A [`Fence`] is always refcounted.
> > >=20
> > > I would explain this a tad better.
> >=20
> > What exactly? The refcounting? The dualism between DriverFence and
> > Fence? :)
>=20
> For example, you say =E2=80=9Ca Fence cannot be signaled=E2=80=9D. A pers=
on seeing this
> code for the first time might ask why. Specially if they start by reading=
 the
> docs for Fence first.
>=20
> I think explaining a bit more about the DriverFence/Fence/refcounting as =
you
> said is already enough to settle it.

OK, I flesh that out a bit.

> > >=20


[=E2=80=A6]

> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let ret =3D unsafe { bi=
ndings::dma_fence_is_signaled(fence) };
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // To guarantee that an=
 API caller can 100% rely on the signalling being
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // completed (i.e., all=
 fence callbacks ran), we have to take the lock.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // The reason is that t=
he C dma_fence backend currently does not carefully
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // synchronize the `dma=
_fence_is_signaled()` function with the proper
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // spinlock. This can l=
ead to the function returning `true` while fence
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // callbacks are still =
being executed. This can be mitigated by guarding
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // the entire function =
with the spinlock.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // See commit c8a5d5ea3=
ba6a.
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `fence` is v=
alid because `self` is valid. `flag_ptr` is
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // merely a pointer to =
an integer, which lives as long as this function.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { bindings::dma_=
fence_lock_irqsave(fence, flag_ptr) };
> > >=20
> > > Shouldn=E2=80=99t this be before the =E2=80=9Cis_signaled=E2=80=9D ff=
i call? Or is this
> > > only about ensuring all callbacks have run? i.e.: is =E2=80=9Cret=E2=
=80=9D valid even
> > > though it was computed before taking the lock?
> >=20
> > OK, this is where it gets ugly.
> >=20
> > So during the last weeks I've been struggling to get the C backend into
> > better shape. One issue from my POV is that the C dma_fence spinlock
> > does not protect the fence state; there is insistence that the lock
> > shall only protect the callback list.
> >=20
> > The function dma_fence_is_signaled() has an unlocked fast path check:
> >=20
> > https://elixir.bootlin.com/linux/v7.2-rc3/source/include/linux/dma-fenc=
e.h#L551
> >=20
> > whereas setting of that bit is done under lock-protection:
> >=20
> > https://elixir.bootlin.com/linux/v7.2-rc3/source/drivers/dma-buf/dma-fe=
nce.c#L362
> >=20
> >=20
> > This can lead to funny races like in the commit mentioned in the
> > comment block above (c8a5d5ea3ba6a).
> >=20
> > And it also leads to weird hacks like this:
> >=20
> > https://elixir.bootlin.com/linux/v7.2-rc3/source/drivers/gpu/drm/amd/am=
dgpu/amdgpu_vm.c#L2775
> >=20
> >=20
> > Now, in principle I agree with you that a pattern like this:
> >=20
> > dma_fence_lock_irqsave(=E2=80=A6);
> > let signaled =3D dma_fence_is_signaled_locked(=E2=80=A6);
> > dma_fence_unlock_irqrestore(=E2=80=A6);
> >=20
> > would be better.
> >=20
> > However, lengthy discussions with Christian seem to settle at the point
> > where Christian sees the very strict requirement of never calling fence
> > callbacks under lock protection, and where he views
> > dma_fence_is_signaled_locked() as a broken function that should be
> > removed.
> >=20
> > He's currently working on removing all bits where fence callbacks are
> > invoked under lock protection:
> >=20
> > https://lore.kernel.org/dri-devel/20260624122917.2483-1-christian.koeni=
g@amd.com/
> >=20
> > There's been a ton of discussions and proposals about that in recent
> > weeks
> >=20
> > https://lore.kernel.org/dri-devel/20260608142436.265820-2-phasta@kernel=
.org/
> > https://lore.kernel.org/dri-devel/20260612104251.2264707-2-phasta@kerne=
l.org/
> >=20
> >=20
> > So tl;dr: The weird code you're commenting on above ensures that
> >=20
> > a) the fence->ops->is_signaled() callback is not called under lock
> > protection and
> > b) taking and releasing the lock guarantees that all callbacks are
> > really finished, i.e. they have run.
> >=20
> >=20
> > (I continue to believe that setting the bit under lock protection and
> > reading it without lock is fundamentally broken and needs to be fixed,
> > but fixes are being rejected because of claimed performance regressions
> > years ago when this was tried, because checking the bit is some sort of
> > fast path check for.. parties that spin on dma_fence_is_signaled() ??)
>=20
> I see, there is a lot more context on this then. Can you merely add a com=
ment
> saying it=E2=80=99s ok to call dma_fence_is_signaled() without the locks?=
 Otherwise
> people might try to =E2=80=9Cfix=E2=80=9D this down the line...

I tried to make it clear with the comment above:

        // To guarantee that an API caller can 100% rely on the signalling =
being
        // completed (i.e., all fence callbacks ran), we have to take the l=
ock.
        //
        // The reason is that the C dma_fence backend currently does not ca=
refully
        // synchronize the `dma_fence_is_signaled()` function with the prop=
er
        // spinlock. This can lead to the function returning `true` while f=
ence
        // callbacks are still being executed. This can be mitigated by gua=
rding
        // the entire function with the spinlock.
        //
        // See commit c8a5d5ea3ba6a.


I can try to make it more explicit.

Actually, I suppose with our design in Rust we would not actually need
this lock-unlock, because we ensure that it does not matter whether a
callback already ran.

But since we don't know who will be working on this in 5 years, adding
this or that exotic callback, or maybe registering callbacks on his own
fence, I put this sequence there for robustness.

So if the function returns true, you really know that all callbacks are
gone forever.

>=20
> >=20
> > >=20
> > > >=20
> >=20
> > [=E2=80=A6]
> > >=20
> > >=20
> > > > +=C2=A0=C2=A0=C2=A0 /// The API user's data. This must either not n=
eed drop, or must delay its
> > > > +=C2=A0=C2=A0=C2=A0 /// drop by a grace period. It is essential tha=
t the data only performs
> > > > +=C2=A0=C2=A0=C2=A0 /// operations legal in atomic context in its [=
`Drop`] implementation.
> > > > +=C2=A0=C2=A0=C2=A0 #[pin]
> > > > +=C2=A0=C2=A0=C2=A0 data: T::FenceDataType,
> > > > +}
> > > > +
> > > >=20
> >=20
> > [=E2=80=A6]
> >=20
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // DriverFenceData is r=
epr(C) and a Fence is its first member.
> > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let fence_data_ptr =3D =
fence_ptr as *mut DriverFenceData<'a, T>;
> > >=20
> > > Without a =E2=80=9CCAST:=E2=80=9D keyword, I think this will trigger =
the linter?
> > >=20
> >=20
> > Didn't see a complaint from clippy nor compiler.
>=20
> I recommend the CAST thing anyways. It=E2=80=99s being adopted in other p=
arts of the kernel
> crate.

I can write a CAST comment, no problem.



Thx
P.
