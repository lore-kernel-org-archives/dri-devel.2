Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A494AC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 13:25:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E747510F5C2;
	Thu,  9 Jul 2026 13:25:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Yp+fY9c1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A895010F5E4
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 13:25:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CEA4E600C3;
 Thu,  9 Jul 2026 13:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF6B1F000E9;
 Thu,  9 Jul 2026 13:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783603538;
 bh=KJafKbBi5DLnlQW24ZWHNODz37hbBJk6/iTHMAQd54U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Yp+fY9c1Dn8i+0urpu5fS4CWShhK5gXMFpJbgpS5lVXbBV0sxUKBNUW+2y83k8MjI
 wAQf+2lwxsYYdBQlqkwh2vidC6DRpxhPE7+sxA+A81jWNRJSG+qetsaPBYEZWEgJ7S
 Yafc/ioNuMTvqJds9tgobcPJW15QtrpXGUEMtWADJpGMM4UdAhckVTc6d+NGWHw/L8
 qaWSWQN3E6JJVLtJWpJxa6vwy34d8QQMIW1Syzmf57gNTsSrLC/NYDeB+UV/zd7SX2
 swWmtBouPMOOlmhv+tWLOTk4FEORcdxdXYPPHmV/p0mXK7KPMJSGjUKarmBGZBmtbW
 TosSGTH/p2PtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] gpu/buddy: bail out of try_harder when alignment
 cannot be honoured
To: "Arunpravin Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260709130221.1021376-1-Arunpravin.PaneerSelvam@amd.com>
References: <20260709130221.1021376-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 13:25:37 +0000
Message-Id: <20260709132538.5BF6B1F000E9@smtp.kernel.org>
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
- [High] On 32-bit architectures, passing a size >=3D 4GB to __alloc_contig=
_try_harder() causes silent truncation in rounddown_pow_of_two(), leading t=
o an underflow in the order calculation and a subsequent massive out-of-bou=
nds array access.
--

--- Patch [1]: [PATCH v2] gpu/buddy: bail out of try_harder when alignment =
cannot be honoured ---
commit bd00afca04077e9aca5c8cacc93b25007c5cb352
Author: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

gpu/buddy: bail out of try_harder when alignment cannot be honoured

The try_harder contiguous fallback is updated to realign a range whose start
offset does not match min_block_size. It frees the misaligned run and
reallocates at the next lower boundary to maintain the requested size.

> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
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
This is a pre-existing issue, but can this lead to an out-of-bounds array
access on 32-bit architectures?

In __alloc_contig_try_harder(), size is a u64. If a contiguous block of 4GB
(0x100000000) or larger is requested, rounddown_pow_of_two(size) delegates
to __rounddown_pow_of_two(unsigned long n), which silently truncates the
64-bit size to 32 bits on 32-bit architectures. For exactly 4GB, the
truncated value becomes 0.

Because ilog2(0) evaluates to -1, the order calculation underflows,
producing a large positive value in the unsigned int order variable.

When this underflowed order is subsequently used to index into the free
trees further down in this function:

	root =3D &mm->free_trees[tree][order];

Would this result in an out-of-bounds memory read and a potential crash?

>  	if (order =3D=3D 0)
>  		return -ENOSPC;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709130221.1021=
376-1-Arunpravin.PaneerSelvam@amd.com?part=3D1
