Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE13C79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 09:55:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2097510F07E;
	Wed,  9 Sep 2026 09:55:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DrTl92rE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7F9F10F083
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 09:55:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 79E3F43BD9;
 Wed,  9 Sep 2026 09:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DAA1F00A3A;
 Wed,  9 Sep 2026 09:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788947746;
 bh=k3ZoXUWw8+ylgNyx+mvqFr+Yin7qk9+Vwg/NP0wfrn8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DrTl92rEH/58vPKQjtHiWyOV3KtyaiStg2D3hgRsDfaHIuvGGm3iPKBfxrZUNK3NT
 1JWeD/g7yqWTNpUeVrbfTQOmhfCI7cPRuFvWEvs40xWMeAdKxn9DqS+nNMrUYVgZEd
 h0v6buzJRD8k0y0J95bb+zS8nWP7RkKrZFtR562GpPzF0S3ebDqmJn4UcNjCGmTe2d
 3xF+VG7TCDpCB8y5+S/tLgPkaBvMMYeLwfEr331arK5Eau66TsNKdKNCKTgaomCSUh
 5yGWDhLRYhhEuOnyTDzD4RYSB9hgfiiWBN4ot52ua+oaOIN092k9fjeoTncbkkgEv4
 vBacFmIfBj3HQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] mm: page_counter: track protection state in
 page_counter_protection
To: linuszeng <linuszeng@tencent.com>
Cc: dri-devel@lists.freedesktop.org, tj@kernel.org, mkoutny@suse.com,
 hannes@cmpxchg.org
In-Reply-To: <20260909-descriptive-name-v2-2-d7dd7c099049@tencent.com>
References: <20260909-descriptive-name-v2-0-d7dd7c099049@tencent.com>
 <20260909-descriptive-name-v2-2-d7dd7c099049@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:55:45 +0000
Message-Id: <20260909095546.11DAA1F00A3A@smtp.kernel.org>
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
- [High] Concurrent dmem cgroup eviction can observe a partially initialize=
d pool and trigger a NULL pointer dereference.
--

commit 505dda1717b6dcbcc1903e6c7cc5e90077d70bb6
Author: linuszeng <linuszeng@tencent.com>
Subject: mm: page_counter: track protection state in page_counter_protection

This patch moves the read/write side of hierarchical protection from struct
page_counter to struct page_counter_protection. It updates
propagate_protected_usage and calculate_protection, along with accessors to
operate on the new context structure. The patch intends to introduce no
functional changes.

> diff --git a/mm/page_counter.c b/mm/page_counter.c
> index 38cb99f5f50ed..401201c8e3902 100644
> --- a/mm/page_counter.c
> +++ b/mm/page_counter.c

[ ... ]

> @@ -463,23 +479,24 @@ void page_counter_calculate_protection(struct page_=
counter *root,
>  		return;
> =20
>  	if (parent =3D=3D root) {
> -		counter->emin =3D READ_ONCE(counter->min);
> -		counter->elow =3D READ_ONCE(counter->low);
> +		prot->emin =3D READ_ONCE(prot->min);
> +		prot->elow =3D READ_ONCE(prot->low);
>  		return;
>  	}
> =20
> +	parent_prot =3D parent->prot;

[Severity: High]
This is a pre-existing issue, but could this code encounter a null pointer
dereference if concurrent dmem cgroup eviction observes a partially
initialized pool?

Looking at alloc_pool_single in kernel/cgroup/dmem.c, a new pool is
published to the RCU-protected pools list before its parent link is fully
established:

alloc_pool_single()
    ...
    list_add_tail_rcu(&pool->css_node, &dmemcs->pools);
    ...

If a concurrent thread running dmem_cgroup_state_evict_valuable or
dmem_cgroup_below_min iterates over the cgroup descendants via
css_for_each_descendant_pre, it can find this partially initialized pool and
pass it to page_counter_calculate_protection.

Since counter->parent is null and does not match the root argument, the
early return above is skipped, leading to a dereference of parent->prot
here when parent is null.

Does the eviction path need to synchronize with the completion of pool
initialization, or should page_counter_calculate_protection check if parent
is null before dereferencing it?

>  	parent_usage =3D page_counter_read(parent);
> =20
> -	WRITE_ONCE(counter->emin, effective_protection(usage, parent_usage,
> -			READ_ONCE(counter->min),
> -			READ_ONCE(parent->emin),

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-descriptiv=
e-name-v2-0-d7dd7c099049@tencent.com?part=3D2
