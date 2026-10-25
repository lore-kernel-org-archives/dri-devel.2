Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A46606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 11:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.a=rsa-sha256 header.s=protonmail2 header.b=aF4PWV/O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C71B110E10A;
	Sun, 25 Oct 2026 11:23:54 +0000 (UTC)
Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch
 [185.70.43.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 572D310E115
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 11:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail2; t=1792927425; x=1793186625;
 bh=KxRL1DvHM8nURGmu+fIetHUszwkcj8gtkIA0u1SuRI0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=aF4PWV/OqdXm+Gg18Fq0Y+EAJPczVLQ5kNHWD8pQ0zoXaJTfKsPC84dzoelhH/vqx
 /8LHTXXqtsHf36qp/9c7pyTbkSZoaoXzTFiI3xlhkEE93DbK6lP2u0ERKdyVxboCFG
 9o2QZ+l6cD3HC8O+IWyXfNi3+pZatHm54DqHyR+5wbes6sfW9AVMPaYdDprFh/iUXz
 DJodG3SAN32wMSwH/MVUwqvQgPfKd0rXWsTZ65WvS84KJka+JyxKQ3Oeu4vNfv2tQT
 XP/2ydefNe5vqR6kDKA9bJ4Izqpk57J1S7PB8e33SvjZopB3VTGMkTUbaF6BQoNUvz
 J6qZy00KGHGwg==
X-Pm-Submission-Id: 4jCDsW0qqfz2ScMt
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Alice Ryhl <aliceryhl@google.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dakr@kernel.org,
 daniel.almeida@collabora.com, airlied@gmail.com, simona@ffwll.ch,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu
Subject: Re: [PATCH 2/2] drm/tyr: unplug the GPU when reset fails
Date: Sun, 25 Oct 2026 14:23:38 +0300
Message-ID: <20261025112341.60054-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20261021093808.1128449-1-aliceryhl@google.com>
References: <20260823-tyr-gpu-unplug-b4-v1-0-e99c07d4c785@onurozkan.dev>
 <20260823-tyr-gpu-unplug-b4-v1-2-e99c07d4c785@onurozkan.dev>
 <20261021093808.1128449-1-aliceryhl@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 21 Oct 2026 09:38:07 +0000=0D
Alice Ryhl <aliceryhl@google.com> wrote:=0D
=0D
> On Sun, Aug 23, 2026 at 01:50:08PM +0300, Onur =C3=96zkan wrote:=0D
> > @@ -56,7 +57,7 @@ pub(crate) struct TyrPlatformDriverData<'bound> {=0D
> >      // ensure the correct drop order.=0D
> >      #[pin]=0D
> >      _reset: reset::ResetHandle<'bound>,=0D
> > -    _reg: drm::Registration<'bound, TyrDrmDriver>,=0D
> > +    _reg: Arc<Revocable<drm::Registration<'bound, TyrDrmDriver>>>,=0D
> >      _device: ARef<TyrDrmDevice>,=0D
> >  }=0D
> >  =0D
> > @@ -161,17 +162,18 @@ fn probe<'bound>(=0D
> >                      gpu_info,=0D
> >              });=0D
> >  =0D
> > -            // SAFETY: `reg` is stored in the platform driver data and=
 is not leaked or=0D
> > -            // forgotten, so it is dropped before the `'bound` registr=
ation data can become=0D
> > -            // invalid.=0D
> > +            // SAFETY: `reg` is wrapped in a `Revocable` owned by the =
platform driver=0D
> > +            // data and its reset handle. Neither is leaked or forgott=
en, so `reg` is=0D
> > +            // dropped before the `'bound` registration data can becom=
e invalid.=0D
> >              let reg =3D=0D
> >                  unsafe { drm::Registration::new_with_lt(pdev.as_ref(),=
 unreg_dev, reg_data, 0)? };=0D
> >              let device =3D reg.device().into();=0D
> > +            let reg =3D Arc::pin_init(Revocable::new(reg), GFP_KERNEL)=
?;=0D
> =0D
> `drm::Registration::new` requires that the `Registration` is dropped=0D
> before `'bound` expires so that `drm_dev_unplug()` runs and=0D
> `TyrDrmRegistrationData<'bound>` is dropped while `'bound` is still=0D
> valid. Wrapping it in an `Arc` makes this invariant fragile: if any=0D
> `Arc` clone outlives `TyrPlatformDriverData` or is leaked,=0D
> `drm::Registration` will not be dropped on platform unbind and=0D
> `TyrDrmRegistrationData<'bound>` will outlive `'bound`.=0D
> =0D
> With `pin-init`'s new safe self-referential struct support in `rust-next`=
=0D
> (see e.g. [1]), you can avoid both `Arc` and raw pointers altogether by=0D
> storing `_reg: Revocable<drm::Registration<'bound, TyrDrmDriver>>`=0D
> directly as a `#[pin]` field of `TyrPlatformDriverData<'bound>` and=0D
> having `_reset` borrow it via field + existential lifetimes:=0D
> =0D
>     #[pin_data]=0D
>     pub(crate) struct TyrPlatformDriverData<'bound> {=0D
>         #[pin]=0D
>         #[uses('_reg: invariant)]=0D
>         _reset: reset::ResetHandle<'_reg>,=0D
>         #[pin]=0D
>         _reg: Revocable<drm::Registration<'bound, TyrDrmDriver>>,=0D
>     }=0D
> =0D
> and in `reset.rs`:=0D
> =0D
>     #[pin_data]=0D
>     struct Controller<'ctrl>=0D
>     where=0D
>         exists<'bound>: 'ctrl,=0D
>     {=0D
>         pdev: &'ctrl platform::Device<Bound>,=0D
>         state: Atomic<ResetState>,=0D
>         hw: Arc<HwGate<'ctrl>>,=0D
>         #[uses('bound: invariant)]=0D
>         registration:=0D
>             Pin<&'ctrl Revocable<drm::Registration<'bound, TyrDrmDriver>>=
>,=0D
>     }=0D
> =0D
> Then `probe()` simply initializes `_reg` first and passes `_reg` to=0D
> `ResetHandle::new(pdev, hw, _reg)?`, `reset_work()` calls=0D
> `self.with_registration(|reg| reg.revoke())`, and `#[pin_data]`=0D
> statically checks that `_reset` drops before `_reg`.=0D
> =0D
> Also, as a heads-up for rebasing onto `drm-rust-next`:=0D
> `_device: ARef<TyrDrmDevice>` has been removed from=0D
> `TyrPlatformDriverData` (along with the empty `PinnedDrop` impl), and=0D
> `drm::Registration::new()` now returns `impl PinInit<Self, Error>`=0D
> directly without the `flags` argument, so `_reg` can be initialized in=0D
> place via `Revocable::new(unsafe { drm::Registration::new(...) })`.=0D
> =0D
> [1] https://lore.kernel.org/r/20261019133647.1279779-1-gary@kernel.org=0D
> =0D
> Alice=0D
=0D
Any idea when will we push drm-rust-next changes into rust-next?=0D
=0D
- Onur=0D
