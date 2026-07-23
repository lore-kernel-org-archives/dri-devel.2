Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52F4C531CA
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 12:38:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AC6110F0DB;
	Thu, 23 Jul 2026 12:38:31 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34E0410F0DB
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 12:38:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6C884600AD;
 Thu, 23 Jul 2026 12:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020FF1F000E9;
 Thu, 23 Jul 2026 12:38:28 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] fbdev: replace dead select with dependency
To: "Julian Braha" <julianbraha@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260723122818.437802-1-julianbraha@gmail.com>
References: <20260723122818.437802-1-julianbraha@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 12:38:26 +0000
Message-Id: <20260723123829.020FF1F000E9@smtp.kernel.org>
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
- [Medium] Replacing `select` with `depends on` silently breaks `socrates_d=
efconfig` and hides the Lime GDC driver.
--

--- Patch [1]: [PATCH v2] fbdev: replace dead select with dependency ---
commit bd0c1c5dd1e0309a476de7f3f80441e35d1d6474
Author: Julian Braha <julianbraha@gmail.com>

fbdev: replace dead select with dependency

This commit modifies the Kconfig dependencies for the Fujitsu Lime GDC
framebuffer driver. It replaces the select statements for foreign and
little endian support with a direct dependency on either little endian
or both endians.

Link: https://lore.kernel.org/all/20260722220023.196029-1-julianbraha@gmail=
.com/

> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 085d3a202148b..e8cd8cb76874b 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -1717,8 +1717,7 @@ config FB_MB862XX_PCI_GDC
>  config FB_MB862XX_LIME
>  	bool "Lime GDC"
>  	depends on OF && PPC
> -	select FB_FOREIGN_ENDIAN
> -	select FB_LITTLE_ENDIAN
> +	depends on FB_LITTLE_ENDIAN || FB_BOTH_ENDIAN

[Severity: Medium]
Will this change cause the driver to be silently dropped in
socrates_defconfig?

Looking at drivers/video/fbdev/core/Kconfig, FB_FOREIGN_ENDIAN defaults
to 'n' and gates the endianness choice block:

menuconfig FB_FOREIGN_ENDIAN
	bool "Framebuffer foreign endianness support"
	depends on FB

Since arch/powerpc/configs/85xx/socrates_defconfig requests
CONFIG_FB_MB862XX_LIME=3Dy but does not explicitly set
CONFIG_FB_FOREIGN_ENDIAN=3Dy, removing the select statement means
FB_FOREIGN_ENDIAN will now evaluate to 'n'.

This hides the endianness choice block, forcing both FB_LITTLE_ENDIAN and
FB_BOTH_ENDIAN to 'n'. Does this mean the new dependency will be unmet,
causing the Lime GDC driver to be dropped during defconfig generation
despite the commit message indicating this avoids breaking defconfig?

>  	help
>  	  Framebuffer support for Fujitsu Lime GDC on host CPU bus.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723122818.4378=
02-1-julianbraha@gmail.com?part=3D1
