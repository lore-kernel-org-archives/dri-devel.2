Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7582C5DF87
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 09:30:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FB1A10F281;
	Fri, 21 Aug 2026 09:30:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j+/7//V7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0C9F10F281
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 09:30:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2B1136001A;
 Fri, 21 Aug 2026 09:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDD31F000E9;
 Fri, 21 Aug 2026 09:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787304633;
 bh=OqOmYjlES3PmKvZ3hYN4Z5kHBhb6kt6R+WQ1flLRUHU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=j+/7//V77waRDzLHrF0ouzV2gfrp0wjKkiPdk5RhEl/TE6mvb68X5qq7C3tYbcerH
 e9qaHrIBc/HYRkr8Gs0lW/0Wn1Z+qCuA/mG2SqWI5+fMKjfjnWFwydDe54etSyJ4bW
 xkFnpGHPF6f7hIqTrxI3gt5+gBEa6+Fn0MSFNonYQLGTqPBPaUwdB3KL7uNHzqKwoZ
 5KdUBTd5orgNISunotwsclmVmfSE9Zslih4HeACYDMhH00BaP0QbdZHQKJb1WCr1MV
 kZsSGXk6UJfpjqrMK3TIbS+eEhicStaizYgQwVZyB/DBOunsA4ZNP1IzvJGnEUDlMl
 1M0ouCD6UT1zA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] linux/log2.h: Add round{up,down}_pow_of_two64()
To: "David Gow" <david@ingeniumdigital.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260821091918.1902032-1-david@ingeniumdigital.com>
References: <20260821091918.1902032-1-david@ingeniumdigital.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 09:30:33 +0000
Message-Id: <20260821093033.ADDD31F000E9@smtp.kernel.org>
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
- [Medium] Calling `__roundup_pow_of_two64(1)` evaluates `ilog2(0)`, violat=
ing the `ilog2()` API contract and relying on undefined behavior for archit=
ecture fallbacks.
- [Low] The kernel-doc comment for `__rounddown_pow_of_two64()` incorrectly=
 describes the `@n` parameter as 'value to round up'.
--

--- Patch [1]: [PATCH 1/2] linux/log2.h: Add round{up,down}_pow_of_two64() =
---
commit 4cce4f9f15f91ab3c1df542bca356b3776146fef
Author: David Gow <david@davidgow.net>

linux/log2.h: Add round{up,down}_pow_of_two64()

This commit adds 64-bit specific versions of round-up and round-down power
of two macros. It is intended to support 64-bit values on 32-bit systems,
particularly for the GPU buddy allocator.

> diff --git a/include/linux/log2.h b/include/linux/log2.h
> index e17ceb32e0c97..67446d5ce9a32 100644
> --- a/include/linux/log2.h
> +++ b/include/linux/log2.h
> @@ -195,6 +195,63 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
>  	__rounddown_pow_of_two(n)		\
>   )
> =20
> +/**
> + * __rounddown_pow_of_two64() - round a 64-bit value down to nearest pow=
er of two
> + * @n: value to round up

[Severity: Low]
This isn't a bug, but should this be "value to round down" for the
__rounddown_pow_of_two64() variant?

> + */
> +static inline __attribute_const__
> +u64 __rounddown_pow_of_two64(u64 n)
> +{

[ ... ]

> +/**
> + * __roundup_pow_of_two64() - round a 64-bit value up to nearest power o=
f two
> + * @n: value to round up
> + */
> +static inline __attribute_const__
> +u64 __roundup_pow_of_two64(u64 n)
> +{
> +	return 1ULL << (ilog2(n - 1) + 1);

[Severity: Medium]
Will calling roundup_pow_of_two64(1) with a runtime variable evaluate to
ilog2(0) here?

The documentation in include/linux/log2.h states that the architecture is
not required to handle n =3D=3D 0 for ilog2(). While current fallback
implementations evaluate fls64(0) - 1 to -1 and return 1, an architecture
providing an optimized hardware ilog2() implementation might trap or break
on 0.

The existing 32-bit __roundup_pow_of_two() avoids this by safely relying on
fls_long(n - 1).

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821091918.1902=
032-1-david@ingeniumdigital.com?part=3D1
