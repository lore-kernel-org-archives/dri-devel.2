Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943D8C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:42:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3AAB10E8B9;
	Mon,  6 Jul 2026 10:42:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g7ofXCrW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22D2810E8B9
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 10:42:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 812A0600DA;
 Mon,  6 Jul 2026 10:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152F71F00ACA;
 Mon,  6 Jul 2026 10:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783334534;
 bh=W9R6UObc1O7GPMwI9AvK9ClCGB047C/1Frhc4t+IhEU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=g7ofXCrWb3Y1uvQ375cXHlJLoWbv7amMXTKUi49pAfKrtBO4DS+TvLAxR4oOIohyd
 QyF2XbCs7gaFwvbrzkju0kpXpUnu52a04ZyX399/4xx02cFqypkQUMonlm1J2nB1ze
 fhNr/l1X+sFdbN/fjOhOHpQQ2wNtS4vNXe9TpSPHzIh6gsvL+bSV30KTvO42Bx7QOg
 11nLssU9Q4ooQu8c72mWaRMcl93VeiYrEBoBh4GvQK71Nd5e9ZhqwQg0CHNh+RClVW
 m1sdYbcsNDCpFR9yAH7f9awHvFy0dsSrHih9IMXWczkWKv7zBae0vsJML44vC4vSPu
 SoVQbPLrrYWxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/10] drm/ttm: replace TTMs refcount with the DRM
 refcount v4
To: "Natalie Vock" <nat@pixelcluster.dev>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260706-ttm_2_drm_exec-v2-2-4bf6bfc0d320@pixelcluster.dev>
References: <20260706-ttm_2_drm_exec-v2-0-4bf6bfc0d320@pixelcluster.dev>
 <20260706-ttm_2_drm_exec-v2-2-4bf6bfc0d320@pixelcluster.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 10:42:13 +0000
Message-Id: <20260706104214.152F71F00ACA@smtp.kernel.org>
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
- [High] Resurrecting TTM BOs with the unified GEM refcount exposes partial=
ly-destroyed zombie objects to xe_drm_client debugfs, leading to a NULL poi=
nter dereference.
--

commit a805e1b4ddde0006d8b373c7aed2f75ce95ec7db
Author: Natalie Vock <nat@pixelcluster.dev>

drm/ttm: replace TTMs refcount with the DRM refcount v4

This commit replaces the separate TTM object reference count with the DRM=20
GEM object reference count. This allows the use of drm_exec inside TTM=20
and avoids maintaining two reference counts for one object.

> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 3980f376e3ba4..2b470c1746f60 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
[ ... ]
> @@ -246,88 +246,84 @@ static void ttm_bo_delayed_delete(struct work_struc=
t *work)
[ ... ]
> -			kref_init(&bo->kref);
> -			spin_unlock(&bdev->lru_lock);
> +		kref_init(&bo->base.refcount);
> +		bo->base.funcs =3D &ttm_deleted_object_funcs;
> +		spin_unlock(&bo->bdev->lru_lock);

[Severity: High]
By resurrecting the GEM refcount here to 1, could this expose=20
partially-destroyed zombie objects to subsystems like the xe_drm_client?

For example, the client list might still hold the BO, and=20
xe_drm_client.c:show_meminfo() attempts to grab a reference:

    if (!kref_get_unless_zero(&bo->ttm.base.refcount))
        continue;

Since the GEM refcount is now resurrected instead of a separate TTM
refcount, this check will succeed on a zombie BO.

If show_meminfo() then acquires the BO's resv lock after the=20
ttm_bo_delayed_delete() worker has called ttm_bo_cleanup_memtype_use()=20
(which sets bo->resource to NULL), it will dereference the NULL resource=20
in bo_meminfo():

    u32 mem_type =3D bo->ttm.resource->mem_type;

Can this lead to a NULL pointer dereference kernel panic when reading=20
the debugfs file?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-ttm_2_drm_=
exec-v2-0-4bf6bfc0d320@pixelcluster.dev?part=3D2
