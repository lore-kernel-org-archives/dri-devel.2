Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B3EC88E40
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 09:02:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F146110E0B8;
	Sun, 13 Sep 2026 09:02:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gfaztbGI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A602F10E05B
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 09:02:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ACF3960DB4;
 Sun, 13 Sep 2026 09:02:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3713E1F000FF;
 Sun, 13 Sep 2026 09:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789290136;
 bh=ruWc/Di7ip0lJAZuHEAAJbuGnZQP7A3y6OS5dX4GqQ4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gfaztbGIdIh//2BTdYeYfyXdtVM2fyIFrZK+e2nKQMOdL1NmMCmXk//TYpDslzF8c
 dXpqx0QC2k+bePKazZ75CDqiwGghgSQhAIw5uthXVG4uZfWtYrUuBIZVBlUF40Q2IL
 5NE+5W7g1viDuakuQe1ih2Z4NRy2K8WJBpu3JV5SP9IBJT5np8/LfXNZkBiBJR15u/
 9gmuakMjt9qLmYt0Glbk5oVfzZ1YPlab4RIpQXKRYOTDB3w9n3Hlzp9Oczpyr94bJF
 zXSLwOnptS1MsuTYsjS8OLJJaS7ZzRyufohhOEnoTUc9l/petQovbu4a2erklUJfk7
 n3W1Lx2SDSGTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm_buddy: fix power-of-2 rounding errs
To: "David Gow" <david@davidgow.net>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260913084907.520877-2-david@davidgow.net>
References: <20260913084907.520877-2-david@davidgow.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 09:02:15 +0000
Message-Id: <20260913090216.3713E1F000FF@smtp.kernel.org>
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
- [High] The `is_power_of_2()` macro truncates 64-bit sizes on 32-bit platf=
orms, undermining the patch's fix.
- [High] `__alloc_contig_try_harder()` breaks list contracts, leaking local=
 allocations and freeing caller-owned blocks.
--

commit 2e4e9330a58d876de4c3883a4c7315a7270524e2
Author: David Gow <david@davidgow.net>

drm_buddy: fix power-of-2 rounding errs

This commit replaces roundup_pow_of_two and rounddown_pow_of_two macros
with 64-bit safe ilog2 equivalents in the buddy allocator to fix
truncation of 64-bit values on 32-bit architectures.

> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index 26e7a48b55f33..964a5ae78f1be 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c

[ ... ]

> @@ -1435,7 +1435,7 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
> =20
>  	/* Roundup the size to power of 2 */
>  	if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) {
> -		size =3D roundup_pow_of_two(size);
> +		size =3D 1ULL << (ilog2(size - 1) + 1);
>  		min_block_size =3D size;
>  		/*
>  		 * Normalize the requested size to min_block_size for regular allocati=
ons.

[Severity: High]
This is a pre-existing issue, but does the is_power_of_2() macro still
silently truncate 64-bit sizes on 32-bit platforms, undermining this fix?

Earlier in gpu_buddy_alloc_blocks() there is a validation check:

    if (!is_power_of_2(min_block_size))
        return -EINVAL;

If min_block_size is a 64-bit value > 4GB, the unsigned long argument
silently truncates the upper 32 bits on 32-bit architectures. For example,
0x100000000 (4GB) truncates to 0 (failing the check), and 0x100001000
(4GB + 4KB) truncates to 4KB (falsely passing the check).

Similarly, gpu_buddy_can_offset_align() does this:

    return size < min_block_size && is_power_of_2(size);

Can this lead to allocation failures or memory corruption because buddy
alignment constraints are bypassed?

[Severity: High]
This is a pre-existing issue, but does __alloc_contig_try_harder() break li=
st
contracts and cause a memory leak when used as a fallback here?

Later in gpu_buddy_alloc_blocks() during a fragmented allocation loop:

    if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION &&
        !(flags & GPU_BUDDY_RANGE_ALLOCATION))
            return __alloc_contig_try_harder(mm,
                                             original_size,
                                             original_min_size,
                                             blocks);

If the loop partially succeeded before falling back, the blocks in the local
allocated list are never freed or spliced, causing a permanent memory leak.

Additionally, the fallback function is passed the caller's blocks list
directly instead of the local list. If it fails internally, it calls:

    gpu_buddy_free_list_internal(mm, blocks);

Doesn't this unconditionally empty the caller's entire list, destroying
any pre-existing blocks the caller might have had before calling
gpu_buddy_alloc_blocks()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913084907.5208=
77-2-david@davidgow.net?part=3D1
