Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFFAC5DF87
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 10:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7C9210E801;
	Wed, 19 Aug 2026 10:49:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m/rN8o/F";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1292710E801;
 Wed, 19 Aug 2026 10:49:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C13004362A;
 Wed, 19 Aug 2026 10:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE3D1F000E9;
 Wed, 19 Aug 2026 10:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787136558;
 bh=zQEfCl7xKtaCC78VIxZhzOSbdkzpLQaDYkBz+b+0oOI=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=m/rN8o/F9l7+jStt/C2McbVvIk/y0RPYIV/dxNC82qKtn7BUlie0m4HFlHeNJs7/x
 eHUoJ/yk4p3P08IhjMOZ9LhQLVitMytRBtXHrG0rmLPm4R8HblsKsEM7zLlv/JTxoy
 e0o5itCDVjt/xUSnKlDUsi6cLjYplRfZr7AZ6DqoE9L3O+k7cuLfWBwwbtRuXAo//N
 YsGbcrd4gz7WFtBwmw6G5+XWqkqBpne9kjsISHb47g6NKkRXzxWxsMhnSkuPx4k6Hd
 4aYF/NPA5Ay6HBSGmFIup9UAt8L7rxy3g+rgtCdOmdWNvoJDfK3sUKgVn6aEbf/okY
 fnYVzjtyKJpMQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Aug 2026 12:49:12 +0200
Message-Id: <DKSV1A4SL7PX.2EM92OHEQHA9@kernel.org>
Cc: "Gary Guo" <gary@garyguo.net>, "Lorenzo Stoakes" <ljs@kernel.org>,
 "Vlastimil Babka" <vbabka@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
To: "Eliot Courtney" <ecourtney@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 1/6] rust: alloc: add Vec::push_init
References: <20260817-b4-nvkv-v1-0-b84db5e84b67@nvidia.com>
 <20260817-b4-nvkv-v1-1-b84db5e84b67@nvidia.com>
 <DKR9WJY3WI0F.1FV4PD1J17ZFD@garyguo.net>
 <DKSR2WF91FL0.78WHY1E7WIX9@nvidia.com>
In-Reply-To: <DKSR2WF91FL0.78WHY1E7WIX9@nvidia.com>
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

On Wed Aug 19, 2026 at 9:43 AM CEST, Eliot Courtney wrote:
> There's also some locations in other code that could use a VecView direct=
ly
> instead of taking a &mut Vec etc. Having a Vec-like thing that's guarante=
ed not
> to allocate also sounds potentially useful to me w.r.t. safety for contex=
ts
> where you can't allocate/sleep.

Allocation in atomic context is still possible as long as we avoid memory
reclaim, e.g. with GFP_ATOMIC. However, this should generally be avoided, p=
lus
there are also cases in non-atomic context where we can't have memory recla=
im,
such as the DMA fence signaling critical section. So, I think this can a be=
 a
useful API.

> If you think this approach is ok I can send it as a separate series. Code=
gen
> appears fine practically speaking AFAICT.

I think this is orthogonal from what you need in this series; also remember=
 that
we need a user with real need for an API before we can introduce it.

It might have a use-case in DRM Jobqueue, where it could be used to handle
pre-allocation for ring buffer slots of jobs before entering the DMA fence
signaling critical section. However, I'm not convinced that Vec or a VecDeq=
ue
like type is the best solution for DRM Jobqueue in the first place.

> pub type Zero =3D ();
> pub type Succ<N> =3D (N,);
> pub type One =3D Succ<Zero>;
> pub type Two =3D Succ<One>;

That can produce annoying error messages, but without const generic expr it=
 is
what it is.

> // Infallible (except for Init) push. `Zero` spare VecView has the fallib=
le version.
> impl<'a, T, N: Count> VecView<'a, T, Succ<N>> {
>     pub fn push<E>(self, init: impl Init<T, E>) -> Result<VecView<'a, T, =
N>, E> {

We still want push() taking impl Init<T> and try_push() taking impl Init<T,=
 E>,
so we get rid of the Result for impl Init<T, Infallible>.

> // Fallible but not allocating ops (can run out of space).
> impl<'a, T> VecView<'a, T> {
>     pub fn push<I: Init<T, E>, E>(&mut self, init: I) -> Result<(), PushI=
nitError<I, E>> {
>         if *self.len =3D=3D self.cap {
>             return Err(PushInitError::Full(init));
>         }
>
>         unsafe { init.__init(self.buf.as_ptr().add(*self.len)) }.map_err(=
PushInitError::Init)?;
>         *self.len +=3D 1;
>
>         Ok(())
>     }
>
>     // Bodies as in the current KVec implementations.

We'd still need forwarding functions on Vec, so we don't force users to go
through view().

>     pub fn pop(&mut self) -> Option<T> { ... }
>     pub fn insert(&mut self, index: usize, element: T) -> Result<(), Inse=
rtError<T>> { ... }
>     pub fn remove(&mut self, i: usize) -> Result<T, RemoveError> { ... }
>     pub fn truncate(&mut self, len: usize) { ... }
>     pub fn retain(&mut self, f: impl FnMut(&mut T) -> bool) { ... }
>     pub fn drain_all(self) -> DrainAll<'a, T> { ... }
>     pub fn len(&self) -> usize { ... }
>     pub fn as_slice(&self) -> &[T] { ... }
>     pub fn as_mut_slice(&mut self) -> &mut [T] { ... }
>     pub fn spare_capacity(&self) -> usize { ... }
>     pub fn spare_capacity_mut(&mut self) -> &mut [MaybeUninit<T>] { ... }
>     pub unsafe fn commit(&mut self, additional: usize) { ... }
> }
