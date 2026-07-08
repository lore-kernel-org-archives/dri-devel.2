Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882DCC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 13:29:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCA6D89DA5;
	Wed,  8 Jul 2026 13:29:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SJ+FOWX4";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A864589DA5
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 13:29:43 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gwJq831JYzMlGX;
 Wed, 08 Jul 2026 15:29:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1783517380; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u+QzoStC3POLvanG8ZLxpgomra4Mq3Lf3oEAWOgFql8=;
 b=SJ+FOWX4vFmAla8qj17/+0Pkuugs68BdDuOZbdI9m4etSGdWRvIHqksjIzlS628SASzyNR
 KUPuAEN2F+d2nP5dm5oJmToHAx6/rGkovRSSvuvYNJw4KEipQgNs6ypGI36iGA3OT+v0zP
 ckLJYh2oyXgqaptLNEQ6df75tzywBssmzdoFvUPiqIR80LQnZMii7jWW8fQt2GW5sMbKUQ
 rz5gVk4GXSyyi3WPj18hBS6neyBkRme4/3JrBS4lnJ1LpMb/A5KTfh1XTz/tIDI5KPpgL3
 MSR39yvd7shKThIgh60krfYf4m9FbcKLfIFGGL9Y9R/XmzqC2qTe6QCVdPZi3w==
Message-ID: <099ab4b0fd40c476fcb5fa804800794f11758416.camel@mailbox.org>
Subject: Re: [PATCH v5 4/5] rust: Add dma_fence abstractions
From: Philipp Stanner <phasta@mailbox.org>
To: Philipp Stanner <phasta@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Andreas Hindborg	 <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Sumit Semwal	
 <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Asahi Lina
 <lina+kernel@asahilina.net>, Burak Emir <bqe@google.com>,  Lorenzo Stoakes	
 <ljs@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Alexandre Courbot
 <acourbot@nvidia.com>, Krishna Ketan Rai <prafulrai522@gmail.com>, Tamir
 Duberstein <tamird@kernel.org>, Mirko Adzic <adzicmirko97@gmail.com>,
 Alistair Francis	 <alistair.francis@wdc.com>, Onur =?ISO-8859-1?Q?=D6zkan?=
 <work@onurozkan.dev>,  Shankari Anand <shankari.ak0208@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org
Date: Wed, 08 Jul 2026 15:29:29 +0200
In-Reply-To: <20260703073141.3962604-6-phasta@kernel.org>
References: <20260703073141.3962604-2-phasta@kernel.org>
 <20260703073141.3962604-6-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 58600b92efd2db828a6
X-MBO-RS-META: jonfcbxufdzn7z77mwmxrqxzisg6c981
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

On Fri, 2026-07-03 at 09:31 +0200, Philipp Stanner wrote:
>=20
> +// Necessary to guarantee that `inner` always comes first and can be fre=
ed by C.
> +// Also useful for using casts instead of container_of().
> +#[repr(C)]
> +#[pin_data]
> +struct DriverFenceData<'a, T: Send + Sync + FenceCtxOps> {
> +=C2=A0=C2=A0=C2=A0 #[pin]
> +=C2=A0=C2=A0=C2=A0 /// The inner fence.
> +=C2=A0=C2=A0=C2=A0 // Must always be the first member so that unsafe cas=
ting works; but also
> +=C2=A0=C2=A0=C2=A0 // necessary so that the C backend can free the alloc=
ation (coming from our
> +=C2=A0=C2=A0=C2=A0 // Rust code) with kfree_rcu().
> +=C2=A0=C2=A0=C2=A0 inner: Fence,
> +=C2=A0=C2=A0=C2=A0 /// Callback head for dropping this in a deferred man=
ner through RCU.
> +=C2=A0=C2=A0=C2=A0 rcu_head: bindings::callback_head,
> +=C2=A0=C2=A0=C2=A0 /// Reference to access the FenceCtx. Useful for obta=
ining name parameters.
> +=C2=A0=C2=A0=C2=A0 fctx: &'a FenceCtx<T>,
> +=C2=A0=C2=A0=C2=A0 /// The API user's data. This must either not need dr=
op, or must delay its
> +=C2=A0=C2=A0=C2=A0 /// drop by a grace period. It is essential that the =
data only performs
> +=C2=A0=C2=A0=C2=A0 /// operations legal in atomic context in its [`Drop`=
] implementation.
> +=C2=A0=C2=A0=C2=A0 #[pin]
> +=C2=A0=C2=A0=C2=A0 data: T::FenceDataType,
> +}
> +
> +pub struct DriverFence<'a, T: Send + Sync + FenceCtxOps> {
> +=C2=A0=C2=A0=C2=A0 /// The actual content of the fence. Lives in a raw p=
ointer so that its
> +=C2=A0=C2=A0=C2=A0 /// memory can be managed independently. Valid until =
both the [`DriverFence`]
> +=C2=A0=C2=A0=C2=A0 /// and all associated [`Fence`]s have disappeared.
> +=C2=A0=C2=A0=C2=A0 data: NonNull<DriverFenceData<'a, T>>,
> +}
> +
> +/// A pre-prepared DMA fence, carrying the user's data and the memory it=
 and the
> +/// fence reside in. Only useful for creating a [`DriverFence`]. Splitti=
ng
> +/// allocation and full initialization is necessary because fences canno=
t be
> +/// allocated dynamically in some circumstances (deadlock).
> +pub struct DriverFenceAllocation<'a, T: Send + Sync + FenceCtxOps> {
> +=C2=A0=C2=A0=C2=A0 /// The memory for the actual content of the fence.
> +=C2=A0=C2=A0=C2=A0 /// Handed over to a [`DriverFence`], or deallocated =
once the
> +=C2=A0=C2=A0=C2=A0 /// [`DriverFenceAllocation`] drops.
> +=C2=A0=C2=A0=C2=A0 data: KBox<DriverFenceData<'a, T>>,
> +}

One issue that I'm only discovering just now is that the request of
deriving the DriverFence's generic through the FenceCtx's generic
causes issues like this:


struct DriverFoo {
  f: DriverFence<()>, // error: must implement FenceCtxOps
}

IOW, all DriverFence::data now must implement the trait. Which is
obviously not what we want.

But I cannot get easily get rid of it. See DriverFenceData.

@Boris: Do you have a suggestion? Otherwise I'd want to default back to
PhantomData, which I still believe is cleaner.


P.
