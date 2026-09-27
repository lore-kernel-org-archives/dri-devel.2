Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E92C9830E
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 10:43:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE64210E452;
	Sun, 27 Sep 2026 10:43:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ovOZpoNw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 885A510E452
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 10:43:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A9A0E60AAE;
 Sun, 27 Sep 2026 10:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B711F000FF;
 Sun, 27 Sep 2026 10:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790505816;
 bh=3ky50om/bjHtczX+q8bIlR7RxN9j5h1yWOgBiONdpAg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ovOZpoNwOwf2Nr61lbbGLG13hs3fFr76xHy4azjaoAkU9H5d58GjsOtij0tGybivX
 6IZMzAMWIQGvy8ePOlFAvrlPjZqRkRibYeBJ11Zb4NYzrWHwok4hcZaHThmKD4yv7o
 bHZv2h9HxTwlY3e/EkyQqBHzDlHnvCKCmx8p7CaYiOUndNH7VcLaYvhX0COS6caX4z
 tvM/s6cFYRgXE83EPL/Zx2MKZAMCRlbZteaVPcKKnYH533ruKuK/GYCn4CWts/PNvj
 KwAIT5tjKtJRpxay1iztBZ2MYH+jEfn4ruORZ5xKAM/aG3lynYWWXoM7ZkYb5H9tKR
 Rf3qJE6ImyF/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] Memory leak error in qxl unbind
To: =?utf-8?b?w5NzY2FyIE1lZ8OtYSBMw7NwZXo=?= <megia.oscar@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260927103231.47692-1-megia.oscar@gmail.com>
References: <20260927103231.47692-1-megia.oscar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 10:43:35 +0000
Message-Id: <20260927104336.35B711F000FF@smtp.kernel.org>
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
- [High] mm: debugfs NULL pointer dereference after premature list_lru_dest=
roy()
--

commit 32ad6c26fe41ce4b4170b40c6c684d9806d52913
Author: =C3=93scar Meg=C3=ADa L=C3=B3pez <megia.oscar@gmail.com>

    Memory leak error in qxl unbind

This commit addresses a memory leak during qxl unbind by calling
list_lru_destroy() for each global pool type's page list in
ttm_pool_mgr_fini(). It also introduces ttm_pool_synchronize_shrinkers()
to prevent concurrent shrinker access to pages being freed.

Link: https://lore.kernel.org/virtualization/20260927101026.45411-1-megia.o=
scar@gmail.com/ [1]
Link: https://lore.kernel.org/dri-devel/20260731053047.24503-1-megia.oscar@=
gmail.com/ [2]

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index 1bf37023fed66..520057cb13332 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
[ ... ]
> @@ -1559,6 +1559,18 @@ void ttm_pool_mgr_fini(void)
>  		ttm_pool_type_fini(&global_dma32_uncached[i]);
>  	}
> =20
> +	/* We removed the pool types from the LRU, but we need to also make sure
> +	 * that no shrinker is concurrently freeing pages from the pool.
> +	 */
> +	ttm_pool_synchronize_shrinkers();
> +
> +	for (i =3D 0; i < NR_PAGE_ORDERS; ++i) {
> +		list_lru_destroy(&global_write_combined[i].pages);
> +		list_lru_destroy(&global_uncached[i].pages);
> +		list_lru_destroy(&global_dma32_write_combined[i].pages);
> +		list_lru_destroy(&global_dma32_uncached[i].pages);
> +	}
> +
[Severity: High]
Does this list_lru_destroy() occur while the debugfs interface is still ful=
ly
active?

During device unbind, ttm_global_release() calls ttm_pool_mgr_fini() before
debugfs_remove(ttm_debugfs_root). This newly added list_lru_destroy() frees=
 the
internal lru->node array and sets it to NULL. If a user concurrently reads =
the
debugfs page_pool file, ttm_pool_debugfs_globals_show() executes, iterating
over the global pools and calling list_lru_count(). Will this trigger a NULL
pointer dereference when accessing lru->node[nid]?

>  	shrinker_free(mm_shrinker);
[Severity: High]
This isn't a bug introduced by this patch, but does leaving shrinker_free()
until the very end expose an empty shrinker_list to a concurrent shrinker
invocation?

The pools are removed from shrinker_list earlier in ttm_pool_type_fini(), b=
ut
the shrinker remains active because shrinker_free(mm_shrinker) hasn't been
called yet. The ttm_pool_synchronize_shrinkers() call only waits for in-fli=
ght
shrinkers, it does not prevent new invocations.

If the system experiences memory pressure in this window, the VM can call
ttm_pool_shrink(), which completely lacks a list_empty() check on the
shrinker_list:

drivers/gpu/drm/ttm/ttm_pool.c:ttm_pool_shrink() {
    ...
    pt =3D list_first_entry(&shrinker_list, typeof(*pt), shrinker_list);
    list_move_tail(&pt->shrinker_list, &shrinker_list);
    ...
}

Will it blindly extract a pointer from the empty shrinker_list and derefere=
nce
it, causing a list corruption and bogus pointer dereference?

>  	WARN_ON(!list_empty(&shrinker_list));
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927103231.4769=
2-1-megia.oscar@gmail.com?part=3D1
