Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3D9C5DF9D
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:15:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CC6010E3D2;
	Thu, 27 Aug 2026 08:15:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Fss59sp2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2883B10EEF2
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 08:15:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7BB7E600D2;
 Thu, 27 Aug 2026 08:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6B21F000E9;
 Thu, 27 Aug 2026 08:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787818513;
 bh=TAGF2fVeDdFbrGgAIllPdWpn3FRHkSe4i68ntDwWZyk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Fss59sp22Ti14nU++RSkBjfl3BSfiewYImsuT87WR2JAMJtWuDkdAYVeHUqycMcOU
 3HnQ7CIHTLamd5Ja00NJwj4/Hks8xPF/CHsttcLLB4aqnbrG91fuJcI03apogQc75F
 8Plw09KxIn5liG4Knjltc5X4AfMVkAygqXPumkXBBFnRercuQ1zTk1Ce3L+Z3uFuWW
 QMqsNVCTwNleWtqFlYe6SBAzq2isTmscIlA4gj+KVMwgMTG3uWSoYYBz0e2/krGXwk
 Nik/AqK0FeLEBxN2NeBm7T6JWcMLqruc1ITgMFesJ/WA1ceKfSA33nM+T1ayf4xUUs
 GLt0hFEhkCq5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] drm/tyr: add TyrIrq threaded IRQ wrapper
To: "Laura Nao" <laura.nao@collabora.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260728-tyr-irq-v2-v6-1-15c90baed949@collabora.com>
References: <20260728-tyr-irq-v2-v6-0-15c90baed949@collabora.com>
 <20260728-tyr-irq-v2-v6-1-15c90baed949@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 08:15:12 +0000
Message-Id: <20260827081512.EF6B21F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The IRQ wrapper requests the threaded IRQ before clearing the devi=
ce's pending interrupt status, creating an initialization race condition th=
at can drop valid interrupts or cause IRQ storms.
--

commit e2f89c4d0d12a403d87f79e5dbf89539040c84df
Author: Laura Nao <laura.nao@collabora.com>

drm/tyr: add TyrIrq threaded IRQ wrapper

Introduce a generic TyrIrq threaded IRQ wrapper along with the
TyrIrqTrait trait describing the operations required to handle a
Tyr interrupt source.

> diff --git a/drivers/gpu/drm/tyr/irq.rs b/drivers/gpu/drm/tyr/irq.rs
> new file mode 100644
> index 0000000000000..e6a739532daa2
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/irq.rs

[ ... ]

> +impl<T: TyrIrqTrait> TyrIrq<T> {
> +    /// Requests a threaded IRQ registration for irq, using name to look=
 up the interrupt.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must not mem::forget() the resulting registration or oth=
erwise prevent its
> +    /// [Drop] implementation from running.
> +    pub(crate) unsafe fn request<'a>(
> +        pdev: &'a platform::Device<Bound>,
> +        name: &'static CStr,
> +        irq: T,
> +    ) -> Result<impl PinInit<ThreadedRegistration<'a, Self>, Error> + 'a>
> +    where
> +        T: 'a,
> +    {
> +        let handler =3D try_pin_init!(Self {
> +            irq,
> +            _pin: PhantomPinned,
> +        });
> +
> +        // SAFETY: The caller guarantees the resulting registration will=
 not be leaked.
> +        let registration =3D
> +            unsafe { pdev.request_threaded_irq_by_name(Flags::SHARED, na=
me, name, handler) };
> +
> +        // Clear the status and unmask once the handler has been
> +        // successfully registered.
> +        Ok(registration.pin_chain(|reg| {
> +            let irq =3D &reg.handler().irq;
> +            irq.clear_status(irq.mask());

[Severity: High]
Does this code request the threaded IRQ before clearing the device's pending
interrupt status?

Calling pdev.request_threaded_irq_by_name() immediately registers the
handler and enables the IRQ at the interrupt controller. However, the
hardware status is only cleared later when the .pin_chain closure executes.

If the device line is shared and level-triggered, could a pending stale
interrupt cause the hardirq handler to fire immediately? If masked, it
returns None, leading the kernel to see an unhandled level interrupt, which
could trigger an IRQ storm and permanently disable the line.

Furthermore, if a valid hardware interrupt arrives after registration but
before the .pin_chain closure runs, does irq.clear_status(irq.mask())
unconditionally wipe it out, permanently losing the event?

Should the device be quiesced (clearing status and masking) before
registering the IRQ?

> +            irq.reenable_mask();
> +            Ok(())
> +        }))
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-tyr-irq-v2=
-v6-0-15c90baed949@collabora.com?part=3D1
