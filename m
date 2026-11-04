Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE794606A331
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ctzt+X2k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 326F810F9F9;
	Wed,  4 Nov 2026 07:46:20 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EADE10F9F9;
 Wed,  4 Nov 2026 07:46:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8AC2B60D81;
 Wed,  4 Nov 2026 07:46:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C081F0093A;
 Wed,  4 Nov 2026 07:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793778373;
 bh=UfYw2coa9Uw1N5bRYGQ1yVRwkVa12E37kxIHwAkm/Mo=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Ctzt+X2kncuH+w9j8zM2EloMzCa/92JAMzd9V9P+dQD++kz56I1bT2Y7EgADrRJtM
 TX5mi9DkLuZgcFKMKQV30gvQBwKIDt6ca0lN8hc3kfqgJQ7GGl/iaal19k9q2nu7kq
 w0QYuyHo4ixm4INGF7F4BMKRGrRyNdszQ+RSXEerxydjbGYCvY1TqXc2ODUYEIjEMi
 b8DJWpyLQ8WFl5p9mTnmx6bt9nNv48kdt5VCkH7ZZinJrKx7VS7UlPYyr+wW5uJ8jX
 F7XOdCpFQzQ+FdbCmevdNgSBXRSkllrvmXg9pjmrmk7AAjKNJOkdIPf+WTXBkhruoR
 6bNJZpx4LbspQ==
Message-ID: <sashiko-outbox-196818@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] gpu/buddy: restore two-pass clear/dirty guard for
 range-biased allocation
To: "Arunpravin Paneer Selvam" <arunpravin.paneerselvam@amd.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261104072847.2617886-1-arunpravin.paneerselvam@amd.com>
References: <20261104072847.2617886-1-arunpravin.paneerselvam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 07:46:12 +0000
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
- [Medium] gpu/buddy: strict pass in __alloc_range_bias() skips straddling =
free blocks
- [Medium] gpu/buddy: __alloc_range_bias() drops clear child preference ove=
r mixed blocks
--

commit 39aa2fd8b0782a6f08d3234bf343e92cab53a75f
Author: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

gpu/buddy: restore two-pass clear/dirty guard for range-biased allocation

This commit adds a two-pass clear/dirty compatibility guard to
__alloc_range_bias() so range-constrained allocations avoid splitting
opposite-class extents unless no compatible space exists in the range. It
also adds a KUnit regression test covering range-biased clear/dirty
isolation.

> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index 28cff97d57dc8..d9749cbaf05d6 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -1240,11 +1240,23 @@ static void __gpu_buddy_undo_splits(struct gpu_bu=
ddy *mm,
>  	}
>  }
> =20
> +static bool block_incompatible(struct gpu_buddy_block *block, unsigned i=
nt flags)
> +{
> +	bool needs_clear =3D flags & GPU_BUDDY_CLEAR_ALLOCATION;
> +
> +	if (!gpu_buddy_block_is_free(block))
> +		return false;
> +
> +	return needs_clear ? !block->has_clear :
> +			     gpu_buddy_block_is_clear(block);
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

> @@ -1296,8 +1306,19 @@ __alloc_range_bias(struct gpu_buddy *mm,
>  			if (round_down(adjusted_end + 1, req_size) <=3D
>  			    round_up(adjusted_start, req_size))
>  				continue;
> +
> +			/*
> +			 * Strict pass: don't split a partially-overlapping free
> +			 * block; rejecting its child would strand the split. Let
> +			 * the fallback pass consume it (either class accepted).
> +			 */
> +			if (!fallback && gpu_buddy_block_is_free(block))
> +				continue;
>  		}
> =20
> +		if (!fallback && block_incompatible(block, flags))
> +			continue;

[Severity: Medium]
In gpu_buddy_alloc_blocks() -> __gpu_buddy_alloc_blocks() ->
__gpu_buddy_alloc_range_bias() -> __alloc_range_bias(), when a sub-range
[start, end) is smaller than a free root or coalesced ancestor block (so
block_start < start || block_end > end), doesn't skipping every partially
overlapping free block in the strict pass cause the strict pass to skip
descending into that block even when it contains compatible space or is
itself wholly compatible with the request?

Since __gpu_buddy_free() coalesces free buddy pairs across clear and dirty
states into mixed free blocks, a coalesced free block or a wholly compatible
free block straddling start or end will be skipped by:

	if (block_start < start || block_end > end) {
		...
		if (!fallback && gpu_buddy_block_is_free(block))
			continue;
	}

When that causes the strict pass to return -ENOSPC,
__gpu_buddy_alloc_range_bias() retries with fallback =3D true, which disabl=
es
block_incompatible() across the entire traversal and allows splitting
higher-address opposite-class extents inside [start, end) even when
compatible blocks exist in the range.

Similarly, when dirty_steer_window() narrows [start, end) to a dirty window
inside a larger coalesced mixed free block, won't the strict pass always
skip the enclosing free block and fail with -ENOSPC before retrying in the
fallback pass?

>  		if (contains(start, end, block_start, block_end) &&
>  		    order =3D=3D gpu_buddy_block_order(block)) {
>  			/*
> @@ -1315,38 +1336,8 @@ __alloc_range_bias(struct gpu_buddy *mm,
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

[Severity: Medium]
In __alloc_range_bias(), block_incompatible() treats both wholly clear
blocks and mixed blocks (where block->has_clear is true but
gpu_buddy_block_is_clear(block) is false) as compatible when
GPU_BUDDY_CLEAR_ALLOCATION is set.

With the child preference check removed here so block->right is always
visited before block->left, if a split parent has a mixed right child and a
wholly clear left child at the target order, won't a non-top-down
GPU_BUDDY_CLEAR_ALLOCATION request now select the mixed right child (with
GPU_BUDDY_HEADER_CLEAR unset, requiring the caller to re-clear it) while
leaving the wholly clear left sibling unused?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104072847.2617=
886-1-arunpravin.paneerselvam@amd.com?part=3D1
