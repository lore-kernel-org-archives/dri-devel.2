Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D9CC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95A8D10F0B5;
	Thu, 27 Aug 2026 14:52:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XgQIYt7m";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6AD710F0B5;
 Thu, 27 Aug 2026 14:52:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 99EFB4012F;
 Thu, 27 Aug 2026 14:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478961F000E9;
 Thu, 27 Aug 2026 14:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787842348;
 bh=+fWbtzVgQDFg+IRS5PwCRbAuijx8PRzrDBLinuUNimI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XgQIYt7mqJNWaquL+xmomAaXbPfYvgbDv0MCoX1Vs+ElNBzRUn8omGlw847vwDPOW
 bvBeWt1TW2IyP/5faczMkQHTMwYZC3GhxyjXQVqHpxizss4lmZ4wwR1KfsLCvpesgu
 z834bnIajrgud0P9m5MadYDjIY7WSyydM0XYXvcb4YMgjOrw+5/a+omO4/UxrNGw94
 7wRYYEpXqquxwzGmLpo1ZGwbiEFTI860tYHKsr5ihw1w6d4I0vO9cvQzUVh9olCKWr
 N7QrYPm2n3dBAIRsfinoKfxlgx5EUmYabwYkl8wiI2YDNT6HpnY279YjM+YJorFtu2
 ouxKVHgSLi2ZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] drm: Unwind drm device registration upon error
To: "Krzysztof Niemiec" <krzysztof.niemiec@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260827143447.99553-2-krzysztof.niemiec@intel.com>
References: <20260827143447.99553-1-krzysztof.niemiec@intel.com>
 <20260827143447.99553-2-krzysztof.niemiec@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 14:52:27 +0000
Message-Id: <20260827145228.478961F000E9@smtp.kernel.org>
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
- [Medium] Debugfs pollution due to early destruction of dev->debugfs_root =
in drm_dev_register() error path.
--

commit d5c910dd66292cf0f42ddf2dd15a2566f8663a8a
Author: Krzysztof Karas <krzysztof.karas@intel.com>

drm: Unwind drm device registration upon error

The drm device registration is done via drm_dev_register().
This function attempts to undo some of the initiatlization steps
under err_unload and err_minors labels, but this process is
incomplete - debugfs entries remain and the dev->registered flag
is still set to true.

> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index cb53baa70995f..2d964c9535f49 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -1144,6 +1144,8 @@ int drm_dev_register(struct drm_device *dev, unsign=
ed long flags)
>  	drm_minor_unregister(dev, DRM_MINOR_ACCEL);
>  	drm_minor_unregister(dev, DRM_MINOR_PRIMARY);
>  	drm_minor_unregister(dev, DRM_MINOR_RENDER);
> +	drm_debugfs_dev_fini(dev);

[Severity: Medium]
Will this cause debugfs pollution if a driver retries registration after a
failure?

In drivers like amdgpu, there is a retry mechanism for registration:

drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:amdgpu_pci_probe() {
    ...
retry_init:
	ret =3D drm_dev_register(ddev, flags);
	if (ret =3D=3D -EAGAIN && ++retry <=3D 3) {
		drm_info(adev_to_drm(adev), "retry init %d\n", retry);
		/* Don't request EX mode too frequently which is attacking */
		msleep(5000);
		goto retry_init;
	}
    ...
}

Because dev->debugfs_root is initialized during drm_dev_init(), calling
drm_debugfs_dev_fini() here in the error path of drm_dev_register() destroys
the directory and permanently sets dev->debugfs_root to NULL.

If the driver retries drm_dev_register() on the same device instance,
drm_debugfs_dev_register() will pass the NULL dev->debugfs_root to
debugfs_create_file(). This causes device-specific debugfs files (like
'clients', 'gem_names', 'framebuffer') to be created in the global debugfs
root (/sys/kernel/debug/) instead of the device-specific directory, polluti=
ng
the global namespace and causing naming collisions.

Should dev->debugfs_root only be destroyed in drm_dev_release() to maintain
object lifecycle symmetry?

> +	dev->registered =3D false;
>  out_unlock:
>  	if (drm_dev_needs_global_mutex(dev))
>  		mutex_unlock(&drm_global_mutex);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827143447.9955=
3-1-krzysztof.niemiec@intel.com?part=3D1
