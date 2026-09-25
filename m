Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05678C9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:39:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 492DB10F8FB;
	Fri, 25 Sep 2026 07:39:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B20BRjtT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5537310F8D3;
 Fri, 25 Sep 2026 07:34:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 259B843414;
 Fri, 25 Sep 2026 07:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4371F000FF;
 Fri, 25 Sep 2026 07:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790321651;
 bh=vmC6c4Z4BJWCF29OvqSo1ljeNOmLH8nUz+0tStjLmyo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=B20BRjtT4LAqOmxcP+I/+d51QN0OOhgbULQRwuK1XPM50AS0dyz/Ro3PbhBbMbUaN
 iyMTOv4Hx1IXBrHiKnIjI5QQya2wkPwtEa7lSaGFROhJVx5pDm+TrcmWLRfC073znJ
 S/jYheY2xJTwxzIo9yn6WbkMcXswcT3O5OnbYocIcuN3FOvcQcNTKwaigolusacXyA
 KG7I8sS8fUL4iWky/e0sIXoGZq2WAtN6RizxD49RDeDncPy1CsQCLl1EOfVImx0FHh
 3rOx0YkqUx0s2i1mnJBMO9jtW6sMckV8RCjs+k56gBk6KPPPf4REyRZ4c55Y8VvSOL
 mpakLDB7lQwiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] drm/fbdev: Move fbdev helpers into client library
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20260925071933.44283-3-tzimmermann@suse.de>
References: <20260925071933.44283-1-tzimmermann@suse.de>
 <20260925071933.44283-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 07:34:10 +0000
Message-Id: <20260925073410.BD4371F000FF@smtp.kernel.org>
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
- [Low] kbuild: link error when GEM helpers are built-in and DRM_CLIENT_LIB=
 is modular
--

commit d69668549441f21758d69fc518df18536eb9bb24
Author: Thomas Zimmermann <tzimmermann@suse.de>
Subject: drm/fbdev: Move fbdev helpers into client library

This commit moves DRM's fbdev emulation helpers into the client library
module and renames them from drm_fb_helper to drm_fbdev_helper.

> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
[ ... ]
> @@ -256,7 +255,6 @@ config DRM_TTM_HELPER
>  	tristate
>  	depends on DRM
>  	select DRM_TTM
> -	select DRM_KMS_HELPER if DRM_FBDEV_EMULATION
>  	select FB_CORE if DRM_FBDEV_EMULATION
>  	select FB_SYSMEM_HELPERS_DEFERRED if DRM_FBDEV_EMULATION
>  	help

[Severity: Low]
When DRM_KMS_HELPER is removed here, is there a replacement needed for the
client library? If a built-in driver selects DRM_TTM_HELPER=3Dy and
DRM_FBDEV_EMULATION=3Dy, but a modular driver forces DRM_CLIENT_LIB=3Dm, can
this result in a vmlinux link error because the fbdev emulation code in
the client library is not built-in?

> @@ -265,7 +263,6 @@ config DRM_TTM_HELPER
>  config DRM_GEM_DMA_HELPER
>  	tristate
>  	depends on DRM
> -	select DRM_KMS_HELPER if DRM_FBDEV_EMULATION
>  	select FB_CORE if DRM_FBDEV_EMULATION
>  	select FB_DMAMEM_HELPERS_DEFERRED if DRM_FBDEV_EMULATION
>  	help

[Severity: Low]
Does this missing replacement for the client library dependency also leave
config DRM_GEM_DMA_HELPER susceptible to the same link error when built-in?

> @@ -274,7 +271,6 @@ config DRM_GEM_DMA_HELPER
>  config DRM_GEM_SHMEM_HELPER
>  	tristate
>  	depends on DRM && MMU
> -	select DRM_KMS_HELPER if DRM_FBDEV_EMULATION
>  	select FB_CORE if DRM_FBDEV_EMULATION
>  	select FB_SYSMEM_HELPERS_DEFERRED if DRM_FBDEV_EMULATION
>  	help

[Severity: Low]
Similarly, should config DRM_GEM_SHMEM_HELPER select the client library to
prevent a link error when DRM_FBDEV_EMULATION is enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925071933.4428=
3-1-tzimmermann@suse.de?part=3D2
