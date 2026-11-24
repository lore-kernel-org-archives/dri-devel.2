Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3751C606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 06:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PxKnBR2n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84F4710E66B;
	Tue, 24 Nov 2026 06:31:53 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D6B410E337;
 Tue, 24 Nov 2026 06:31:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B49E660D2F;
 Tue, 24 Nov 2026 06:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFD71F000CA;
 Tue, 24 Nov 2026 06:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795501905;
 bh=qBkSQ24bPt1jBHxMiTGr+82etN3hgC6nAv9yD1Mmlyo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PxKnBR2nMIUD85GtMiZa5FJ9I2auSDP0AWIlpWT5OzuaKDdrVtfxQ/RTVRVVfsGsu
 HyhKlQru9CtiPNWzbv6OjLve0BZBsdF0m2p2/Iu8cBZbttJ3Jz4kLQlB/WpvLhUtvA
 xqzAxw1Nem1xS4K45as5jrYlqFEFErDLQleshzFit4mz/xmyOJ1l81UA3TqfRNtiHF
 JE5fx+bzC+EaXjK7b8JR5pnevX/9hibWb9yC/UatFZ6QRm/ucJuRRYDYOZyLHbZQhF
 J2vqDcwzi+P8pX6dSXVb85iWCn/sduWejRUIijKahuDt4obOidSKoro6yOldz/ML7+
 nb0isd310TcAQ==
Message-ID: <sashiko-outbox-230598@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC v2 05/11] drm/amdgpu: Use ttm_operation_ctx numa_info
 instead of per-partition pools
To: "Himal Prasad Ghimiray" <himal.prasad.ghimiray@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
In-Reply-To: <20261124062123.2431244-18-himal.prasad.ghimiray@intel.com>
References: <20261124062123.2431244-13-himal.prasad.ghimiray@intel.com>
 <20261124062123.2431244-18-himal.prasad.ghimiray@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 06:31:44 +0000
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
- [High] drm/amdgpu: -EOPNOTSUPP in amdgpu_ttm_tt_populate() when
  need_swiotlb is set
--

commit 0d7e02838b040282a0c34d64857fd1fdc0a04ed6
Author: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>

drm/amdgpu: Use ttm_operation_ctx numa_info instead of per-partition pools

This commit removes the per-partition TTM pools on APUs with memory
partitions and allocates pages from the device pool using
TTM_NUMA_POLICY_PREFERRED in ttm_operation_ctx.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index d3a875a32af1e..8740b7a76ad19 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c

[ ... ]

> @@ -1242,7 +1245,9 @@ static int amdgpu_ttm_tt_populate(struct ttm_device=
 *bdev,
>  {
>  	struct amdgpu_device *adev =3D amdgpu_ttm_adev(bdev);
>  	struct amdgpu_ttm_tt *gtt =3D ttm_to_amdgpu_ttm_tt(ttm);
> -	struct ttm_pool *pool;
> +	/* ctx is shared by every BO of the operation; set the node locally */
> +	struct ttm_operation_ctx node_ctx =3D *ctx;
> +	nodemask_t preferred;
>  	pgoff_t i;
>  	int ret;
> =20
> @@ -1257,11 +1262,13 @@ static int amdgpu_ttm_tt_populate(struct ttm_devi=
ce *bdev,
>  	if (ttm->page_flags & TTM_TT_FLAG_EXTERNAL)
>  		return 0;
> =20
> -	if (adev->mman.ttm_pools && gtt->pool_id >=3D 0)
> -		pool =3D &adev->mman.ttm_pools[gtt->pool_id];
> -	else
> -		pool =3D &adev->mman.bdev.pool;
> -	ret =3D ttm_pool_alloc(pool, ttm, ctx);
> +	if (gtt->numa_node !=3D NUMA_NO_NODE) {
> +		nodes_clear(preferred);
> +		node_set(gtt->numa_node, preferred);
> +		node_ctx.numa_info.policy =3D TTM_NUMA_POLICY_PREFERRED;
> +		node_ctx.numa_info.nodes =3D &preferred;
> +	}
> +	ret =3D ttm_pool_alloc(&adev->mman.bdev.pool, ttm, &node_ctx);

[Severity: High]
Will ttm_pool_alloc() fail with -EOPNOTSUPP when adev->need_swiotlb is set
on a partitioned APU?

amdgpu_ttm_init() initializes adev->mman.bdev.pool with
TTM_ALLOCATION_POOL_USE_DMA_ALLOC when adev->need_swiotlb is true (for
example, under SME/SEV memory encryption), whereas the old
amdgpu_ttm_pools_init() omitted that flag on the per-partition pools.
Because ttm_pool_check_numa() rejects any policy other than
TTM_NUMA_POLICY_NONE when TTM_ALLOCATION_POOL_USE_DMA_ALLOC is set on the
pool, populating any BO with a partition NUMA node will now fail with
-EOPNOTSUPP.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124062123.2431=
244-13-himal.prasad.ghimiray@intel.com?part=3D5
