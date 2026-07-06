Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6568C43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:02:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5791D10E1B6;
	Mon,  6 Jul 2026 13:02:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JnoeaQqn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D883910E1B6
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 13:01:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BD577416E9;
 Mon,  6 Jul 2026 13:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD0C1F00A3A;
 Mon,  6 Jul 2026 13:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783342919;
 bh=OGmcyP6BmS9wQc7/06ZhpmOGMu2PkE14odFg3emM7FI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JnoeaQqn4NU0cOna5olKzlDfV+nDyX5+m/u0/e1BC0uzXbtlE907X0k8vMDtl0ZwK
 e7S8ES0unCnuPEBXpWGuGaLaO6dfcqRZbzvbQbHF7OkNmsktF1kTwEREw7sa6ZIRSb
 Bpk5fI5n2C8RsnkK32u8VeaF8Oat4xAYGal1rD2MPSh/YwTK3XU3r+4NZ4AihV8FVb
 svb7pWRNeeRObm242nQqBwBRJSY1AIF/n4GqHt12KZhFtYIxVGHqma8vk1tjZaS8CC
 hXAKoCgldcQrZs+6yBzwzglVRJRvtlnfwJz8/h/jt4nM8SoymhCq3A4kpbHZODyAda
 DIThiuDh8jgIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 14/20] rust: io: add I/O backend for system memory
 with volatile access
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>, ojeda@kernel.org
In-Reply-To: <20260706-io_projection-v6-14-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-14-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 13:01:59 +0000
Message-Id: <20260706130159.5FD0C1F00A3A@smtp.kernel.org>
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
- [High] SysMem silently breaks the implicit endianness and memory ordering=
 contracts of the Io trait, making generic I/O abstraction unsafe on big-en=
dian architectures and weakly-ordered CPUs.
--

commit f9c9f4f480b4daad1545ae67d8a19099030dc2fd
Author: Laura Nao <laura.nao@collabora.com>

rust: io: add I/O backend for system memory with volatile access

This commit adds a SysMem backend for the Io trait, intended for kernel=20
virtual address ranges. It uses volatile accessors to provide access to=20
shared memory, allowing alternative mapping layers to devices.

> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 62643b23e9042..78c6ae2a0db82 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs

[ ... ]

> +macro_rules! impl_sysmem_io_capable {
> +    ($ty:ty) =3D> {
> +        impl IoCapable<$ty> for SysMemBackend {
> +            #[inline]
> +            fn io_read(view: SysMem<'_, $ty>) -> $ty {
> +                // SAFETY:
> +                // - Per type invariant, `ptr` is valid and aligned.
> +                // - Using read_volatile() here so that race with hardwa=
re is well-defined.
> +                // - Using read_volatile() here is not sound if it races=
 with other CPU per Rust
> +                //   rules, but this is allowed per LKMM.
> +                // - The macro is only used on primitives so all bit pat=
terns are valid.
> +                unsafe { view.ptr.read_volatile() }
> +            }
> +
> +            #[inline]
> +            fn io_write(view: SysMem<'_, $ty>, value: $ty) {
> +                // SAFETY:
> +                // - Per type invariant, `ptr` is valid and aligned.
> +                // - Using write_volatile() here so that race with hardw=
are is well-defined.
> +                // - Using write_volatile() here is not sound if it race=
s with other CPU per Rust
> +                //   rules, but this is allowed per LKMM.
> +                unsafe { view.ptr.write_volatile(value) }
> +            }

[Severity: High]
Do these volatile accessors break the implicit endianness and memory orderi=
ng
contracts established for the Io trait?

The MmioBackend implements io_write and io_read using writel and readl,
which perform little-endian byte-swapping and include memory barriers. In
contrast, SysMemBackend uses native-endian write_volatile and read_volatile
without memory barriers.

If a driver uses the Io trait generically, could this difference lead to
data corruption or DMA race conditions on big-endian or weakly-ordered
architectures? For instance, if a driver manually byte-swaps to little-endi=
an,
MmioBackend would double-swap it, whereas SysMemBackend would write the
manually swapped data.

> +        }
> +    };
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D14
