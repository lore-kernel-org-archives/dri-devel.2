Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FF2C55822
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 05:51:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85D3810ECC8;
	Wed,  5 Aug 2026 05:51:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PSUN4mJQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5907A10ECC8
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 05:51:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9FFFC600B1;
 Wed,  5 Aug 2026 05:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BE31F000E9;
 Wed,  5 Aug 2026 05:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785909075;
 bh=yBeAjYBbUgXecUns1vOoIgVhTHmIOm7k45twEZthb7s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PSUN4mJQGyFDCaSjUfEri/KC4O0ctvjKmDP8rqab1W+WN1u1j+wPbWmyfzdXq1QUJ
 iF6Nl/3a14yLYQhGKhpVFAzXvDuffCakI1S0zkxs3JlCoSOvWrAEPlcMsMy9tmvryI
 6+sBBhbLvbG8ZUPvGyrywJc6sLylEnqwXvroGLZqBg37wmfbwnroyh6I57Y5I4bg17
 naG9DJDE5VvWhcna6HZ6iZzPwGny0CQbkd+2Wn+LeJ7beTNHL/xYilEG4X0j3tss9i
 Ag4pG4qid0I7ZyFZ0FR0xCsvD9HPrRZL8E6Oa+ORzQhh5SUAoQrKxlqTBGbRS1MDfG
 6KNca7rnE/AEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/12] rust: num: add Bounded::shr_exact
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, ojeda@kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260805-pramin-split-v1-3-ff3e84a75dac@nvidia.com>
References: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
 <20260805-pramin-split-v1-3-ff3e84a75dac@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 05:51:14 +0000
Message-Id: <20260805055115.12BE31F000E9@smtp.kernel.org>
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
- [Low] The small abstraction function `shr_exact` is missing the `#[inline=
]` attribute.
--

--- Patch [3]: [PATCH 03/12] rust: num: add Bounded::shr_exact ---
commit fe8d74a80e41351c792119ee859ab7990c063f88
Author: Eliot Courtney <ecourtney@nvidia.com>

rust: num: add Bounded::shr_exact

This commit adds shr_exact to shift a bounded value right only if it loses
no set bits. This is useful for getting a shifted down integer while
simultaneously checking that it is aligned.

> diff --git a/rust/kernel/num/bounded.rs b/rust/kernel/num/bounded.rs
> index f263107f001ed..2695a7858d8ad 100644
> --- a/rust/kernel/num/bounded.rs
> +++ b/rust/kernel/num/bounded.rs
[ ... ]
> +    /// // A set bit would be shifted out.
> +    /// let v =3D Bounded::<u32, 16>::new::<0xff01>();
> +    /// let v_shifted: Option<Bounded<u32, 8>> =3D v.shr_exact::<8, _>();
> +    ///
> +    /// assert!(v_shifted.is_none());
> +    /// ```
> +    pub fn shr_exact<const SHIFT: u32, const RES: u32>(self) -> Option<B=
ounded<T, RES>> {

[Severity: Low]
This isn't a bug, but should this small abstraction function be annotated
with #[inline]? According to the Rust subsystem coding guidelines, functions
that are small or forwarding to a binding call should be annotated with
#[inline].

> +        let shifted =3D self.shr::<SHIFT, RES>();
> +        if shifted.get() << SHIFT =3D=3D self.0 {
> +            Some(shifted)
> +        } else {
> +            None
> +        }
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-pramin-spl=
it-v1-0-ff3e84a75dac@nvidia.com?part=3D3
