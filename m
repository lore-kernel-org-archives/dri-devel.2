Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B95C55173
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 17:50:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D36B10F370;
	Fri, 31 Jul 2026 17:50:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FHZqUwHI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A7A910F370
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 17:50:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8C76E600C3;
 Fri, 31 Jul 2026 17:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D591F00AC4;
 Fri, 31 Jul 2026 17:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785520217;
 bh=yQjGBuegKft+d7JZE94GfWgQJwWOu3bicyqNFN3eUyk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FHZqUwHIplUz+V9LHdxFQ3kItfrG41gUREOd6siZnc79n5RvAl0bYvLCoe5mMMy9t
 nXzpWXY8HzDhAqMxlilLcVZFfmPWlQEGlAR9wYnPXsKa/aySWTEtFjcIj9Q3qQWxEE
 jmZrZEpffXpXqLHaxyePQ3c37S9z+zgJfV+hLMgM2ESi4SfqXeytBaSn5EZOHDDT1w
 kxx4G7X5neKMkF1FgDG+Mtqr1xgwpRQ3uQLeKr5QMUw/cC14wa7vk71JOLIwk0I/Fc
 4oL4XPJ4JO+rO+XAE0Iz+xz4RZ5h2+sxNxgCtRmmRqjOGRZygE3U0/fE0NuJUar0mJ
 CcWP/dtj4BtIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 12/69] drm/bridge: Fix unlocked list_del in
 drm_bridge_add()
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-12-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-12-294364b2cf15@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 17:50:16 +0000
Message-Id: <20260731175016.C5D591F00AC4@smtp.kernel.org>
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
- [High] Legacy zero-initialized bridges not allocated via devm_drm_bridge_=
alloc() will cause a kernel panic due to an uninitialized list_head and tri=
gger refcount warnings.
--

--- Patch [12]: [PATCH v10 12/69] drm/bridge: Fix unlocked list_del in drm_=
bridge_add() ---
commit e0f10da4c05d8a75c537ce94edb147bda1eb2e78
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/bridge: Fix unlocked list_del in drm_bridge_add()

This commit addresses a list corruption issue in drm_bridge_add() by wrappi=
ng=20
the bridge_lingering_list removal sequence with the bridge_lock mutex. It=20
prevents concurrent modifications from drm_bridge_remove() and debugfs walk=
s.

Closes: https://lore.kernel.org/all/20260723015004.1F5711F000E9@smtp.kernel=
.org/

> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index afaae272347c0..8b8f71c3ccff9 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c

[ ... ]

> @@ -454,8 +455,10 @@ void drm_bridge_add(struct drm_bridge *bridge)
>  	 * in bridge_lingering_list. Remove it or bridge_lingering_list will be
>  	 * corrupted when adding this bridge to bridge_list below.
>  	 */
> -	if (!list_empty(&bridge->list))
> -		list_del_init(&bridge->list);
> +	scoped_guard(mutex, &bridge_lock) {
> +		if (!list_empty(&bridge->list))
> +			list_del_init(&bridge->list);
> +	}

[Severity: High]
This is a pre-existing issue, but will this cause a kernel panic for legacy=
=20
bridge drivers that allocate struct drm_bridge using kzalloc() instead of=20
devm_drm_bridge_alloc()?

For a zero-initialized bridge struct, the list_empty() check evaluates to=20
false because the uninitialized list_head pointers are NULL, and NULL is no=
t=20
equal to &bridge->list.=20

This means list_del_init() will execute and unconditionally dereference the=
=20
NULL prev and next pointers, crashing the kernel during device probe.

Is it possible to check if the list_head is actually initialized before=20
testing if it is empty, or handle legacy zero-initialized bridges safely=20
to avoid breaking the probe path on affected platforms?

> =20
>  	mutex_init(&bridge->hpd_state_mutex);
>  	mutex_init(&bridge->hpd_mutex);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-dw-hdmi-qp=
-scramb-v10-0-294364b2cf15@collabora.com?part=3D12
