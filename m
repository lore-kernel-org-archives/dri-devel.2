Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98D7CD8C85
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 07:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87B52112D5E;
	Sat,  6 Jun 2026 07:19:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IigRaZgJ";
	dkim-atps=neutral
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com
 [209.85.221.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B00B10E1A8
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 16:01:00 +0000 (UTC)
Received: by mail-vk1-f173.google.com with SMTP id
 71dfb90a1353d-59ebf30a91dso773621e0c.1
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 09:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780675259; x=1781280059; darn=lists.freedesktop.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VyQyGkRUe5VvjYqInQnqi8SySL6a23ZU66H1yfN16R0=;
 b=IigRaZgJCridhiP0RVB8LqFXpiLCVPX8L57TRGPz+/fV62e4xJDAzBI7lb4XegtpKZ
 uQGvDsG8VpiDX2cWtVrtOyL47ihRK/X+qkkjOF7z5CbhnDssj6y4TWCApKhXB41jsNiX
 QSuKU+5aRwIFKhiA9gWpUzi7szFAGbOfrBcLM0sP6d4VaNksyUNrnp90h0P90t/bnqsJ
 4IClfuWoVx8oVicGKGRU0qWNXNe2RsCXV8OC6w48JuFoC7SZCMo8Djjb3kXuRtWjczBh
 QUPq2hOLVl4xUUehUo5oaBQgfdTx85ShS+tikjuYZ1lTonNZ0uaMsPyX3VA1KZiFzWxu
 dTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780675259; x=1781280059;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VyQyGkRUe5VvjYqInQnqi8SySL6a23ZU66H1yfN16R0=;
 b=RbWYkt2Z4Cv9cIunJIgu1xtbHTwi2QBhAMsRtxNAUfxo7qKtbXtiGQ2n45PA5DHSLs
 RjcVsHxj4gPGwtwPx59MQn0xFVfWPfm9bGiax21w/Lrc3MLbNVPy7X7V97Yd0+yryecK
 gEHbH84gu7uGey09XQYo8Gs1r7e0ioiB3WkyZdcTysD6/QrQ6G1cryz74YeYW+Xi7t8V
 +m7/qLbHSr4et7uD4bZ8S8PK0UNA5BUu73wD8JKyOR4lh/qtkGDmXAYHjReCxVo3/VLZ
 aXz3Dmivpf8af8Z3b+RMm3OhqzEQkq3+Ts7MYPR+SR8t+t0bmbsWALrI2Nkmd3u8ANmH
 +ZxA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+248sSHQ1L18Dfwgc++L0ZadrqW8QYL+qfdHhGUDFhbwAZ0yQm+hevoXApHuiXCsU1Ye9fBMnTGFY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzOKcPUNhOtcV10LFKVaelXiuruFx4kO5mM95fBHNx/WVL87skl
 m85EWIz3FhoVbWR+ODPLnpP+yHfIazgdgdi38QlvMxhVpRNbUvld63Dp
X-Gm-Gg: Acq92OG9IBoMFxiJuhq5or9ZOKWBLJWAonlvGQ0kL1iHqJPs/XnohqHx0xM5bPOHmCn
 8Xw+LfjJyRBwAILrmeFiMn/nROYsqw7KOhi267vJqS8uRjZhOq0BB+76YjxOOyHveES6DFFsACQ
 c/1HP6RCDJGGCXB/SGMJWoEwB990QEev0F7N3e2OV3Do9A8WbFvsgSLroB/hl5HeJAUEKrnxVAW
 uJ1Remrkb5mk2IP6OrPrhvGiUaORLV/rdzWy5oUz33MhezrRSGoFN5dgk9NLGUUmIjmcDNzQV8S
 7RymJYhfVCDdAxTReUEIlOmv5+nZcnjD0UwNEuzk6lvo9RTvPYymB0IoMi2kJtoRpP267At7KLB
 set7Jj6dfcRQs4Oqyw+e5T2EQ6dykN/lmXTK9/y63gz+BIXJ84TbMAw26KnTm8TwPbRs1B6EAhU
 BUyL1iND2/BQCT3Ri+P13UDfmit7XQ4OorBSDeowQcdjWncwnUx0ES5I8smOVQ
X-Received: by 2002:a05:6122:54a:b0:5a1:edab:f216 with SMTP id
 71dfb90a1353d-5ac5197b908mr2700846e0c.11.1780675257631; 
 Fri, 05 Jun 2026 09:00:57 -0700 (PDT)
Received: from smtpclient.apple ([2804:7f1:c241:abe4:8c1d:3d1b:d7cb:e7e9])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5a6d6fb9ca0sm9109916e0c.6.2026.06.05.09.00.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jun 2026 09:00:57 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 3/4] rust: Add dma_fence abstractions
From: Daniel Almeida <dwlsalmeida@gmail.com>
In-Reply-To: <8ff2de94a50ed077a4cfe520a081f2b8b438a375.camel@mailbox.org>
Date: Fri, 5 Jun 2026 13:00:35 -0300
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Igor Korotin <igor.korotin@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Krishna Ketan Rai <prafulrai522@gmail.com>,
 Shankari Anand <shankari.ak0208@gmail.com>, manos@pitsidianak.is,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, rcu@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FEFE0522-FD7A-40DE-8B2A-09FE2F33F327@gmail.com>
