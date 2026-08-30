Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC34BC61DD9
	for <dri-devel@archiver.kernel.org>; Sun, 30 Aug 2026 10:58:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0783810E1AC;
	Sun, 30 Aug 2026 10:58:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="baX2vpEo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8CF310E1AC
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 10:58:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 955B6436FA;
 Sun, 30 Aug 2026 10:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF271F000E9;
 Sun, 30 Aug 2026 10:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788087514;
 bh=eXrOcQMn/YsunWYL2XbUkAyNsgbZ2BdtJ5a1VEPTSMg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=baX2vpEoIueUTCH73pACjmQymS/UPoIHMwm2M6pFZN4Z+xZsWEEXN8QxxWGfXpibK
 nk37ZZ5nmCmX01DCZ+TfFv4il8px+NVd2HFq3GguBCqW2WSruBaOFgW+xE02UPsKSH
 2pjs1okdxPGa6Kf3mndsMT21yzdgy+8ChfQIR0yH1siRUEJ+vAI6EGfa4gM6uqKXps
 fmt1d8XaIiqLv6q2ogZO/d1QbddfaHi0NaD3WU9ZniMVrQGib8e8mL4B+gMpsp4Hjs
 K6C+6e9J8+1H1U9+4imwJetkhEs27t89l28WxSd9DEW6UNC8WM2/GYpJbEm7JrJt9c
 HZYRcc+tHPLwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] drm_buddy: fix power-of-2 rounding errs
To: "David Gow" <david@davidgow.net>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260830103321.2042968-2-david@davidgow.net>
References: <20260830103321.2042968-1-david@davidgow.net>
 <20260830103321.2042968-2-david@davidgow.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 10:58:33 +0000
Message-Id: <20260830105834.4EF271F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Silent 32-bit truncation of u64 variables in is_power_of_2() check=
s.
- [Medium] The patch incompletely fixes 32-bit truncation of `u64 size` by =
leaving `unsigned long pages`, `fls()`, and `BIT()` in the exact same calcu=
lation paths.
--

commit c788807ff6acd696c6d8c9760009db4310c73ca2
Author: Jim Cromie <jim.cromie@gmail.com>
Subject: drm_buddy: fix power-of-2 rounding errs

This commit fixes 32-bit truncation of 64-bit sizes when using the standard
roundup_pow_of_two() and rounddown_pow_of_two() macros. It replaces them wi=
th
safe 64-bit equivalents to resolve unexpected test successes in DRM-CI on
32-bit systems.

Link: https://lore.kernel.org/all/20260326185413.1205870-40-jim.cromie@gmai=
l.com/

> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index a5553fcec28c2..0c432719f8f17 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c

[ ... ]

> @@ -1440,7 +1440,7 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
> =20
>  	/* Roundup the size to power of 2 */
>  	if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) {
> -		size =3D roundup_pow_of_two(size);
> +		size =3D roundup_pow_of_two_u64(size);

[Severity: High]
This is a pre-existing issue, but does is_power_of_2() also suffer from the
exact same silent 32-bit truncation?

Earlier in gpu_buddy_alloc_blocks(), the 64-bit min_block_size is validated:

	if (!is_power_of_2(min_block_size))
		return -EINVAL;

Since is_power_of_2() expects an unsigned long, if a 64-bit value is provid=
ed
where the lower 32 bits form a power of two but the upper bits are non-zero
(e.g., 0x100001000), it seems it will be truncated to a valid power of two =
on
32-bit architectures. This would bypass validation and corrupt the allocator
state.

Other places doing this check on 64-bit variables:
- gpu_buddy_init() validates the 64-bit chunk_size
- gpu_buddy_can_offset_align() validates the 64-bit size

[Severity: Medium]
This is also a pre-existing issue, but does this function incompletely fix
the truncation of size by leaving 32-bit types in the subsequent
calculations?

Just below this hunk in gpu_buddy_alloc_blocks(), pages is calculated:

	unsigned long pages;
	...
	pages =3D size >> ilog2(mm->chunk_size);
	order =3D fls(pages) - 1;

Since pages is an unsigned long, it will be silently truncated if the shift=
ed
value exceeds 32 bits on 32-bit architectures.

Additionally, on 64-bit architectures where pages is 64-bit, the fls() macro
takes a 32-bit unsigned int. If pages > 0xFFFFFFFF, fls() only sees the
lower 32 bits, which may be 0, incorrectly setting order to -1.=20

Further down in the allocation loop, the BIT() macro is used:

	pages -=3D BIT(order);

If order >=3D 32, the BIT() macro will overflow and evaluate incorrectly. C=
ould
these paths lead to incorrect block allocations or memory corruption for ve=
ry
large sizes?

>  		min_block_size =3D size;
>  		/*
>  		 * Normalize the requested size to min_block_size for regular allocati=
ons.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830103321.2042=
968-1-david@davidgow.net?part=3D2
