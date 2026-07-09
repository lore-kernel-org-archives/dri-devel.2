Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDA1C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 13:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D29210E6EF;
	Thu,  9 Jul 2026 13:29:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="STxeDSmM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2856510E6EF
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 13:29:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B329642ADC;
 Thu,  9 Jul 2026 13:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE701F000E9;
 Thu,  9 Jul 2026 13:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783603795;
 bh=Uzr+8HM2+cRNeG6HV48/IGp3qE6ZOF9o2xt28eo45Tc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=STxeDSmMFDKmsHadGhFpI/FpNS4rD7Nb40ksK0laLRq/vVWsPPQKTtGnDbyhU/igM
 8IkxTjXsbqGd6CmQx2V5ohqYy7saA17boEiSVlCZ7dBF7LfcsD07YTnIu2RlkudISx
 VpVt0t77DeNo74qW5wT4veSCDCGXi/SjfCjx5biUPtcPiEZWRnfsdDvygfh9UFg1jZ
 kSbsCY/aku1W8bqASqOQGA4U3rqj26YQuqyfuJ0C3wolOJB908p9lenFRNZvk1B7qj
 q71uZtf0nFNUgF8g/HwtJ7kGosxG9avIKIMbY7ivRGPjg7DUmKI1t76NWbQZj9weVp
 lXnXubY3IRDmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] gpu/buddy: bail out of try_harder when alignment
 cannot be honoured
To: "Arunpravin Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260709131050.1022759-1-Arunpravin.PaneerSelvam@amd.com>
References: <20260709131050.1022759-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 13:29:54 +0000
Message-Id: <20260709132955.5EE701F000E9@smtp.kernel.org>
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
- [High] Integer truncation in `rounddown_pow_of_two(size)` on 32-bit archi=
tectures leads to out-of-bounds array access.
--

--- Patch [1]: [PATCH v2] gpu/buddy: bail out of try_harder when alignment =
cannot be honoured ---
commit e9f823b96a2660e1690b65d2c8c95099338dc996
Author: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

gpu/buddy: bail out of try_harder when alignment cannot be honoured

The try_harder contiguous fallback could return a range whose start
offset did not match the caller's min_block_size. When a candidate's
start is misaligned, realign it: free the misaligned run and reallocate
exactly @size at the next lower min_block_size boundary.

> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index dc81fe0301ce8..3c73ae87f3c5b 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c

[ ... ]

>  static int __alloc_contig_try_harder(struct gpu_buddy *mm,
>  				     u64 size,
>  				     u64 min_block_size,
>  				     struct list_head *blocks)
>  {
> -	u64 rhs_offset, lhs_offset, lhs_size, filled;
> +	u64 rhs_offset, lhs_offset, filled;
>  	struct gpu_buddy_block *block;
>  	unsigned int tree, order;
> -	LIST_HEAD(blocks_lhs);
> -	unsigned long pages;
>  	u64 modify_size;
>  	int err;
> =20
>  	modify_size =3D rounddown_pow_of_two(size);
> -	pages =3D modify_size >> ilog2(mm->chunk_size);
> -	order =3D fls(pages) - 1;
> +	order =3D ilog2(modify_size) - ilog2(mm->chunk_size);

[Severity: High]
This isn't a bug introduced by this patch, but could this integer truncation
lead to out-of-bounds array accesses on 32-bit architectures?

The size parameter is a u64, but the rounddown_pow_of_two() macro operates
on an unsigned long. On a 32-bit system, if a large size is passed
(e.g., 4GB) where the lower 32 bits are smaller than chunk_size or zero,
the truncation can result in modify_size becoming 0.

When modify_size is 0, ilog2(0) yields -1. This causes order (an unsigned
int) to underflow into a massive positive value. The if (order =3D=3D 0) ch=
eck
is bypassed, and this huge order value is then used to index into the
mm->free_trees[tree][order] array, which could crash the kernel during the
RB tree traversal.

>  	if (order =3D=3D 0)
>  		return -ENOSPC;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709131050.1022=
759-1-Arunpravin.PaneerSelvam@amd.com?part=3D1
