Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5447D606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 16:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hm0LOsNf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 084FC10F2E4;
	Mon, 16 Nov 2026 16:23:42 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FA7410F2FB;
 Mon, 16 Nov 2026 16:23:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 69FA062F1C;
 Mon, 16 Nov 2026 16:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01AB1F000C4;
 Mon, 16 Nov 2026 16:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794846213;
 bh=32mFNLQUKtUkrWv4Og1eMZ5U67MAPSgRgOmFqHC2o4c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Hm0LOsNf/wOMHJLB8a/RUbMzFzdKjkUrIpQ7Axln0AIgGcG1kEH0jEl4/B5cZIHdx
 woDoKPXxsycxZJLgr+0XjbeQMZFISxvlrs+UxJ3oyhaHL+hYlzDbZ374jOYCMTUvEg
 G9VUT/5qyuzWTSZInt3L2NV8ee/MWGyL8zi2hZ+9dpmEKfUDVFv8rqL0UNVa/Vj52u
 2jUKIUrD+ehbEbSvI/74U2uhH8hwnntMxLzIWvfuT4JPnfIXF2aDIQvOZ3PA5TR78T
 jbEZqfgcaLq8DKwZLXvZV4p3vUmyyr8lTaRz8OPtP9B2reA2g4/UmcuXZHVpeP6sNc
 3EUumdhER6fEw==
Message-ID: <sashiko-outbox-217356@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] gpu/buddy: find range-biased blocks in the free
 trees
To: "William Palacek" <William.Palacek@amd.com>,
 dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
In-Reply-To: <17f2a6366ba845edc799dbeb712c12f8d060afad.1794845083.git.William.Palacek@amd.com>
References: <cover.1794845083.git.William.Palacek@amd.com>
 <17f2a6366ba845edc799dbeb712c12f8d060afad.1794845083.git.William.Palacek@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 16:23:32 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] gpu/buddy: u64 underflow on inverted range in
  __alloc_range_bias()
--

commit 84539d9e7a89604b1f5d66dfb390e667e4fccb69
Author: William Palacek <William.Palacek@amd.com>

gpu/buddy: find range-biased blocks in the free trees

This commit replaces the root-to-leaf block tree walk in
__alloc_range_bias() with augmented RB-tree lookups in the per-order
free trees, adding a subtree_has_dirty augment to skip all-clear
subtrees on dirty requests.

> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index e7d2212bcec95..baf17700ffba5 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c

[ ... ]

> @@ -1247,96 +1262,155 @@ static bool block_incompatible(struct gpu_buddy_=
block *block, unsigned int flags
>  			     gpu_buddy_block_is_clear(block);
>  }
> =20
> -static struct gpu_buddy_block *
> -__alloc_range_bias(struct gpu_buddy *mm,
> -		   u64 start, u64 end,
> -		   unsigned int order,
> -		   unsigned long flags,
> -		   bool fallback)

[ ... ]

> +static struct gpu_buddy_block *
> +__alloc_range_bias(struct gpu_buddy *mm,
> +		   u64 start, u64 end,
> +		   unsigned int order,
> +		   unsigned long flags,
> +		   bool fallback)
> +{
> +	u64 req_size =3D mm->chunk_size << order;
> +	struct gpu_buddy_block *block =3D NULL;
> +	u64 best =3D 0;
> +	unsigned int i;
> +	int err;
> =20
> +	for (i =3D order; i <=3D mm->max_order; i++) {
> +		struct rb_root *root =3D &mm->free_tree[i];
> +		u64 size =3D mm->chunk_size << i;
> +		struct gpu_buddy_block *found;
> +		u64 offset =3D 0;
> =20
> +		if (!fallback) {
> +			if (end - start < size)
> +				break;
> =20
> +			found =3D rbtree_last_range_block(root, end - size + 1,
> +							flags, false);
> +			if (!found || gpu_buddy_block_offset(found) < start)
> +				continue;

[Severity: Medium]
Can end - start and end - size + 1 underflow when start > end, causing
__alloc_range_bias() to allocate a block outside [start, end)?

gpu_buddy_alloc_blocks() checks end <=3D mm->size and
range_overflows(start, size, mm->size), which only checks start + size
<=3D mm->size, so an inverted range (for example, when
AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED clamps lpfn to visible_pfn below a
memory partition's fpfn in amdgpu_bo_placement_from_domain()) reaches
__alloc_range_bias() with start > end.  Previously, the adjusted_end vs
adjusted_start check rejected inverted ranges with -ENOSPC.  In the new
strict pass, end - start wraps in u64 arithmetic past the size check,
and when size > end, end - size + 1 wraps to near U64_MAX, so
rbtree_last_range_block() matches and returns a block at offset >=3D start
> end.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/17f2a6366ba845edc79=
9dbeb712c12f8d060afad.1794845083.git.William.Palacek@amd.com?part=3D1
