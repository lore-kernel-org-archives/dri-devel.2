Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C33CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 08:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21DB110F4C7;
	Fri, 26 Jun 2026 08:04:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U8QI7bhz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C42A10F4C5
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 08:04:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 40CCD42A0A;
 Fri, 26 Jun 2026 08:04:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82BE1F000E9;
 Fri, 26 Jun 2026 08:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782461040;
 bh=G/xc9Wmg70H+OywpMdRATP5caijVm7g7aoctgrvYl28=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=U8QI7bhzz564R+zi+4E9v2r++O3m5CP6G0QHTR27gYMQvEyygu3ZLsnJwbWsEEIHd
 R+8oU83EjRkaZEqxOvSnVvRwpNldAvH5NTjfVRa74SydCybkupdlaqQ+KqJ7noeXp+
 XeSsXqhN/495x4RcbiqldgjH2rux6D+oHuW1lhY+pcUJk3cUvDhvOHVij3uZ+L07K9
 RON+BxjEEXx88Ufb3VArYq/KE+xJ3Nj6YeuUo6RK/xnMh6NKJbLdDbxMGR3uO1Jdue
 /HXwyP1/a7h0j+UmsbZT0u1lhYtYZ1S1B+ZK1LG1z/1D+QHXFYgdbk3k7t/nP4giAM
 Bn1ad/nSw/nYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Memory leak error in qxl unbind
To: =?utf-8?b?w5NzY2FyIE1lZ8OtYSBMw7NwZXo=?= <megia.oscar@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625191812.70066-1-megia.oscar@gmail.com>
References: <20260625191812.70066-1-megia.oscar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 08:03:59 +0000
Message-Id: <20260626080359.E82BE1F000E9@smtp.kernel.org>
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
- [High] The patch introduces a use-after-free race condition between `ttm_=
pool_type_fini()` and the active memory shrinker `ttm_pool_shrink()` by cal=
ling `list_lru_destroy()` prematurely.

Pre-existing issues:
- [High] `ttm_pool_type_init()` ignores the return value of `list_lru_init(=
)`, leading to a NULL pointer dereference if allocation fails.
- [High] `ttm_pool_shrink()` assumes `shrinker_list` is never empty, causin=
g memory corruption and crashes during module unload if triggered.
--

commit 2d02cce6fc533c55922ee9772ecc91925df8846e
Author: =C3=93scar Meg=C3=ADa L=C3=B3pez <megia.oscar@gmail.com>
Subject: Memory leak error in qxl unbind

This commit fixes a 64 bytes memory leak discovered when qxl unbind is
executed.

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index 278bbe7a11add..15191efe9f7e8 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -401,6 +401,7 @@ static void ttm_pool_type_fini(struct ttm_pool_type *=
pt)
> =20
>  	list_lru_walk(&pt->pages, pool_move_to_dispose_list, &dispose, LONG_MAX=
);
>  	ttm_pool_dispose_list(pt, &dispose);
> +	list_lru_destroy(&pt->pages);

[Severity: High]
Can this list_lru_destroy() call cause a use-after-free race with the active
memory shrinker?

If ttm_pool_shrink() executes concurrently, it takes a read lock on
pool_shrink_rwsem and iterates over pt->pages:

drivers/gpu/drm/ttm/ttm_pool.c:ttm_pool_shrink() {
    ...
    num_pages =3D list_lru_walk_node(&pt->pages, nid, pool_move_to_dispose_=
list,
                                   &dispose, &num_to_free);
    ...
}

Because list_lru_destroy() is called here before
ttm_pool_synchronize_shrinkers() (which is called later in ttm_pool_fini()),
the shrinker might access the LRU after its memory has been freed. Should
this destruction be deferred until after the shrinkers are synchronized?

>  }
> =20
>  /* Return the pool_type to use for the given caching and order */

[Severity: High]
This isn't a bug introduced by this patch, but I noticed that
ttm_pool_type_init() ignores the return value of list_lru_init():

drivers/gpu/drm/ttm/ttm_pool.c:ttm_pool_type_init() {
    ...
    list_lru_init(&pt->pages);
    ...
}

If the internal allocation in list_lru_init() fails under memory pressure,
it returns -ENOMEM and leaves pt->pages uninitialized. Does this lead to a
NULL pointer dereference when the shrinker later iterates or when a page is
added?

[Severity: High]
This is a pre-existing issue, but I noticed that ttm_pool_shrink() assumes
shrinker_list is never empty:

drivers/gpu/drm/ttm/ttm_pool.c:ttm_pool_shrink() {
    ...
    pt =3D list_first_entry(&shrinker_list, typeof(*pt), shrinker_list);
    ...
}

During module unload in ttm_pool_mgr_fini(), all pool types are unlinked
from shrinker_list. Before shrinker_free() resolves, there is a window where
the list is empty. If the shrinker triggers during this window, will
list_first_entry() return a bogus pointer and cause memory corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625191812.7006=
6-1-megia.oscar@gmail.com?part=3D1
