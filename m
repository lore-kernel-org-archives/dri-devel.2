Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2387E606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 08:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BBS0SMTA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80B7710E050;
	Sun,  1 Nov 2026 08:21:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CD6D10E050
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 08:21:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2684543E7D;
 Sun,  1 Nov 2026 08:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77AD1F00919;
 Sun,  1 Nov 2026 08:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793521277;
 bh=Q6peo5Ze7QeOV3cEc1cLiQTQlstaSX7uPjteK8k7F5M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BBS0SMTAbpSCYvWzNbquWNqi08YqXaO8TF6E1r93yl3B0qbGfg38d6ACGEt6krRQb
 uyxNEemF11lLUux9/kWJ+GLhzmt0Dk6KoQgCNPdLa8d78e5iJNGXmpORaHAsbTnoHP
 ZrTho5cr7mb2hd1PCMo2hfEtDyv+Zk8p6giz0Wmz9zQjPnKuDF4gLI3c97eL2YGnUu
 m4TfIJnjkxS1Q5WVAi5FMh8PWApe6LUelZNR+1TlJ6M6eQIiVTVyzM5za3BC4INiJ8
 j7BZmKcQWbboaQYJh1rs0bXbKnTur3FtHOwuV77IG0j2LFJBpG0yEj9R37C6DxQLor
 RibsA+88ag/IA==
Message-ID: <sashiko-outbox-192325@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] drm_buddy: Fix power-of-two rounding errors
To: "David Gow" <david@davidgow.net>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261101081121.3273967-2-david@davidgow.net>
References: <20261101081121.3273967-2-david@davidgow.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 08:21:16 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] gpu/buddy: 32-bit shift overflow in gpu_buddy_alloc_blocks() on =
BIT(order)
- [Low] gpu/buddy: malformed kernel-doc comment marker above is_power_of_2_=
u64()
--

commit 73704a4c8e819013a9e0b34c59f4447160bbf9ae
Author: David Gow <david@davidgow.net>

drm_buddy: Fix power-of-two rounding errors

This commit introduces u64-specific power-of-two helpers in
drivers/gpu/buddy.c and widens page count variables from unsigned long to u=
64
to avoid 32-bit truncation when handling 64-bit GPU allocation sizes on
32-bit architectures.

> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index 503f7d5934e4b..504bd013f4ea2 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -36,6 +36,35 @@
>  #define gpu_buddy_assert(condition) WARN_ON(!(condition))
>  #endif
> =20
> +/**
> + * Implementations of pow_of_2 functions targeting u64:
> + *
> + * The various pow_of_2 functions in log2.h work on longs, which are 32-=
bit on
> + * 32-bit systems. Since the GPU address space is 64-bit even on systems=
 with
> + * a 32-bit CPU, this causes needless truncation. Work is underway to im=
prove
> + * the general implementations to support 64-bit types on 32-bit systems=
, but
> + * in the meantime, we implement our own here.
> + */

[Severity: Low]
Since drivers/gpu/buddy.c is included by Documentation/gpu/drm-mm.rst for
kernel-doc processing, starting this comment block above is_power_of_2_u64()
with /** instead of /* causes scripts/kernel-doc to warn during W=3D1 and
documentation builds because the block is not formatted as a kernel-doc
comment. Should this comment open with /* instead?

[ ... ]

> @@ -1970,7 +1999,7 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>  	u64 original_size, original_min_size;
>  	unsigned int min_order, order;
>  	LIST_HEAD(allocated);
> -	unsigned long pages;
> +	u64 pages;
>  	int err;

[ ... ]

> @@ -2017,7 +2046,7 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>  	}
> =20
>  	pages =3D size >> ilog2(mm->chunk_size);
> -	order =3D fls(pages) - 1;
> +	order =3D fls64(pages) - 1;
>  	min_order =3D ilog2(min_block_size) - ilog2(mm->chunk_size);
> =20
>  	if (order > mm->max_order || size > mm->size) {
> @@ -2031,7 +2060,7 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>  	}
> =20
>  	do {
> -		order =3D min(order, (unsigned int)fls(pages) - 1);
> +		order =3D min(order, (unsigned int)fls64(pages) - 1);
>  		BUG_ON(order > mm->max_order);
>  		/*
>  		 * Regular allocations must not allocate blocks smaller than min_block=
_size.

[Severity: Medium]
In gpu_buddy_alloc_blocks(), widening pages to u64 and computing order with
fls64(pages) - 1 allows order to be 32 or greater on 32-bit architectures
when an allocation spans at least 1ULL << 32 chunks.

However, at the bottom of this allocation loop in gpu_buddy_alloc_blocks(),
pages is still decremented using BIT(order):

		kmemleak_update_trace(block);
		list_add_tail(&block->link, &allocated);

		pages -=3D BIT(order);

		if (!pages)
			break;

Because BIT(order) expands to (1UL << (order)), on 32-bit systems an order =
of
32 or more shifts a 32-bit unsigned long past its width, invoking undefined
behavior and corrupting the remaining pages count so the loop does not
terminate normally.

Should that decrement in gpu_buddy_alloc_blocks() use BIT_ULL(order) instea=
d?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101081121.3273=
967-2-david@davidgow.net?part=3D1
