Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9289DC61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:30:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 048AE10F0A5;
	Thu, 27 Aug 2026 14:30:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cTQ12pzW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DE4310F0A5
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 14:30:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1AAF6600D2;
 Thu, 27 Aug 2026 14:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6441F00A3D;
 Thu, 27 Aug 2026 14:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787841054;
 bh=B7Tucz5bBi5CeOgkY4y8e/7bMyG2eP8R4GGEe727FzI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cTQ12pzWWuOVMgam3TptwN8JIzw9W+O9Gq2jQg6J2w9fXsxiaP4LqRB9aqZ+Ou/QY
 JPyo/wO9+fIftNOJAZQFSD1eGg7IxmqdUzB/COSRzT9e2te2uDI5ENkWpSj2Rs17Ll
 LWwGrdKk6rd+S5cS4MGmDajzC3pk0hno780dZz0yotxlpSOteUOtUJzfGGj/wVu/ip
 Q2O9DHJB+nNbkDFYpCKLkTqkucNXWe+PHoVE77DWlkpnNCLvj4YywVm6F2XZz0/3LV
 Fx/0YfdWe05mX4RKnjAxfqFZmeMlU2Cclyilf3DndJYdlPVMHOP5eN1mtU7ryhwrbh
 hUO0Ao3jUxXwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/8] rust: alloc: add Vec::push_init
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>,
 ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260827-b4-nvkv-v2-2-0de9d5c8658c@nvidia.com>
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-2-0de9d5c8658c@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 14:30:54 +0000
Message-Id: <20260827143054.7F6441F00A3D@smtp.kernel.org>
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
- [Low] Missing `#[inline]` annotation on the small abstraction function `p=
ush_init`.
--

commit 3fa22789a74731c2279859cccd39cd9ebf36a551
Author: Eliot Courtney <ecourtney@nvidia.com>

rust: alloc: add Vec::push_init

This commit adds Vec::push_init as an init-infallible version of try_push_i=
nit.

> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index fe86530624c1b..bb4da220293bc 100644
> --- a/rust/kernel/alloc/kvec.rs
> +++ b/rust/kernel/alloc/kvec.rs

[ ... ]

> @@ -369,7 +369,24 @@ pub fn push(&mut self, v: T, flags: Flags) -> Result=
<(), AllocError> {
> =20
>      /// Appends an element to the back of the [`Vec`] instance by initia=
lizing it in place.
>      ///
> -    /// Unlike [`Vec::push`], the initializer may be fallible. If the al=
location fails, the
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use pin_init::init_zeroed;
> +    ///
> +    /// let mut v =3D KVec::<[u8; 200]>::new();
> +    /// v.push_init(init_zeroed(), GFP_KERNEL)?;
> +    /// assert_eq!(v[0], [0; 200]);
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn push_init(&mut self, init: impl Init<T>, flags: Flags) -> Res=
ult<(), AllocError> {

[Severity: Low]
Should this small wrapper function be annotated with #[inline]?

The Rust subsystem guidelines state that small functions in abstraction
crates like kernel should be annotated with #[inline]. Since push_init
is a small abstraction forwarding to try_push_init, omitting the inline
annotation may inhibit cross-crate inlining by the compiler optimizer
when it is invoked from an external crate (like a driver), leading to
unnecessary function call overhead.

> +        self.try_push_init(init, flags)
> +            .map_err(|PushInitError::AllocError(_)| AllocError)
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-b4-nvkv-v2=
-0-0de9d5c8658c@nvidia.com?part=3D2
