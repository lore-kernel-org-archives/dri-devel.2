Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA11606A325
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.a=rsa-sha256 header.s=protonmail2 header.b=W8ul+5er
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 720E910E2CB;
	Mon, 26 Oct 2026 05:00:58 +0000 (UTC)
Received: from mail-244105.protonmail.ch (mail-244105.protonmail.ch
 [109.224.244.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F3CB10E2CB
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 05:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail2; t=1792990507; x=1793249707;
 bh=bkFoj/p9kuVrOrWL82YWFiYwfoD25GjMBtArR/G/taI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=W8ul+5erNyhV9loBI+BtaiHwQF+Bi9Stx46ldUUeTa6eIGKNMK+OB/V2iiSSjC9qy
 sMDMAzuoEKhlD0DAMNI67tSU4gt3E/7xrhtVneoAPTbZD8Tmnyo6hlWUJXFYa6xLZd
 iGQgqYAiAPFNQvPzl9TWrjy+TiYx1YRNw/oSSiwl/eDFIKD7DsSiJ76iUS0Sf2t/FT
 QaZUatBr++evYKBSznvtgGGP/ObOtKMq8HGZHKF9cYVeweg+TjsrN55V7ajcVCSi6F
 UB5alFfQXRgGrLV0Z9pzv15PFqRFvMNeMYnr76MShxB92NRGWGdsAV/+B+LtKQlsmF
 8oFXEULLzLx3w==
X-Pm-Submission-Id: 4jChBb6pNbz1DFSj
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Alice Ryhl <aliceryhl@google.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dakr@kernel.org,
 daniel.almeida@collabora.com, airlied@gmail.com, simona@ffwll.ch,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu
Subject: Re: [PATCH 2/2] drm/tyr: unplug the GPU when reset fails
Date: Mon, 26 Oct 2026 07:55:00 +0300
Message-ID: <20261026045502.43739-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <CAH5fLghQAGskFzEOAQwjO9eDoKU51nG4L0C8EHNOtugWov4hHQ@mail.gmail.com>
References: <20260823-tyr-gpu-unplug-b4-v1-0-e99c07d4c785@onurozkan.dev>
 <20260823-tyr-gpu-unplug-b4-v1-2-e99c07d4c785@onurozkan.dev>
 <20261021093808.1128449-1-aliceryhl@google.com>
 <20261025112341.60054-1-work@onurozkan.dev>
 <CAH5fLghQAGskFzEOAQwjO9eDoKU51nG4L0C8EHNOtugWov4hHQ@mail.gmail.com>
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

On Sun, 25 Oct 2026 13:05:09 +0100=0D
Alice Ryhl <aliceryhl@google.com> wrote:=0D
=0D
> On Sun, Oct 25, 2026 at 12:23=E2=80=AFPM Onur =C3=96zkan <work@onurozkan.=
dev> wrote:=0D
> >=0D
> > On Wed, 21 Oct 2026 09:38:07 +0000=0D
> > Alice Ryhl <aliceryhl@google.com> wrote:=0D
> >=0D
> > > On Sun, Aug 23, 2026 at 01:50:08PM +0300, Onur =C3=96zkan wrote:=0D
> > > > @@ -56,7 +57,7 @@ pub(crate) struct TyrPlatformDriverData<'bound> {=
=0D
> > > >      // ensure the correct drop order.=0D
> > > >      #[pin]=0D
> > > >      _reset: reset::ResetHandle<'bound>,=0D
> > > > -    _reg: drm::Registration<'bound, TyrDrmDriver>,=0D
> > > > +    _reg: Arc<Revocable<drm::Registration<'bound, TyrDrmDriver>>>,=
=0D
> > > >      _device: ARef<TyrDrmDevice>,=0D
> > > >  }=0D
> > > >=0D
> > > > @@ -161,17 +162,18 @@ fn probe<'bound>(=0D
> > > >                      gpu_info,=0D
> > > >              });=0D
> > > >=0D
> > > > -            // SAFETY: `reg` is stored in the platform driver data=
 and is not leaked or=0D
