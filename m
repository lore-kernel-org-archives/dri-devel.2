Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1859CA6012
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 10:17:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8EE4112030;
	Fri,  9 Oct 2026 10:17:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XMgEmVbs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FF8110E6D9;
 Fri,  9 Oct 2026 10:17:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4BB5243A64;
 Fri,  9 Oct 2026 10:17:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECED91F000FF;
 Fri,  9 Oct 2026 10:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791541057;
 bh=UPfE00/UoXUG7zf6ee6Dlr63eUdGwgSn+b7TXJUv0tU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XMgEmVbsyaQ1ZMejdiNaHJCfShK6tgg4cBYbBluLd2p6Mi8umtR517nX4MxpNCz/5
 Uv7nliqz32hRA4Pra6N6Xzv3A4i4c85SPOJIwSIUSU2Kg1/pFfVbjTS+7mkw80Ozzs
 jNwzNX1ZSjFkhJ1C3na/Nm0mSe3ztWc6atbbE1bWlWHRH/c3Ieinr05XgJBjW5oWyf
 GJ8bixBF3WGQiXj/S4b2oLeLFPKNjLAuZvM14SxheYuyegEu43DoTNRC6dOa9rW9GX
 rh6xDWI4gF5mU68E/JDPVYIY5AR8+oix4YdQxOaAxuw7th1lwyNW21dUAQO/BnI4q0
 BpufR62NxzRZw==
Message-ID: <sashiko-outbox-165221@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] gpu/buddy: restore two-pass clear/dirty guard
 for range-biased allocation
To: "Arunpravin Paneer Selvam" <arunpravin.paneerselvam@amd.com>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261009100546.1103622-1-arunpravin.paneerselvam@amd.com>
References: <20261009100546.1103622-1-arunpravin.paneerselvam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 10:17:36 +0000
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
- [High] gpu/buddy: block_incompatible() incorrectly rejects mixed subtrees=
 during CLEAR allocations
- [High] gpu/buddy: range allocator strict pass skips valid subtrees due to=
 stale split block clear bits
--

commit 19316e455db24fbfaa4dda04f7d988cae7073da7
Author: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

gpu/buddy: restore two-pass clear/dirty guard for range-biased allocation

This commit introduces a two-pass range search in the buddy allocator's
range-biased allocation path. The strict pass uses block_incompatible() to
reject opposite-class blocks, while the fallback pass relaxes this constrai=
nt
when opposite-class space is the only option remaining.

> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index 2f2aaadafe351..6566bad4fef15 100644
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

[Severity: High]
Does this evaluation correctly handle intermediate SPLIT blocks?

A SPLIT block's GPU_BUDDY_HEADER_CLEAR bit retains the value from when it
was last FREE and is not updated after splitting. If a root or intermediate
block was dirty when split, its clear bit remains 0 even if it now contains
free clear children.

For a CLEAR allocation, will this cause the strict pass to read a stale 0 b=
it
and incorrectly skip the entire valid subtree?

Additionally, are mixed subtrees inadvertently rejected during CLEAR
allocations here?

Since mixed subtrees contain both clear and dirty pages, their is_clear
state evaluates to false. Consequently, block_incompatible() will evaluate
mixed subtrees as incompatible, causing the strict pass to skip them entire=
ly
unless the entire root block is fully clear.

>  static struct gpu_buddy_block *
>  __alloc_range_bias(struct gpu_buddy *mm,
>  		   u64 start, u64 end,
>  		   unsigned int order,
> -		   unsigned long flags)
> +		   unsigned long flags,
> +		   bool fallback)
>  {

[ ... ]

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
Without the has_clear steering logic, how does the fallback pass handle
CLEAR allocations when descending?

If the strict pass fails (as described above for mixed subtrees), the
allocator executes the fallback pass which ignores class preferences.
Because the fallback pass now blindly traverses top-down (right child first)
after the removal of the has_clear steering logic, could a CLEAR range
allocation incorrectly allocate and return dirty blocks if they happen to
be right-most?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009100546.1103=
622-1-arunpravin.paneerselvam@amd.com?part=3D1
