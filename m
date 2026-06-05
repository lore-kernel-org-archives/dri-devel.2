Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AE8CD8C8B
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 07:19:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62802112D6A;
	Sat,  6 Jun 2026 07:19:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SK321UkH";
	dkim-atps=neutral
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com
 [209.85.221.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB71011A956
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 15:52:00 +0000 (UTC)
Received: by mail-vk1-f172.google.com with SMTP id
 71dfb90a1353d-59b074ec7ceso630142e0c.1
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 08:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780674720; x=1781279520; darn=lists.freedesktop.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8nGKygQkHUwQC80rJNI9ybnw4Obautm/GK0xUhE4dko=;
 b=SK321UkHehir4NwjIeLCVPXCcMevObaQn0qoVdDXOLvPgX5G5VLYC0JWLs9drso4fV
 duj5HHyFruQjmrjcBdeT4YMlpIFA67ajDs7yQLlEAbFpbyfPhngz7GQny3TR/Rk7cJEs
 6zHuupqvZbUfKH7Oo+azgwLTlO+gSDETWdqiJjY8FwTBoG+wGzxc8sV9rfBt81FFtBWz
 ZbJA+3C0YNROdFfF7Ng7w7kpWxiJBMUOT5Erq17bws3HNsKgq+YbUHt0C2QLivLNIANX
 FaP8jlv5VqAa7jisYx7NnARptgoCL83ZSsgl1ZO396mfskhFFjKx9UKzTppkKThgQkqF
 hsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780674720; x=1781279520;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8nGKygQkHUwQC80rJNI9ybnw4Obautm/GK0xUhE4dko=;
 b=fpp5Cp+gaGeo8Mi9xnCcL0fK2iCSlFkROTwK5klzdCYbEGQ3+Zg3X/4YK4dUKKyP2P
 SqHKongg2X+FktMwF0CFATN2V+WhQ84uVRr9BuII3JAElDkKbIpXfZMPOhWwhZ6Lrgkq
 lNJZLITGjare+jdMPL9rOWAPaGSDTe25UrEyUaLrlJ/q5rk5OCzIohsVZXFUzW09Yb22
 QlVXGIW1qpMSWmYD6BD28+PfAO5NCUkoNTlHmUTQkDL9u/2Zbt2tH3ZSlJT1FAF3Fcpw
 V2ge50XDqCVkPAafpBbP5Rm7UAhxz8pP3SSLmF92Pr8l5NldQ3ZX6xTFcbEYT4S/6xk3
 5DFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+6gHPJ2aPosr2OUAnuEZWeNUMu62dRoLU+9bFeKMwKNgTNInadBGRmv97msTOdxDRCPMS5/E5X3UQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyla8NzR4VPxaVR8toJimNfcZw/BE8IIGI4/3002e5JCKKaR6HP
 XIPFk8L8H0EhrQn2p71TdYHrZyhmHleFmaKi/YIHqHxpuXc2MkOoQ8eN
X-Gm-Gg: Acq92OEr93KDrJ3DFjD7lUkmR8QXB25CUApKo8z7tMaF2zNNXbhRoX7HTJ0fhPqwBZ8
 J8LTPpdZ130n8o4wQKOl6Tjx8yL+G7bJdz8UrlFfHwIpaQDzx4kx+/ODEBZejcXkqJWRjqibaEn
 B7pZgywrq8LiJ6ajOZuVrnSITJb9XSiO0ZtIxyAByLtkJBRKRVZCsGUbkWYrgZSIlViAkrkt9V7
 9kuWQDLNcgc+b9TFNqyWneqkX8Z3L/Hq+v0mX28ZOCk11oCWGrcA4GpWSKtRZy90lWtBbCJd/6A
 zxewNV0UaYYUSx24qFMNmvF03OG7I/VvRux44WWn/DhtdCUXKjAsKY7P9bLkDtYztdTy3EvfqLF
 ZhVnpArwMCvPb9weDx4R4nKn9D7Ul2aDTDG9UnE9SssV3RTOn083XtbFLwsie7IFRg8yT+E5TNZ
 XyVkSkEh8N4LaOLjvrLWtJdNmQyhcA5NMvkwJO/wUIhSXIQmDsawsvSbJKWz34lGm4DLAtnno=
X-Received: by 2002:a05:6122:20a2:b0:59e:b127:fc6f with SMTP id
 71dfb90a1353d-5ac53c944c8mr2226236e0c.2.1780674719617; 
 Fri, 05 Jun 2026 08:51:59 -0700 (PDT)
Received: from smtpclient.apple ([2804:7f1:c241:abe4:8c1d:3d1b:d7cb:e7e9])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-96414115a93sm7095512241.9.2026.06.05.08.51.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jun 2026 08:51:59 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 3/4] rust: Add dma_fence abstractions
From: Daniel Almeida <dwlsalmeida@gmail.com>
In-Reply-To: <20260604101552.4232733b@fedora-2.home>
Date: Fri, 5 Jun 2026 12:51:35 -0300
Cc: Philipp Stanner <phasta@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
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
Message-Id: <82F71A28-076F-4100-A702-840018937D1B@gmail.com>
References: <20260530143541.229628-2-phasta@kernel.org>
 <20260530143541.229628-5-phasta@kernel.org>
 <4F8E8E04-5AB5-4E6B-9194-5FC467E2313F@collabora.com>
 <20260603191405.4c75badb@fedora-2.home>
 <09096455-BA79-4E61-AD88-44DA57C5BEA8@gmail.com>
 <20260604101552.4232733b@fedora-2.home>
