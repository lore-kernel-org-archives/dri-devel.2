Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B5DC5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 20:56:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1056310E1E7;
	Mon, 24 Aug 2026 20:56:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="go2O0Auc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69C4C10E1E7
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 20:56:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1919841FA2;
 Mon, 24 Aug 2026 20:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63501F000E9;
 Mon, 24 Aug 2026 20:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787605014;
 bh=PbCSZ/Sdk81NMDXNTjxjrRgnmPybYfkVKkZDvzXQpIk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=go2O0AucPVw6WoQR7XdqeEEZm/GzsFOOzmbdFnxZTBYqTR0ZMznebmMVlPE5uK9vH
 MGW9B5a+n8+f+SMjdz4z0MQ677ZqTsX0DKrVjkti6AeRGnn38ply/9rVITZh0nlCFH
 zukSOOq4QYfJK5IJoWYtffj65GqH0AR6ssMVlmsjfC6tJvC4uwjGyo+EnClYp96TJG
 psPjgLiGffa+Bxq2awCvr4xWBo1WXGEB/W/sVGjd8yXVDqsmNqsBHuIeCS0IG/7tM9
 2vE3p0sKnylhuKiInBMDcha5Ld+hYnu5ZgYKtmHXPT0DEyoAqmp147sCUa32dLkzGS
 30dJ2k+YrdWoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] drm/ingenic: fix bridge allocation
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <4f30341735d77c77a9a4952abd91879007bc00fd.1787604223.git.hns@goldelico.com>
References: <4f30341735d77c77a9a4952abd91879007bc00fd.1787604223.git.hns@goldelico.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 20:56:53 +0000
Message-Id: <20260824205653.C63501F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing error check on devm_drm_panel_bridge_add_typed() leads to =
an ERR_PTR dereference.
- [High] The driver uses the deprecated drm_of_find_panel_or_bridge() API w=
hich returns a raw, non-refcounted pointer to a bridge, creating a Use-Afte=
r-Free risk.
--

--- Patch [1]: [PATCH v6] drm/ingenic: fix bridge allocation ---
commit 945d263f4d85ed4baf2bf5a4b9f94a4476cfb80e
Author: H. Nikolaus Schaller <hns@goldelico.com>

drm/ingenic: fix bridge allocation

This commit fixes the bridge allocation API in ingenic/drm by allocating
a stable driver-specific container struct that embeds a struct drm_bridge.
It also adjusts the object lifecycle by calling drm_bridge_add before
drm_bridge_attach.

> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/=
ingenic/ingenic-drm-drv.c
> index 738a80b2550ff..4098192c642bd 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c

[ ... ]

> @@ -1316,10 +1321,27 @@ static int ingenic_drm_bind(struct device *dev, b=
ool has_components)
> =20
>  		drm_encoder_helper_add(encoder, &ingenic_drm_encoder_helper_funcs);
> =20
> -		ib->bridge.funcs =3D &ingenic_drm_bridge_funcs;
> +		bridge_alloc =3D devm_drm_bridge_alloc(priv->dev,
> +						     struct ingenic_drm_bridge_alloc,
> +						     bridge,

[Severity: High]
This is a pre-existing issue, but since we are working with the bridge
pointer here, should we consider migrating away from the deprecated
drm_of_find_panel_or_bridge() API called earlier in this function?

Looking at ingenic_drm_bind(), it calls drm_of_find_panel_or_bridge() which
returns a non-refcounted bridge. If an external bridge driver unbinds
concurrently, the bridge memory could be freed before we finish executing
ingenic_drm_bind(), leaving us passing a dangling pointer into
drm_bridge_attach().

[Severity: High]
This isn't a bug introduced by this patch, but does the bridge pointer need
an IS_ERR() check before we use it?

A few lines above in ingenic_drm_bind(), devm_drm_panel_bridge_add_typed()
is called. If it fails due to memory allocation issues, it returns an
ERR_PTR. We blindly assign that to bridge, which eventually gets passed to
drm_bridge_attach().=20

Because drm_bridge_attach() only checks if (!bridge), the ERR_PTR bypasses
this check and gets dereferenced when accessing bridge->container, leading
to a crash.

> +						     &ingenic_drm_bridge_funcs);
> +		if (IS_ERR(bridge_alloc)) {
> +			ret =3D PTR_ERR(bridge_alloc);
> +			goto err_drvdata;
> +		}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/4f30341735d77c77a9a=
4952abd91879007bc00fd.1787604223.git.hns@goldelico.com?part=3D1
