Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DE9C98311
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 09:43:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0B4210E81A;
	Thu, 24 Sep 2026 09:43:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jx2UOZdI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACAAC10E81A;
 Thu, 24 Sep 2026 09:43:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 69B2541779;
 Thu, 24 Sep 2026 09:43:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F311F000FF;
 Thu, 24 Sep 2026 09:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790243012;
 bh=IlAzjOylR7gOvnBHL9lIBc2N2riyk9bh140STelRoNk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jx2UOZdIhA2j7a+MlDeHL0y2ahJy5is2KwJFM+E1144vTz3RCHBbBa1ivYSTVZtqZ
 dxkVW+aynGx6Vx+Q71PtYCgVz74UvCyz4nZ9waiVhazr7EdSaEXYRiflPmPy2Ce3Ky
 jNoVcHkrazvbBL8vVnrtm4dgeLfGyNr97+cAFeb4O98f/UXIfXfBpIXA6pYGVzzl2F
 dNu70UpYbI74z2Xz3KUk2sSSBJvcy0nWQF64QQYyLvlQHKLxwqYYEjb61f6mAm92/6
 RNPKzk8i1XfLpZA3myY5BwmSXZc8C9otlA0MtC5HtYQ/ibduZv+2aokFCVciBHZmd+
 n8VrM/qE0Gk5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm/fbdev: Move fbdev helpers into client library
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20260924093036.82356-3-tzimmermann@suse.de>
References: <20260924093036.82356-1-tzimmermann@suse.de>
 <20260924093036.82356-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 09:43:31 +0000
Message-Id: <20260924094332.14F311F000FF@smtp.kernel.org>
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
- [Low] drm: missing DRM_CLIENT_LIB selection in memory helpers causes link=
er error
--

commit b0f3c606cfc59f0c56cd9be7e3349abc72f97a64
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/fbdev: Move fbdev helpers into client library

DRM's fbdev helpers are for the fbdev-emulation clients. Move them
into the client-library module. Fix include statements throughout
DRM drivers.

> diff --git a/drivers/gpu/drm/clients/Makefile b/drivers/gpu/drm/clients/M=
akefile
> index c16addbc327f0..1304ff358509d 100644
> --- a/drivers/gpu/drm/clients/Makefile
> +++ b/drivers/gpu/drm/clients/Makefile
> @@ -4,5 +4,6 @@ subdir-ccflags-y +=3D -I$(src)/..
> =20
>  drm_client_lib-y :=3D drm_client_setup.o
>  drm_client_lib-$(CONFIG_DRM_CLIENT_LOG) +=3D drm_log.o
> -drm_client_lib-$(CONFIG_DRM_FBDEV_EMULATION) +=3D drm_fbdev_client.o
> +drm_client_lib-$(CONFIG_DRM_FBDEV_EMULATION) +=3D drm_fbdev_client.o \
> +						drm_fbdev_helper.o

[Severity: Low]
Since drm_fbdev_helper.o is now built into drm_client_lib, can this cause a
linker error for built-in memory helpers?

If CONFIG_DRM_FBDEV_EMULATION=3Dy and a driver selects DRM_GEM_DMA_HELPER=
=3Dy,
but CONFIG_DRM_CLIENT_SELECTION=3Dm (selected only by modular drivers),
drm_client_lib.ko will be built as a module while drm_fbdev_dma.o becomes
built-in.

This would lead to undefined references to fbdev helper functions (e.g.,
drm_fb_helper_fini) during vmlinux linkage.

Do the memory helpers in drivers/gpu/drm/Kconfig (DRM_GEM_DMA_HELPER,
DRM_GEM_SHMEM_HELPER, DRM_TTM_HELPER) need to explicitly select
DRM_CLIENT_LIB when DRM_FBDEV_EMULATION is enabled to prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924093036.8235=
6-1-tzimmermann@suse.de?part=3D2
