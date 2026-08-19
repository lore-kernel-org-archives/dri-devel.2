Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3828FC5DF86
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:23:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E8E210EDFD;
	Wed, 19 Aug 2026 11:23:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IaK7Ewug";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FE3010EDFD
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 11:23:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C96E560A58;
 Wed, 19 Aug 2026 11:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413291F000E9;
 Wed, 19 Aug 2026 11:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787138624;
 bh=vz0+VE4OJdUUYiH3h+69CUS+5Mc1TwuqM8kbvKTqRdg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IaK7EwugF/w1jJrqzaYuI2nAkO1DLO9xUj0UxWaLh8DI9HrgmUtUd7qUzqnCWqRR6
 CZbQxsdzIKVA79BE6CP5VkQKWB+zWhf1beuYXYT4M9kW/zuBZhvRe1IrzizHHz3pE6
 oMiYoDXXucIRTwXqB2Zryc/u408SZO9kBMYrkz2OWX0qzs+DHL3lkYHUxmx8j6y8HL
 i9RJSZVnr+G40hn9XIUAU7NvlGh0Le9MR6JfTZDHPSrwTAF9Qq5dvhEigGmosz3JFU
 iKmvwOuFLC0sos4oH4WIpR8TDqtD5Z/KUhspuiSYEYiLamCZAif5HYwk5jUxJolDjx
 Rqp94lcqCc4kQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/16] gpu: nova-core: convert hshub0 from relative
 register to projection
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260819-typed_register-v3-13-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-13-3699a75fadf1@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 11:23:43 +0000
Message-Id: <20260819112344.413291F000E9@smtp.kernel.org>
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
- [Low] Incorrect usage of `#[inline]` annotation in a driver crate.
- [Low] Imports within the `kernel::io` block are not alphabetically sorted.
--

--- Patch [13]: [PATCH v3 13/16] gpu: nova-core: convert hshub0 from relati=
ve register to projection ---
commit f28bbcca2d960a3571d5473146fa91faad20810e
Author: Gary Guo <gary@garyguo.net>
gpu: nova-core: convert hshub0 from relative register to projection

This commit converts the hshub0 relative access to use projection and a new
base, similar to previous conversions.=20

> diff --git a/drivers/gpu/nova-core/fb/hal/gb100.rs b/drivers/gpu/nova-cor=
e/fb/hal/gb100.rs
> index d9e4d62ae6321..9fa0949396009 100644
> --- a/drivers/gpu/nova-core/fb/hal/gb100.rs
> +++ b/drivers/gpu/nova-core/fb/hal/gb100.rs
> @@ -5,11 +5,10 @@
> =20
>  use kernel::{
>      io::{
> -        register::{
> -            RegisterBase,
> -            WithBase, //
> -        },
> -        Io, //
> +        io_project,
> +        register,
> +        Io,
> +        Mmio, //

[Severity: Low]
This isn't a bug, but should these imports be alphabetically sorted?=20

The kernel vertical import style usually requires sorting items alphabetica=
lly,
so Io and Mmio would typically precede the lowercase entries.

[ ... ]

> @@ -31,17 +33,26 @@
> =20
>  struct Gb100;
> =20
> -impl RegisterBase<regs::Hshub0Base> for Gb100 {
> -    const BASE: usize =3D 0x0087_0000;
> +register! {
> +    base: NovaRegisters;
> +
> +    HSHUB0: regs::Hshub0Registers @ 0x0087_0000;
> +}
> +
> +#[inline]
> +fn hshub0(bar: Bar0<'_>) -> Mmio<'_, regs::Hshub0Registers> {

[Severity: Low]
This isn't a bug, but is the #[inline] annotation needed here?=20

The Rust subsystem guidelines suggest reserving #[inline] for abstractions,
and specifically note that leaf crates like drivers are exempt from needing=
 it.

> +    io_project!(bar, build: HSHUB0)
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-typed_regi=
ster-v3-0-3699a75fadf1@garyguo.net?part=3D13
