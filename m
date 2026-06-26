Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678CBC43327
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C805A10F5F0;
	Fri, 26 Jun 2026 15:01:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AoArrreP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AEE710F5F0
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 15:01:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7346E42D98;
 Fri, 26 Jun 2026 15:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B0B1F00A3A;
 Fri, 26 Jun 2026 15:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782486092;
 bh=h9NEUzGlZeqdSBID1pom6o9yW7H60IVY9t8Gg3d7V+o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AoArrrePLouzx4Q9Djy9jf77LHx+3iquJ4MdXT2Gu9S8Q9yVTg2UQrug3HUiVvVj6
 F1PifbH5ise81dd6CdEyOys60hQK9alReEZtKf1cyf5gw2QtT2Ly+ISN4bt2Fp0BHw
 5N4/xH/nlIouAHVxbSWI2sc64WDnyj7rU75u7QxuqQgSW255RW1YzmHLuieo77a2AJ
 YcsI4WzoAYByX7vjkjFLCfotFSRIgvv66lXS9Ce4XxI5uuM1hPZPeXOvi4ExG7xyS2
 wSrsVyM/0DfzrwKu7iBPAGJR1amGqN9/KGH/yQ6GvNhFHmooDRrNfk2cubtMg4PF3M
 9z5tfS8crDqcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/20] rust: io: implement `Mmio` as view type
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org,
 ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260626-io_projection-v5-7-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-7-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 15:01:30 +0000
Message-Id: <20260626150131.E1B0B1F00A3A@smtp.kernel.org>
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
- [Low] The infallible `read64` and `write64` methods cause a compilation e=
rror on 64-bit architectures when used with standard `Region` types due to =
a static alignment mismatch.
--

commit 0321066113dacd6668c86fd092b4b4ebb3e4e5e0
Author: Gary Guo <gary@garyguo.net>

rust: io: implement Mmio as view type

This commit implements Mmio and RelaxedMmio as view types, and delegates the
I/O implementations of MmioOwned to these new views. It also updates the
existing users of MmioOwned in the documentation to reflect the new semanti=
cs.

> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs

[ ... ]

> -impl_mmio_io_capable!(
> -    MmioOwned,
> -    #[cfg(CONFIG_64BIT)]
> -    u64,
> -    readq,
> -    writeq
> -);
> +#[cfg(CONFIG_64BIT)]
> +impl_mmio_io_capable!(Mmio, u64, readq, writeq);

[Severity: Low]
Will this cause a compilation error on 64-bit architectures when read64 or
write64 are used with standard Region types?

Looking at the static assertions for I/O operations (like io_addr_assert or
the refactored io_view_assert), u64 requires 8-byte alignment, but
Region::MIN_ALIGN is statically set to 4.=20

Does this mean the static assertion checking alignment (comparing Alignment=
::of
against MIN_ALIGN) will unconditionally evaluate to false and abort compila=
tion
when drivers attempt to use infallible 64-bit I/O on Region-backed mappings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D7
