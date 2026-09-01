Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F13C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 19:19:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D97A10EEB6;
	Tue,  1 Sep 2026 19:19:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HpOF+9AX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49FA110EEB6
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 19:19:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BA6F260232;
 Tue,  1 Sep 2026 19:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452A81F000E9;
 Tue,  1 Sep 2026 19:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788290350;
 bh=SXMvuod23sNbleHF8eVx/5E0QbrynE6dBxbESeyPGII=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HpOF+9AX0FV91P48YCbuE7ZHyyM2Ty6VqNLKIJNJMJRzKM+J2nK97L/H74ngSjmlU
 LTPCHjlKK8FqA/U9CGCvTngRA6nPEvFVp8tea0yvaPvWEGYiseRV76t1BVK7Wm3udW
 FNc9mHC4CdfDg/37r48Yy1LdJVMVSftTxGxKS7sYGbytLw+znU4r8OdP1uGwgc5Iz8
 bjziLc1QO68rmAjQjXUy8hr/m0QL+XjUOyFHYdy5X+uZnK3SpiAwDmUWUZkiol3J9W
 39ElYVqnyrk87fTEfQwm3KeN1HiCNH6/+A0sJa/4j0iSIY5wWHIbZ7Y2vFVBSpHW49
 BzDbNH2DHIodA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 13/74] drm/bridge: Fix NULL deref in
 drm_bridge_add() for legacy bridges
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-13-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
 <20260901-dw-hdmi-qp-scramb-v11-13-bc12954a0688@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 19:19:09 +0000
Message-Id: <20260901191910.452A81F000E9@smtp.kernel.org>
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
- [High] Legacy bridge drivers allocating a zero-initialized struct drm_bri=
dge fail to initialize the `refcount` field. When `drm_bridge_add()` calls =
`drm_bridge_get()`, `kref_get()` increments the 0-valued refcount, triggeri=
ng a `WARN_ONCE` and permanently setting the refcount to `REFCOUNT_SATURATE=
D`. On driver teardown, `drm_bridge_remove()` moves the bridge to `bridge_l=
ingering_list` and calls `drm_bridge_put()`. Due to the saturated refcount,=
 it never drops to 0, preventing `__drm_bridge_free()` from unlinking the b=
ridge from `bridge_lingering_list`. The backing memory is then freed by `de=
vres`, leaving a dangling pointer in the global `bridge_lingering_list` tha=
t causes a use-after-free kernel panic if traversed (e.g., via the `/sys/ke=
rnel/debug/dri/bridges` debugfs file or further bridge removals).
--

commit 752e06bb4d7b734ae3e24f68e339df3e0062a55d
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

    drm/bridge: Fix NULL deref in drm_bridge_add() for legacy bridges

    This commit fixes a NULL pointer dereference in drm_bridge_add() for le=
gacy
    bridges that embed struct drm_bridge in a zero-initialized allocation. =
It
    adds a check to initialize the list head if list.next is NULL.
   =20
    Closes: https://lore.kernel.org/all/20260731175016.C5D591F00AC4@smtp.ke=
rnel.org/

> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 2c457ad74f3b3..a8b6df5c13eaf 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -453,9 +453,16 @@ void drm_bridge_add(struct drm_bridge *bridge)
>  	 * If the bridge was previously added and then removed, it is now
>  	 * in bridge_lingering_list. Remove it or bridge_lingering_list will be
>  	 * corrupted when adding this bridge to bridge_list below.
> +	 *
> +	 * Legacy drivers that allocate the bridge with kzalloc() rather than
> +	 * devm_drm_bridge_alloc() leave list.next NULL. Such a bridge cannot
> +	 * be on any list, and list_del_init() would dereference NULL, so
> +	 * initialize the list head first.

[Severity: High]
This isn't a bug introduced by this patch, but since legacy bridge drivers
allocate a zero-initialized struct drm_bridge, doesn't this also mean the
refcount field is uninitialized?

When drm_bridge_add() is called, it executes drm_bridge_get() on the bridge
which increments the 0-valued refcount. This triggers a WARN_ONCE and
permanently sets the refcount to REFCOUNT_SATURATED.

Later, during driver teardown, the bridge is moved to the lingering list:

drivers/gpu/drm/drm_bridge.c:drm_bridge_remove() {
	mutex_lock(&bridge_lock);
	list_move_tail(&bridge->list, &bridge_lingering_list);
	mutex_unlock(&bridge_lock);
    ...
	drm_bridge_put(bridge);
}

Since the refcount is saturated, drm_bridge_put() fails to drop it to 0. The
bridge is stranded in the lingering list, preventing __drm_bridge_free() fr=
om
unlinking it.

Once devres frees the structure, the dangling pointer in the global
bridge_lingering_list can cause a use-after-free kernel panic if traversed
(e.g., via the /sys/kernel/debug/dri/bridges debugfs file or further bridge
removals).

Could the refcount initialization also be handled for kzalloc'd bridges to
prevent this leak and use-after-free?

>  	 */
>  	mutex_lock(&bridge_lock);
> -	if (!list_empty(&bridge->list))
> +	if (!bridge->list.next)
> +		INIT_LIST_HEAD(&bridge->list);
> +	else if (!list_empty(&bridge->list))
>  		list_del_init(&bridge->list);
>  	mutex_unlock(&bridge_lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-dw-hdmi-qp=
-scramb-v11-0-bc12954a0688@collabora.com?part=3D13
