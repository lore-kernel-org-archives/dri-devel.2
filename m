Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3E9606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HYLHAZO9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01B8410E02A;
	Thu,  5 Nov 2026 08:35:13 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 466B510E02A
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 08:35:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with UTF8SMTP id 3DE4860C02;
 Thu,  5 Nov 2026 08:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 17A251F000C1;
 Thu,  5 Nov 2026 08:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793867706;
 bh=v0+BrrivRfnkIQASeKgDrnesCksNDWwtoNYk5A34Ewo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=HYLHAZO917vgMApNDZmXdmOtgDBz5oOUwvtkA3LiE8EBYg9W5svxN7297d075vrBn
 FmBIMWfxGjX/ZI2sjkWWS+OmaApQqeyN3rNPTrFYvbP3G6jJoRRUunaWgZ3Z4VapqH
 h26yVKOPZyN10fRoIjEiq69dA3L+Z1T1z44PATiyg5Ws8ti9izEj+d5LmJKcY9sj+5
 lKv+1pBsrjYudjh80MQrdVzNUu/XtFHkhhwS1NvmnuFrxVLQeJSdCCuggYEtFceJfW
 Zv31pdmdm4k7zoOrjmgTsigu0C7QGZ6nptnPDrFrW7hZRp/P2yFvQ0WbGK59cD7jZK
 JkQPgr02gma9w==
Date: Thu, 5 Nov 2026 09:35:02 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/3] ARM: sunxi: select HAVE_SHARED_GPIOS
Message-ID: <dbrddaburmupwyobtrliqf32pzowjp2t5bkpzcyslj74uslmhx@ny22if7wgmxb>
References: <20261103-panel-mipi-non-exclusive-gpios-v1-0-aa862c1d71e3@oss.qualcomm.com>
 <20261103-panel-mipi-non-exclusive-gpios-v1-2-aa862c1d71e3@oss.qualcomm.com>
 <sashiko-outbox-195389@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-195389@kernel.org>
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 01:43:13PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] ARM: sunxi: HAVE_SHARED_GPIOS ignores 3-cell sunxi SoC GPIO bindings
> --
> 
> commit 08b8c5df755142dacaed1d91af688663b9db7e82
> Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> 
> ARM: sunxi: select HAVE_SHARED_GPIOS
> 
> This commit selects HAVE_SHARED_GPIOS for ARCH_SUNXI to enable automated
> management of shared GPIOs via the GPIO shared proxy module on sunxi
> platforms.
> 
> > diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> > index e015f2497111a..b62e8518e2704 100644
> > --- a/arch/arm/mach-sunxi/Kconfig
> > +++ b/arch/arm/mach-sunxi/Kconfig
> > @@ -5,6 +5,7 @@ menuconfig ARCH_SUNXI
> >  	select ARCH_HAS_RESET_CONTROLLER
> >  	select CLKSRC_MMIO
> >  	select GPIOLIB
> > +	select HAVE_SHARED_GPIOS
> 
> [Severity: Medium]
> Does selecting HAVE_SHARED_GPIOS here actually work for Allwinner sunxi SoC
> GPIO controllers?
> 
> Allwinner sunxi pinctrl/GPIO controllers (&pio and &r_pio) use 3-cell GPIO
> specifiers (#gpio-cells = <3>: bank, pin, flags), as translated in
> drivers/pinctrl/sunxi/pinctrl-sunxi.c:sunxi_pinctrl_gpio_of_xlate():
>

Right, shared GPIOs need support for 3-cell bindings first. Let's drop
this for now.

Bart
