Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E9BCD6E56
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 10:13:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83B19113144;
	Mon,  1 Jun 2026 10:13:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Pd8ZT5BK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F75A113144
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 10:13:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 59E0743E36;
 Mon,  1 Jun 2026 10:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425C21F00893;
 Mon,  1 Jun 2026 10:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780308827;
 bh=3Ts6lB+NKnhLtXYHmT257yvnWMD6Ph1yqe+TlwPK+oM=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=Pd8ZT5BK2RvzgTUlsXOQVBEiMwZGkMyUoMd8Lx5ODzTdFIWZswBajI/tODyqROqWT
 to5Yfm2ruJGsFd7Aaqg5YI78s6jRh8vdyPShR3BzPDi0KAtBFul22aTc8Gw2fRrPyU
 415n2lb7D2q/yed7aDWBBAXuFXxW8frBXPM1v6tiAg9tphhbwFI8zO4a0Z8dtR2zDI
 vsoh7J7e32jR6yQKssPu7IRwWXZNZ3yCtIwpB4nto02HbgaYuXtIWLC5SNmvl/u1eu
 Nw//bc5n+3e3w5IED5m33qGD9XEW0gruuh669lKpNd15WbUaIAG0a70JOKA5dT7gd8
 VGaNX/Kx7TrDg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 12:13:38 +0200
Message-Id: <DIXMT0KKU8D9.2XLDHIGBCM1PZ@kernel.org>
Subject: Re: [PATCH 3/4] rust: Add dma_fence abstractions
Cc: <phasta@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Sumit
 Semwal" <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 "Frederic Weisbecker" <frederic@kernel.org>, "Neeraj Upadhyay"
 <neeraj.upadhyay@kernel.org>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Josh Triplett" <josh@joshtriplett.org>, "Uladzislau Rezki"
 <urezki@gmail.com>, "Steven Rostedt" <rostedt@goodmis.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, "Lai Jiangshan"
 <jiangshanlai@gmail.com>, "Zqiang" <qiang.zhang@linux.dev>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Igor Korotin" <igor.korotin@linux.dev>,
 "Lorenzo Stoakes" <ljs@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "FUJITA Tomonori" <fujita.tomonori@gmail.com>,
 "Krishna Ketan Rai" <prafulrai522@gmail.com>, "Shankari Anand"
 <shankari.ak0208@gmail.com>, <manos@pitsidianak.is>, "Boris Brezillon"
 <boris.brezillon@collabora.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-media@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>,
 <rcu@vger.kernel.org>
To: "Philipp Stanner" <phasta@mailbox.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260530143541.229628-2-phasta@kernel.org>
 <20260530143541.229628-5-phasta@kernel.org>
 <DIW3ZK5NLKU3.1QYMQB0ISHFBG@kernel.org>
 <08b87b07279e7774c76c0267b1d6c337f705acda.camel@mailbox.org>
In-Reply-To: <08b87b07279e7774c76c0267b1d6c337f705acda.camel@mailbox.org>
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

On Mon Jun 1, 2026 at 10:46 AM CEST, Philipp Stanner wrote:
> On Sat, 2026-05-30 at 17:16 +0200, Danilo Krummrich wrote:
>> (Not a full review, but a few drive-by comments.)
>>=20
>> On Sat May 30, 2026 at 4:35 PM CEST, Philipp Stanner wrote:
>> > +#[allow(unused_unsafe)]
>>=20
>> What is this needed for?
>
> You know that :-P

I don't, it's a serious question.

>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Once a `DriverF=
ence` is initialized, the inner `fence` is
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // valid and initialized. =
It is valid until the refcount drops
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // to 0, which can earlies=
t happen once the `DriverFence` has been dropped.
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe {
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bi=
ndings::dma_fence_lock_irqsave(fence, flag_ptr);
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 !bindings::dma_fence_is_signaled_locked(fence) {
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if let Err(err) =3D res {
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bindings::dma_fence_set_error=
(fence, err.to_errno());
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bindings::dma_fence_signal_locked(fence);
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bi=
ndings::dma_fence_unlock_irqrestore(fence, flag_ptr);
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>=20
>> Please use a single unsafe block per unsafe function call, here and in a=
 few
>> other places.
>
> Is that an official rule? If so, the linters should inform about it.
>
> At first glance, I don't see any advantage to it and the disadvantage
> of greatly reducing readability.

The advantage is that it separates the safety justifications per unsafe cal=
l,
which increases the chances of catching a bug, makes it easier for the read=
er to
match requirements against justifications and potentially allows tooling to
perform checks of the justification against the requirement.

For the specific case above, there's no documented requirements in the sens=
e of
Rust safety requirements of course, as they are all FFI calls, but
dma_fence_signal_locked() for instance has the obvious requirement that it =
must
only be called with the fence lock held and dma_fence_set_error() must only=
 be
called when the fence is actually signaled.

Besides that, since this pattern seems to occur at least twice, you could a=
lso
consider adding a lock guard.
