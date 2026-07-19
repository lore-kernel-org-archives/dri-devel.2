Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F95FC4451C
	for <dri-devel@archiver.kernel.org>; Sun, 19 Jul 2026 03:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A94610E1CC;
	Sun, 19 Jul 2026 03:32:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="FlEH7EpI";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBFEA10E1CC
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 03:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=Rjc+gerhmCYCzaJXtcxnv4SN3FPtKy2qexZHFwrRceo=; b=FlEH7EpIwbSOZSMe23Qkbfs4TC
 SFUvXVlrMFg873exOk9drhpldlXq/jqZPSVj5NAioI7plec3AaE8IkQQndedtI3+XT9CUjvLnDkgU
 gLTANWBTwmR02A803BNCdCOIAKNCGjrwfsEzj6kNJVH23B9b7TsamzGBq+dVbxzhGikTxsubnVd5u
 yAEDJOdFmCtlohK7agc1yVws533s46PTBJ9s3lJiaq1MumVBdBMEQARYYpab/WKVPKiOV/iQPMo22
 67/BT4hlIkPiJ2O+HahupDgMqadFLvepH6zXQnlx1qJfcqEYBQdKJ4nABUXsXf2p1+SGuEu4QbY47
 CH1MDF2Q==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wlIFu-00000004iVh-2jcs; Sun, 19 Jul 2026 03:31:54 +0000
Message-ID: <ccb5e897-6974-4492-887f-62aea074c62e@infradead.org>
Date: Sat, 18 Jul 2026 20:31:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] backlight: ktd2801: fix unmet dependency on GPIOLIB
To: Julian Braha <julianbraha@gmail.com>, lee@kernel.org, danielt@kernel.org, 
 jingoohan1@gmail.com, deller@gmx.de
Cc: duje@dujemihanovic.xyz, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
References: <20260719024902.151710-1-julianbraha@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260719024902.151710-1-julianbraha@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi,

On 7/18/26 7:49 PM, Julian Braha wrote:
> LEDS_EXPRESSWIRE depends on GPIOLIB, so its selector, BACKLIGHT_KTD2801
> also needs to ensure GPIOLIB is enabled. Otherwise:
> 
> WARNING: unmet direct dependencies detected for LEDS_EXPRESSWIRE
>   Depends on [n]: NEW_LEDS [=n] && GPIOLIB [=n]
>   Selected by [y]:
>   - BACKLIGHT_KTD2801 [=y] && HAS_IOMEM [=y] && BACKLIGHT_CLASS_DEVICE [=y]
> 
> This unmet dependency was found by kconfirm, a static analysis tool for
> Kconfig.

or it can be hand-crafted and the warning seen by 'make oldconfig' etc.


> Fixes: d95963e309bc ("backlight: ktd2801: Depend on GPIOLIB")
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
>  drivers/video/backlight/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 7c66b8840d88..dbf4ca23a9b6 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -193,7 +193,7 @@ config BACKLIGHT_KTD253
>  
>  config BACKLIGHT_KTD2801
>  	tristate "Backlight Driver for Kinetic KTD2801"
> -	depends on GPIOLIB || COMPILE_TEST
> +	depends on GPIOLIB
>  	select LEDS_EXPRESSWIRE
>  	help
>  	  Say Y to enable the backlight driver for the Kinetic KTD2801 1-wire

Well, ktd2801.ko is being built for me with no warnings and I have:
COMPILE_TEST=y
GPIOLIB=n
BACKLIGHT_KTD2801=m

but we do want to eliminate the warning, so:

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

thanks.
-- 
~Randy
