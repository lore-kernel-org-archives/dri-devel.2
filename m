Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E49C5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 08:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6475310E722;
	Mon, 10 Aug 2026 08:19:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LZdRSh8f";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BDA010E720
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 08:19:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 52E72412C9;
 Mon, 10 Aug 2026 08:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A24C1F00A3A;
 Mon, 10 Aug 2026 08:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786349977;
 bh=a928142tAJcF5hB1a4L5ML4JsCtb8mVpVueYBnr2WKE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LZdRSh8fUuKTlUm2NhYiTv/148Whd34CaJANBoBYeWfEMhpcHUcBkCC/vSODzZw7n
 /o9a4ADjtaD9BOz0aycmHGaT0rHTflbhMTGMuTkCZhxwEe/qG+4Y6E4plE4kSuKuFV
 VPvN2D4sUXH02ilBWoS0Vr1mjQldhqSOo9tWgc/2Iknh7TVcCL0XzS6beLBzCxoNd/
 00Q8/SztmnD5DRj8j2BIILo5h4yEZ0Asrk+fYUCldWPtiEAN2Ap1RGIZKt1ND0mw+J
 7ZgNt/EmPzrUyPhB1jROYLyabyeT59Vc+5hAHQvZcn2e4I1MFlIJBOhbqeSm2WOTVe
 IjF3ux+omvosg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] drm/tyr: add Job IRQ handling
To: "Laura Nao" <laura.nao@collabora.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260728-tyr-irq-v2-v5-1-59fd9dea952a@collabora.com>
References: <20260728-tyr-irq-v2-v5-1-59fd9dea952a@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 08:19:36 +0000
Message-Id: <20260810081937.0A24C1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Teardown race condition: device interrupts are disabled after the =
IRQ handler is unregistered, which can cause an interrupt storm on a shared=
 IRQ line.
- [High] The threaded IRQ handler will enter an infinite loop if the device=
 becomes inaccessible, causing a CPU stall.
- [Medium] Missing dummy read after clearing the interrupt mask causes spur=
ious hardirq invocations.
--

--- Patch [1]: [PATCH v5] drm/tyr: add Job IRQ handling ---
commit 3c87c90f73f8609cae24e8591456f2e88af085b5
Author: Laura Nao <laura.nao@collabora.com>

drm/tyr: add Job IRQ handling

Add a threaded IRQ wrapper for Tyr interrupt sources and use it to
handle the firmware Job IRQ.

Link: https://lore.kernel.org/all/20260728-fw-boot-b4-v10-0-9187aefa3f2f@co=
llabora.com/
Link: https://lore.kernel.org/rust-for-linux/20260424-b4-fw-boot-v4-v4-15-a=
5d91050789d@collabora.com/
Link: https://lore.kernel.org/rust-for-linux/20260719153631.559341-1-dakr@k=
ernel.org/
Link: https://lore.kernel.org/rust-for-linux/20260726223613.1242940-1-dakr@=
kernel.org/
Link: https://lore.kernel.org/all/20260302232154.861916-1-lyude@redhat.com/

> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
> index d78ad9d292ff7..495cc3baa98c3 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs

[ ... ]

> @@ -236,3 +245,102 @@ struct Regulators {
> +impl<T: TyrIrqTrait> ThreadedHandler for TyrIrq<T> {
> +    fn handle(&self) -> ThreadedIrqReturn {
> +        let masked_status =3D self.irq.read_status();
> +
> +        if masked_status =3D=3D 0 {
> +            return ThreadedIrqReturn::None;
> +        }
> +        self.irq.clear_mask();
> +        ThreadedIrqReturn::WakeThread
> +    }

[Severity: Medium]
Is a dummy read required after clearing the mask to flush the posted write?

Looking at JobIrq::clear_mask() in fw/irq.rs, it performs a raw MMIO write
without a subsequent dummy read:

    fn clear_mask(&self) {
        self.iomem.write_reg(JOB_IRQ_MASK::zeroed());
    }

If the write hasn't reached the device when handle() returns WakeThread,
could the interrupt controller immediately re-invoke the hardirq handler,
causing spurious invocations?

> +
> +    fn handle_threaded(&self) -> IrqReturn {
> +        let mut ret =3D IrqReturn::None;
> +
> +        loop {
> +            let raw_status =3D self.irq.read_raw_status() & self.irq.mas=
k();
> +            if raw_status =3D=3D 0 {
> +                break;
> +            }

[Severity: High]
Does this loop need a safeguard against MMIO reads returning 0xFFFFFFFF?

If the device becomes inaccessible (e.g. from surprise removal, loss of
power, or a bus error) while handle_threaded() is running,=20
read_raw_status() might return all 1s.

Since that value bitwise-ANDed with mask() is non-zero, could this cause=20
the kernel thread to spin indefinitely and result in CPU stalls?

> +            self.irq.clear_status(raw_status);
> +            self.irq.handle(raw_status);
> +            ret =3D IrqReturn::Handled;
> +        }
> +
> +        self.irq.reenable_mask();
> +        ret
> +    }
> +}
> +
> +#[pinned_drop]
> +impl<T: TyrIrqTrait> PinnedDrop for TyrIrq<T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        self.irq.clear_mask();
> +    }
> +}

[Severity: High]
Will clear_mask() execute too late during teardown, leading to an interrupt
storm?

Since TyrIrq is embedded inside the ThreadedRegistration returned by
request_threaded_irq_by_name(), the Rust drop order will drop the
ThreadedRegistration first (which calls free_irq()), followed by TyrIrq
(which calls clear_mask() here).

If the device asserts an interrupt after free_irq() completes but before
clear_mask() runs, could the unhandled interrupt on a shared line result
in an IRQ storm that permanently disables the IRQ line?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-tyr-irq-v2=
-v5-1-59fd9dea952a@collabora.com?part=3D1
