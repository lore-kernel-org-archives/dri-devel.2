Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B705C531CC
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6E8C10E620;
	Fri, 24 Jul 2026 00:06:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ffy9Hzx/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E6E710E620
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 00:06:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7A15E600B1;
 Fri, 24 Jul 2026 00:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086401F000E9;
 Fri, 24 Jul 2026 00:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784851573;
 bh=2uyPN9bcHZySTocNfytlYmSpxXSrp1MP/zZGpfq4e4k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ffy9Hzx/eZvRzc8s1XcReIPjvCCAngy9khpA/MqpRIYUMbEB2bdXYIqXZ+jUl+XDh
 whHz+adQB0nRTL77cibqyQSNGr67hp0uxek+Rx7DbDdd6KDS3L7SEVt0cC5V5/HDKZ
 W+nJbLP5pRvJi3NVP6qSIILQuL9ukrwvUe/K29DOVu03gbvv5wVC/B8WtXvv4F11iq
 S1DPfoptdaPbKbR/y8UPzJEe2fDrULb902KhYF79nkyIq/g9f/Pk442cmWtBucV34f
 3nvLhP5TFd2PNjxt5e9byOFhJ7HUkgqmXnRGZ9KKFZ8uJimUL+/2zEnlodwF4OLXAB
 m+Ainx318VCVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/13] drm/panfrost: Move shrinker initialization and
 unplug one level down
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260724-claude-fixes-v3-4-542af61abd0f@collabora.com>
References: <20260724-claude-fixes-v3-0-542af61abd0f@collabora.com>
 <20260724-claude-fixes-v3-4-542af61abd0f@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 00:06:12 +0000
Message-Id: <20260724000613.086401F000E9@smtp.kernel.org>
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
- [High] The Panfrost GEM shrinker is silently skipped and left uninitializ=
ed if transparent hugepages (THP) are disabled.
--

--- Patch [4]: [PATCH v3 04/13] drm/panfrost: Move shrinker initialization =
and unplug one level down ---
commit ba73347cedd0ca5a2e99301107bfd0b9268d44b4
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Move shrinker initialization and unplug one level down

This commit moves the panfrost shrinker initialization into
panfrost_gem_init() so it is ready before drm_dev_register() completes.
It also updates the shrinker functions to take a panfrost_device pointer.

[ ... ]

> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/pa=
nfrost/panfrost_gem.c
> index 3a7fce4288987..d2cd357a2ae33 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> @@ -15,13 +15,13 @@
>  #include "panfrost_gem.h"
>  #include "panfrost_mmu.h"
> =20
> -void panfrost_gem_init(struct panfrost_device *pfdev)
> +int panfrost_gem_init(struct panfrost_device *pfdev)
>  {
>  	int err;
> =20
>  	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
>  	    !panfrost_transparent_hugepage)
> -		return;
> +		return 0;

[Severity: High]
Will this early return bypass the newly added shrinker initialization at the
end of the function?

If the kernel is compiled with CONFIG_TRANSPARENT_HUGEPAGE and the module
parameter panfrost.transparent_hugepage is set to false, panfrost_gem_init(=
)=20
returns early here. This leaves the GEM shrinker completely uninitialized,=
=20
which could lead to out-of-memory conditions under memory pressure because
memory reclaim capabilities for GEM objects are lost.

> =20
>  	err =3D drm_gem_huge_mnt_create(&pfdev->base, "within_size");
>  	if (drm_gem_get_huge_mnt(&pfdev->base))
> @@ -29,6 +29,8 @@ void panfrost_gem_init(struct panfrost_device *pfdev)
>  	else if (err)
>  		drm_warn(&pfdev->base, "Can't use Transparent Hugepage (%d)\n",
>  			 err);
> +
> +	return panfrost_gem_shrinker_init(pfdev);
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-claude-fix=
es-v3-0-542af61abd0f@collabora.com?part=3D4
