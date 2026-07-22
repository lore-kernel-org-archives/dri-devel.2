Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D5CC4453A
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 22:09:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6758010E508;
	Wed, 22 Jul 2026 22:09:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IDwNQUin";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B839310E508
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 22:09:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6AD0B43FB8;
 Wed, 22 Jul 2026 22:09:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B27D1F000E9;
 Wed, 22 Jul 2026 22:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784758160;
 bh=ji2oQ+H1P4K5osOpG8EUDX+ka1ZOl/y9DLME5TEH+38=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IDwNQUinda1BMcrNVBmz45ZQSaZ3d5hYfOiBRalzU22t0IDKT//0v/5h08TWnHwdy
 fJRwsM/hOTZgSaV0T/Vd7ljN+yakxlY1h02j+G01KZ6Wr7ybFttTKnsCDnoK9xtP5/
 RmUsE4yn6N/VRxFgyy5k4HXl9tc2yefMtPDS8eqZ0zHDHiVS8CpM1o8kcWj3k8ZJkC
 P2DZpXzyknx9tow4md3/du9csS1y0L6wxakruWpJ1rqgYqahnfmeandFrKp5SX5Du0
 AJRgGsUWoOVigCH39iviwuxV68J6xaIpNKEajHIskW5+iCo+KnC6cmBAeWpeTx7Pov
 aws3d/o4sk4iA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fbdev: replace dead select with dependency
To: "Julian Braha" <julianbraha@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722220023.196029-1-julianbraha@gmail.com>
References: <20260722220023.196029-1-julianbraha@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 22:09:19 +0000
Message-Id: <20260722220920.2B27D1F000E9@smtp.kernel.org>
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
- [High] Changing `select` to `depends on` for `FB_FOREIGN_ENDIAN` and `FB_=
LITTLE_ENDIAN` breaks defconfigs and hides the driver under the default `FB=
_BOTH_ENDIAN` configuration.
--

--- Patch [1]: [PATCH] fbdev: replace dead select with dependency ---
commit f6c60088df30f6a2f86ba2d49417608f5f3983b3
Author: Julian Braha <julianbraha@gmail.com>

fbdev: replace dead select with dependency

This commit modifies the Kconfig entry for FB_MB862XX_LIME, replacing the
select statements for FB_FOREIGN_ENDIAN and FB_LITTLE_ENDIAN with depends
on statements. This is intended to fix a dead select on a choice option
without creating recursive dependencies.

> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 085d3a202148b..1ed4506c0cb2e 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -1717,8 +1717,8 @@ config FB_MB862XX_PCI_GDC
>  config FB_MB862XX_LIME
>  	bool "Lime GDC"
>  	depends on OF && PPC
> -	select FB_FOREIGN_ENDIAN
> -	select FB_LITTLE_ENDIAN
> +	depends on FB_FOREIGN_ENDIAN
> +	depends on FB_LITTLE_ENDIAN

[Severity: High]
Does changing these to 'depends on' inadvertently disable the driver for
existing defconfigs and users of the default FB_BOTH_ENDIAN choice?

For example, arch/powerpc/configs/85xx/socrates_defconfig contains:

CONFIG_FB_MB862XX_LIME=3Dy

Because the defconfig does not explicitly enable FB_FOREIGN_ENDIAN, won't
this new dependency cause the configuration system to silently drop the
driver from the build?

Additionally, if a user selects FB_BOTH_ENDIAN (the default for the choice),
FB_LITTLE_ENDIAN becomes 'n'.

Does this make the driver unselectable even though FB_BOTH_ENDIAN should
satisfy the endianness requirements?

>  	help
>  	  Framebuffer support for Fujitsu Lime GDC on host CPU bus.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722220023.1960=
29-1-julianbraha@gmail.com?part=3D1
