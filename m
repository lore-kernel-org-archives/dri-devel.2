Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17D3CD6E56
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:17:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 522301131FA;
	Mon,  1 Jun 2026 11:17:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cPbFnAeS";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8D771131FA
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 11:17:43 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gTWdw0pXfz9tZ4;
 Mon,  1 Jun 2026 13:17:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1780312660; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D04O1XsCuuemXbY2YVN0rSer7xhr48HKYGRqzuFlAPQ=;
 b=cPbFnAeSy9iiIQhi43evWGZcVGFHTXNPXi90ZHOokjf+XuWUCknF67LUcSNjDtcSTfW6J0
 M3Q7eVk0KtSZVwvmLiX0nE77hu9cIojWChsZv0J/XTVlU99Bi/9nfwZzkjJU42dVIXyMhG
 ZYdaq1qcoGXROeuiPa1vTaDuI0cgs4L9uEy5Gy9KNcrLJDBMUXa+aCuyBi5IhFo1kcgCfj
 0I8T3aZMcEXrHP4wdyYzMnr4wbIDJPYLp8MoDAuRCFstfuUs7HQb85JEOBjMt2uepu7+oB
 JELjiEK73LfBi3MjC4qn4bGNbFTYTBQtF4ABkbVVGotTOUTaoXz6SH6udW6HmA==
Message-ID: <df2daf200c9a69f497f4285074d2a95425b3dbdd.camel@mailbox.org>
Subject: Re: [PATCH 3/4] rust: Add dma_fence abstractions
From: Philipp Stanner <phasta@mailbox.org>
To: Boris Brezillon <boris.brezillon@collabora.com>, Alice Ryhl
 <aliceryhl@google.com>
Cc: Philipp Stanner <phasta@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Andreas Hindborg	 <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich	 <dakr@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker	 <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Uladzislau Rezki	 <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers	
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Zqiang <qiang.zhang@linux.dev>, Daniel Almeida
 <daniel.almeida@collabora.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Igor Korotin <igor.korotin@linux.dev>,
 Lorenzo Stoakes	 <ljs@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 FUJITA Tomonori	 <fujita.tomonori@gmail.com>, Krishna Ketan Rai
 <prafulrai522@gmail.com>,  Shankari Anand <shankari.ak0208@gmail.com>,
 manos@pitsidianak.is, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 rcu@vger.kernel.org
Date: Mon, 01 Jun 2026 13:17:27 +0200
In-Reply-To: <20260601125933.17ca4dd5@fedora-2.home>
References: <20260530143541.229628-2-phasta@kernel.org>
 <20260530143541.229628-5-phasta@kernel.org>	<ah1glmXDM-OAKa5h@google.com>
 <20260601125933.17ca4dd5@fedora-2.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: e4utjoyocfe4p1fqaetun1euskdi8cyn
X-MBO-RS-ID: b921df505de11e783e6
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

On Mon, 2026-06-01 at 12:59 +0200, Boris Brezillon wrote:
> On Mon, 1 Jun 2026 10:36:06 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> > > +};
> > > +
> > > +use bindings::ECANCELED;
> > > +
> > > +use kernel::str::CString;
> > > +use kernel::sync::{
> > > +=C2=A0=C2=A0=C2=A0 aref::{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARef,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AlwaysRefCounted, //
> > > +=C2=A0=C2=A0=C2=A0 },
> > > +=C2=A0=C2=A0=C2=A0 Arc,
> > > +=C2=A0=C2=A0=C2=A0 ArcBorrow, //
> > > +};
> > > +
> > > +/// VTable for dma_fence backend_ops callbacks.
> > > +//
> > > +// Mandatory dma_fence backend_ops are implemented implicitly throug=
h
> > > +// [`FenceCtx`]. Additional ones shall get implemented on this trait=
, which then
> > > +// shall be demanded for the fence context data.
> > > +pub trait FenceCtxOps {}=C2=A0=20
> >=20
> > This empty trait is unused.
>=20
> I had initially suggested to add the F type (AKA FenceData) passed
> around in multiple places type as an associated type
>=20
> pub trait FenceCtxOps {
> =C2=A0=C2=A0 type FenceData: Send + Sync;
> }
>=20
> so we don't have to pass both F and C. The reasoning here is that:
>=20
> 1. We expect we'll have to define more methods to the FenceCtxOps trait
> at some point, so adding it now kinda makes sense.
>=20
> 2. In the current design, we've assumed that a Fence can't live/be
> created outside of a given context, so there's no world where the
> FenceData wouldn't be known by the FenceCtx implementation, and forcing
> users to pass F and C around seems needlessly verbose.

I had investigated that, but found that this causes us to write things
like

DriverFence<T> (where T is the FencCtx generic)

and then in the actual implementation use

T::FenceData

which reads very weird IMO. Because now for reasons a fence's own data
are not referred to in its own implementation, but you derive it from
the context.

I do prefer it in a way where the DriverFence generic does appear in
said fence's actual code, on equal rank with the FenceCtx.

I suppose that is actually one use case for which PhantomData does
exist.


P.
