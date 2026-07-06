Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90D6C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 02:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0779A10E716;
	Mon,  6 Jul 2026 02:56:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W9F/oqxk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B73D510E716
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 02:55:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6FA5642B97;
 Mon,  6 Jul 2026 02:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E6D1F000E9;
 Mon,  6 Jul 2026 02:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783306558;
 bh=VJwicUBRYZevUQ5vGSUR111aoOXBtmECWjHz/s3JMBw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W9F/oqxkqH6SpyECa23APA0s5T+LIRftsM2aMK5atIRr7pIUveSfqrASN8ou5K2Q0
 3Q5UNH5hf324GUZ0cCnmGQneMohJC7CLNebDr5A+E/zpRPVmck7gzDVyxvdfVHqnKH
 MNyGXa6MdXmlugt1RvhvVZChLv3U2wvB671lV69sQHNBBeQHx+n51IiHZKJm756nGl
 5t0nRF5x6/ozzdeNkyZDAeMsjn8dDUuLhpjTMZc+//WENI/znmOSQReSW3EIj75K0T
 HbdCIXjiMspAFN7cDAx5dO6cIF1lvOTz6Tp9Jws5ErKq+fJKCKKgv7Xj9IpOTm1lwa
 1E6MGMikXIZmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/10] memcontrol: allow objcg api when memcg is config
 off.
To: "Dave Airlie" <airlied@gmail.com>
Cc: tj@kernel.org, mkoutny@suse.com, dri-devel@lists.freedesktop.org,
 hannes@cmpxchg.org
In-Reply-To: <20260706024122.853329-8-airlied@gmail.com>
References: <20260706024122.853329-1-airlied@gmail.com>
 <20260706024122.853329-8-airlied@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:55:56 +0000
Message-Id: <20260706025557.83E6D1F000E9@smtp.kernel.org>
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
- [Low] Missing `!CONFIG_MEMCG` stubs for GPU memcg accounting functions (`=
mem_cgroup_charge_gpu_page`, etc.) causes a linker error.
--

commit ba45048ba307805ed185b05a25fe4419acb46277
Author: Dave Airlie <airlied@redhat.com>

memcontrol: allow objcg api when memcg is config off.

This commit adds a dummy function for get_obj_cgroup_from_current() when
CONFIG_MEMCG is disabled. This allows drivers like amdgpu to use the objcg
API without needing ifdef blocks around it.

> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 3a968c6be0c84..a8f74aa930c57 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1804,6 +1804,11 @@ static inline void __memcg_kmem_uncharge_page(stru=
ct page *page, int order)
>  {
>  }
> =20
> +static inline struct obj_cgroup *get_obj_cgroup_from_current(void)
> +{
> +	return NULL;
> +}
> +

[Severity: Low]
Are there other objcg API functions that also need dummy stubs to prevent
linker errors when CONFIG_MEMCG is disabled?

For example, mem_cgroup_charge_gpu_page() is declared unconditionally in
include/linux/memcontrol.h:

bool mem_cgroup_charge_gpu_page(struct obj_cgroup *objcg, struct page *page,
                                unsigned int order,
                                gfp_t gfp_mask, bool reclaim);

This function is used directly without an ifdef block in the TTM driver:

drivers/gpu/drm/ttm/ttm_pool.c:ttm_pool_alloc_page() {
    ...
    if (!mem_cgroup_charge_gpu_page(objcg, p, order, gfp_flags, false)) {
    ...
}

Does building a kernel with CONFIG_MEMCG=3Dn and CONFIG_DRM_TTM=3Dy result =
in
undefined reference linker errors for mem_cgroup_charge_gpu_page() and
other related GPU memcg accounting functions?

>  static inline struct obj_cgroup *get_obj_cgroup_from_folio(struct folio =
*folio)
>  {
>  	return NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706024122.8533=
29-1-airlied@gmail.com?part=3D7
