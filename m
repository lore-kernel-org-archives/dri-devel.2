Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D80C44512
	for <dri-devel@archiver.kernel.org>; Sun, 19 Jul 2026 20:17:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B738210E0A7;
	Sun, 19 Jul 2026 20:17:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L7OxzYoG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 238EB10E0A7
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 20:17:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A557B4378E;
 Sun, 19 Jul 2026 20:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DD11F000E9;
 Sun, 19 Jul 2026 20:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784492224;
 bh=pdo6izOoKWxQXD4uDvND688C2pO48q2coVGlV4/oT88=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L7OxzYoGXzkPtZzgZosmFxa934JSBPkpdv+nj4SEl0o8eCnnHJK7U79neOzz0CgV3
 KSXxaz+Dv9MAjr5KipVjkdkkG9IN+jtcFxYS9U2emPWDBMuN3rFyu9mud7BfVOILWE
 PhvlTMuyiH15HvRJMKhvEMY3iEBV0bnw0xtfEQOdIs2RRcXIN8uSXWVMYIPu5pSPrD
 cwnpNEyVmmgs6CB7rx6E7WJo5sLGvV4hhxSyOker6JC5CyuepaNoG66RGODMfruxN/
 jQQtXmWUCWaLfpKj57kQnJAdY2YWReH1fjNKMy41z4wuNJdCw/hFjUCNrVQmzEHEEh
 mV3F0Z78Q4ePg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] rust: io: convert ResourceSize into a transparent
 newtype
To: "Lorenzo Delgado" <lnsdev@proton.me>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260719200945.687904-1-lnsdev@proton.me>
References: <20260712113602.389060-1-lnsdev@proton.me>
 <20260719200945.687904-1-lnsdev@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Jul 2026 20:17:03 +0000
Message-Id: <20260719201704.06DD11F000E9@smtp.kernel.org>
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
- [Medium] Incomplete API Implementation: PCI FFI boundary methods continue=
 to return raw `bindings::resource_size_t` instead of the typed `ResourceSi=
ze` API.
- [Low] Incorrect import order for `core::num::TryFromIntError` violating k=
ernel guidelines.
--

--- Patch [1]: [PATCH v2] rust: io: convert ResourceSize into a transparent=
 newtype ---
commit b81b66fe76cbe9487443105d289e399a714dd21d
Author: Lorenzo Delgado <lnsdev@proton.me>

rust: io: convert ResourceSize into a transparent newtype

This patch wraps ResourceSize in a #[repr(transparent)] newtype to prevent
unintended integer operations and truncating casts. It provides explicit
boundary conversions and updates existing producers and consumers to use the
new typed API.

Link: https://github.com/Rust-for-Linux/linux/issues/1203

> Wrap it in a `#[repr(transparent)]` newtype so each conversion at a
> boundary becomes explicit and reviewable. The representation is
> unchanged, so this is ABI-identical; only the spelling at the FFI
> boundary changes. Provide the conversion surface `from_raw`/`into_raw`,
> `From` in both directions, and a fallible `TryFrom<ResourceSize> for
> usize` for checked narrowing. Update the two producers, `Resource::size`
> and `SGEntry::dma_len`, and the `request_region` consumer. In nova-core,

[Severity: Medium]
Does this miss other producers in the FFI boundary?

Looking at rust/kernel/pci.rs, both resource_start() and resource_len()
continue to return the raw bindings::resource_size_t type rather than the
new ResourceSize type.

Should these functions also be updated to return the new ResourceSize
type to ensure the API remains consistent and fully protected against
implicit casts across the subsystem?

> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index fcc7678fd9e3c..ebf00b4536d6d 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -6,9 +6,12 @@
> =20
>  use crate::{
>      bindings,
> +    fmt,
>      prelude::*, //
>  };
> =20
> +use core::num::TryFromIntError;

[Severity: Low]
This isn't a bug, but should the core import be placed before the crate
imports?

The kernel's Rust coding guidelines typically require vertical imports
where core and alloc are grouped together and placed before kernel (or crat=
e)
imports.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719200945.6879=
04-1-lnsdev@proton.me?part=3D1
