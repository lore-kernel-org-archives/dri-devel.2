Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A47C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 21:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C32410F753;
	Fri, 14 Aug 2026 21:08:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mtTGAkW5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC26610F73C;
 Fri, 14 Aug 2026 21:08:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6266740292;
 Fri, 14 Aug 2026 21:08:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6AF1F000E9;
 Fri, 14 Aug 2026 21:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786741720;
 bh=rMcM0lBlPoPh1FiorELQJDBDv6Kiof5qqVa1jsW625k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mtTGAkW50fZxxenfAzuyu0UFNDw/J7doURQ0Dhd69su0npvC2IZfOSmYnBXGgduBj
 uIFl07kEDemyqgFsMBYLtsmyW5VWVxcWj7S7uNo99a7LIHSqsSxtoiTotSuscuYfRr
 ETiTqR6xt2MGNSSod9Cyijd1FS6mIMY/kyHbgNxQIXDsJ4G7AqnVwGCT57fV96XrQf
 /mdaz6NwfF/9/pYWV+BZYPVmbBQgUtFhfz02eSLoAyqm+pOniop5tNQ44ZU2PvwZ87
 r0sieZCZBgD87zLv6yjNgKRjwon6SBH9rxwCKE/y0UFm+dVlRvNS+pOkitiqDclJPC
 wQr5iu3OlO7FA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] drm/vblank: Require all CRTCs implement vblank
 support in drm_vblank_init()
To: "Lyude Paul" <lyude@redhat.com>
Cc: linux-sunxi@lists.linux.dev, Frank.Li@kernel.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org, neil.armstrong@linaro.org,
 linux-amlogic@lists.infradead.org, wsa+renesas@sang-engineering.com,
 intel-xe@lists.freedesktop.org, imx@lists.linux.dev
In-Reply-To: <20260814203542.1405135-6-lyude@redhat.com>
References: <20260814203542.1405135-1-lyude@redhat.com>
 <20260814203542.1405135-6-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 21:08:39 +0000
Message-Id: <20260814210839.AC6AF1F000E9@smtp.kernel.org>
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
- [High] drm_vblank_init() causes a NULL pointer dereference or driver prob=
e failure due to accessing uninitialized or empty crtc_list
--

--- Patch [5]: [PATCH 5/5] drm/vblank: Require all CRTCs implement vblank s=
upport in drm_vblank_init() ---
commit 178bbb448a16663eaad60425c62b446801e0f387
Author: Lyude Paul <lyude@redhat.com>

drm/vblank: Require all CRTCs implement vblank support in drm_vblank_init()

This commit modifies drm_vblank_init() to verify that all CRTCs implement
vblank support, ensuring an all-or-nothing configuration. It returns -EINVAL
if support is mixed, and -ENODEV if no CRTCs support vblank.

> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index d57405050554f..17affae23e7a6 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -542,12 +542,31 @@ static void drm_vblank_init_release(struct drm_devi=
ce *dev, void *ptr)
>   * drmm_add_action_or_reset().
>   *
>   * Returns:
> - * Zero on success or a negative error code on failure.
> + * Zero on success or a negative error code on failure. If no CRTCs with=
 vblank
> + * support implemented were found, -ENODEV will be returned.
>   */
>  int drm_vblank_init(struct drm_device *dev)
>  {
>  	int ret;
>  	struct drm_crtc *crtc;
> +	bool found_vbl_crtc =3D false, found_non_vbl_crtc =3D false;
> +
> +	/* Vblank hooks are per-CRTC, not per-device - which is contrary to how
> +	 * the vblank core was written. Since hardware that only has vblank
> +	 * support on some CRTCs but not all is non-existent and would likely
> +	 * lead to UB, ensure that vblank support is all or nothing.
> +	 */
> +	drm_for_each_crtc(crtc, dev) {

[Severity: High]
Can iterating over dev->mode_config.crtc_list here cause a NULL pointer
dereference or a false -ENODEV return during driver probe?

Several DRM drivers call drm_vblank_init() before initializing mode_config
or creating CRTCs. For example:

In i915, intel_display_driver_probe_noirq() calls drm_vblank_init() before
intel_mode_config_init() sets up the crtc_list, meaning the list head is
uninitialized.

In vkms, vkms_create() calls drm_vblank_init() before vkms_modeset_init()
initializes the crtc_list.

In zynqmp_kms, zynqmp_dpsub_drm_init() initializes the list but calls
drm_vblank_init() before any CRTCs are created, meaning the list is empty
and this function will unconditionally return -ENODEV.

Does drm_vblank_init() need to support being called before CRTCs are
registered?

> +		if (crtc->funcs->enable_vblank)
> +			found_vbl_crtc =3D true;
> +		else
> +			found_non_vbl_crtc =3D true;
> +
> +		if (drm_WARN_ON(dev, found_vbl_crtc && found_non_vbl_crtc))
> +			return -EINVAL;
> +	}
> +	if (!found_vbl_crtc)
> +		return -ENODEV;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814203542.1405=
135-1-lyude@redhat.com?part=3D5
