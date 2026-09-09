Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02549C79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 396A410E12E;
	Wed,  9 Sep 2026 08:23:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W8fA2dk3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 534E810E12E
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 08:23:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3C6A04164F;
 Wed,  9 Sep 2026 08:23:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EDA1F00A3A;
 Wed,  9 Sep 2026 08:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788942199;
 bh=oEZuvwTcmy5ZkLce63iYDgvqyZzZrigtGBFagirH42I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W8fA2dk3s1amu5NmHYAsbyoOCEbxt5C1uNE/BVWnBq5R3lZLHdY5OSW78vEoDC286
 o98O0mondJTr95jRphigLRoYOVGxJTj8x0zNQl+Ut/K0jhaXSKbmBmPQedv3a2NXlt
 Lsslh7yUYZoot4glInS3h6PqjypWIqNSTX38bW+jxcypZh39ayUwRE67cmJj0hWqyN
 6jdo5YQom01zube6d0U234CbE8t1c6Fnh4LfOO0m7sx3SnEMb1O08MKaEH2RY/7Evv
 H0tXyODiYrNsTQznpLqLnR8a6WCne2I+3riMRj/mZ/Xzi7rPzLf6/TgHhRocrcn00X
 /ZPnrHNNb0p5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] mm: page_counter: add page_counter_protection
 struct and init API
To: linuszeng <linuszeng@tencent.com>
Cc: dri-devel@lists.freedesktop.org, hannes@cmpxchg.org, tj@kernel.org,
 mkoutny@suse.com
In-Reply-To: <20260909-descriptive-name-v1-1-1828961cb01a@tencent.com>
References: <20260909-descriptive-name-v1-0-1828961cb01a@tencent.com>
 <20260909-descriptive-name-v1-1-1828961cb01a@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 08:23:18 +0000
Message-Id: <20260909082318.C6EDA1F00A3A@smtp.kernel.org>
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
- [High] Missing fixup of `prot.parent` linkage when dynamically creating d=
mem cgroup pools breaks hierarchical protection.
--

commit 534b5f88933b6e08b308d664bd9c8b28861c0c8c
Author: linuszeng <linuszeng@tencent.com>

mm: page_counter: add page_counter_protection struct and init API

This commit extracts the hierarchical protection state (memory.min and
memory.low) from struct page_counter into a new page_counter_protection
structure. It introduces page_counter_init_protection() to attach this
context, saving space for counters that don't support protection.

> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> index 4683f3d680226..e33d807cdea89 100644
> --- a/kernel/cgroup/dmem.c
> +++ b/kernel/cgroup/dmem.c
> @@ -426,8 +427,9 @@ alloc_pool_single(struct dmemcg_state *dmemcs, struct=
 dmem_cgroup_region *region
>  	if (parent)
>  		ppool =3D find_cg_pool_locked(parent, region);
> =20
> -	page_counter_init(&pool->cnt,
> -			  ppool ? &ppool->cnt : NULL, true);
> +	page_counter_init(&pool->cnt, ppool ? &ppool->cnt : NULL);
> +	page_counter_init_protection(&pool->cnt, &pool->prot,
> +				     ppool ? &ppool->prot : NULL);
>  	reset_all_resource_limits(pool);
>  	refcount_set(&pool->ref, 1);
>  	kref_get(&region->ref);

[Severity: High]
Does get_cg_pool_locked() also need to be updated to fix up the prot.parent
linkage?

When alloc_pool_single() is called during a bottom-up dynamic pool creation,
ppool can be NULL. This sets pool->prot.parent to NULL here. Later in
get_cg_pool_locked(), the missing parent pools are created and a fixup loop
links the counters:

kernel/cgroup/dmem.c:get_cg_pool_locked() {
    ...
		/* ppool was created if it didn't exist by above loop. */
		ppool =3D find_cg_pool_locked(pp, region);

		/* Fix up parent links, mark as inited. */
		pool->cnt.parent =3D &ppool->cnt;
		if (ppool && !pool->parent) {
    ...
}

Because pool->prot.parent =3D &ppool->prot; is missing in this fixup loop,
prot.parent permanently remains NULL. This causes propagate_protected_usage=
()
to silently abort due to !prot->parent, breaking hierarchical protection
for the dmem cgroup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-descriptiv=
e-name-v1-0-1828961cb01a@tencent.com?part=3D1
