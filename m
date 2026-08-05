Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713CBC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6C5D10EF4A;
	Wed,  5 Aug 2026 16:43:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IJX+rkKX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AA3A10EF4A
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 16:43:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F20B24183B;
 Wed,  5 Aug 2026 16:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2511F000E9;
 Wed,  5 Aug 2026 16:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785948221;
 bh=MvzRydyz06HIj9hgvBQ5xnNg7QdfpNlyKvTAIoy0cbg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IJX+rkKXccakWbAuXRy+dYvsSllaCXRDGFuDPzT4C52lPTPiu6JMx3qRbkBuPJbs+
 KPFw9VrbeKz5s5T28NWVEW7wZo3lt+a/V5/Sg5SDKcjV39whfYN+AGWvF+sLEwQ5aP
 WJlnIIOwV/YY+62Mppe+9+46fBF34DKr+2Pqf8dP0zSNEzmQ8ygm6sZDaiKw0dW3kO
 +mi99TF8iBx5z0vCC71gPAu10b2O2X3x4hKMLr0bJaX+E6rZsNS4lWVrdGFRmOX81r
 10JPQL7eLI4s68JZmQICptINN2w5GIpOBDlnwb9Myhf+pCUQCSGqurfiTneTtN81v/
 peqSCdvVvQl9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/16] rust: io: register: handle one register at a time
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260805-typed_register-v2-4-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-4-c3ca142220a0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:43:40 +0000
Message-Id: <20260805164341.7E2511F000E9@smtp.kernel.org>
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
- [Low] The refactored `register!` macro uses a tail-recursive TT-muncher p=
attern, which increases macro recursion depth linearly with the number of r=
egisters defined. This can cause compilation failures (reaching rustc's rec=
ursion limit) for macro blocks defining a large number of registers.
--

--- Patch [4]: [PATCH v2 04/16] rust: io: register: handle one register at =
a time ---
commit 8ec2a5aa6d4bcb8811ecb0ce6d13218a169b562d
Author: Gary Guo <gary@garyguo.net>

rust: io: register: handle one register at a time

This commit refactors the register! macro to match and handle one register
definition at a time using a recursive pattern. It aims to simplify the rule
definitions by avoiding a single catch-all repetition rule.

> diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
> index d898b2b46d521..91804c1ca117d 100644
> --- a/rust/kernel/io/register.rs
> +++ b/rust/kernel/io/register.rs
[ ... ]
> @@ -786,44 +786,25 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
>  /// ```
>  #[macro_export]
>  macro_rules! register {
[ ... ]
> -    // All the rules below are private helpers.
> +    () =3D> {};
> =20
>      // Creates a register at a fixed offset of the MMIO space.
>      (
> -        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) @ $off=
set:literal
> +        $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) @ $offset:l=
iteral
>              { $($fields:tt)* }
> +        $($rest:tt)*
>      ) =3D> {
>          $crate::register!(@bitfield $(#[$attr])* $vis struct $name($stor=
age) { $($fields)* });
>          $crate::register!(@io_base $name @ $offset);
>          $crate::register!(@io_fixed $(#[$attr])* $vis $name);
> +        $crate::register!($($rest)*);

[Severity: Low]
Does this recursive pattern increase the macro recursion depth linearly with
the number of registers defined?

If a single register! block contains a large number of registers, this tail
recursion might exceed rustc's default recursion limit and cause compilation
failures. While this can be worked around by splitting the definitions into
multiple register! invocations, it is a regression compared to the previous
repetition pattern.

>      };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-typed_regi=
ster-v2-0-c3ca142220a0@garyguo.net?part=3D4
