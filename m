Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96428C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 05:33:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F24010E03D;
	Mon,  6 Jul 2026 05:33:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hxRCWjs9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D55610E03D
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 05:33:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 23CD943B97;
 Mon,  6 Jul 2026 05:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEABE1F000E9;
 Mon,  6 Jul 2026 05:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783316014;
 bh=Nt2hW9UAZd/3dw/nxDG8xnufGlARNUpdPhr1ERAznII=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hxRCWjs9HdFCKhjf7euEJ2f8rL7udhRdZuHDEAZFAOG6cqtLNWBBWHT73nZ2PeP7I
 H8lsncTXb3vOmmhnyjxLmQVQWZioyKivqpa3+zBBR/ezKV+kCOfE5SavHM8KgqeOYX
 ymEsq4zFndps8L04FQ+G6sGOgf5n+5j/Pwd9J6dCjcTJs+EZ8RIGJC15avbdaS9000
 z/LzWknp9imBM/oMn95QpI5wsHpk+EvGgILbrPqH67G/mU2dxASbRIcpsNMLcblypY
 TU9xon1ouXjcguDk1ii91T8/z+Fq32ycm7JCFYaUzBr6uKunIpsFr05mezh3wweVQt
 a86xNysPY1jaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/10] ttm/pool: initialise the shrinker earlier (v2)
To: "Dave Airlie" <airlied@gmail.com>
Cc: mkoutny@suse.com, tj@kernel.org, hannes@cmpxchg.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260706052330.1110909-4-airlied@gmail.com>
References: <20260706052330.1110909-1-airlied@gmail.com>
 <20260706052330.1110909-4-airlied@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 05:33:33 +0000
Message-Id: <20260706053333.AEABE1F000E9@smtp.kernel.org>
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
- [High] Deadlock due to leaked `pool_shrink_rwsem` read lock on early retu=
rn in `ttm_pool_shrink()`.
- [High] Fatal NULL pointer dereference caused by bypassed global pool init=
ialization upon `shrinker_alloc` failure.
--

commit a5f142f7cded6383539224542edc3c44efc5294c
Author: Dave Airlie <airlied@redhat.com>

ttm/pool: initialise the shrinker earlier (v2)

This commit moves the shrinker initialization earlier in the module load
sequence to accommodate future memcg enablement. It also adds a check in
the shrinker callback to handle uninitialized lists.

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index e4dbf4c93091c..f12b68812081f 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -440,10 +440,14 @@ static unsigned int ttm_pool_shrink(int nid, unsign=
ed long num_to_free)
> =20
>  	down_read(&pool_shrink_rwsem);
>  	spin_lock(&shrinker_lock);
> -	pt =3D list_first_entry(&shrinker_list, typeof(*pt), shrinker_list);
> -	list_move_tail(&pt->shrinker_list, &shrinker_list);
> +	pt =3D list_first_entry_or_null(&shrinker_list, typeof(*pt), shrinker_l=
ist);
> +	if (pt)
> +		list_move_tail(&pt->shrinker_list, &shrinker_list);
>  	spin_unlock(&shrinker_lock);
> =20
> +	if (!pt)
> +		return 0;
> +

[Severity: High]
Does this early return leak the pool_shrink_rwsem read lock?

We acquire the lock just a few lines above via down_read(&pool_shrink_rwsem=
).
If the shrinker list is empty and pt is NULL, returning here skips the
up_read() call at the end of the function, which could lead to a deadlock
when another writer or reader attempts to acquire it.

[ ... ]

> @@ -1402,6 +1406,17 @@ int ttm_pool_mgr_init(unsigned long num_pages)
>  	spin_lock_init(&shrinker_lock);
>  	INIT_LIST_HEAD(&shrinker_list);
> =20
> +	mm_shrinker =3D shrinker_alloc(SHRINKER_NUMA_AWARE, "drm-ttm_pool");
> +	if (!mm_shrinker)
> +		return -ENOMEM;
> +

[Severity: High]
If shrinker_alloc() fails and returns early here, does it leave the global
pool structures completely uninitialized?

Because the caller ttm_global_init() ignores the return value of
ttm_pool_mgr_init(), driver initialization will continue. The newly moved
return bypasses the initialization loop for structures like
global_write_combined.

When the driver later attempts to allocate from these pools, or when
ttm_pool_mgr_fini() calls list_del() on the zero-filled uninitialized
structures, can this cause a NULL pointer dereference?

> +	mm_shrinker->count_objects =3D ttm_pool_shrinker_count;
> +	mm_shrinker->scan_objects =3D ttm_pool_shrinker_scan;
> +	mm_shrinker->batch =3D TTM_SHRINKER_BATCH;
> +	mm_shrinker->seeks =3D 1;
> +
> +	shrinker_register(mm_shrinker);
> +
>  	for (i =3D 0; i < NR_PAGE_ORDERS; ++i) {
>  		ttm_pool_type_init(&global_write_combined[i], NULL,
>  				   ttm_write_combined, i);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706052330.1110=
909-1-airlied@gmail.com?part=3D3
