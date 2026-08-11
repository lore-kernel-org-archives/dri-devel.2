Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3272C5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 19:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3087310ED75;
	Tue, 11 Aug 2026 19:52:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A9cLLJcT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DF2910ED75
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 19:52:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7FCE5600AD;
 Tue, 11 Aug 2026 19:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091581F000E9;
 Tue, 11 Aug 2026 19:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786477967;
 bh=YW5GW7Nfc3wFM7A50/05/o5j9hNZ2PVdTvIstgtFYGg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=A9cLLJcTsb5FY2b9+1dCJOFie19Pj7KnWGst4nXSmaL7Fw2PeWl9sy/kKMtAls4eB
 HXRg/w7KvTaNPXY/Vwke2TamTIW4yjYnniFwAc67sdRVDaZq8ZvuhXObnUcQcKTBGp
 76WzfZGTZAQlj4nmPvlA+NwVo0PY4l4ScQIiyqSTwneB03v95Rj280ltIBr3IWJaIE
 lfArCko44PfQePh47UuXsbdLjezfCCxlf7i3bSgaYTadlgpj+aDyMKd6UPsdt9tARq
 12ffuAxKBD7xuSTnz1ziJfj7tJN2eneBT1Kns+lWklvo2vLsJ0uRMg+q18/otirvQK
 vInkogOcqKmNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/6] ttm_pool_type_init() does not check return value
To: =?utf-8?b?w5NzY2FyIE1lZ8OtYSBMw7NwZXo=?= <megia.oscar@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260811194224.121597-5-megia.oscar@gmail.com>
References: <20260811194224.121597-1-megia.oscar@gmail.com>
 <20260811194224.121597-5-megia.oscar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 19:52:46 +0000
Message-Id: <20260811195247.091581F000E9@smtp.kernel.org>
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
- [High] Missing return value check of ttm_pool_mgr_init() combined with de=
structive error cleanup leads to double free and list poisoning panic.
--

--- Patch [4]: [PATCH v5 4/6] ttm_pool_type_init() does not check return va=
lue ---
commit 141193c84a0c35c0b77d8194cafc18a0ddfa41ee
Author: =C3=93scar Meg=C3=ADa L=C3=B3pez <megia.oscar@gmail.com>

ttm_pool_type_init() does not check return value

This commit modifies ttm_pool_mgr_init() to check the return value of
ttm_pool_type_init(). If initialization fails, it cleans up the partially
allocated structures, frees the shrinker, and returns the error code.

Cc: <stable@vger.kernel.org> # 7.1.0
Fixes: 444e2a19d7fd ("ttm/pool: port to list_lru. (v2)")

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index b95c6548adf7f..8d9891ea8c6aa 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c

[ ... ]

> @@ -1537,6 +1585,8 @@ static inline u64 ttm_get_node_memory_size(int nid)
>  int ttm_pool_mgr_init(unsigned long num_pages)
>  {
>  	unsigned int i;
> +	int ret =3D 0;
> +	struct ttm_pool_type *types_free[3];
> =20
>  	int nid;
>  	for_each_node(nid) {

[ ... ]

> +	mm_shrinker =3D shrinker_alloc(SHRINKER_NUMA_AWARE, "drm-ttm_pool");
> +	if (!mm_shrinker)
> +		return -ENOMEM;
> +
>  	for (i =3D 0; i < NR_PAGE_ORDERS; ++i) {
> -		ttm_pool_type_init(&global_write_combined[i], NULL,
> +		ret =3D ttm_pool_type_init(&global_write_combined[i], NULL,
>  				   ttm_write_combined, i);
> -		ttm_pool_type_init(&global_uncached[i], NULL, ttm_uncached, i);
> +		if (ret) {
> +			ttm_pool_type_fini_and_list_lru_destroy(i);
> +			shrinker_free(mm_shrinker);
> +			return ret;

[Severity: High]
If ttm_pool_mgr_init() fails and returns an error here, can this lead to
a double-free or panic during teardown?

Looking at the caller ttm_global_init() in drivers/gpu/drm/ttm/ttm_device.c,
the return value is ignored:

ttm_global_init(void)
{
        ...
        ttm_pool_mgr_init(num_pages);
        ttm_tt_mgr_init(num_pages, num_dma32);
        ...
}

Because the caller ignores the error, the system will continue running with
partially destroyed global state. When the module is eventually unloaded,
ttm_pool_mgr_fini() will run unconditionally:

ttm_pool_mgr_fini(void)
{
        ...
        for (i =3D 0; i < NR_PAGE_ORDERS; ++i) {
                ttm_pool_type_fini(&global_write_combined[i]);
                ...
        }
        ...
        shrinker_free(mm_shrinker);
}

Since mm_shrinker isn't set to NULL after the error path calls
shrinker_free(), won't ttm_pool_mgr_fini() trigger a double-free on the
shrinker?

Also, won't ttm_pool_mgr_fini() attempt to access list entries that have
already been poisoned or deleted by
ttm_pool_type_fini_and_list_lru_destroy() in the error path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811194224.1215=
97-1-megia.oscar@gmail.com?part=3D4
