Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B11F606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=GsFRI/UK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C55B710E1D4;
	Sun, 25 Oct 2026 12:05:31 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A27E310E1D4
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 12:05:25 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48e0d1c095dso1289307f8f.1
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 05:05:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792929924; cv=none;
 d=google.com; s=arc-20260327;
 b=li+dZPRVeoIiR4LAk9yPj41JSi0nu5fVoGo1Q6rUHVCI1b/Y1BP1dZqYRq+EZCrgFL
 cX/ZPugQvlOIrwAYUYtM8HW6H47UyzyIAIgKXhpqW1THylQdP8nypLLGw9415utzdc55
 9OcAN3HzZBhIubBaBSpWsauTCtXKbdKIKZlxUL7XUhWkgYsn5TmXP3OfZtrN3HnxzraG
 8clbXiie966RJ2DCMtKMn2zshfjcF66Kxyr0EADfdqEcS3xQtiLdOV3krEnlMu1AQi7+
 3Tq4mH9+a6A3yk6tmsJsQlEEjUcb0NtlMD/gZBoY5GZfSWDNO33XJc1c3dvARA6ja8hX
 PW1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZLCOnd82Q2AmvSjk1g9482NEnoKPBW6l7CpBPhWPtsU=;
 fh=mvEOMCf6YoQt6/M60D+7pLRXbncvv/illhHAi6i7ozA=;
 b=ALCQdC2EK08/j0iNOmrIyXdXQAqc6olIS0Zkaqh21jBQE71/hxR0kxKg+fuSBpXcvY
 CkAz3wLHmqy7rVo5MV7Ng+2iv/k8XLUQHljLbhWchoC1fr8hlzycQaiAk8lQastj79LN
 e2waRfgG4S6paxld7RBjCUFxqCSSFJJLQDKXh9Ja8Q4CFU2DwYxCFALiGX2RkYHUZBj7
 BoBjKqYybsz6N1D+VOM2V6DdokPMrxa8gX7WssRLFiDbd8zWaCnx2duTVy3SwMaocKxe
 RXDBtZSTVlX/yYz5XyajcQDvvDMBKzEZxdxRaEYkwX6Yb79y15rzWokSUI1U4uAiiryd
 JmCA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792929924; x=1793534724;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZLCOnd82Q2AmvSjk1g9482NEnoKPBW6l7CpBPhWPtsU=;
 b=GsFRI/UKDD2Xj7KzILfEAcp5I5o1/J9UdIZ15wKGf0XCO0GxsHoOUC909DsZYLctLa
 oEW+j1qfznfnHtw6+g1rbk6SBidryNO0Pq7syP77Jwtuq8Lm60ES9zH/9oLKBLhcxzdt
 js1v85hr5vjl/TlBQnuchQNj/moBSwiBaWEIm3ZJMQ4N9eyN6Xdw1IKn28DcRrzkshaF
 lxsw69t0v96B4EHldTtwONksJvpXCR8Sj16czbrFdTs4CykmVZSF6lHBEfNLJG9TDObi
 67thWGwmsQaLhNdsHsLOUopSiza+TDaip2+DempA2j5Af20SMdPd9ry32jw/zXx+2aXC
 8Gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792929924; x=1793534724;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZLCOnd82Q2AmvSjk1g9482NEnoKPBW6l7CpBPhWPtsU=;
 b=IomJoTobeO0H+xS4f9/8Hj1EVhlD9+aGKyNhxJFOmk4cfeRsdlD2KXT15Y6GE44dYc
 iaiu+B8V8qVd+kYqIzP/rujXV5xiPwqSTKQpdb4SKfciFIoYe2h4UnabMAmKT6OQ2XCY
 xwUW7tKdQNOBmILy3VutFgkAviyrCaWZL/ss8ZcTaqbYNrBsB+byy0TimaxH6EJjI69U
 m0KwoX8Icynl95fQdLYxWEcYbdPFSqCwy0izFZ+BEfDLQsxANa1dXH5SdL/pHijRytME
 XFE4TYF/V+JkY62r1/ZikUN0ofGemDR87sSCAkWDuJRPUyc0+lTpRdzJgRyvCLTdhufi
 /lJA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1rmWsxer6GGs0dp2LXCCMCUZcxKHiDa3Tj4gK0Q/KiuiGBr9vjVHtZm+owNw2Rbl1rOpoahTnbjU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJOr+otAXaE3hCfkMzDXo8oD6sY0pFFaO2+tI95yedCGMADzfoY
 ahK/Cc2E9jS3enJ4ZSVQGr07DoHbqSeewXgKYzhZzxEp/xUGGd7g1LRbVYK4JyNXpIFTNHmfNCO
 dQbxVwQv7ro+KGpA6830rb/EEp7arZyV4eaETJA+YTFQU443p4Vrwfgni
