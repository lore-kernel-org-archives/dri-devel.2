Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F095C55ABA
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 15:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 737FC10EEC8;
	Wed,  5 Aug 2026 15:03:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kfECq8w9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EF0410E171
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 15:03:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9AED643422;
 Wed,  5 Aug 2026 15:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474581F000E9;
 Wed,  5 Aug 2026 15:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785942217;
 bh=FngmsmDst1YMQ0u473yCobG+KzI8BNiro/xY3GJEjxo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kfECq8w9BrRmS3pZVX0M8iWyfwhJWvIuOa3bmGC0T0aAJuiOOlKAs4DYOpjMeXuey
 t0+YMfaa2Xvjz7r0Yw1fBUbGz/fXIY4eGzd7lisjl0ie8ZiyaeaM6HBUUjCdHCkAuo
 1ZowPo0X080lEYQCO04jnkhTI0VNCDWz3iM94x711zOzqUGOwBTtTM1OqL6N1IaNUB
 GTqYg/XXXI+A+jXsNuuuInE9uSXKKU/xSWC+7N4FhIwwrNd2df/fseyJz3Zhk9IdJ9
 pPl/KuRQhAxl/GSaZ6Aexy37PNXbHoVvDKuoReB7QCCqEu1b4+Y5fb7b8iJFMdu9O+
 hmr9FOpnuq+CQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] drm/tyr: add Job IRQ handling
To: "Laura Nao" <laura.nao@collabora.com>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260805-tyr-irq-v2-v4-1-81a4701611c0@collabora.com>
References: <20260805-tyr-irq-v2-v4-1-81a4701611c0@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 15:03:36 +0000
Message-Id: <20260805150337.474581F000E9@smtp.kernel.org>
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
- [High] Missing interrupt mask teardown leaves the device asserting the ph=
ysical IRQ line when the driver is unloaded, risking an IRQ storm on a shar=
ed line.
--

--- Patch [1]: [PATCH v4] drm/tyr: add Job IRQ handling ---
commit fd73c579108c1051f2238bc09dcd25149bcc3d3b
Author: Laura Nao <laura.nao@collabora.com>

drm/tyr: add Job IRQ handling

Add a threaded IRQ wrapper for Tyr interrupt sources and use it to handle
the firmware Job IRQ. A wait queue and a bool flag are added so the handler
can signal firmware readiness when the GLB bit is set.

> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
> index bfb0ba19caff9..020df7c257355 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
[ ... ]
> +/// A threaded IRQ wrapper shared by all Tyr interrupt sources.
> +#[pin_data]
> +pub(crate) struct TyrIrq<T: TyrIrqTrait> {
> +    /// The interrupt source.
> +    irq: T,
> +    #[pin]
> +    _pin: PhantomPinned,
> +}

[Severity: High]
Does this wrapper need a Drop (or PinnedDrop) implementation to clean up the
interrupt mask?

If the registration is dropped (for example, during driver unbind or probe
failure), there doesn't seem to be a call to clear_mask(). Leaving the
interrupt unmasked while the handler is unregistered could cause an unhandl=
ed
IRQ storm if the device asserts the line. This might potentially cause the
kernel's IRQ core to permanently disable a shared IRQ line.

[ ... ]
> diff --git a/drivers/gpu/drm/tyr/fw/irq.rs b/drivers/gpu/drm/tyr/fw/irq.rs
> index 0000000000000..fcdc0097f2dde
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/fw/irq.rs
[ ... ]
> +    // SAFETY: The caller guarantees the resulting registration will not=
 be leaked.
> +    let registration =3D unsafe { TyrIrq::request(pdev, c"job", job_irq)=
 };
> +
> +    // Unmask once the handler has been successfully registered.
> +    Ok(registration?.pin_chain(|reg| {
> +        reg.handler().irq().reenable_mask();
> +        Ok(())
> +    }))
> +}

[Severity: High]
Since the interrupt is explicitly unmasked here via reenable_mask() during
initialization, shouldn't there be a corresponding teardown step to mask it
again when the registration chain is dropped?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-tyr-irq-v2=
-v4-1-81a4701611c0@collabora.com?part=3D1
