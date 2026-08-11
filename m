Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F1EFC5B56A
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 19:55:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C729B10ED86;
	Tue, 11 Aug 2026 19:55:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KwfYliZZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB9F110ED87
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 19:55:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DB7CA600AD;
 Tue, 11 Aug 2026 19:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7291F000E9;
 Tue, 11 Aug 2026 19:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786478141;
 bh=WnUz9wtxaHLF1eeLt27AQQxOIesmfpyWYpCtgUAqLRw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KwfYliZZhN461oIP0pz3nTfw4eIo9ovnqlJrAI3DLzUvKXToFmEP1jCFtaSBi1Cao
 9DHupLnelm0crT8pJL7J/FUx7Mo+ok6Dw8SG4HcjAAEyTaiWxVf7EzclCKFu5lxOZf
 rxA4hXp+UxPEUO9b4jGRDokI5jIRn/JJKmInuXrNm/xE2N7XpsRetorbV5PfGgMJM6
 /kH49NXInxbmuar6PHtrQngUskMF8jIec/0NmxWtUPZbB04tW+et5+FCzE/bN+CEvP
 5JH4bmvgYXdrvPVJ5H4hcuhbg/F+OU6PDyXuIuw8k8r4jmuoxrDpuBKltIDBUsJ3l9
 11P7E3BJlPPJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/6] list_lru_init() does not check return value
To: =?utf-8?b?w5NzY2FyIE1lZ8OtYSBMw7NwZXo=?= <megia.oscar@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260811194224.121597-3-megia.oscar@gmail.com>
References: <20260811194224.121597-1-megia.oscar@gmail.com>
 <20260811194224.121597-3-megia.oscar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 19:55:40 +0000
Message-Id: <20260811195541.6E7291F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The return value of `ttm_pool_type_init()` is ignored in `ttm_pool=
_mgr_init()`, leading to kernel panics if `list_lru_init()` fails.
- [High] External callers of `ttm_pool_init()` and `ttm_pool_mgr_init()` ig=
nore their error return values, leading to silent failures and crashes.

Pre-existing issues:
- [High] Missing `list_lru_destroy()` calls in normal teardown paths leak m=
emory on every pool destruction and module unload.
--

--- Patch [2]: [PATCH v5 2/6] list_lru_init() does not check return value -=
--
commit 05689bd64e30d8c766538356d67e8a63f77ecc7c
Author: =C3=93scar Meg=C3=ADa L=C3=B3pez <megia.oscar@gmail.com>

list_lru_init() does not check return value

This patch adds an error check for list_lru_init() in ttm_pool_type_init(),
propagating the error code back to the caller if the initialization fails.

Cc: <stable@vger.kernel.org> # 7.1.0

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index 73284497cc785..e116b83db1356 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -374,17 +374,23 @@ static struct page *ttm_pool_type_take(struct ttm_p=
ool_type *pt, int nid)
>  }
> =20
>  /* Initialize and add a pool type to the global shrinker list */
> -static void ttm_pool_type_init(struct ttm_pool_type *pt, struct ttm_pool=
 *pool,
> +static int ttm_pool_type_init(struct ttm_pool_type *pt, struct ttm_pool =
*pool,
>  			       enum ttm_caching caching, unsigned int order)

[Severity: High]
Since ttm_pool_type_init() now returns an error code, do the callers need
to be updated to check it?

Looking at ttm_pool_mgr_init(), it calls ttm_pool_type_init() in a loop
without checking the return value. If list_lru_init() fails, it skips adding
the node to shrinker_list.

During module unload, ttm_pool_mgr_fini() will call ttm_pool_type_fini(),
which executes list_del() on the uninitialized items. Will this result in a
NULL pointer dereference?

Also, ttm_pool_type_take() calls list_lru_walk_node() unconditionally on
pt->pages. Can this crash if it was never initialized?

[Severity: High]
Similarly, do external callers of ttm_pool_init() and ttm_pool_mgr_init()
need to check for errors now that list_lru_init() failures are propagated?

Callers like ttm_device_init() and amdgpu_ttm_pools_init() appear to ignore
the return values. If initialization fails, the device driver might later
attempt an allocation or unbind the device, accessing uninitialized list_lru
structures.

>  {
> +	int ret =3D 0;
> +
>  	pt->pool =3D pool;
>  	pt->caching =3D caching;
>  	pt->order =3D order;
> -	list_lru_init(&pt->pages);
> +	ret =3D list_lru_init(&pt->pages);

[Severity: High]
This is a pre-existing issue, but does normal teardown leak the list_lru
allocations?

list_lru_init() dynamically allocates node arrays. While ttm_pool_type_init=
()
sets it up, ttm_pool_type_fini() does not appear to call list_lru_destroy().

Neither ttm_pool_fini() nor ttm_pool_mgr_fini() call list_lru_destroy() on
normal device unbinds or module unloads. If a device is repeatedly bound and
unbound via sysfs, will this systematically leak memory and eventually exha=
ust
system memory?

> +	if (ret)
> +		return ret;
> =20
>  	spin_lock(&shrinker_lock);
>  	list_add_tail(&pt->shrinker_list, &shrinker_list);
>  	spin_unlock(&shrinker_lock);
> +
> +	return 0;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811194224.1215=
97-1-megia.oscar@gmail.com?part=3D2
