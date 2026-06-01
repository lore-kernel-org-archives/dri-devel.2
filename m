Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8B7CD6E56
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 12:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA4531132D4;
	Mon,  1 Jun 2026 12:35:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="O2IPgqdG";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 122361132D4
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 12:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780317317;
 bh=eAUzv1oG+8VrLgTwvZZXP2w73GbBrRo2AMk8yHYYo/g=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=O2IPgqdGjYBmcd1L8ay8IHaSnv7qhvvdT4jKgED96lL0CeEuqzwa8UxulhBaEbEX1
 fwJ/W7WRpI+fOjAvM4T1OIM0hiBaO0H8aYaQwDmPbCYQkw8EakmamAibQFAsOCQAGO
 FXcT+19Mru1h8WCVU5Z9gBvC+vP2YBFiWhoV1cEsyn4CTB6XGoNU7sOLfmE6LJ/KF1
 Nal619P4ZV8I6dwW6ljfLyKXfKL1fXV2xHH/HbHh3SADwuMBKFq7EgM5NMKrOogfiL
 CwUVcGF0lIWCoYSmbNc4ApuPsPqiMuJcd/nlk6UTSMUJI6Zn4Xjux4dEblglX5QGTX
 eigc7sG8rcF5w==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 628E217E052F;
 Mon,  1 Jun 2026 14:35:16 +0200 (CEST)
Date: Mon, 1 Jun 2026 14:35:12 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Philipp Stanner <phasta@mailbox.org>
Cc: phasta@kernel.org, Alice Ryhl  <aliceryhl@google.com>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?UTF-8?B?QmrDtnJu?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich	 <dakr@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?UTF-8?B?S8O2bmln?=	 <christian.koenig@amd.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, Frederic Weisbecker	 <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, Uladzislau
 Rezki	 <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers	 <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, Daniel Almeida
 <daniel.almeida@collabora.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Igor Korotin <igor.korotin@linux.dev>,
 Lorenzo Stoakes	 <ljs@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 FUJITA Tomonori	 <fujita.tomonori@gmail.com>, Krishna Ketan Rai
 <prafulrai522@gmail.com>, Shankari Anand <shankari.ak0208@gmail.com>,
 manos@pitsidianak.is, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 rcu@vger.kernel.org
Subject: Re: [PATCH 3/4] rust: Add dma_fence abstractions
Message-ID: <20260601143512.2d9de9c2@fedora-2.home>
In-Reply-To: <df2daf200c9a69f497f4285074d2a95425b3dbdd.camel@mailbox.org>
References: <20260530143541.229628-2-phasta@kernel.org>
 <20260530143541.229628-5-phasta@kernel.org>
 <ah1glmXDM-OAKa5h@google.com>
 <20260601125933.17ca4dd5@fedora-2.home>
 <df2daf200c9a69f497f4285074d2a95425b3dbdd.camel@mailbox.org>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Mon, 01 Jun 2026 13:17:27 +0200
Philipp Stanner <phasta@mailbox.org> wrote:

> On Mon, 2026-06-01 at 12:59 +0200, Boris Brezillon wrote:
> > On Mon, 1 Jun 2026 10:36:06 +0000
> > Alice Ryhl <aliceryhl@google.com> wrote:
> >  =20
> > > > +};
> > > > +
> > > > +use bindings::ECANCELED;
> > > > +
> > > > +use kernel::str::CString;
> > > > +use kernel::sync::{
> > > > +=C2=A0=C2=A0=C2=A0 aref::{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARef,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AlwaysRefCounted, //
> > > > +=C2=A0=C2=A0=C2=A0 },
> > > > +=C2=A0=C2=A0=C2=A0 Arc,
> > > > +=C2=A0=C2=A0=C2=A0 ArcBorrow, //
> > > > +};
> > > > +
> > > > +/// VTable for dma_fence backend_ops callbacks.
> > > > +//
> > > > +// Mandatory dma_fence backend_ops are implemented implicitly thro=
ugh
> > > > +// [`FenceCtx`]. Additional ones shall get implemented on this tra=
it, which then
> > > > +// shall be demanded for the fence context data.
> > > > +pub trait FenceCtxOps {}=C2=A0  =20
> > >=20
> > > This empty trait is unused. =20
> >=20
> > I had initially suggested to add the F type (AKA FenceData) passed
> > around in multiple places type as an associated type
> >=20
> > pub trait FenceCtxOps {
> > =C2=A0=C2=A0 type FenceData: Send + Sync;
> > }
> >=20
> > so we don't have to pass both F and C. The reasoning here is that:
> >=20
> > 1. We expect we'll have to define more methods to the FenceCtxOps trait
> > at some point, so adding it now kinda makes sense.
> >=20
> > 2. In the current design, we've assumed that a Fence can't live/be
> > created outside of a given context, so there's no world where the
> > FenceData wouldn't be known by the FenceCtx implementation, and forcing
> > users to pass F and C around seems needlessly verbose. =20
>=20
> I had investigated that, but found that this causes us to write things
> like
>=20
> DriverFence<T> (where T is the FencCtx generic)
>=20
> and then in the actual implementation use
>=20
> T::FenceData
>=20
> which reads very weird IMO. Because now for reasons a fence's own data
> are not referred to in its own implementation, but you derive it from
> the context.

Well, I actually think that's a good thing, because DriverFence and
FenceCtx are tightly related: FenceCtx<F, C> instantiates and manages
DriverFence<F, C> fences, and DriverFenceData<F, C> has an Arc to a
FenceCtx<F, C>.

>=20
> I do prefer it in a way where the DriverFence generic does appear in
> said fence's actual code, on equal rank with the FenceCtx.

Question is, can you really have random <F, C> combination or is C
dictating which F you'll get attached to the DriverFence? If a given
context can't handle more than one type of fence, I don't really see the
point of passing both around when one could be directly derived from the
other, and since the trait we consider defining for the future is on the
FenceCtx (FenceCtxOps), it makes sense to have FenceData defined as an
associated type of FenceCtx.

>=20
> I suppose that is actually one use case for which PhantomData does
> exist.

Yeah, I don't, it just feels weird to pass both around, and it doesn't
seem to match what we've been doing in other places (drm::Driver,
drm::Object, ...).
