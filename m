Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946DDC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 05:55:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A84BB10E1C7;
	Wed,  5 Aug 2026 05:55:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f0atRIIw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDC7010E1C7
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 05:55:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2166460A82;
 Wed,  5 Aug 2026 05:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD541F000E9;
 Wed,  5 Aug 2026 05:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785909342;
 bh=uaa4Fo77CRhuJiLpH9r5tlDb3SJjfeRTrxDDsQMNlB0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=f0atRIIwXbTqaJ3RUCT6zrFC7gFjCoHRWsV60Gyovd1SO05BO64Fj1LnXqtX+Yw9T
 v21Qj3jPZ3JxxLlYkEL22JBQ+9aSTZNwVbblJksjlJ8uf32WOb7vJYepcANa/lOA1R
 W9K7cO/WiLXcjJ2LD3x+xFOPv8ejC4tTyJL3TKg9iVQhipQk2IDe82y7jXJ2XaZbod
 a3XUqyE5XirL2psaw8eWReVpSrdH8zS1G/EQ5G8ztsbpsejI4cMf/AdMYWlPJKxKGW
 /OaUezNhJsTpCVPh4YAb1ARMaaRDV5B7c8JF6Fp9Lc0D8sZLQAFx13coU8HLYEBjAm
 D3xb8p7aVxceQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/12] rust: num: reject Bounded::shr overshifts at
 build time
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org
In-Reply-To: <20260805-pramin-split-v1-2-ff3e84a75dac@nvidia.com>
References: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
 <20260805-pramin-split-v1-2-ff3e84a75dac@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 05:55:42 +0000
Message-Id: <20260805055542.7FD541F000E9@smtp.kernel.org>
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
- [Medium] The `Bounded` struct derives `Default`, which safely bypasses th=
e required compile-time invariant checks in `Bounded::__new`.
--

--- Patch [2]: [PATCH 02/12] rust: num: reject Bounded::shr overshifts at b=
uild time ---
commit a9c888d83116c04cce01b982b58983e2d81e53c5
Author: Eliot Courtney <ecourtney@nvidia.com>

rust: num: reject Bounded::shr overshifts at build time

This commit updates shr in the Bounded struct to reject shifts that are
greater than or equal to the type's bit width at build time. This prevents
runtime panics or masked shift amounts.

> diff --git a/rust/kernel/num/bounded.rs b/rust/kernel/num/bounded.rs
> index dafe77782d797..f263107f001ed 100644
> --- a/rust/kernel/num/bounded.rs
> +++ b/rust/kernel/num/bounded.rs

[Severity: Medium]
This is a pre-existing issue, but does deriving Default on Bounded safely
bypass the required compile-time invariant checks?

Looking at the struct definition in rust/kernel/num/bounded.rs:

#[derive(Clone, Copy, Debug, Default, Hash)]
pub struct Bounded<T: Integer, const N: u32>(T);

The Bounded struct defines strict type invariants (such as N > 0 and
N <=3D T::BITS) which are enforced at compile time in its __new
constructor. However, deriving Default automatically implements a construct=
or
that initializes the tuple struct field via Self(T::default()), completely
bypassing __new.

Can safe downstream code construct an invalid instance using
Bounded::<u32, 0>::default()?

If this invalid instance is dereferenced, deref evaluates fits_within(0, 0),
calculating 32 - 0 =3D 32. Does left-shifting by 32 bits then trigger a run=
time
panic in debug builds due to an overshift, or mask the shift amount in rele=
ase
builds?

[ ... ]

> @@ -485,6 +485,7 @@ pub fn cast<U>(self) -> Bounded<U, N>
>      /// assert_eq!(v_shifted.get(), 0xff);
>      /// ```
>      pub fn shr<const SHIFT: u32, const RES: u32>(self) -> Bounded<T, RES=
> {
> +        const { assert!(SHIFT < T::BITS) }
>          const { assert!(RES + SHIFT >=3D N) }
> =20
>          // SAFETY: We shift the value right by `SHIFT`, reducing the num=
ber of bits needed to

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-pramin-spl=
it-v1-0-ff3e84a75dac@nvidia.com?part=3D2