> > > > -            // forgotten, so it is dropped before the `'bound` reg=
istration data can become=0D
> > > > -            // invalid.=0D
> > > > +            // SAFETY: `reg` is wrapped in a `Revocable` owned by =
the platform driver=0D
> > > > +            // data and its reset handle. Neither is leaked or for=
gotten, so `reg` is=0D
> > > > +            // dropped before the `'bound` registration data can b=
ecome invalid.=0D
> > > >              let reg =3D=0D
> > > >                  unsafe { drm::Registration::new_with_lt(pdev.as_re=
f(), unreg_dev, reg_data, 0)? };=0D
> > > >              let device =3D reg.device().into();=0D
> > > > +            let reg =3D Arc::pin_init(Revocable::new(reg), GFP_KER=
NEL)?;=0D
> > >=0D
> > > `drm::Registration::new` requires that the `Registration` is dropped=
=0D
> > > before `'bound` expires so that `drm_dev_unplug()` runs and=0D
> > > `TyrDrmRegistrationData<'bound>` is dropped while `'bound` is still=0D
> > > valid. Wrapping it in an `Arc` makes this invariant fragile: if any=0D
> > > `Arc` clone outlives `TyrPlatformDriverData` or is leaked,=0D
> > > `drm::Registration` will not be dropped on platform unbind and=0D
> > > `TyrDrmRegistrationData<'bound>` will outlive `'bound`.=0D
> > >=0D
> > > With `pin-init`'s new safe self-referential struct support in `rust-n=
ext`=0D
> > > (see e.g. [1]), you can avoid both `Arc` and raw pointers altogether =
by=0D
> > > storing `_reg: Revocable<drm::Registration<'bound, TyrDrmDriver>>`=0D
> > > directly as a `#[pin]` field of `TyrPlatformDriverData<'bound>` and=0D
> > > having `_reset` borrow it via field + existential lifetimes:=0D
> > >=0D
> > >     #[pin_data]=0D
> > >     pub(crate) struct TyrPlatformDriverData<'bound> {=0D
> > >         #[pin]=0D
> > >         #[uses('_reg: invariant)]=0D
> > >         _reset: reset::ResetHandle<'_reg>,=0D
> > >         #[pin]=0D
> > >         _reg: Revocable<drm::Registration<'bound, TyrDrmDriver>>,=0D
> > >     }=0D
> > >=0D
> > > and in `reset.rs`:=0D
> > >=0D
> > >     #[pin_data]=0D
> > >     struct Controller<'ctrl>=0D
> > >     where=0D
> > >         exists<'bound>: 'ctrl,=0D
> > >     {=0D
> > >         pdev: &'ctrl platform::Device<Bound>,=0D
> > >         state: Atomic<ResetState>,=0D
> > >         hw: Arc<HwGate<'ctrl>>,=0D
> > >         #[uses('bound: invariant)]=0D
> > >         registration:=0D
> > >             Pin<&'ctrl Revocable<drm::Registration<'bound, TyrDrmDriv=
er>>>,=0D
> > >     }=0D
> > >=0D
> > > Then `probe()` simply initializes `_reg` first and passes `_reg` to=0D
> > > `ResetHandle::new(pdev, hw, _reg)?`, `reset_work()` calls=0D
> > > `self.with_registration(|reg| reg.revoke())`, and `#[pin_data]`=0D
> > > statically checks that `_reset` drops before `_reg`.=0D
> > >=0D
> > > Also, as a heads-up for rebasing onto `drm-rust-next`:=0D
> > > `_device: ARef<TyrDrmDevice>` has been removed from=0D
> > > `TyrPlatformDriverData` (along with the empty `PinnedDrop` impl), and=
=0D
> > > `drm::Registration::new()` now returns `impl PinInit<Self, Error>`=0D
> > > directly without the `flags` argument, so `_reg` can be initialized i=
n=0D
> > > place via `Revocable::new(unsafe { drm::Registration::new(...) })`.=0D
> > >=0D
> > > [1] https://lore.kernel.org/r/20261019133647.1279779-1-gary@kernel.or=
g=0D
> > >=0D
> > > Alice=0D
> >=0D
> > Any idea when will we push drm-rust-next changes into rust-next?=0D
> =0D
> We are currently in the merge window, so drm-rust-next and rust-next=0D
> are both being pushed into Linus's tree. Once the merge window is=0D
> over, drm-rust-next will have everything that was pushed to Linus's=0D
> tree available.=0D
> =0D
> Alice=0D
=0D
Cool, I will wait for that and send new versions for this and the reset ser=
ies.=0D
=0D
- Onur=0D
