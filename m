Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD560C5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 14:07:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 240DA10E89E;
	Mon, 10 Aug 2026 14:07:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ljeTOqSk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 371C310E89E
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:07:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4C2BC60120;
 Mon, 10 Aug 2026 14:07:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EAC1F000E9;
 Mon, 10 Aug 2026 14:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786370858;
 bh=ozr240zYFHeLPupAmwKvRYqCaf5IhVtuPeBTvdYWCiA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ljeTOqSk4xXHrtp8SiKm25nOQO1CFUdSQSqVlKqu2ypdDyMDfhWX7VHjxd6ACUysx
 IB60oFJPhCHY75MyySJP7NHkvAdaNu5XF3u28TKzXirElJ8o0z+QvUJXg4o7qS0HSF
 klIlBg83dpx67K/f7ik80KJmVaZP72BkB3GeN/BVW0YRJG/yhh8/rdlN2DtTjNO80S
 jxjms5p3H8AO4HvQ0+BKkgPj3L5VLcIat+h+K16PrV0YVxAtATEQANxs8oNryBW3r9
 nOTJ8a7Ss+51ysnaNdPmT22Sxb0/DQtXVmMEYjx5BbOthAUKJWX0Hqgc+mMBKZtmjP
 Dw4rMp1JiSCCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/12] rust: num: use const_assert! in Bounded
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260810-pramin-split-v2-1-65a00b3c7309@nvidia.com>
References: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
 <20260810-pramin-split-v2-1-65a00b3c7309@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 14:07:37 +0000
Message-Id: <20260810140737.89EAC1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but Bounded::shr=
 lacks a bound check for SHIFT < T::BITS, allowing wrapping shifts that bre=
ak safety invariants and lead to Undefined Behavior.
--

--- Patch [1]: [PATCH v2 01/12] rust: num: use const_assert! in Bounded ---
commit afcfa782abd748c8cc818867c320e813e00f8278
Author: Eliot Courtney <ecourtney@nvidia.com>

rust: num: use const_assert! in Bounded

This patch converts the const-block asserts in bounded.rs to use the
const_assert! macro, matching the styling in the rest of the file.

> diff --git a/rust/kernel/num/bounded.rs b/rust/kernel/num/bounded.rs
> index dafe77782d797..9ad7df1a243d9 100644
> --- a/rust/kernel/num/bounded.rs
> +++ b/rust/kernel/num/bounded.rs
> @@ -485,7 +485,7 @@ pub fn cast<U>(self) -> Bounded<U, N>
>      /// assert_eq!(v_shifted.get(), 0xff);
>      /// ```
>      pub fn shr<const SHIFT: u32, const RES: u32>(self) -> Bounded<T, RES=
> {
> -        const { assert!(RES + SHIFT >=3D N) }
> +        const_assert!(RES + SHIFT >=3D N);

[Severity: Critical]
This isn't a bug introduced by this patch, but does Bounded::shr lack a
bounds check for SHIFT being less than the number of bits in the type?

If a caller invokes Bounded::shr with a SHIFT value greater than or equal to
the bit width of the type, the shift amount can be masked in release builds
without overflow checks. This would leave the original value unchanged.

Because the condition RES + SHIFT >=3D N would still be satisfied, this
unchanged value is unsafely wrapped in the returned Bounded type. If the
value exceeds RES bits, it breaks the safety invariant of the struct.
Subsequent safe calls like Bounded::cast could then trigger undefined
behavior when encountering unwrap_unchecked on a failed try_from conversion.

Could we add an additional bounds check here to prevent wrapping shifts?

> =20
>          // SAFETY: We shift the value right by `SHIFT`, reducing the num=
ber of bits needed to
>          // represent the shifted value by as much, and just asserted tha=
t `RES >=3D N - SHIFT`.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810-pramin-spl=
it-v2-0-65a00b3c7309@nvidia.com?part=3D1
