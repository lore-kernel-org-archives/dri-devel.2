Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4666BC5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 20:56:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C81A10E93F;
	Fri, 14 Aug 2026 20:56:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="faVlqrLB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BB0B10E5CC;
 Fri, 14 Aug 2026 20:56:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0229E40A25;
 Fri, 14 Aug 2026 20:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497061F00A3A;
 Fri, 14 Aug 2026 20:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786740963;
 bh=fTfUDQrgJ3Y+t0RXMYFXkxKPnYej7d4+iN1qSmhzYRY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=faVlqrLBEhwneawuv22KUSZLYCX7unkodfOtf3Hcy0hRJXpLl3IrOplgOC9ywccXK
 /vk5qU0qILftzpV2Z7wUjZLsodfwUxICqs6/i8/CUNzSkAv9eMhVbmhJYDgyIO1sFz
 /vw2D90gMNhpA5V7nvcO2ezHZLgrc+4Pexmc4Rx48OQcgcqOgowpqtXddb6/IaOYEq
 8PhWN/CHhCzvr6WLO+6UFekETFGShIvJYIG1le4FZ+XixW3npDsdzUeZOMRgLiMApa
 QmNJghPBd6iqva7/1NKcD+XRgPOmQteFxxCjrDZO0mxUkdbG6sX+inC02wD0bucfHX
 T9S1jtidwcOhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] drm/vblank: Use drm_for_each_crtc() in
 drm_vblank_init()
To: "Lyude Paul" <lyude@redhat.com>
Cc: imx@lists.linux.dev, intel-xe@lists.freedesktop.org,
 neil.armstrong@linaro.org, intel-gfx@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org, linux-sunxi@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 wsa+renesas@sang-engineering.com, Frank.Li@kernel.org
In-Reply-To: <20260814203542.1405135-5-lyude@redhat.com>
References: <20260814203542.1405135-1-lyude@redhat.com>
 <20260814203542.1405135-5-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 20:56:02 +0000
Message-Id: <20260814205603.497061F00A3A@smtp.kernel.org>
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
- [Critical] Calling `drm_vblank_init` before creating CRTCs results in a z=
ero-size allocation, leading to a kernel crash when vblank features are lat=
er used.
--

--- Patch [4]: [PATCH 4/5] drm/vblank: Use drm_for_each_crtc() in drm_vblan=
k_init() ---
commit 4aec980231f556c8a36b5294d67b3d582d49d623
Author: Lyude Paul <lyude@redhat.com>

drm/vblank: Use drm_for_each_crtc() in drm_vblank_init()

This patch updates drm_vblank_init() to use the drm_for_each_crtc() iterator
instead of manually counting the number of CRTCs.

> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index 17283e8920378..d57405050554f 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -547,19 +547,20 @@ static void drm_vblank_init_release(struct drm_devi=
ce *dev, void *ptr)
>  int drm_vblank_init(struct drm_device *dev)
>  {
>  	int ret;
> -	unsigned int num_crtcs =3D dev->mode_config.num_crtc;
> -	unsigned int i;
> +	struct drm_crtc *crtc;
> =20
>  	spin_lock_init(&dev->vbl_lock);
>  	spin_lock_init(&dev->vblank_time_lock);
> =20
> -	dev->vblank =3D drmm_kcalloc(dev, num_crtcs, sizeof(*dev->vblank), GFP_=
KERNEL);
> +	dev->vblank =3D drmm_kcalloc(dev, dev->mode_config.num_crtc,
> +				   sizeof(*dev->vblank), GFP_KERNEL);
>  	if (!dev->vblank)
>  		return -ENOMEM;
> =20
>  	dev->has_hw_vblank =3D true;
> =20
> -	for (i =3D 0; i < num_crtcs; i++) {
> +	drm_for_each_crtc(crtc, dev) {

[Severity: Critical]
Could this change lead to an uninitialized vblank array and subsequent page
fault for drivers that initialize vblank before creating CRTCs?

For example, in vkms_drv.c:vkms_create(), drm_vblank_init() is called before
vkms_modeset_init() creates the CRTCs:

	ret =3D drm_vblank_init(&vkms_device->drm);
	if (ret) {
		DRM_ERROR("Failed to vblank\n");
		goto out_devres;
	}

	ret =3D vkms_modeset_init(vkms_device);

Because the CRTCs are not yet created at this point, dev->mode_config.num_c=
rtc
is 0. The allocation for the vblank array becomes a 0-byte allocation,
returning ZERO_SIZE_PTR (0x10). The drm_for_each_crtc() loop then executes 0
times, and drm_vblank_init() successfully returns 0.

When userspace later calls DRM_IOCTL_WAIT_VBLANK, the kernel looks up the
CRTC using drm_vblank_crtc(dev, pipe). This returns a pointer into the arra=
y,
which evaluates to ZERO_SIZE_PTR + pipe * sizeof(...).

Will dereferencing this pointer cause an immediate kernel OOPS?

> +		unsigned int i =3D crtc->index;
>  		struct drm_vblank_crtc *vblank =3D drm_vblank_crtc(dev, i);
> =20
>  		vblank->dev =3D dev;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814203542.1405=
135-1-lyude@redhat.com?part=3D4
