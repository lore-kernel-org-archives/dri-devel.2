Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B576606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=mI1AiV3w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCB8510FCFF;
	Wed, 21 Oct 2026 09:38:23 +0000 (UTC)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DE1710F9CB
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 09:38:17 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49953abe51fso3971185e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 02:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792575496; x=1793180296;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DMEarNjccdTmA6jkwGLogCoUkmgNrujCfqG0VHqUqZ0=;
 b=mI1AiV3w3dp9fKpmPA2QX+gMqx2ctqxjzfcjavBMmvNAKeRBlBx5GoiyFeuYonjomI
 89XuG1OHhCecKZhOUNKH3te062f96Be/U5yCDoJxMdtHQhg/DJz2GEtv8dLZArPBNH48
 9TzQN+Id1RzZjDdrfL6673LCYuB3eVWoXxUQb6UeZBcaM2nZklxMp725wMQ9XuObo4Y1
 0lXUgTO+4Yys1B1KncfRdoKkrdqK2Kn05DtdZEV/U7wc9visMFhKAX92I57vb5vfLzLt
 OAwVIPlE4vXfM1XZpydE2+tXEuXQG+XfkZ9f/sUyTgrXLGeFkR83A1D0KfHYxn8il7Zr
 Z1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792575496; x=1793180296;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DMEarNjccdTmA6jkwGLogCoUkmgNrujCfqG0VHqUqZ0=;
 b=zhkoJt9EvgrudBWPuTAwfyQs3PIWejiVgoXdTcpXmgqNZLVREAg7qhv/3cNoCwDAoL
 hcNvpOdE1198/y3xdb1lLec+p7X8X95NkFKHhL0EMJMGvRuBnuGKarWVOzUP06sMFmqi
 wpl2cEZtKIwPBAXwBkHkPZTQ5WQNLdhxF6fBnp8OavUgKB4S4YnlSB/jRohuNGciEiOH
 It/SElzN+70ezQfYEj1P+liazyYT9hBmHN8N1v+037lslxcowfdl61enzLQX1wUYbpYY
 TDl63gjEejcL2poRH7VjuE1n0R31Uxp4L5N6uWoq+Rx0v7Y/W4araAs8hSwdk+wJkqmo
 V+Ug==
X-Forwarded-Encrypted: i=1;
 AKwUvBxntzXUDrzeracYvyw1SN3PqKsPcpZUus3o08l1u1duZvPCBDqEsKbCXX/M2iCaGM38/zqr3grotMM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIxb9g5tQ/RJx8attS7R0ial2JLDTFOpU0aNIGrSucmQtAjU/WN
 gNAmaZOBqLOUG9evF5ZMfNUcy3didpiVYLLwtxLc7qvGh7r8hl6goD4VjQORPQ3SkJl3vEz3Q1l
 IQhKr01Xq1xZ5jgHUkA==