References: <20260530143541.229628-2-phasta@kernel.org>
 <20260530143541.229628-5-phasta@kernel.org>
 <4F8E8E04-5AB5-4E6B-9194-5FC467E2313F@collabora.com>
 <20260603191405.4c75badb@fedora-2.home>
 <09096455-BA79-4E61-AD88-44DA57C5BEA8@gmail.com>
 <20260604101552.4232733b@fedora-2.home>
 <8ff2de94a50ed077a4cfe520a081f2b8b438a375.camel@mailbox.org>
To: phasta@kernel.org
X-Mailer: Apple Mail (2.3826.700.81)
X-Mailman-Approved-At: Sat, 06 Jun 2026 07:19:14 +0000
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



> On 5 Jun 2026, at 04:56, Philipp Stanner <phasta@mailbox.org> wrote:
>=20
> On Thu, 2026-06-04 at 10:15 +0200, Boris Brezillon wrote:
>> On Wed, 3 Jun 2026 21:43:05 -0300
>> Daniel Almeida <dwlsalmeida@gmail.com> wrote:
>>=20
>>>> On 3 Jun 2026, at 14:14, Boris Brezillon =
<boris.brezillon@collabora.com> wrote:
>>>>=20
>>>> On Wed, 3 Jun 2026 13:41:02 -0300
>>>> Daniel Almeida <dwlsalmeida@gmail.com> wrote:
>>>>  =20
>>>>>> +    /// Called when the fence is signaled.
>>>>>> +    ///
>>>>>> +    /// This is called from the fence signaling path, which may =
be in interrupt
>>>>>> +    /// context or with locks held, which is why `self` is only =
borrowed, so that
>>>>>> +    /// it cannot drop. Implementations must not sleep or =
perform
>>>>>> +    /// long-running operations.
>>>>>> +    ///
>>>>>> +    /// An implementation likely wants to inform itself (e.g., =
through a work item)
>>>>>> +    /// within this callback that the associated =
[`FenceCbRegistration`] can now be
>>>>>> +    /// dropped.
>>>>>> +    fn called(&mut self);   =20
>>>>>=20
>>>>> This is a central point. We ideally would want this to consume =
self, because we
>>>>> may want to move things out of the callback.   =20
>>>>=20
>>>> This one comes from me. The rationale being that ::called() is =
called
>>>> from an atomic context, and the resources attached to the callback =
data
>>>> might require acquiring other sleeping locks to be released, and
>>>> sometimes you don't even notice immediately because said resources =
are
>>>> refcounted, and the lock is only acquired when you happen to be the
>>>> last owner. Yes, those can be caught at runtime if the C side is
>>>> properly annotated with might_sleep(), but that's not always the =
case.
>>>>=20
>>>> If we defer the drop of the data only when the FenceCb is
>>>> dropped/recycled, we're at least not constrained by this "runs in
>>>> atomic context" thing.
>>>>  =20
>>>=20
>>> This design does not solve it, because one can quite trivially get =
around this
>>> restriction using Option<T> as I said. If your point is =E2=80=9Cdon=E2=
=80=99t run any drop() here=E2=80=9D,
>>> then &mut self doesn=E2=80=99t do it.
>>=20
>> My bad, I thought you were talking about some Option<T> in
>> FenceCbRegistration<T> (there was one at some point, but it's gone =
now),
>> but you're talking about having an Option<X> inside the T. Yes, =
there's
>> indeed nothing preventing a drop on X in that path, and it's just as
>> bad as passing the fence back as value to the callback in that case.
>=20
> Then maybe we should just pass it by value and require implementation
> of an unsafe trait on `T`, whose safety-requirements demand that this
> must be save to drop from atomic context.
>=20
>>=20
>>>=20
>>>>>=20
>>>>> Consider a fence design where signal() consumes self. Now consider =
this:
>>>>>=20
>>>>> ```
>>>>> impl FenceCb for MyCallback {
>>>>> fn called(&mut self) {
>>>>>   // Can't move the fence out, so we have to put an Option<T> just =
to be able
>>>>>   // to move.
>>>>>   if let Some(f) =3D self.some_fence.take() {
>>>>>     f.signal();
>>>>>   }
>>>>> }
>>>>> ```
>>>>>=20
>>>>> This used to be the case when our version of the job queue used =
the "proxy
>>>>> fence" design:
>>>>>=20
>>>>>=20
>>>>> ```
>>>>> // Callback on the hw fence
>>>>> impl FenceCb for MyCallback {
>>>>> fn called(&mut self) {
>>>>>   if let Some(f) =3D self.submit_fence.take() {
>>>>>     f.signal();
>>>>>   } =20
>>>>=20
>>>> I'm pretty sure lockdep won't like it anyway, because this is =
nested
>>>> locking of the same lock class. For such proxies, we'll need to =
teach
>>>> lockdep about the nesting like has been recently done on
>>>> dma_fence_array & co. But I'm digressing. =20
>>>=20
>>> Yeah, but this is more about resource transfer in general, not
>>> this pattern specifically.
>>>=20
>>> I agree that this has issues, and yes, lockdep complained back
>>> then :)
>>=20
>> The thing is, there's so many aspects that could go wrong because of =
the
>> context this callback is called in. Nested locking is one of them,
>> the fact we can't sleep is another. And with rust it's even worse,
>> because of the implicit drops that will happen when you take =
ownership
>> of resources (taking sleeping locks to remove resources from a =
dataset
>> for instance).
>=20
> Doesn't that have to be a problem for much of Rust infrastructure? How
> do other parties solve that?
>=20
>>=20
>> So, by passing self by value to the ::callback(), you're basically
>> telling users "hey, BTW, don't forget to defer the drop to some
>> workqueue if you think it's not atomic-safe". And how can users know
>> that the thing they're about to drop can be dropped in atomic =
context?
>> They basically have to audit the ::drop() of all the resources they
>> embed in their type implementing FenceCb. Not only that, but they =
also
>> have to design the thing so the deferral of this ::drop() doesn't
>> allocate, because, obviously, allocating in atomic context is
>> tricky/fallible. AFAIK, none of this can be spot at compile-time (I
>> remember Gary/Danilo mentioning that we could teach the klint about
>> some of these rules). This would leave us with runtime checks like
>> might_sleep(), but most of the C putters (xxx_put(object)) don't have
>> might_sleep() in the path where the decref doesn't lead to a refcnt=3D0=

>> situation.
>>=20
>> TLDR; Call this PTSD if you want, but this is the sort of bugs I
>> struggled with on the C side, and I can predict that the exact same
>> will happen in rust drivers if we expose the FenceCb as it is =
designed
>> here and we don't have a way to check the soundness of the FenceCb
>> implementations at compile time.
>=20
> My guess would be that the existence of unsafe-traits is the admission
> of Rust that this just cannot be guaranteed by design.
>=20
> If a driver cannot know whether this or that is safe to drop, then it
> would have to defer it's dropping. Or would there be cases where this
> also doesn't work?


Although I totally understand where Boris is coming from here, and I =
agree with
him, the reality is that the current &mut self design doesn=E2=80=99t =
solve this. An
unsafe trait could work as a pinky-promise by drivers, which is half-way =
there.

What we ideally would like to have is a bound though, something like:

T: !Drop

If I recall correctly there were people working to get support for that =
on
Rust? I think there are two things here: !Trait, which is not supported =
except
for !Sized IIRC, and having an auto trait that represents types that =
implement
Drop, similar to Send and Sync.


>=20
>>=20
>> The other option (the one I've been advocating for from the start), =
is
>> to not let drivers implement FenceCb (make it private), but instead
>> have a bunch of implementations that we know are safe. Here's a list =
of
>> implementations that I think would unblock most of the drivers use
>> cases:
>>=20
>> - wakeup a thread
>> - complete a completion object
>> - schedule a WorkItem
>> - schedule a kthread_worker (once we get a proper rust abstraction =
for
>>   that)
>>=20
>> It doesn't mean we can't have optimized FenceCb implementations that =
do
>> a lot more in the callback() path instead of deferring to a
>> workqueue/thread, but at least those would have to be implemented in
>> dma_fence.rs, and the dma_fence.rs maintainers can then carefully =
audit
>> the code as part of the review process, which we know is not really =
the
>> case when changes touch drivers code only.
>=20
> Pragmatically speaking, if the common cases are trivial, then the
> drivers will get them right, because those critical primitives are
> already atomic-safe.

No, you can still fumble trivial code, specially when it has to be =
cargo-culted
from somewhere else. =20

I am not saying that having things in dma_fence . rs is the solution, =
although
it is definitely one solution. But the argument above isn=E2=80=99t very =
strong
IMHO.

>=20
> And a non-common case will have to be implemented in the driver
> anyways, so we'd have to allow for that.
>=20
>=20
>=20
> P.


