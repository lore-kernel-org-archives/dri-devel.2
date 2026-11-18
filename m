Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6E2606A333
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k1RjRNk6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1030B10FBA0;
	Wed, 18 Nov 2026 12:10:46 +0000 (UTC)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F4E910FBA0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:10:40 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a20e41008cso7265905e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 04:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795003839; x=1795608639;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qj1PLy2yInc0qHugCW7c4uxMVK1VS1mHZtMcI4xn/SA=;
 b=k1RjRNk6WGnKEIf0tGqofJWnE1Eayh6SWPUGuxnCvZ1ijT3m52Hgm9Xnx1+TzJu2+n
 IR++l0DpENY680iGYK4wwCTscqatYwKUShpimS/5YcU80KXtMUPJAVQgr7YRWHlaH+le
 z3jLJvqMR2WYa54yNkpzGCUUvzc1Yoh2+ovUuI+Dc2v/OAtBevO7cjE+GBGlVbAj1C9F
 OW38ac6XZjZSHTi2mCdCZwdnioLUiOxGCopo4Dwp6dAvwnirZGXFmMRXJhOuqd0XnyPY
 X6rUYi4TFmf34UR0zpUwO1ax3eZKBD3HYR3IeATTbAoKaKyA0DMA9joJntKCJo5aNUou
 SKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795003839; x=1795608639;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qj1PLy2yInc0qHugCW7c4uxMVK1VS1mHZtMcI4xn/SA=;
 b=ezbSFc0NrDT6XbB8Y09lB+t3XeBQdokaJUARk/f5HyZKwhxgONblnprcMmkSgXRWN5
 cH165X0SL6b6Rfdoe0ioQ+QNhM6ZFfR8n3aOiYHLgr4ZDwHorzoL/RdrHtKajpL8BWw6
 hTtLoVsrs7TwiKxmNE5phXViygJ+7F0XkmRhyKPbZNkYhi4qKNha+xbURym8njwJS4Bt
 r+7urHJaJJTlnVzlaMDQWto2oEzAO/xm/JbfVKFhoWmZW9It49zZs+dhkiBC2frca57h
 W3B37+KBtzYo8EyupEyJ4NrxvH3eMOlZ/19pQAPR+w+ptvHReGOW4N5BEvgCQQ6cBrWO
 W8vg==
X-Forwarded-Encrypted: i=1;
 AL+hErHJdgd36bcpVgAgxnRl6ilTwZvep0/v1i5zYPAwEvbLy2GWZWATwt1exChs4xcxruiCFcz0tFPpH88=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/bEWqxWWNo/nZLmAf3tlcT+d/W/w9YY8yDYocb9VacUwCAs7jw
 xXcVWTUDh4kcBth4+ndqlaQm/p1Ic/jIejit2+RH/mW69YujV9o6tIfNpWCe96M6B4qkeAkh+BV
 GD/b+qB8v/W6H6mYbNA==
X-Received: from wrpe7.prod.google.com ([2002:adf:f347:0:b0:496:d435:25e5])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e05:b0:4a1:813f:2a60 with SMTP id
 5b1f17b1804b1-4bb7da03dfemr41829965e9.11.1795003838418; 
 Wed, 18 Nov 2026 04:10:38 -0800 (PST)
Date: Wed, 18 Nov 2026 12:10:37 +0000
In-Reply-To: <20261113-tyr-reset-impl-v8-2-2ee298ac9808@onurozkan.dev>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261113-tyr-reset-impl-v8-0-2ee298ac9808@onurozkan.dev>
 <20261113-tyr-reset-impl-v8-2-2ee298ac9808@onurozkan.dev>