X-Gm-Gg: AYBFou3sG968lTuQYzB4natnZ2ZIZ8P8uEtsU/xDFFMz7TBEj51sAVamxJ7VPJ5ANvI
 +z8BFU1KuoTwH91P4JCbwPkXMICqL2uH0p3ZTG1x5b8NZ7OV+V6WjO38LewrGYapvbJ5Ios/gsU
 bVAvmYeNHdrN5pCE+UrD3Qbxm3EzrZzLVyNjDDTMwkVIXuzAJSokEBP5YktzBcRrHKp0Wb9P2FN
 PJzuAGJBNQ9fTm5mWeFDguiSS28mxlOzkDB+d0GVWiKCm77kHjdwhpb0I3skrbzs0jBUMg1ue3W
 U+mgYQdmCYCfEckqL6r0AglRjkgNO+nQptIKE2+KMnYs5iqNzLe1G9BXQEL5FRadFQ6Ilo9Pp4l
 JJ5HjnnhOF2t18bBrEzwOfgiOFsir8EHpXvIn8Vm3i9V+aN+VKLv8qkqQRIjQkE5NPZ4rKBZEMD
 /I3TRcSUglGJi/0w==
X-Received: by 2002:a5d:5f44:0:b0:48b:10af:f85c with SMTP id
 ffacd0b85a97d-48e3eb9da68mr6693615f8f.37.1792929923496; Sun, 25 Oct 2026
 05:05:23 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260823-tyr-gpu-unplug-b4-v1-0-e99c07d4c785@onurozkan.dev>
 <20260823-tyr-gpu-unplug-b4-v1-2-e99c07d4c785@onurozkan.dev>
 <20261021093808.1128449-1-aliceryhl@google.com>
 <20261025112341.60054-1-work@onurozkan.dev>
