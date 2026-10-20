Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42081606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 08:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ctm37YhY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D98AF10F327;
	Tue, 20 Oct 2026 08:00:56 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 976D310EB78;
 Tue, 20 Oct 2026 08:00:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 49F3743AF6;
 Tue, 20 Oct 2026 08:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88EB1F000C4;
 Tue, 20 Oct 2026 08:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792483250;
 bh=EF6KnZ0E0rBGuqqY9uuw2Ecm050/peVggQOs2GAxmpc=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=ctm37YhY+4Pge5/FfnVScMCOSxomh2HCIOtVQLBUcqGTd/zeDsGRm4tXWnS5lMOcj
 gCYsQTBtiF+ICV/csyHCJQ7a4O3WFkuQzRO1UEIl95aRZW9hgLBej0Ew2DNHFKwIG7
 xLTf1oNDQ+n4/+Ddl7HWXwkjpd94KQR8OBbkOZQ13ellEhDiM1Nqs23Rb6dVNEPXQq
 V0ikveoqv+JuLJ7KN51APLCard0c6ZkUHjdsoaaYzGV8fbgHvqWVz7d7PQZYnpsMnO
 v4Z/DTa3rvKSVdhX84MPgkHkAtVUZwrtblxuR7pvtMyHVjKGAGINCD+rkZL2QexIfo
 ugzqrvCfmPb+w==
Message-ID: <sashiko-outbox-178464@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] gpu/buddy: restore two-pass clear/dirty guard
 for range-biased allocation
To: "Arunpravin Paneer Selvam" <arunpravin.paneerselvam@amd.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261020055537.1640552-1-arunpravin.paneerselvam@amd.com>
References: <20261020055537.1640552-1-arunpravin.paneerselvam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:00:49 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] gpu/buddy: block_incompatible() mishandles split and mixed blocks =
in __alloc_range_bias()
--

commit 6dff7f0e6dce9c68ecb98f2d911199843d2b4401
Author: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

gpu/buddy: restore two-pass clear/dirty guard for range-biased allocation

This commit introduces a two-pass search in __gpu_buddy_alloc_range_bias()
using block_incompatible() in the strict pass to prevent range-restricted
allocations from splitting opposite-class (clear vs. dirty) blocks unless
no matching blocks exist in the range.

> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index 503f7d5934e4b..91935c71c5255 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -1240,11 +1240,19 @@ static void __gpu_buddy_undo_splits(struct gpu_bu=
ddy *mm,
>  	}
>  }
> =20
> +static bool block_incompatible(struct gpu_buddy_block *block, unsigned i=
nt flags)
> +{
> +	bool needs_clear =3D flags & GPU_BUDDY_CLEAR_ALLOCATION;
> +
> +	return needs_clear !=3D gpu_buddy_block_is_clear(block);
> +}
> +
>  static struct gpu_buddy_block *
>  __alloc_range_bias(struct gpu_buddy *mm,
>  		   u64 start, u64 end,
>  		   unsigned int order,
> -		   unsigned long flags)
> +		   unsigned long flags,
> +		   bool fallback)
>  {

[ ... ]

> @@ -1298,6 +1304,9 @@ __alloc_range_bias(struct gpu_buddy *mm,
>  				continue;
>  		}
> =20
> +		if (!fallback && block_incompatible(block, flags))
> +			continue;
> +
>  		if (contains(start, end, block_start, block_end) &&
>  		    order =3D=3D gpu_buddy_block_order(block)) {
>  			/*
> @@ -1315,38 +1324,8 @@ __alloc_range_bias(struct gpu_buddy *mm,
>  				goto err_undo;
>  		}
> =20
> -		/*
> -		 * Top-down is a strict address-placement policy, so when it is
> -		 * requested we ignore clear steering and simply descend the
> -		 * right (higher-address) child first. Only a non-top-down clear
> -		 * request biases the descent towards clear/has_clear subtrees.
> -		 */
> -		if ((flags & GPU_BUDDY_CLEAR_ALLOCATION) &&
> -		    !(flags & GPU_BUDDY_TOPDOWN_ALLOCATION)) {
> -			struct gpu_buddy_block *prefer;
> -
> -			if (gpu_buddy_block_is_clear(block->right))
> -				prefer =3D block->right;
> -			else if (gpu_buddy_block_is_clear(block->left))
> -				prefer =3D block->left;
> -			else if (block->right->has_clear)
> -				prefer =3D block->right;
> -			else if (block->left->has_clear)
> -				prefer =3D block->left;
> -			else
> -				prefer =3D block->right;
> -
> -			if (prefer =3D=3D block->right) {
> -				list_add(&block->left->tmp_link, &dfs);
> -				list_add(&block->right->tmp_link, &dfs);
> -			} else {
> -				list_add(&block->right->tmp_link, &dfs);
> -				list_add(&block->left->tmp_link, &dfs);
> -			}
> -		} else {
> -			list_add(&block->left->tmp_link, &dfs);
> -			list_add(&block->right->tmp_link, &dfs);
> -		}
> +		list_add(&block->left->tmp_link, &dfs);
> +		list_add(&block->right->tmp_link, &dfs);
>  	} while (1);

[Severity: High]
Does calling block_incompatible() on every visited node in
__alloc_range_bias() before checking whether the block is split or mixed
mishandle internal GPU_BUDDY_SPLIT nodes and coalesced GPU_BLOCK_MIXED free
blocks?

First, when mark_split() transitions a block to GPU_BUDDY_SPLIT, it leaves
the previous GPU_BUDDY_HEADER_CLEAR bit intact on the internal node:

drivers/gpu/buddy.c:mark_split() {
	block->header &=3D ~GPU_BUDDY_HEADER_STATE;
	block->header |=3D GPU_BUDDY_SPLIT;
	...
}

Because gpu_buddy_init() initializes roots as dirty, any root or ancestor
split while dirty keeps gpu_buddy_block_is_clear(block) =3D=3D false while =
any
descendant remains allocated. Conversely, a clear block that is split and
later has a descendant freed as dirty keeps gpu_buddy_block_is_clear(block)
=3D=3D true on the split ancestor.

When __gpu_buddy_alloc_range_bias() runs the first pass (fallback =3D false=
),
__alloc_range_bias() evaluates block_incompatible(block, flags) on those
GPU_BUDDY_SPLIT ancestors and skips the entire subtree without descending
into its children. If no other root satisfies the request, the first pass
returns -ENOSPC and __gpu_buddy_alloc_range_bias() falls back to the second
pass (fallback =3D true), where block_incompatible() is disabled and the
clear/has_clear child-ordering preference has been removed, causing the
search to split the highest-address extent regardless of class.

Second, __gpu_buddy_free() coalesces adjacent clear and dirty free buddies
into a single GPU_BUDDY_FREE block with state GPU_BLOCK_MIXED, which has
gpu_buddy_block_is_clear(block) =3D=3D false and block->has_clear =3D=3D tr=
ue:

1. For clear range allocations (flags & GPU_BUDDY_CLEAR_ALLOCATION), Pass 1
   sees gpu_buddy_block_is_clear(block) =3D=3D false on a GPU_BLOCK_MIXED b=
lock
   and skips it via block_incompatible() without splitting it to reach the
   clear sub-blocks inside. Pass 2 then splits the mixed block without clear
   child-steering and unconditionally visits block->right first, returning a
   dirty block whenever the clear half is in block->left.

2. For dirty range allocations (!(flags & GPU_BUDDY_CLEAR_ALLOCATION)),
   block_incompatible() returns false on a higher-order GPU_BLOCK_MIXED
   block because gpu_buddy_block_is_clear(block) is false. Pass 1 then calls
   split_block(mm, block), which reclassifies block->left and block->right
   via mark_free(). If the child overlapping [start, end) is clear while the
   dirty child lies outside [start, end), Pass 1 rejects the clear child via
   block_incompatible() and skips the other child without calling
   __gpu_buddy_undo_splits().

Wouldn't leaving that split GPU_BLOCK_MIXED block unmerged keep both
children in GPU_BUDDY_FREE state, preventing ancestor coalescing on teardown
and triggering gpu_buddy_assert(gpu_buddy_block_is_free(mm->roots[i])) while
leaking the split child gpu_buddy_block structures in gpu_buddy_fini()?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020055537.1640=
552-1-arunpravin.paneerselvam@amd.com?part=3D1
