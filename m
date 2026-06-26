Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1C5CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:06:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B1C310F5A3;
	Fri, 26 Jun 2026 12:06:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I45bwjCd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D974110F5A3
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:06:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 854664083E
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8971F000E9;
 Fri, 26 Jun 2026 12:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782475563;
 bh=ZZ06f9wlGZVLS+GT6+UOydleZuBEya0yBhKsIh/LYK0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=I45bwjCdlUHV6d829FU6TZjPyN8oyq3f89Vu8Brx3ivRotc2f5rMmzEuDG/SkmcTy
 kbv+1SDvYeStsD2GwWmSXcgEYwmYH1dL8bDztOaGYbBezQ3l3ClFXveCrORS/oh+k2
 sv4sa/j8XCpSC+Dr9v+9O99q4X5byLE11oopENDQmwu3W9N8HSEg+0lToFp4PB2EAb
 4N78Zw9F4hCQpLyKNcjvJ05eS/RvJ7QKVE4uaOcm/kcBuZPOOmjjSlGegNipxbYD2K
 gFsfprdRGukSHOyORPDUlLZNnur3RbrlhpLnALWfBZrnDcFWW4SAJI/jNFefFQ8k6Y
 uw2tkr6vVYtnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 2/8] rust: types: Add Ownable/Owned types
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org
In-Reply-To: <20260626-unique-ref-v19-2-2607ca88dfdf@kernel.org>
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org>
 <20260626-unique-ref-v19-2-2607ca88dfdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 12:06:02 +0000
Message-Id: <20260626120603.1E8971F000E9@smtp.kernel.org>
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
- [High] The unsafe constructor `Owned::from_raw` and the extractor `Owned:=
:into_raw` fail to require or document the necessary pinning constraints, a=
llowing safe code to violate `Pin` guarantees.
--

commit a0693c87c8e48e6a9ddc21b1871047bae4f76436
Author: Asahi Lina <lina+kernel@asahilina.net>

rust: types: Add Ownable/Owned types

This commit introduces the Ownable trait and Owned pointer type for handling
unique ownership of C-allocated objects in Rust. It delegates resource
management to the custom drop logic of the underlying type.

Link: https://lore.kernel.org/all/20250202-rust-page-v1-1-e3170d7fe55e@asah=
ilina.net/

> diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
> new file mode 100644
> index 0000000000000..7fe9ec3e55126
> --- /dev/null
> +++ b/rust/kernel/owned.rs

[ ... ]

> +    /// Creates a new instance of [`Owned`].
> +    ///
> +    /// This function takes over ownership of the underlying object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that:
> +    /// - `ptr` points to a valid instance of `T`.
> +    /// - Until `T::release` is called, the returned `Owned<T>` exclusiv=
ely owns the underlying `T`.
> +    #[inline]
> +    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {

[Severity: High]
Does this safety documentation need to require the caller to provide a
logically pinned allocation?

Since Owned<T> guarantees its contents are pinned and provides as_pin_mut(),
a caller could pass an unpinned pointer (like a stack variable) to
from_raw(), fully complying with these documented preconditions. This would
then allow safe code to obtain a Pin<&mut T> and potentially violate Pin
invariants later.

> +        // INVARIANT: By function safety requirement we satisfy the firs=
t invariant of `Self`.
> +        // We treat `T` as pinned from now on.
> +        Self { ptr }
> +    }
> +
> +    /// Consumes the [`Owned`], returning a raw pointer.
> +    ///
> +    /// This function does not drop the underlying `T`. When this functi=
on returns, ownership of the
> +    /// underlying `T` is with the caller.
> +    #[inline]
> +    pub fn into_raw(me: Self) -> NonNull<T> {

[Severity: High]
Should the documentation here warn the caller that the returned pointer
inherits the Pin guarantee and must not be moved?

Without this, a developer could safely extract the pointer via into_raw()
and move the memory, causing undefined behavior by violating the Pin
guarantees established while it was Owned.

> +        ManuallyDrop::new(me).ptr
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-unique-ref=
-v19-0-2607ca88dfdf@kernel.org?part=3D2