In-Reply-To: <20261025112341.60054-1-work@onurozkan.dev>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sun, 25 Oct 2026 13:05:09 +0100
X-Gm-Features: AclHuK_vlq1pG_e9KogyCUhHCbMVS-gy1nu0YhyrawGdRf1hO7SrcpUQY2i8IzE
Message-ID: <CAH5fLghQAGskFzEOAQwjO9eDoKU51nG4L0C8EHNOtugWov4hHQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/tyr: unplug the GPU when reset fails
To: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, dakr@kernel.org, 
 daniel.almeida@collabora.com, airlied@gmail.com, simona@ffwll.ch, 
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
 tmgross@umich.edu
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 25, 2026 at 12:23=E2=80=AFPM Onur =C3=96zkan <work@onurozkan.de=
v> wrote:
>
> On Wed, 21 Oct 2026 09:38:07 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > On Sun, Aug 23, 2026 at 01:50:08PM +0300, Onur =C3=96zkan wrote:
> > > @@ -56,7 +57,7 @@ pub(crate) struct TyrPlatformDriverData<'bound> {
> > >      // ensure the correct drop order.
> > >      #[pin]
> > >      _reset: reset::ResetHandle<'bound>,
> > > -    _reg: drm::Registration<'bound, TyrDrmDriver>,
> > > +    _reg: Arc<Revocable<drm::Registration<'bound, TyrDrmDriver>>>,
> > >      _device: ARef<TyrDrmDevice>,
> > >  }
> > >
> > > @@ -161,17 +162,18 @@ fn probe<'bound>(
> > >                      gpu_info,
> > >              });
> > >
> > > -            // SAFETY: `reg` is stored in the platform driver data a=
nd is not leaked or
> > > -            // forgotten, so it is dropped before the `'bound` regis=
tration data can become
> > > -            // invalid.
> > > +            // SAFETY: `reg` is wrapped in a `Revocable` owned by th=
e platform driver
> > > +            // data and its reset handle. Neither is leaked or forgo=
tten, so `reg` is
> > > +            // dropped before the `'bound` registration data can bec=
ome invalid.
> > >              let reg =3D
> > >                  unsafe { drm::Registration::new_with_lt(pdev.as_ref(=
), unreg_dev, reg_data, 0)? };
> > >              let device =3D reg.device().into();
> > > +            let reg =3D Arc::pin_init(Revocable::new(reg), GFP_KERNE=
L)?;
> >
> > `drm::Registration::new` requires that the `Registration` is dropped
> > before `'bound` expires so that `drm_dev_unplug()` runs and
> > `TyrDrmRegistrationData<'bound>` is dropped while `'bound` is still
> > valid. Wrapping it in an `Arc` makes this invariant fragile: if any
> > `Arc` clone outlives `TyrPlatformDriverData` or is leaked,
> > `drm::Registration` will not be dropped on platform unbind and
> > `TyrDrmRegistrationData<'bound>` will outlive `'bound`.
> >
> > With `pin-init`'s new safe self-referential struct support in `rust-nex=
t`
> > (see e.g. [1]), you can avoid both `Arc` and raw pointers altogether by
> > storing `_reg: Revocable<drm::Registration<'bound, TyrDrmDriver>>`
> > directly as a `#[pin]` field of `TyrPlatformDriverData<'bound>` and
> > having `_reset` borrow it via field + existential lifetimes:
> >
> >     #[pin_data]
> >     pub(crate) struct TyrPlatformDriverData<'bound> {
> >         #[pin]
> >         #[uses('_reg: invariant)]
> >         _reset: reset::ResetHandle<'_reg>,
> >         #[pin]
> >         _reg: Revocable<drm::Registration<'bound, TyrDrmDriver>>,
> >     }
> >
> > and in `reset.rs`:
> >
> >     #[pin_data]
> >     struct Controller<'ctrl>
> >     where
> >         exists<'bound>: 'ctrl,
> >     {
> >         pdev: &'ctrl platform::Device<Bound>,
> >         state: Atomic<ResetState>,
> >         hw: Arc<HwGate<'ctrl>>,
> >         #[uses('bound: invariant)]
> >         registration:
> >             Pin<&'ctrl Revocable<drm::Registration<'bound, TyrDrmDriver=
>>>,
> >     }
> >
> > Then `probe()` simply initializes `_reg` first and passes `_reg` to
> > `ResetHandle::new(pdev, hw, _reg)?`, `reset_work()` calls
> > `self.with_registration(|reg| reg.revoke())`, and `#[pin_data]`
> > statically checks that `_reset` drops before `_reg`.
> >
> > Also, as a heads-up for rebasing onto `drm-rust-next`:
> > `_device: ARef<TyrDrmDevice>` has been removed from
> > `TyrPlatformDriverData` (along with the empty `PinnedDrop` impl), and
> > `drm::Registration::new()` now returns `impl PinInit<Self, Error>`
> > directly without the `flags` argument, so `_reg` can be initialized in
> > place via `Revocable::new(unsafe { drm::Registration::new(...) })`.
> >
> > [1] https://lore.kernel.org/r/20261019133647.1279779-1-gary@kernel.org
> >
> > Alice
>
> Any idea when will we push drm-rust-next changes into rust-next?

We are currently in the merge window, so drm-rust-next and rust-next
are both being pushed into Linus's tree. Once the merge window is
over, drm-rust-next will have everything that was pushed to Linus's
tree available.

Alice
