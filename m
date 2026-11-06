Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E731606EEBF
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HpGWkcjE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75A6E10EA9B;
	Fri,  6 Nov 2026 17:19:49 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E30A110EA9B
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 17:19:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9A36941B5A;
 Fri,  6 Nov 2026 17:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A201F008A1;
 Fri,  6 Nov 2026 17:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793985583;
 bh=2Ki9WbXI9WdqAjVBEc/hHwmzCYkFZHUJDhuGONhIyeE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HpGWkcjE1Vi2fwVu4fIZZTOJd9eSiaR0YIwXMNDl3axmtonT/TqWGtR6ddQwlAYRb
 YF1CG4jPILViRurk7Gmm3vSrUoQoAQxI9/EeFJ/EHRGagpV9WRAnv+uImrJi4wbkEb
 fnTXbzEsuNUfJT9lm2m0Org4ZqKJwYEvmNV+XUp2X9jvQFjOaDY4QMiq+yEjQ5lvmo
 to4y1DN2g6JD4As3LUNocnHTq8GLhbl1M1zg4Ls3TNyO2sxt5TdPKmujw+rVzOH99D
 bKOagYGVsGxezzqssOvHsaPsVgfkdO4wnxPd6osnQihcAF9tHxbLe7tLtvE55TYU3f
 VDQb0ktRxF56g==
Message-ID: <sashiko-outbox-201909@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] fbdev: xilinxfb: remove the driver
To: "Radhey Shyam Pandey" <radhey.shyam.pandey@amd.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261106170902.3656809-2-radhey.shyam.pandey@amd.com>
References: <20261106170902.3656809-1-radhey.shyam.pandey@amd.com>
 <20261106170902.3656809-2-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:19:42 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] fbdev: xilinxfb: stale CONFIG_FB_XILINX in microblaze
  mmu_defconfig
--

commit dc9c5a7ca88a79ff63fa682655927a4c3e97e183
Author: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

fbdev: xilinxfb: remove the driver

This commit removes the obsolete xilinxfb framebuffer driver along with its
Kconfig option and Makefile entry.

> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index e8cd8cb76874b..50673b83cb857 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -1620,15 +1620,6 @@ config FB_PS3_DEFAULT_SIZE_M
>  	  The default value can be overridden on the kernel command line
>  	  using the "ps3fb" option (e.g. "ps3fb=3D9M");
> =20
> -config FB_XILINX
> -	tristate "Xilinx frame buffer support"
> -	depends on FB && (MICROBLAZE || ARCH_ZYNQ || ARCH_ZYNQMP)
> -	select FB_IOMEM_HELPERS
> -	help
> -	  Include support for the Xilinx ML300/ML403 reference design
> -	  framebuffer. ML300 carries a 640*480 LCD display on the board,
> -	  ML403 uses a standard DB15 VGA connector.
> -
>  config FB_GOLDFISH
>  	tristate "Goldfish Framebuffer"
>  	depends on FB

[Severity: Low]
Should CONFIG_FB_XILINX=3Dy also be removed from
arch/microblaze/configs/mmu_defconfig?  Leaving it there triggers an
unknown symbol warning when configuring mmu_defconfig with W=3Dc.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106170902.3656=
809-1-radhey.shyam.pandey@amd.com?part=3D1
