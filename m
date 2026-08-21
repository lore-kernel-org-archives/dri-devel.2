Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4C5C5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 09:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 728B410F28E;
	Fri, 21 Aug 2026 09:44:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OHCgZuON";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEA1010F28E
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 09:44:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9E42941AD1;
 Fri, 21 Aug 2026 09:44:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5761E1F00A3A;
 Fri, 21 Aug 2026 09:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787305440;
 bh=cS72zh5NwU1Bjx24N0skZbsBt97TJcM6ZABlFLAcGls=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OHCgZuONsmhQOpDv1TcD4BSXx19lEzeXtzQ86NioBGq0mU9J1y9BumV8pJ6PfXgje
 oHayGuIrYOgeHVVmd8EU/w/M24IRB1q7HayFxfo7iQlebMHSduvUOoJw4mGqQExLXr
 EAt+Qkj1+jeKi+IKw1DngOtr9h4hdgn40eBsijWw1DK1Dm5qld4kh4PUsSFdhcUotQ
 t59W19inrzOq8I3asj0b6Z4XS9sc4ltk7N+uyIo0CpMVIpNIMmZi6dlsVcss4RdgCR
 1qPzs6+YTqe9OBS630kkbE0+ND3Or04qHjdcyoWWL0jxuL7dWup4JeHn2tzAGvJYAD
 ppQO0KVMewiBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm_buddy: fix power-of-2 rounding errs
To: "David Gow" <david@ingeniumdigital.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260821091918.1902032-2-david@ingeniumdigital.com>
References: <20260821091918.1902032-1-david@ingeniumdigital.com>
 <20260821091918.1902032-2-david@ingeniumdigital.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 09:43:59 +0000
Message-Id: <20260821094400.5761E1F00A3A@smtp.kernel.org>
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
- [High] The `pages` variable is declared as `unsigned long`, and the `fls(=
)` and `BIT()` macros are used, leading to silent truncation and potential =
infinite loops or crashes for large allocations.
- [High] Calling the `is_power_of_2()` macro with 64-bit variables (`min_bl=
ock_size` and `size`) silently truncates them to 32 bits on 32-bit architec=
tures, breaking allocator validation.
--

--- Patch [2]: [PATCH 2/2] drm_buddy: fix power-of-2 rounding errs ---
commit 6e9e2fbe5490ccf9c40ea5dcdf1e897c00f63b30
Author: Jim Cromie <jim.cromie@gmail.com>

drm_buddy: fix power-of-2 rounding errs

This patch replaces standard roundup_pow_of_two() and rounddown_pow_of_two()
macros with their 64-bit equivalents in the GPU buddy allocator. This fixes
silent truncation of 64-bit allocation sizes on 32-bit architectures, which
was causing tests to fail.

Link: https://lore.kernel.org/all/20260326185413.1205870-40-jim.cromie@gmai=
l.com/

> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index a5553fcec28c2..64f41f1fe9089 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
[ ... ]
> @@ -1440,7 +1440,7 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
> =20
>  	/* Roundup the size to power of 2 */
>  	if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) {
> -		size =3D roundup_pow_of_two(size);
> +		size =3D roundup_pow_of_two64(size);
>  		min_block_size =3D size;
>  		/*
>  		 * Normalize the requested size to min_block_size for regular allocati=
ons.

[Severity: High]
This is a pre-existing issue, but since you are fixing 32-bit truncation
errors in this function, are there similar truncation issues with the pages
variable later in gpu_buddy_alloc_blocks()?

The pages variable is declared as unsigned long:

	unsigned long pages;

And later initialized and used with fls() and BIT():

	pages =3D size >> ilog2(mm->chunk_size);
	order =3D fls(pages) - 1;
        ...
		pages -=3D BIT(order);

Since unsigned long is 32-bit on 32-bit architectures, pages truncates
for sizes > 16TB (assuming 4KB chunks).

Furthermore, fls() takes a 32-bit integer, so it will truncate pages on 64-=
bit
systems.

BIT(order) also uses 1UL, which overflows on 32-bit architectures if order =
>=3D 32.

Can this lead to infinite loops or crashes for large allocations?

Similar truncation might also occur in gpu_buddy_offset_aligned_allocation(=
),
which also uses unsigned long pages.

[Severity: High]
This is another pre-existing issue, but does is_power_of_2() also silently
truncate 64-bit variables on 32-bit architectures?

Earlier in gpu_buddy_alloc_blocks():

	if (!is_power_of_2(min_block_size))
		return -EINVAL;

The is_power_of_2() macro casts its argument to unsigned long.

If a 64-bit value like 4GB + 4KB is passed, it truncates to 4KB on 32-bit
systems, which is a valid power of two.

This bypasses the validation and allows non-power-of-two sizes to reach
round_up(), which could corrupt sizes and allocator memory.

A similar check exists in gpu_buddy_can_offset_align():

	return size < min_block_size && is_power_of_2(size);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821091918.1902=
032-1-david@ingeniumdigital.com?part=3D2
