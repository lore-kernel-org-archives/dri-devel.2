Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA40C531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 06:50:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33D4310EFB0;
	Thu, 23 Jul 2026 06:50:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NXGOqbD3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F4AA10EFB0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 06:50:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A16AB600AF;
 Thu, 23 Jul 2026 06:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A9D1F000E9;
 Thu, 23 Jul 2026 06:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784789449;
 bh=zjStDI5j7z8M4XNreuG+yWJmxxBM9LCrEz0iOtDNXS0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NXGOqbD3bBuZanhWGHSelVsJqeHuBZaUggoUFrBPr0yWdCq+ZHcCLMGoRC7qoHS0N
 uvFs8OKupehBep1GZ2HrLHei0HYdnygPwoshllwMPGAcyTWQBlpedsVtW4o2ZQwZeW
 ocRcdq95sSX+K+STW5GVE0Z5W/Y3Otg+ZOgvjKr4DOECgdYg5v/U05aF/vZuHJ3w/F
 YeuEcfoy5KSL1ghc8SXYcYdbU9GysQ83KLIf3Nf1WdjYH6sc0DNhwm88qeUP4kz+dH
 eVIDcrR8fwRwmf/8tn7/VDiO1Q9EQ1rQ0KABLzuTqMzw6qYJg40O7REoUKp6Ie36eC
 n5p3IKeaA6/MA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/7] gpu: nova-core: Add public driver API to nova-core
To: "Alistair Popple" <apopple@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>,
 ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260723063046.1265791-2-apopple@nvidia.com>
References: <20260723063046.1265791-1-apopple@nvidia.com>
 <20260723063046.1265791-2-apopple@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 06:50:46 +0000
Message-Id: <20260723065049.04A9D1F000E9@smtp.kernel.org>
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
- [High] Forging a `'bound` lifetime for a local field reference inside a `=
KBox` creates a reference that outlives its referent and violates strict al=
iasing.
--

--- Patch [1]: [PATCH v3 1/7] gpu: nova-core: Add public driver API to nova=
-core ---
commit 75bdf4e26c67bf993498d459d03f978972444242
Author: Alistair Popple <apopple@nvidia.com>

gpu: nova-core: Add public driver API to nova-core

Nova core will be used to export core functionality to other drivers
which will bind to it via auxiliary bus devices. Add a NovaCoreApi type
which drivers can use to call nova-core methods.

> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driv=
er.rs
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs

[ ... ]

> @@ -86,15 +90,33 @@ fn probe<'bound>(
>                  // (`try_pin_init!()` initializes fields in declaration =
order), lives at a pinned
>                  // stable address, and is dropped after `gpu` (struct fi=
eld drop order).
>                  gpu <- Gpu::new(pdev, unsafe { &*core::ptr::from_ref(bar=
) }),
> -                _reg: auxiliary::Registration::new(
> -                    pdev.as_ref(),
> -                    c"nova-drm",
> -                    // TODO[XARR]: Use XArray or perhaps IDA for proper =
ID allocation/recycling. For
> -                    // now, use a simple atomic counter that never recyc=
les IDs.
> -                    AUXILIARY_ID_COUNTER.fetch_add(1, Relaxed),
> -                    crate::MODULE_NAME,
> -                    (),
> -                )?,
> +
> +                _reg: {
> +                    // TODO: Use `&gpu` self-referential pin-init syntax=
 once available.
> +                    //
> +                    // SAFETY: `gpu` is initialized before this expressi=
on is evaluated
> +                    // (`try_pin_init!()` initializes fields in declarat=
ion order), lives at
> +                    // a pinned stable address, and is dropped after `_r=
eg` (struct field
> +                    // drop order).
> +                    let gpu =3D unsafe {
> +                        Pin::new_unchecked(&*core::ptr::from_ref(gpu.as_=
ref().get_ref()))
> +                    };

[Severity: High]
Does creating this reference to gpu violate Rust's strict aliasing rules?

Because NovaCore is dynamically allocated in a KBox during device probe,
expanding the lifetime of the local gpu field reference to the longer 'bound
lifetime appears unsafe. The KBox does not strictly outlive 'bound since it
is dropped when the driver unbinds, which could eventually leave child
drivers holding a dangling reference.

Furthermore, when the pin_init macro completes and forms the KBox, the
underlying Box asserts unique ownership over the memory. If the previously
created reference to gpu has escaped into the externally allocated
registration data, it might be invalidated immediately under Stacked Borrows
or Tree Borrows. This could potentially lead to undefined behavior when the
reference is accessed later by the child driver.

> +
> +                    // SAFETY: `NovaCore` is dropped when the device is =
unbound;
> +                    // i.e. `mem::forget()` is never called on it.
> +                    unsafe {
> +                        auxiliary::Registration::new_with_lt(
> +                            pdev.as_ref(),
> +                            c"nova-drm",

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723063046.1265=
791-1-apopple@nvidia.com?part=3D1
