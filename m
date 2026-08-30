Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FFCC61DD9
	for <dri-devel@archiver.kernel.org>; Sun, 30 Aug 2026 10:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55BC010E1AB;
	Sun, 30 Aug 2026 10:47:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FK3Iei3P";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 941E410E1AB
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 10:47:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 65FC5600AE;
 Sun, 30 Aug 2026 10:47:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA221F000E9;
 Sun, 30 Aug 2026 10:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788086832;
 bh=3Jzzlc3I7vX9wSrB6NISTYOmr+2YT3G7jwl+9RRxW3k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FK3Iei3P+d3tnoiRS8fFzMcIn5g70+vDrA8oL9t/6/Zyqa1ImdzzjcvJ/u5duluXF
 /eFafljl9jz7PKq7GAwYhlckOOobCYeOfdQ5fyBji/lVodAeIcOsw8cC0NO25mS7x6
 jXaRBf1gLstLB+ymp5QCzX6v06ToG0eIW4o/zYRlCdAPJyPAs4D6VAFidNBmQvQdh9
 HLhUn1CNPS2fUI5eNoNaHHc2FopQW+2ZHQDIRB3rzuBu2rbuItV5GbXHVhKLQoXmtm
 VGVGEIMWREkR/oDezzfPuJ4kPPaSG1zFscXvREhwDK95g8j57wAVh5q4rfwG7RsAvO
 s7oxzL7dk0HEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] linux/log2.h: Add 64-bit safe variants of
 power-of-two functions
To: "David Gow" <david@davidgow.net>
Cc: dri-devel@lists.freedesktop.org, dsterba@suse.cz
In-Reply-To: <20260830103321.2042968-1-david@davidgow.net>
References: <20260830103321.2042968-1-david@davidgow.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 10:47:11 +0000
Message-Id: <20260830104711.DBA221F000E9@smtp.kernel.org>
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
- [High] `__roundup_pow_of_two_u64()` computes the wrong value for `n =3D 1=
` when optimizations propagate the constant, due to misuse of `ilog2(0)`.
- [Low] Kernel-doc comment for `__rounddown_pow_of_two_u64` incorrectly use=
s the suffix `_64` instead of `_u64`.
--

commit 1b2e30cc48e12ee945f73271fbcb60bed282f343
Author: David Gow <david@davidgow.net>

linux/log2.h: Add 64-bit safe variants of power-of-two functions

This commit adds 64-bit safe variants of power-of-two functions which always
operate on a 64-bit value regardless of sizeof(long). It also removes a
conflicting implementation from i915.

> diff --git a/include/linux/log2.h b/include/linux/log2.h
> index e17ceb32e0c97..fc44e59f57328 100644
> --- a/include/linux/log2.h
> +++ b/include/linux/log2.h
[ ... ]
> @@ -195,6 +211,63 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
>  	__rounddown_pow_of_two(n)		\
>   )
> =20
> +/**
> + * __rounddown_pow_of_two_64() - round a 64-bit value down to nearest po=
wer of two
> + * @n: value to round down
> + */
> +static inline __attribute_const__
> +u64 __rounddown_pow_of_two_u64(u64 n)

[Severity: Low]
Is there a typo in the kernel-doc function name?

The comment documents __rounddown_pow_of_two_64, but the function is named
__rounddown_pow_of_two_u64. Will this cause kernel-doc warnings?

> +{
> +	return 1ULL << ilog2(n);
> +}
> +
[ ... ]
> +/**
> + * __roundup_pow_of_two_u64() - round a 64-bit value up to nearest power=
 of two
> + * @n: value to round up
> + */
> +static inline __attribute_const__
> +u64 __roundup_pow_of_two_u64(u64 n)
> +{
> +	return 1ULL << (ilog2(n - 1) + 1);
> +}

[Severity: High]
Can this compute the wrong value for n =3D 1 if the compiler propagates the
constant after macro expansion?

If n =3D 1 is passed to roundup_pow_of_two_u64(n) and __builtin_constant_p(=
n)
evaluates to false at macro expansion time, it will fall back to calling th=
is
inline function.

When the compiler later inlines the function and proves n =3D 1 via constant
propagation, it will evaluate ilog2(0).

Inside the ilog2(0) macro, __builtin_constant_p(0) evaluates to true, so it
takes the constant branch (0 < 2 ? 0 : ...), which evaluates to 0.

Would this result in 1ULL << (0 + 1) returning 2 instead of 1?

Should this use fls64(n - 1) instead, similar to how the 32-bit
__roundup_pow_of_two() uses fls_long(n - 1)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830103321.2042=
968-1-david@davidgow.net?part=3D1
