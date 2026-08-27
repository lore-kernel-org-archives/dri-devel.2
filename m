Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC34C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADA5910F0A7;
	Thu, 27 Aug 2026 14:33:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nihSBCFl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA46510F0A7
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 14:33:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4A457414CF;
 Thu, 27 Aug 2026 14:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3301F000E9;
 Thu, 27 Aug 2026 14:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787841201;
 bh=3BpF00NijwxXeoA3FQaxE7YbtCYnUdvUOj9eCJK+OrU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nihSBCFlVmH0u1XzVdJBXJvnlygRThz5lVhdnxGUz5gpV6/kTd7tI8hQMFRaC74Ys
 39a513CL/MkmTNCVKreH5BYZQdfKuuVtaYc0ZV6+w94PWPEsh3SsAAOvISkRIfr+U8
 vN9lXHQQQpvFcw0DUo/dBjDukt/u+5EfN9RdPHWsyhWLMdfrzNbGmXs+rzrJJ98EwT
 63iHquqBVM37nKloL2DdSagFwV0F0RDfVjRydAQFaaMCaiDGOTdgUAsbeDl8oPXFmT
 i8iHPntbEq+YeYPrgK6xTprycDCUPb5t0ixom5sevCsv2YGZJLDZy6FQ989zU95+z6
 cnfkrZ2JJcjdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/8] rust: alloc: add ArrayVec
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org
In-Reply-To: <20260827-b4-nvkv-v2-3-0de9d5c8658c@nvidia.com>
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-3-0de9d5c8658c@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 14:33:20 +0000
Message-Id: <20260827143320.EA3301F000E9@smtp.kernel.org>
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
- [Low] Small abstraction functions are missing the `#[inline]` attribute.
--

commit 04be610d7cb2829e10f7bdcdb68a4d11695975ca
Author: Eliot Courtney <ecourtney@nvidia.com>

rust: alloc: add ArrayVec

Add a fixed capacity vector backed by an uninitialized array. The ArrayVec
is initializable with a closure to avoid stack construction. It provides
a way to avoid heap allocations for small but varying size arrays stored
on the stack.

> diff --git a/rust/kernel/alloc/arrayvec.rs b/rust/kernel/alloc/arrayvec.rs
> new file mode 100644
> index 0000000000000..4172a982e4775
> --- /dev/null
> +++ b/rust/kernel/alloc/arrayvec.rs
[ ... ]
> +    /// Appends an element to the back of the [`ArrayVec`].
> +    ///
> +    /// Fails when the [`ArrayVec`] is full, handing the element back in=
 [`PushError`].
> +    pub fn push(&mut self, v: T) -> Result<(), PushError<T>> {

[Severity: Low]
Should ArrayVec::push in rust/kernel/alloc/arrayvec.rs include an #[inline]
attribute?

> +        self.try_push_init(v)
> +            .map_err(|PushInitError::Full(v)| PushError(v))
> +    }
> +
> +    /// Appends an element to the back of the [`ArrayVec`] by initializi=
ng it in place.
> +    ///
> +    /// Fails with [`FullError`] when the [`ArrayVec`] is full.
> +    pub fn push_init(&mut self, init: impl Init<T>) -> Result<(), FullEr=
ror> {

[Severity: Low]
Would it be appropriate to add #[inline] to ArrayVec::push_init as well,
given that it purely forwards to try_push_init?

> +        self.try_push_init(init)
> +            .map_err(|PushInitError::Full(_)| FullError)
> +    }
[ ... ]
> +    /// Returns a slice of `MaybeUninit<T>` for the remaining spare capa=
city of the [`ArrayVec`].
> +    fn spare_capacity_mut(&mut self) -> &mut [MaybeUninit<T>] {

[Severity: Low]
Is the short helper function ArrayVec::spare_capacity_mut missing an #[inli=
ne]
attribute?

> +        // PANIC: `len` never exceeds `N` by the type invariants.
> +        &mut self.data[self.len..]
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-b4-nvkv-v2=
-0-0de9d5c8658c@nvidia.com?part=3D3