X-Received: from wmix23-n2.prod.google.com
 ([2002:a05:600c:e557:20b0:4a1:f553:f96b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5391:b0:4a1:d537:1c8d with SMTP id
 5b1f17b1804b1-4a1fdd23e21mr30007175e9.19.1792575495499; 
 Wed, 21 Oct 2026 02:38:15 -0700 (PDT)
Date: Wed, 21 Oct 2026 09:38:07 +0000
In-Reply-To: <20260823-tyr-gpu-unplug-b4-v1-2-e99c07d4c785@onurozkan.dev>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20260823-tyr-gpu-unplug-b4-v1-0-e99c07d4c785@onurozkan.dev>
 <20260823-tyr-gpu-unplug-b4-v1-2-e99c07d4c785@onurozkan.dev>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261021093808.1128449-1-aliceryhl@google.com>
Subject: Re: [PATCH 2/2] drm/tyr: unplug the GPU when reset fails
From: Alice Ryhl <aliceryhl@google.com>
To: "=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>
Cc: Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 dakr@kernel.org, daniel.almeida@collabora.com, airlied@gmail.com, 
 simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
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
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Aug 23, 2026 at 01:50:08PM +0300, Onur =C3=96zkan wrote:
> @@ -56,7 +57,7 @@ pub(crate) struct TyrPlatformDriverData<'bound> {
>      // ensure the correct drop order.
>      #[pin]
>      _reset: reset::ResetHandle<'bound>,
> -    _reg: drm::Registration<'bound, TyrDrmDriver>,
> +    _reg: Arc<Revocable<drm::Registration<'bound, TyrDrmDriver>>>,
>      _device: ARef<TyrDrmDevice>,
>  }
> =20
> @@ -161,17 +162,18 @@ fn probe<'bound>(
>                      gpu_info,
>              });
> =20
> -            // SAFETY: `reg` is stored in the platform driver data and i=
s not leaked or
> -            // forgotten, so it is dropped before the `'bound` registrat=
ion data can become
> -            // invalid.
> +            // SAFETY: `reg` is wrapped in a `Revocable` owned by the pl=
atform driver
> +            // data and its reset handle. Neither is leaked or forgotten=
, so `reg` is
> +            // dropped before the `'bound` registration data can become =
invalid.
>              let reg =3D
>                  unsafe { drm::Registration::new_with_lt(pdev.as_ref(), u=
nreg_dev, reg_data, 0)? };
>              let device =3D reg.device().into();
> +            let reg =3D Arc::pin_init(Revocable::new(reg), GFP_KERNEL)?;

`drm::Registration::new` requires that the `Registration` is dropped
before `'bound` expires so that `drm_dev_unplug()` runs and
`TyrDrmRegistrationData<'bound>` is dropped while `'bound` is still
valid. Wrapping it in an `Arc` makes this invariant fragile: if any
`Arc` clone outlives `TyrPlatformDriverData` or is leaked,
`drm::Registration` will not be dropped on platform unbind and
`TyrDrmRegistrationData<'bound>` will outlive `'bound`.

With `pin-init`'s new safe self-referential struct support in `rust-next`
(see e.g. [1]), you can avoid both `Arc` and raw pointers altogether by
storing `_reg: Revocable<drm::Registration<'bound, TyrDrmDriver>>`
directly as a `#[pin]` field of `TyrPlatformDriverData<'bound>` and
having `_reset` borrow it via field + existential lifetimes:

    #[pin_data]
    pub(crate) struct TyrPlatformDriverData<'bound> {
        #[pin]
        #[uses('_reg: invariant)]
        _reset: reset::ResetHandle<'_reg>,
        #[pin]
        _reg: Revocable<drm::Registration<'bound, TyrDrmDriver>>,
    }

and in `reset.rs`:

    #[pin_data]
    struct Controller<'ctrl>
    where
        exists<'bound>: 'ctrl,
    {
        pdev: &'ctrl platform::Device<Bound>,
        state: Atomic<ResetState>,
        hw: Arc<HwGate<'ctrl>>,
        #[uses('bound: invariant)]
        registration:
            Pin<&'ctrl Revocable<drm::Registration<'bound, TyrDrmDriver>>>,
    }

Then `probe()` simply initializes `_reg` first and passes `_reg` to
`ResetHandle::new(pdev, hw, _reg)?`, `reset_work()` calls
`self.with_registration(|reg| reg.revoke())`, and `#[pin_data]`
statically checks that `_reset` drops before `_reg`.

Also, as a heads-up for rebasing onto `drm-rust-next`:
`_device: ARef<TyrDrmDevice>` has been removed from
`TyrPlatformDriverData` (along with the empty `PinnedDrop` impl), and
`drm::Registration::new()` now returns `impl PinInit<Self, Error>`
directly without the `flags` argument, so `_reg` can be initialized in
place via `Revocable::new(unsafe { drm::Registration::new(...) })`.

[1] https://lore.kernel.org/r/20261019133647.1279779-1-gary@kernel.org

Alice