Message-ID: <av2VvS0bRJYVwdUz@google.com>
Subject: Re: [PATCH v8 2/3] drm/tyr: add GPU reset infrastructure
From: Alice Ryhl <aliceryhl@google.com>
To: "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, dakr@kernel.org, 
 daniel.almeida@collabora.com, airlied@gmail.com, simona@ffwll.ch, 
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
 tmgross@umich.edu, boris.brezillon@collabora.com
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 05:32:27PM +0300, Onur =C3=96zkan wrote:
> +    /// Processes one scheduled reset request.
> +    ///
> +    /// If the pending reset cannot be claimed, the worker returns immed=
iately.
> +    ///
> +    /// It first claims [`ResetState::Pending`], then waits for earlier =
hardware
> +    /// accesses to complete before issuing the reset and returning the =
worker
> +    /// state to [`ResetState::Idle`].
> +    ///
> +    /// Panthor reference:
> +    /// - drivers/gpu/drm/panthor/panthor_device.c::panthor_device_reset=
_work()
> +    fn reset_work(&self) {
> +        if !self.try_transition(ResetState::Pending, ResetState::InProgr=
ess) {
> +            return;
> +        }
> +
> +        dev_dbg!(self.pdev, "Starting GPU reset.\n");
> +
> +        // Wait for current hardware accesses to finish before resetting=
.
> +        let reset_guard =3D self.hw.close();
> +        let reset_result =3D run_reset(self.pdev.as_ref(), &self.iomem);
> +        drop(reset_guard);
> +
> +        if let Err(e) =3D reset_result {
> +            dev_err!(self.pdev, "GPU reset failed: {:?}\n", e);
> +
> +            // TODO: Unplug the GPU.
> +            // There is no API for unplugging the GPU and this is unreac=
hable
> +            // for now since there are no hardware users for reset API.
> +        } else {
> +            dev_dbg!(self.pdev, "GPU reset completed.\n");
> +        }
> +
> +        let _ =3D self.try_transition(ResetState::InProgress, ResetState=
::Idle);

I'm pretty sure this needs to happen before drop(reset_guard).

> +    /// Creates [`ResetHandle`].
> +    ///
> +    /// # Safety
> +    ///
> +    /// The returned handle must not be leaked or otherwise prevented fr=
om
> +    /// running [`Drop`], since it owns work that may borrow from `'rese=
t`.
> +    pub(crate) unsafe fn new(
> +        pdev: &'reset platform::Device<Bound>,
> +        iomem: ArcBorrow<'_, IoMem<'reset>>,
> +    ) -> Result<impl PinInit<Self, Error>> {
> +        let iomem =3D iomem.into();
> +
> +        Ok(try_pin_init!(Self {
> +            // SAFETY: The caller guarantees the handle is dropped.
> +            controller <- unsafe {
> +                kernel::new_scoped_work!("tyr::reset", Controller::new(p=
dev, iomem))
> +            },
> +            wq: Queue::new_ordered().build(c"tyr-reset-wq")?,
> +        }))

The Result is not needed. This can simplify to:

	) -> impl PinInit<Self, Error> {
	    let iomem =3D iomem.into();
=09
	    try_pin_init!(Self {
	        // SAFETY: The caller guarantees the handle is dropped.
	        controller <- unsafe {
	            kernel::new_scoped_work!("tyr::reset", Controller::new(pdev, i=
omem))
	        },
	        wq: Queue::new_ordered().build(c"tyr-reset-wq")?,
	    })

> +    }
> +
> +    /// Schedules a GPU reset on the dedicated workqueue.
> +    ///
> +    /// If a reset is already pending or in progress the call is a no-op=
.
> +    #[expect(dead_code)]
> +    pub(crate) fn schedule(&'reset self) {
> +        // TODO: Similar to `panthor_device_schedule_reset()` in Panthor=
, add a
> +        // power management check once Tyr supports it.
> +
> +        if self
> +            .controller
> +            .try_transition(ResetState::Idle, ResetState::Pending)
> +        {
> +            let _ =3D self.wq.enqueue_scoped(&self.controller);
> +        }

Because this type is invariant over 'reset, it's impossible to call a
method that takes &'reset self.

I think you can just change this to &self.

Alice
