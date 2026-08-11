Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFABC5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 19:50:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B79E010E38A;
	Tue, 11 Aug 2026 19:50:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q646UvQD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38FA210E38A
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 19:50:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1FD72600AD;
 Tue, 11 Aug 2026 19:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7921F000E9;
 Tue, 11 Aug 2026 19:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786477822;
 bh=fqyUkkMbd7IgXtMSMaqppFt8NZJOi/FATEcDnStxWWk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Q646UvQDDEwN/W30kca1LXZuhNokcaHUDnA1iBlyyABj5nriRE6eibHaHP68SWKsX
 +IEykq/nr2YZsoUwwk+DYIBwC5qILXxkvrMymfbdKgY8/th+Vm6V6Q+ns+bBs3lUe7
 q3AEorV6TezvnoDCxltAdebRxVzHJ9spddMgq1sH+lVCCPFnDXStw7LiND9ybUdZ4C
 nUE8mGBevYhZTu7qIT1DLcapJ97m9yhT18VtxzMM8IbQMdNquq0yvd/fumpDP6zsjJ
 znzW9Jga5Z9rao6boYl5R1w1rm68OQQRRCHY8RbzOH5M+uTn+wEooC9nYSz+L0LK0S
 wDXRO93U+wEVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/6] ttm_pool_mgr_init() does not check return value
To: =?utf-8?b?w5NzY2FyIE1lZ8OtYSBMw7NwZXo=?= <megia.oscar@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260811194224.121597-7-megia.oscar@gmail.com>
References: <20260811194224.121597-1-megia.oscar@gmail.com>
 <20260811194224.121597-7-megia.oscar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 19:50:21 +0000
Message-Id: <20260811195022.9E7921F000E9@smtp.kernel.org>
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
- [High] Missing cleanup of `ttm_pool_mgr_init()` allocations when `alloc_p=
age()` fails in `ttm_global_init()`.
--

--- Patch [6]: [PATCH v5 6/6] ttm_pool_mgr_init() does not check return val=
ue ---
commit 18452a40ead8211d272e9f32ad64ceec8ef1cf22
Author: =C3=93scar Meg=C3=ADa L=C3=B3pez <megia.oscar@gmail.com>

ttm_pool_mgr_init() does not check return value

This commit fixes a missing return value check for ttm_pool_mgr_init() in
ttm_global_init(). It propagates the error by jumping to the out label if
initialization fails.

Cc: <stable@vger.kernel.org> # 7.1.0
Fixes: 444e2a19d7fd ("ttm/pool: port to list_lru. (v2)")

> diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_d=
evice.c
> index d3bfb9a696a74..896b766712d04 100644
> --- a/drivers/gpu/drm/ttm/ttm_device.c
> +++ b/drivers/gpu/drm/ttm/ttm_device.c
> @@ -96,7 +96,9 @@ static int ttm_global_init(void)
>  		>> PAGE_SHIFT;
>  	num_dma32 =3D min(num_dma32, 2UL << (30 - PAGE_SHIFT));
> =20
> -	ttm_pool_mgr_init(num_pages);
> +	ret =3D ttm_pool_mgr_init(num_pages);
> +	if (ret)
> +		goto out;

[Severity: High]
This is a pre-existing issue, but does the error handling at the out label
properly clean up after a successful ttm_pool_mgr_init() call?

If the dummy_read_page allocation fails later in this function, we
jump to the out label returning -ENOMEM:

        glob->dummy_read_page =3D alloc_page(__GFP_ZERO);
        if (unlikely(glob->dummy_read_page =3D=3D NULL)) {
                ret =3D -ENOMEM;
                goto out;
        }

However, the cleanup at the out label doesn't appear to call
ttm_pool_mgr_fini() or unregister the shrinker:

out:
        if (ret && ttm_debugfs_root)
                debugfs_remove(ttm_debugfs_root);
        if (ret)
                --ttm_glob_use_count;
        mutex_unlock(&ttm_global_mutex);
        return ret;

Since ttm_pool_mgr_init() registers a shrinker (mm_shrinker) and
initializes global spinlocks and lists:

        spin_lock_init(&shrinker_lock);
        INIT_LIST_HEAD(&shrinker_list);
        ...
        mm_shrinker =3D shrinker_alloc(SHRINKER_NUMA_AWARE, "drm-ttm_pool");

Could this leave a registered shrinker behind on failure?

If ttm_global_init() is called again on a subsequent driver load, it would
unconditionally re-initialize shrinker_lock and shrinker_list. If the
originally leaked shrinker is running concurrently during memory reclaim,
could this cause lock or list corruption?

>  	ttm_tt_mgr_init(num_pages, num_dma32);
> =20
>  	glob->dummy_read_page =3D alloc_page(__GFP_ZERO | GFP_DMA32 |

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811194224.1215=
97-1-megia.oscar@gmail.com?part=3D6