To: Boris Brezillon <boris.brezillon@collabora.com>
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


>>=20
>>>>=20
>>>> Consider a fence design where signal() consumes self. Now consider =
this:
>>>>=20
>>>> ```
>>>> impl FenceCb for MyCallback {
>>>> fn called(&mut self) {
>>>>  // Can't move the fence out, so we have to put an Option<T> just =
to be able
>>>>  // to move.
>>>>  if let Some(f) =3D self.some_fence.take() {
>>>>    f.signal();
>>>>  }
>>>> }
>>>> ```
>>>>=20
>>>> This used to be the case when our version of the job queue used the =
"proxy
>>>> fence" design:
>>>>=20
>>>>=20
>>>> ```
>>>> // Callback on the hw fence
>>>> impl FenceCb for MyCallback {
>>>> fn called(&mut self) {
>>>>  if let Some(f) =3D self.submit_fence.take() {
>>>>    f.signal();
>>>>  } =20
>>>=20
>>> I'm pretty sure lockdep won't like it anyway, because this is nested
>>> locking of the same lock class. For such proxies, we'll need to =
teach
>>> lockdep about the nesting like has been recently done on
>>> dma_fence_array & co. But I'm digressing. =20
>>=20
>> Yeah, but this is more about resource transfer in general, not
>> this pattern specifically.
>>=20
>> I agree that this has issues, and yes, lockdep complained back
>> then :)
>=20
> The thing is, there's so many aspects that could go wrong because of =
the
> context this callback is called in. Nested locking is one of them,
> the fact we can't sleep is another. And with rust it's even worse,
> because of the implicit drops that will happen when you take ownership
> of resources (taking sleeping locks to remove resources from a dataset
> for instance).
>=20
> So, by passing self by value to the ::callback(), you're basically
> telling users "hey, BTW, don't forget to defer the drop to some
> workqueue if you think it's not atomic-safe". And how can users know
> that the thing they're about to drop can be dropped in atomic context?


Can=E2=80=99t we create a token type that signals we=E2=80=99re in =
atomic context? If
we pass this token type as an argument, perhaps lockdep can check it for =
us?

Perhaps

enum SomeFancyName {
  Atomic(AtomicToken)
  NotAtomic,
}

signaled(self, atomic: AtomicToken) {
  ..
}

> They basically have to audit the ::drop() of all the resources they
> embed in their type implementing FenceCb. Not only that, but they also
> have to design the thing so the deferral of this ::drop() doesn't
> allocate, because, obviously, allocating in atomic context is
> tricky/fallible. AFAIK, none of this can be spot at compile-time (I
> remember Gary/Danilo mentioning that we could teach the klint about
> some of these rules). This would leave us with runtime checks like
> might_sleep(), but most of the C putters (xxx_put(object)) don't have
> might_sleep() in the path where the decref doesn't lead to a refcnt=3D0
> situation.
>=20
> TLDR; Call this PTSD if you want, but this is the sort of bugs I
> struggled with on the C side, and I can predict that the exact same
> will happen in rust drivers if we expose the FenceCb as it is designed
> here and we don't have a way to check the soundness of the FenceCb
> implementations at compile time.
>=20
> The other option (the one I've been advocating for from the start), is
> to not let drivers implement FenceCb (make it private), but instead
> have a bunch of implementations that we know are safe. Here's a list =
of
> implementations that I think would unblock most of the drivers use
> cases:
>=20
> - wakeup a thread
> - complete a completion object
> - schedule a WorkItem
> - schedule a kthread_worker (once we get a proper rust abstraction for
>  that)

This can also work too, I guess.

>=20
> It doesn't mean we can't have optimized FenceCb implementations that =
do
> a lot more in the callback() path instead of deferring to a
> workqueue/thread, but at least those would have to be implemented in
> dma_fence.rs, and the dma_fence.rs maintainers can then carefully =
audit
> the code as part of the review process, which we know is not really =
the
> case when changes touch drivers code only.
>=20
> FWIW, I think the FenceProxy design you were describing falls into
> this "must be carefully audited" bucket, and should be implemented in
> dma_fence.rs.
>=20
>>=20
>>>=20
>>>> }
>>>> ```
>>>>=20
>>>> Although this is not the case anymore, since we phased out this =
design given
>>>> Christian's recent work. Still, we should ideally not require =
Option<T> here in
>>>> general just to make resource transfer possible. =20
>>>=20
>>> I see. OTOH, don't we need to make this inner data movable if we =
want
>>> to cancel the FenceCb before the fence is signaled anyway? And =
that's
>>> most certainly a case we have in the teardown path. =20
>>=20
>> Can you expand a bit on what you mean here?
>=20
> Never mind, I was confusing two different iterations of the code here.
> I thought the Option<T> you were mentioning was in
> FenceCbRegistration<T>, with some explicit ::cancel() function that
> would return Option<T> so the user can get its resources back when it
> cancels the registration, and also know whether the callback was =
called
> or not. But this is all gone now, and all we can do is drop the
> registration, which will automatically drop the inner T.


