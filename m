Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431AEC5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:19:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE4A210EDF0;
	Wed, 19 Aug 2026 11:19:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V/OMyP/M";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15DF410EDF0
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 11:19:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F1AEB40B7C;
 Wed, 19 Aug 2026 11:19:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959791F000E9;
 Wed, 19 Aug 2026 11:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787138368;
 bh=NEwB5P8E3bJckGKg+azupxgPzftFyqZf7DbXSnaRsks=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=V/OMyP/Mq+rZL+8hSl9J66Fofe0rQFFk2+8cvmY6J9p4bRE3hqS64q564bMDu2IXj
 +QuMCk/Bip1VHVwVqW57Qovwa5s8iFUgtUsHaOPw4N1zHx88ihQnhrEGnwYJjsENP/
 NLaeTchbpEtA37U42yP8qm9SwCs8ZtOaKRECex1FoZuSyO6eOZqUFuCVjFsRoQ0gWo
 J7U/L4iU2UGD8BJqzqBBcfq63t6C+4KpITIx+Bamy/yWjM6NLnOtDRFSR7IVklmqRJ
 99WUL7xJAw2b2WjYdNiwFZVKhiC48P/GjFnax1aMUG/lbHX80SSGvPQHKUi2lUh6KW
 Hk0f3NGQPvr8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/16] rust: mem: add `AsRepr` and `AsReprMut`
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260819-typed_register-v3-3-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-3-3699a75fadf1@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 11:19:28 +0000
Message-Id: <20260819111928.959791F000E9@smtp.kernel.org>
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
- [Low] Incorrect use of `#[inline(always)]` instead of `#[inline]` for abs=
traction trait methods.
- [Low] The commit message asserts that 'all repr types are normalized to u=
nsigned integers', but pointer types use `*const c_void` as their represent=
ation.
--

--- Patch [3]: [PATCH v3 03/16] rust: mem: add `AsRepr` and `AsReprMut` ---
commit 0638c4f7e52f9eb87681654296d18ff15c916f15
Author: Gary Guo <gary@garyguo.net>

rust: mem: add AsRepr and AsReprMut

This commit adds AsRepr and AsReprMut traits to indicate that a type
can be turned into a primitive for operations like atomics and I/O. It
also provides implementations for booleans, pointers, and integers.

> To avoid duplicating implementation, all repr types are normalized to
> unsigned integers.

[Severity: Low]
This isn't a bug, but the commit message states that all repr types are
normalized to unsigned integers. However, the implementations for *mut T
and *const T use *const c_void as their representation instead of an
unsigned integer. Should the commit message or the pointer implementations
be updated to match?

> diff --git a/rust/kernel/mem.rs b/rust/kernel/mem.rs
> index a0901cbe1b2d6..5bce381d88952 100644
> --- a/rust/kernel/mem.rs
> +++ b/rust/kernel/mem.rs
[ ... ]
> +pub unsafe trait AsRepr: Sized {
> +    /// Primitive representation of this type.
> +    type Repr;
> +
> +    /// Convert from [`AsRepr::Repr`] to `Self`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `repr` must be a valid bit patern of `Self`. If `repr` is previo=
usly obtained using
> +    /// [`AsRepr::into_repr`], then it will always be safe.
> +    #[inline(always)]
> +    unsafe fn from_repr_unchecked(repr: Self::Repr) -> Self {

[Severity: Low]
This isn't a bug, but is #[inline(always)] the intended attribute here?
The Rust subsystem guidelines state that functions for abstractions should
be annotated with #[inline] unless they use build_assert!() dependent on
function parameters.

> +        // SAFETY: Per safety requirement of the trait.
> +        unsafe { transmute_unchecked(repr) }
> +    }
> +
> +    /// Convert from `Self` to [`AsRepr::Repr`].
> +    #[inline(always)]
> +    fn into_repr(this: Self) -> Self::Repr {

[Severity: Low]
This isn't a bug, but this method might also need to use #[inline] rather
than #[inline(always)] for the same reason.

> +        // SAFETY: Per safety requirement of the trait.
> +        unsafe { transmute_unchecked(this) }
> +    }
> +}
> +
> +/// Type that is bi-directionally transmutable with a primitive represen=
tation.
> +///
> +/// # Safety
> +///
> +/// - [`Self`] must be [transmutable] from [`Self::Repr`].
> +/// - Note that [`Self::Repr`] must be [transmutable] from `Self` as wel=
l, however that is a
> +///   requirement of the [`AsRepr`] super trait already.
> +///
> +/// [`transmutable`]: core::mem::transmute
> +pub unsafe trait AsReprMut: AsRepr {
> +    /// Convert from [`AsRepr::Repr`] to `Self`.
> +    #[inline(always)]
> +    fn from_repr(repr: Self::Repr) -> Self {

[Severity: Low]
This isn't a bug, but would it be better to use #[inline] here to follow
the abstraction guidelines?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-typed_regi=
ster-v3-0-3699a75fadf1@garyguo.net?part=3D3
