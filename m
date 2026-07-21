Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770CBC4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:08:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC02D10EAD5;
	Tue, 21 Jul 2026 17:08:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hWXpabdF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B71F10EACE
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 17:08:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 84EA341A82;
 Tue, 21 Jul 2026 17:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B381F000E9;
 Tue, 21 Jul 2026 17:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784653710;
 bh=eejtYFSfYQrwyaH+yPZ3tVpj7lpIoZ7iAQC126jsg2Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hWXpabdF1wTxp95W/qsHVR9TBEQ/n3fruaLQ0tib2zf+eOO9AtTkEFFZ3sXB2JgiR
 wNdCFOaFLDw1T7c9la5fypz1xMT7N/NC/Grz2+S0PcI7EeC1IfKqJDWshFPcdHkj6s
 3GrGIaQo/M13dqk7mjZFughlobdDP8eZA1WE8YqG7v+tE88O3MkdykvNeRpTEJt2Bo
 hq9J3GAeP6jSkjKV76RF/Mektq46Ztq8uLjbgwln+L5RHadN7pLFwBD/Xtr5QJRwnC
 gOzAuG4ijciFuRTn5/rdC+Xqm0R2qYfcBNSYdnkEjlIwH4qkkqMU4Ogryc3AGQnoRM
 LXkJsQlclCQXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/10] rust: io: add static `cast()` method for views
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org,
 linux-pci@vger.kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260721-typed_register-v1-6-452d72b60262@garyguo.net>
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-6-452d72b60262@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 17:08:29 +0000
Message-Id: <20260721170830.23B381F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The rustdoc example for `cast<U>` contains a visible code snippet t=
hat will fail to compile if uncommented and used, because it uses an unsize=
d `Region`.

Pre-existing issues:
- [High] Clock prepare/enable state is leaked on error paths during probe.
--

--- Patch [6]: [PATCH 06/10] rust: io: add static `cast()` method for views=
 ---
commit bc8b9f11b619bcfae6c2907cbb69af497e185e8b
Author: Gary Guo <gary@garyguo.net>

rust: io: add static cast() method for views

Add a compile-time checked variant of try_cast() using the minimum size
and alignment information.

Signed-off-by: Gary Guo <gary@garyguo.net>

> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index c5f07c38e59e5..0f8b166a6d3bb 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs

[ ... ]

> +    /// # Examples
> +    ///
> +    /// ```no_run
> +    /// use kernel::io::{
> +    ///     io_project,
> +    ///     Mmio,
> +    ///     Io,
> +    ///     Region,
> +    /// };
> +    /// #[derive(FromBytes, IntoBytes)]
> +    /// #[repr(C)]
> +    /// struct MyStruct { field: u32, }
> +    ///
> +    /// # fn test(mmio: &Mmio<'_, Region<0x1000>>) {
> +    /// // let mmio: Mmio<'_, Region>;

[Severity: Low]
Does this rustdoc example compile successfully? Using an unsized Region here
might result in a compile-time assertion failure if a developer uncomments
and tries to use it.

> +    /// let whole: Mmio<'_, MyStruct> =3D mmio.cast();
> +    /// # }
> +    /// ```
> +    #[inline]
> +    fn cast<U>(self) -> <Self::Backend as IoBackend>::View<'a, U>

[ ... ]

I also noticed a pre-existing issue in drivers/gpu/drm/tyr/driver.rs:

drivers/gpu/drm/tyr/driver.rs:TyrPlatformDriver::probe() {
[ ... ]
        core_clk.prepare_enable()?;
        stacks_clk.prepare_enable()?;
        coregroup_clk.prepare_enable()?;

        let mali_regulator =3D Regulator::<regulator::Enabled>::get(pdev.as=
_ref(), c"mali")?;
        let sram_regulator =3D Regulator::<regulator::Enabled>::get(pdev.as=
_ref(), c"sram")?;
[ ... ]
}

[Severity: High]
This is a pre-existing issue, but does this leak the clock prepare/enable
state on error paths?

If operations like Regulator::get() fail and return an error like
-EPROBE_DEFER, the function returns early. The Clk instances are dropped,
but it doesn't seem to unprepare or disable the clocks before they are
wrapped in the Clocks struct later in the function.

Could this permanently lock the hardware clocks in the enabled state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-typed_regi=
ster-v1-0-452d72b60262@garyguo.net?part=3D6
