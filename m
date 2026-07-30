Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC30DC55167
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:45:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD0A910F086;
	Thu, 30 Jul 2026 20:45:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SgkGK+co";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C483410F086
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 20:45:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9437241220;
 Thu, 30 Jul 2026 20:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554B91F00A3A;
 Thu, 30 Jul 2026 20:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785444346;
 bh=Oh/pWjDRb47tOQGUbmCylSDTt8vE4RlF+Hk/1MrKKH4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SgkGK+coHGNtFHGS1Su5LCAOPXjrq9VLW8L7DYLHuhy8jHpJKAyI3zGzV19YjbVR6
 poBRBwPG/FjWd+ZhwBRS9qa13jUNXqnIh+s6zP3yE3L/Jx1HNrzUmAU1q+Lus3asOg
 43gbj8H7km1njYp0qNnYHwxhuBk4ieaRUdM03oKTH54r0rV4J/KDxiT0g8Gj/ghm6Y
 yLDFiC5kuieXYJb08zCgzfzgP6hyPo3tqyZaVIh1qy9JqDRZXG43kPGniAX8YvzReX
 2xh2QUPtdPwk10+Ke7kXUPoRKrxndHMQ1BAn5nxzs9d248ikLAe6Y7kDbGFx6ThOTs
 R6pHWT4UagyhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/5] drm/nouveau: Fix cleanup bug in
 nouveau_drm_device_new()
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260730203723.1649433-2-lyude@redhat.com>
References: <20260730203723.1649433-1-lyude@redhat.com>
 <20260730203723.1649433-2-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 20:45:45 +0000
Message-Id: <20260730204546.554B91F00A3A@smtp.kernel.org>
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
- [High] NULL pointer dereference in nouveau_drm_device_init() due to nouve=
au_drm_device_new() returning 0 (NULL) on success.
--

--- Patch [1]: [PATCH v4 1/5] drm/nouveau: Fix cleanup bug in nouveau_drm_d=
evice_new() ---
commit a5372851dc75d5b677c79a26019c14c8143d697d
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau: Fix cleanup bug in nouveau_drm_device_new()

This patch fixes the error handling path in nouveau_drm_device_new() so
it doesn't attempt to free an error pointer if drm_dev_alloc fails. It
replaces the single done label with specific error labels.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouv=
eau/nouveau_drm.c
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
[ ... ]
> @@ -762,39 +762,43 @@ nouveau_drm_device_new(const struct drm_driver *drm=
_driver, struct device *paren
[ ... ]
>  	ret =3D nvif_mmu_ctor(&drm->device.object, "drmMmu", mmus[ret].oclass, =
&drm->mmu);
>  	if (ret) {
>  		NV_ERROR(drm, "MMU allocation failed: %d\n", ret);
> -		goto done;
> +		goto err_device_del;
>  	}
> =20
> -done:
> -	if (ret) {
> -		nouveau_drm_device_del(drm);
> -		drm =3D NULL;
> -	}
> +	return 0;

[Severity: High]
Does this code cause a NULL pointer dereference during device probe?

The function nouveau_drm_device_new() returns a struct nouveau_drm pointer,
but the success path was changed to return 0 (NULL).

Since the caller checks for failure using IS_ERR(), it will consider NULL a
success and pass the NULL pointer to nouveau_drm_device_init(), where it wi=
ll
be dereferenced:

nouveau_drm_device_init()
    struct drm_device *dev =3D drm->dev;

Should this return the drm pointer instead?

> +
> +err_free_drm:
> +	kfree(drm);
> +
> +	return ERR_PTR(ret);
> +
> +err_device_del:
> +	nouveau_drm_device_del(drm);
> =20
> -	return ret ? ERR_PTR(ret) : drm;
> +	return ERR_PTR(ret);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730203723.1649=
433-1-lyude@redhat.com?part=3D1
