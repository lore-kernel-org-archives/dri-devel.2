Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3501AC5CFDB
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:55:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DBAF10EDB6;
	Tue, 11 Aug 2026 21:55:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="onUBY8PX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6426B10EDB6
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 21:55:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DCEBE601E0;
 Tue, 11 Aug 2026 21:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674D11F000E9;
 Tue, 11 Aug 2026 21:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786485326;
 bh=WY94XiClcXP98RMKVCLeX7epAY4ef981DhaFqKjAcfA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=onUBY8PXJFFLHNiO1W2awcrtQB/AaNzMLp8mm/oeexU/b/50Cl38iuXL5XiGRJMnu
 1xUWJPtsx2bG4u+xBbzxDdl+wfn8ewnyOefitAOvI+e9KXlWxGhqizdtMro+m5wJ/r
 kgdZJ02ImFFQnhnExw/ruBZIIqpirNu45hyAobXKFA/lkn/EWOBeDqqgh+yp75Lvqn
 TphHh+53+hSk+fNpbN/47WfJMobFSlFCPl8oMhLrJzttPyovqh5CSNlnTLWWbSkq3r
 tNZl53tqokJgDTejlSZseMLC22B5XY/LD/feDyQr0GIhNz8huT0wFn8Wq83R8avZ1V
 uYTXcESBTcF3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/11] drm/panfrost: Move shrinker initialization and
 unplug one level down
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260811-claude-fixes-v5-4-3d692c9e98c2@collabora.com>
References: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
 <20260811-claude-fixes-v5-4-3d692c9e98c2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 21:55:26 +0000
Message-Id: <20260811215526.674D11F000E9@smtp.kernel.org>
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
- [Low] Removing the `IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)` check causes=
 a build failure (undefined reference to `panfrost_transparent_hugepage`) w=
hen `CONFIG_TRANSPARENT_HUGEPAGE` is disabled.
--

--- Patch [4]: [PATCH v5 04/11] drm/panfrost: Move shrinker initialization =
and unplug one level down ---
commit a1e5fed49d6d030d377938e3c3e5a1b2314d6290
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Move shrinker initialization and unplug one level down

Since the moment we call drm_dev_register() the device should be in a
position to accept jobs, so it's best if the shrinker is already
initialized by then.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/pa=
nfrost/panfrost_gem.c
> index 3a7fce4288987..7b993a089af2d 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> @@ -15,20 +15,25 @@
>  #include "panfrost_gem.h"
>  #include "panfrost_mmu.h"
> =20
> -void panfrost_gem_init(struct panfrost_device *pfdev)
> +int panfrost_gem_init(struct panfrost_device *pfdev)
>  {
>  	int err;
> =20
> -	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> -	    !panfrost_transparent_hugepage)
> -		return;
> +	if (panfrost_transparent_hugepage) {
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Low]
Will this cause a build failure when CONFIG_TRANSPARENT_HUGEPAGE is disable=
d?

Looking at drivers/gpu/drm/panfrost/panfrost_drv.c,
panfrost_transparent_hugepage is defined under an #ifdef:

#ifdef CONFIG_TRANSPARENT_HUGEPAGE
bool panfrost_transparent_hugepage =3D true;
module_param_named(transparent_hugepage, panfrost_transparent_hugepage, boo=
l, 0400);
MODULE_PARM_DESC(transparent_hugepage, "Use a dedicated tmpfs mount point w=
ith Transparent Hugepage enabled (true =3D default)");
#endif

Without the IS_ENABLED() check, evaluating panfrost_transparent_hugepage he=
re
could result in an undefined reference error during linking if the config is
disabled.

> +		err =3D drm_gem_huge_mnt_create(&pfdev->base, "within_size");
> +		if (drm_gem_get_huge_mnt(&pfdev->base))
> +			drm_info(&pfdev->base, "Using Transparent Hugepage\n");
> +		else if (err)
> +			drm_warn(&pfdev->base,
> +				 "Can't use Transparent Hugepage (%d)\n", err);
> +	}
> =20
> -	err =3D drm_gem_huge_mnt_create(&pfdev->base, "within_size");
> -	if (drm_gem_get_huge_mnt(&pfdev->base))
> -		drm_info(&pfdev->base, "Using Transparent Hugepage\n");
> -	else if (err)
> -		drm_warn(&pfdev->base, "Can't use Transparent Hugepage (%d)\n",
> -			 err);
> +	return panfrost_gem_shrinker_init(pfdev);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811-claude-fix=
es-v5-0-3d692c9e98c2@collabora.com?part=3D4
