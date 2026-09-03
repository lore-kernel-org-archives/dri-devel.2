Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02CCC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 08:56:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B71B10E0F9;
	Thu,  3 Sep 2026 08:56:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RruX83I9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19E0110E0F9
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 08:56:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B4747403F0;
 Thu,  3 Sep 2026 08:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E4B1F000E9;
 Thu,  3 Sep 2026 08:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788425790;
 bh=9Qw4JZFWWjkORZxzjTCdXCuBsF2CzyFSmcScBz0oy0k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RruX83I9SrMUERZm2GVSYG0cZ4bSr7PuXqELI5lo9e8xuGmaqgCmjos5WDgKhK8/+
 ku6UgeQvOCocqNbaHBiJfqbABBWZnMQNaDn8Q8PRuOh8RLXpOubVedbuECuJGjx9dO
 RZ7TUbzZeB11iXmPAVGgrVEODCkVbCHBfurgGjmIGB7/ys//rfcCkY4VFPPhPh2wro
 fr28dpQMyER2vLw81dyqQrqJL23N3cNBgwXSN++GeoS9cMw9OoIUWAf/cqQknCaABq
 xPAQ+ERnL9SjGc5z08sBBD50RGU2Pyqql6Lu/iDyeMUfjUxO2vDT6fP6SIjnjI7dSG
 /25yV0ZqLZJPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3] drm/loongson: Create blend mode property for cursor
 plane
To: "Huacai Chen" <chenhuacai@loongson.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260903084212.3621540-1-chenhuacai@loongson.cn>
References: <20260903084212.3621540-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 08:56:30 +0000
Message-Id: <20260903085630.83E4B1F000E9@smtp.kernel.org>
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
- [High] State mismatch between blend mode property and atomic state initia=
lization rejects atomic commits.
--

commit e4c1ccbb76c983c05930b35bbb7291c8273016d7
Author: Huacai Chen <chenhuacai@kernel.org>

drm/loongson: Create blend mode property for cursor plane

This commit adds a blend mode property for cursor planes, exposing only
the DRM_MODE_BLEND_COVERAGE mode since the hardware does not support
DRM_MODE_BLEND_PREMULTI.

> diff --git a/drivers/gpu/drm/loongson/lsdc_plane.c b/drivers/gpu/drm/loon=
gson/lsdc_plane.c
> index bea42215796d4..bcc0ffa17bdf2 100644
> --- a/drivers/gpu/drm/loongson/lsdc_plane.c
> +++ b/drivers/gpu/drm/loongson/lsdc_plane.c
[ ... ]
> @@ -765,7 +766,7 @@ int ls7a1000_cursor_plane_init(struct drm_device *dde=
v,
> =20
>  	drm_plane_helper_add(plane, &ls7a1000_cursor_plane_helper_funcs);
> =20
> -	return 0;
> +	return drm_plane_create_blend_mode_property(plane, BIT(DRM_MODE_BLEND_C=
OVERAGE));
>  }

[Severity: High]
Will this cause atomic commits to fail during modesetting?

This adds a blend mode property supporting only COVERAGE, but the driver's
plane functions use the default reset hook:

drivers/gpu/drm/loongson/lsdc_plane.c:lsdc_plane_funcs {
        ...
        .reset =3D drm_atomic_helper_plane_reset,
        ...
}

The default drm_atomic_helper_plane_reset() unconditionally initializes
the plane state to PREMULTI.

Because PREMULTI is not registered as a supported enum value in the plane's
blend mode property mask, when compositors query the current properties and
submit them back, validation fails in drm_property_change_valid_get()
returning -EINVAL.

Should the driver provide a custom reset hook that initializes the state to
DRM_MODE_BLEND_COVERAGE instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903084212.3621=
540-1-chenhuacai@loongson.cn?part=3D1
