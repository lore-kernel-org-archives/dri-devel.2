Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B36CC4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 10:33:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A378010E324;
	Thu, 16 Jul 2026 10:33:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HW6OBAGx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6856710E324
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 10:33:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 89B626001A;
 Thu, 16 Jul 2026 10:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149CA1F000E9;
 Thu, 16 Jul 2026 10:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784197993;
 bh=/vBCPI9P7f641JiD814RqqbbMgEE3Uq0E6yzftESq0I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HW6OBAGxxoPFtgTdkxX7Km3je9v04yszcmdvsl/ZVOJxXQ6SXkHuh/XO+zd8PEJ1t
 owZRX/4iXbfaXv3KzRv2SeB5p2n7zBlYkU0LjE1NFJMm8ud7sn10MYJWAq9BD0bF/q
 4Sv0TkkHpc6PVVkEjLYETmvAVPiOooi7M1BWmBwIiUr4+unaPBCHumLaLVkjNlwK8a
 2F1JlSKl4qoU3X0EKQHoDsRAsfPHfInwYjiW7Mb9zE1YsePRO8Xo0KXwyIMFCX2a/y
 MADd5MQxvaNVsqSUifFogWExNIcaBDZWMUXHGGkLeP7E871nT5xCxHSrt3zrDx1KbM
 1gef30Ip7IAQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/fb-helper: guard against NULL fb_helper->funcs in
 restore path
To: "Sebastian Brzezinka" <sebastian.brzezinka@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <e1957da52fcdd1d88a285553d36e12a0362a8258.1784196681.git.sebastian.brzezinka@intel.com>
References: <e1957da52fcdd1d88a285553d36e12a0362a8258.1784196681.git.sebastian.brzezinka@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 10:33:12 +0000
Message-Id: <20260716103313.149CA1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] __drm_fb_helper_restore_fbdev_mode_unlocked() attempts to commit m=
odesets even when the fbdev probe failed, triggering a WARN_ON(!set->fb).
- [High] Framebuffer and GEM object memory leak in intel_fbdev_driver_fbdev=
_probe() error paths.
- [High] The patch's fix is incomplete because intel_fbdev_driver_fbdev_pro=
be() can fail after assigning helper->funcs, leading to a NULL pointer dere=
ference in intelfb_restore().
--

--- Patch [1]: [PATCH] drm/fb-helper: guard against NULL fb_helper->funcs i=
n restore path ---
commit 388e602c24e24848a47714842dc175e61eefb458
Author: Sebastian Brzezinka <sebastian.brzezinka@intel.com>

drm/fb-helper: guard against NULL fb_helper->funcs in restore path

When a driver's fbdev probe callback fails before assigning fb_helper->func=
s,
any later restore reaches __drm_fb_helper_restore_fbdev_mode_unlocked() and
unconditionally dereferences fb_helper->funcs->fb_restore, causing a NULL
pointer dereference. This patch adds a NULL check on fb_helper->funcs.

> When a driver's fbdev probe callback fails before assigning
> fb_helper->funcs (e.g. i915's intel_fbdev_driver_fbdev_probe() bailing
> out early on a DMA/GGTT pin failure),

[Severity: High]
This isn't a bug introduced by this patch, but does
intel_fbdev_driver_fbdev_probe() leak the framebuffer if it fails during
the DMA/GGTT pin step?

If a new framebuffer is allocated via __intel_fbdev_fb_alloc() (with a
refcount of 1), and a subsequent step fails, the code jumps to out_unlock:

drivers/gpu/drm/i915/display/intel_fbdev.c:intel_fbdev_driver_fbdev_probe()=
 {
    ...
    if (ret)
        goto out_unlock;
    ...
out_unlock:
    intel_fbdev_hpd_set_fault(ifbdev);
    return ret;
}

Does this exit without calling drm_framebuffer_put(&fb->base), permanently
leaking the framebuffer and its backing GEM object, potentially leading to
an OOM condition upon repeated hotplug retries?

[Severity: High]
This is also a pre-existing issue, but does
__drm_fb_helper_restore_fbdev_mode_unlocked() need an early exit if the
fbdev probe failed?

When the probe fails (e.g., fb_helper->info is NULL), the client remains
registered. Later, when an unprivileged user closes the DRM fd,
drm_client_dev_restore() calls this function, which unconditionally
executes:

__drm_fb_helper_restore_fbdev_mode_unlocked() {
    ...
    ret =3D drm_client_modeset_commit(&fb_helper->client);
    ...
}

Since drm_client_modeset_probe() populated set->mode but set->fb was never
allocated due to the probe failure, this eventually reaches
__drm_atomic_helper_set_config() and triggers a WARN_ON(!set->fb). Could
userspace repeatedly trigger this warning as a denial of service?

> the fbdev client stays registered
> with fb_helper->funcs =3D=3D NULL. Any later restore, such as on drm fd c=
lose
> via drm_client_dev_restore() -> drm_fbdev_client_restore(), reaches
> __drm_fb_helper_restore_fbdev_mode_unlocked() and unconditionally
> dereferences fb_helper->funcs->fb_restore, causing a NULL pointer
> dereference.
>=20
> Guard the fb_restore call with a NULL check on fb_helper->funcs.

> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_hel=
per.c
> index 3316bb00a662b..5621cc19b47ce 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -146,7 +146,7 @@ __drm_fb_helper_restore_fbdev_mode_unlocked(struct dr=
m_fb_helper *fb_helper,
>  	if (do_delayed)
>  		drm_fb_helper_hotplug_event(fb_helper);
> =20
> -	if (fb_helper->funcs->fb_restore)
> +	if (fb_helper->funcs && fb_helper->funcs->fb_restore)

[Severity: High]
This is a pre-existing issue, but is this fix incomplete if the probe fails
after assigning helper->funcs?

In intel_fbdev_driver_fbdev_probe(), helper->funcs is assigned before some
potential error paths:

drivers/gpu/drm/i915/display/intel_fbdev.c:intel_fbdev_driver_fbdev_probe()=
 {
    ...
    helper->funcs =3D &intel_fb_helper_funcs;
    helper->fb =3D &fb->base;
    ...
    ret =3D intel_bo_fbdev_fill_info(ifbdev->fb->obj, ifbdev->helper.info);
    if (ret)
        goto out_unlock;
    ...
}

If intel_bo_fbdev_fill_info() or another late step fails, helper->funcs
remains set, but ifbdev->fb is left as NULL because it is not assigned until
later in the function.

If an unprivileged user triggers a restore by closing the DRM fd,
__drm_fb_helper_restore_fbdev_mode_unlocked() will see a non-NULL
helper->funcs and call intelfb_restore().

Will this still lead to a NULL pointer dereference when intelfb_restore()
calls to_frontbuffer() and accesses ifbdev->fb->frontbuffer?

>  		fb_helper->funcs->fb_restore(fb_helper);
> =20
>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/e1957da52fcdd1d88a2=
85553d36e12a0362a8258.1784196681.git.sebastian.brzezinka@intel.com?part=3D1
