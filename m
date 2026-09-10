Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBE3C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB27A10E5D1;
	Thu, 10 Sep 2026 10:01:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Zgxc/SBD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2120010E5D1
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 10:01:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2B0D6601EF;
 Thu, 10 Sep 2026 10:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C8B1F000FF;
 Thu, 10 Sep 2026 10:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789034492;
 bh=JCR4H7qx+jtu3XIDoUNkrIueLMJhoSdcmF2v3549jl4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Zgxc/SBD3SSIF1nqOTn2oMCM2FxY4GTppCv8alh/K+mAWWpdDQ7CASS7L0fw+9pIg
 lp/J/ZAujkizCJiJRIvGXQqQWi243KtBaodUBpFq4C0/n5X+7ItKJHjOgfZg4/KONQ
 b4CHuCdOjnUi80Dr4UqmfOFbJWiEbeo8V6fuoUbFt5DhYDC4yfaY/j3tjLW0rNwEVI
 CtnU72a73UMwG+i4J7Q7T3PWAxHbgB/MZc/gZCgVZqOfv0tG40IXQ5LQoG6KBSYYku
 3QYj2YmZCBp3OAa91bK9Cz3f+P1tdfKiU9s7k/XqIyHgzD8By4z6QW9MmolSGIz8a5
 t3QX39RxZYr9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/verisilicon: set blend mode for the cursor plane
To: "Icenowy Zheng" <zhengxingda@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260910094904.3502741-1-zhengxingda@iscas.ac.cn>
References: <20260910094904.3502741-1-zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 10:01:32 +0000
Message-Id: <20260910100132.B1C8B1F000FF@smtp.kernel.org>
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
- [Low] Unchecked return value from drm_plane_create_blend_mode_property() =
may silently violate alpha format requirements and cause DRM core warnings.
--

commit d27ea97d91c1dff2b3f030af5cf9f066321653e6
Author: Icenowy Zheng <zhengxingda@iscas.ac.cn>

drm/verisilicon: set blend mode for the cursor plane

This commit adds a fixed COVERAGE blend mode property to the cursor plane.
This is required because blend mode properties must be exposed for pixel
formats with alpha.

> diff --git a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c b/drivers/gpu/=
drm/verisilicon/vs_cursor_plane.c
> index fa4f601dd0c87..da456dced88aa 100644
> --- a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> +++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c

[ ... ]

> @@ -267,6 +268,7 @@ struct drm_plane *vs_cursor_plane_init(struct drm_dev=
ice *drm_dev,
>  		return plane;
> =20
>  	drm_plane_helper_add(plane, &vs_cursor_plane_helper_funcs);
> +	drm_plane_create_blend_mode_property(plane, BIT(DRM_MODE_BLEND_COVERAGE=
));

[Severity: Low]
Should the return value of drm_plane_create_blend_mode_property() be checked
here?

If drm_plane_create_blend_mode_property() fails (for example, due to an
ENOMEM in drm_property_create()), the cursor plane is initialized without t=
he
intended blend mode property.

Does this leave the plane in an incomplete state where the DRM core will em=
it
a warning during validation, since the pixel format exposes alpha but the
blend mode is not fully set up?

> =20
>  	return plane;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910094904.3502=
741-1-zhengxingda@iscas.ac.cn?part=3D1
