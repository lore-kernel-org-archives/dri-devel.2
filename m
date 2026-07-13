Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838B5C44507
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 13:31:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0F8410E110;
	Mon, 13 Jul 2026 13:31:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nch39BDY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDC7F10E110
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 13:31:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 60484414DF;
 Mon, 13 Jul 2026 13:31:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DB21F000E9;
 Mon, 13 Jul 2026 13:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783949492;
 bh=+gg5/r5gl23UMWz23t+ZU7I8b3f/rtTQHYytnt7hECI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nch39BDYwAknGSrMRi/abqmbLsvNMMV36O/foddEGQ5XznmTDaoydg23uQ6XSYOfw
 3Bf7xo7YQL6Cr1VKwvXgEEVZkrpvWrgGWdwlv3nuBXETVf74YqrBzyyd7VAphKyjSV
 N7QtMv10/NhJqSlxTilRfnMzkv9FTl/byCmXMx6mJmgpnkQVazgjoXXikWxbSLVbMB
 BWA8PFUVcwIDAyVcucB927HhlNyQ9QTPLT+SmcXBsLmCmsOZqhYU3SWBnFYPMeAXik
 cEe5WBPUypofBFB3dFbCWVAgMCGTscxA6QFsMRUAdKTFL/Yxbl573DK5jeBPKVtRXE
 W/MexYNIGBPdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] gpu: buddy: avoid repeated builds of root dfs when
 alloc range
To: "Zhaoyu Liu" <liuzhaoyu.zackary@picoheart.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <alTlW8TmTXLocWKP@hostpc>
References: <alTlW8TmTXLocWKP@hostpc>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 13:31:31 +0000
Message-Id: <20260713133132.18DB21F000E9@smtp.kernel.org>
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
- [High] Spurious -ENOSPC failure in __alloc_range() for fully free memory =
ranges due to unmerged SPLIT blocks.
--

--- Patch [1]: [PATCH v2] gpu: buddy: avoid repeated builds of root dfs whe=
n alloc range ---
commit 87b87afa0112d6b6bc23de2294a961d8ef1fb83e
Author: Zhaoyu Liu <liuzhaoyu.zackary@picoheart.com>

gpu: buddy: avoid repeated builds of root dfs when alloc range

This commit optimizes the buddy allocator by avoiding wasteful repeated bui=
lds
of the DFS list during range allocations. It introduces __get_candidate_blo=
ck()
to unify block acquisition, falling back to lazily fetching the next root b=
lock
only when the DFS list is exhausted.

> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index 3c73ae87f3c5b..72f521c51b3fa 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c

[ ... ]

> @@ -1030,14 +1059,10 @@ static int __alloc_range(struct gpu_buddy *mm,
>  		u64 block_start;
>  		u64 block_end;
> =20
> -		block =3D list_first_entry_or_null(dfs,
> -						 struct gpu_buddy_block,
> -						 tmp_link);
> -		if (!block)
> +		block =3D __get_candidate_block(mm, dfs, &cursor);
> +		if (IS_ERR(block))
>  			break;
> =20
> -		list_del(&block->tmp_link);
> -
>  		block_start =3D gpu_buddy_block_offset(block);
>  		block_end =3D block_start + gpu_buddy_block_size(mm, block) - 1;

[Severity: High]
This is a pre-existing issue, but could allocations fail spuriously in
__alloc_range() due to unmerged SPLIT blocks?

Looking further down in this same loop in __alloc_range():

    if (contains(start, end, block_start, block_end)) {
        if (gpu_buddy_block_is_free(block)) {
            ...
        } else if (!mm->clear_avail) {
            err =3D -ENOSPC;
            goto err_free;
        }
    }

If a previous allocation attempt splits a large free block but fails and do=
es
not undo the splits, the parent block is left marked as SPLIT with fully FR=
EE
children.

If the system globally has no available clear memory (mm->clear_avail =3D=
=3D 0), a
subsequent call to __alloc_range() requesting a range that completely
encompasses this SPLIT block will satisfy the contains() check. However,
because the parent block is SPLIT rather than FREE, it hits the
!mm->clear_avail condition and immediately aborts the entire allocation with
-ENOSPC.

Should this logic instead traverse down to allocate the perfectly free
children instead of aborting?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/alTlW8TmTXLocWKP@ho=
stpc?part=3D1
