Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F5CC55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 09:01:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A20F10E2B5;
	Thu,  6 Aug 2026 09:01:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KBASob7v";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0ECB10E2B5
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 09:01:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6032F60A9F;
 Thu,  6 Aug 2026 09:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C013F1F000E9;
 Thu,  6 Aug 2026 09:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786006882;
 bh=gtt+zplP1NQteJybU0xLiv3wJ4KT/lOlzhGGTNIRcm4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KBASob7vFaOgGODbTeQS5Tc3BJ4ei5vr6UYD/v90sbOI6u7NpgGPN9mH4bjsetee0
 ZwgsDwJSHOk8QKJIfkj2bQVa3kmh8DsSl8hpR4IKOZeqpk5SvYpzrcvhN4eeoyhLXY
 RUnxBhvbG7m+EU5FF6wMBG5TEDtHY2oDfQ7dcWXsHFcLjwCkKR/KEp/2TCBNSoU7LF
 SLnC8uER56a7KHo58rq6AmQrJjLnH7c/9IT62pe11m1luTQBF5exzbXG6UN0NaFDJ3
 v3WTWjYZO342LT55cAOIa01OzOU7nrZPLR5Gq1Is7OdUjROr7rkj6NMY5ttqJjeifw
 xEFuNdqNCscAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/9] mm/kasan: use hw_pte_t for the early shadow PTE table
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
 damon@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260806083926.1807279-8-usama.anjum@arm.com>
References: <20260806083926.1807279-1-usama.anjum@arm.com>
 <20260806083926.1807279-8-usama.anjum@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 09:01:21 +0000
Message-Id: <20260806090121.C013F1F000E9@smtp.kernel.org>
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
- [High] Invalid non-present page table entry conversion in ptdump callback=
s.
--

--- Patch [7]: [PATCH 7/9] mm/kasan: use hw_pte_t for the early shadow PTE =
table ---
commit 3ee38376d3d7f9e85666863e4080641fcf9b048b
Author: Muhammad Usama Anjum <usama.anjum@arm.com>

mm/kasan: use hw_pte_t for the early shadow PTE table

kasan_early_shadow_pte is a complete PTE table rather than a standalone
PTE value. Declare and define its elements as hw_pte_t so the object uses
the PTE table storage type.

[ ... ]

> diff --git a/mm/ptdump.c b/mm/ptdump.c
> index 376880071ca2a..8f19f20be3c44 100644
> --- a/mm/ptdump.c
> +++ b/mm/ptdump.c
> @@ -19,7 +19,7 @@ static inline int note_kasan_page_table(struct mm_walk =
*walk,
>  {
>  	struct ptdump_state *st =3D walk->private;
> =20
> -	st->note_page_pte(st, addr, kasan_early_shadow_pte[0]);
> +	st->note_page_pte(st, addr, ptep_get(kasan_early_shadow_pte));

[Severity: High]
This isn't a bug introduced by this patch, but since we are modifying the K=
ASAN
shadow table handling in ptdump, are the page extraction checks that lead h=
ere
safe for non-present entries?

In mm/ptdump.c, callbacks like ptdump_pmd_entry() and ptdump_pud_entry()
unconditionally call pmd_page() and pud_page() before checking if the entry
is present:

mm/ptdump.c:ptdump_pmd_entry() {
    ...
	pmd_t val =3D pmdp_get(pmd);

#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
	if (pmd_page(val) =3D=3D virt_to_page(lm_alias(kasan_early_shadow_pte)))
		return note_kasan_page_table(walk, addr);
#endif
    ...
}

User page tables can contain non-present swap or migration entries at the P=
MD
level. If pmd_page() (and equivalents like pud_page(), p4d_page(), pgd_page=
())
extracts a bogus PFN from a non-present entry, could this lead to an
out-of-bounds array access and a NULL pointer dereference in the sparsemem
arrays when pfn_to_page() is evaluated?

Since ptdump can be invoked on user page tables via debugfs by users with r=
ead
access, could this trigger a kernel panic? Should these callbacks verify the
entry is present before calling the page conversion functions?

> =20
>  	walk->action =3D ACTION_CONTINUE;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806083926.1807=
279-1-usama.anjum@arm.com?part=3D7
