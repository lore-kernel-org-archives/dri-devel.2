Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A25C5AD2B
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 09:44:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FE2510E407;
	Sat,  8 Aug 2026 09:44:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jt/2OQU4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C015010E407
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 09:44:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D3BC860054;
 Sat,  8 Aug 2026 09:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555271F000E9;
 Sat,  8 Aug 2026 09:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786182273;
 bh=FhC3d/llWNsxYmoeWJvfdD4dJDNrtRf2RYqgYv6VDI0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Jt/2OQU4rObcGyPyzfFtRCwI0SSLUs86NGKAJU+/lfXyghcXCG89xopbk5048KmCn
 6wvYf1xINbTYPMp0XBolLLbotXpKrF5uGLL4/ArDvle6Nd+htl08ajPVEjZtYJSTnw
 aDeyUNlCyjCf2+vLoyw+Mbg1T1M+6kafts/3xQPnASFBTASw5L3U8ixxe7n0UI54+D
 /KvXHj7qlDZt2esSipLLl6vyUiphv6FZn/tV6Vy+umugaitVO2TTQ3jO7t/Gzqp1nd
 y5yBx3eqqsDjWbV+UHhdl7WxR4h+UtfHvxIvDvm6VMOT7gmrHlxnuQVCto5W2rJWv6
 MvwFKyXdyQr3A==
Date: Sat, 8 Aug 2026 11:44:26 +0200
From: Helge Deller <deller@kernel.org>
To: Max Pedraza <maximpedraza@gmail.com>, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>,
 Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/6] video: logo: allow the boot logo to come from the
 device tree
Message-ID: <anb6ejVQMPqD7G3r@carbonx1>
References: <20260804225617.264861-1-maximpedraza@gmail.com>
 <20260804225617.264861-3-maximpedraza@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804225617.264861-3-maximpedraza@gmail.com>
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

* Max Pedraza <maximpedraza@gmail.com>:
> Add CONFIG_LOGO_DT_CLUT224, which makes fb_find_logo() look for a node
> compatible with "linux,boot-logo-clut224" under /chosen before falling
> back to the logos built into the kernel image.
> 
> The image is validated before it is used: the palette must have at most
> 224 entries, the pixel data length must match the geometry, and every
> pixel must reference an entry that exists. A malformed node is reported
> and ignored rather than drawn, so a bad device tree cannot take the
> display down with it.
> 
> The image is copied out of the device tree so that the 32 entry offset
> the frame buffer layer reserves for the console can be applied to the
> pixels, and the copy is released from fb_logo_late_init() alongside the
> built-in logos.
> 
> The node lives under /chosen because a logo is configuration handed over
> by firmware rather than a description of the hardware, which is also
> where simple-framebuffer nodes live for the same reason.
> 
> Signed-off-by: Max Pedraza <maximpedraza@gmail.com>
> ---
>  drivers/video/logo/Kconfig |  12 +++
>  drivers/video/logo/logo.c  | 160 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 172 insertions(+)
> 
> diff --git a/drivers/video/logo/Kconfig b/drivers/video/logo/Kconfig
> index cda15b958..215afa7ef 100644
> --- a/drivers/video/logo/Kconfig
> +++ b/drivers/video/logo/Kconfig
> @@ -76,4 +76,16 @@ config LOGO_LINUX_CLUT224_FILE
>  
>  	    magick source_image -compress none -colors 224 destination.ppm
>  
> +config LOGO_DT_CLUT224
> +	bool "224-color logo supplied by the device tree"
> +	depends on OF
> +	help
> +	  Look for a boot logo in the device tree, in a node compatible with
> +	  "linux,boot-logo-clut224" under /chosen, instead of using one of
> +	  the logos built into the kernel image. This allows a single kernel
> +	  image to be used by several products that only differ in branding.
> +
> +	  If no such node is present, or it is disabled, the built-in logo
> +	  selected above is used, so saying Y here is safe.
> +
>  endif # LOGO
> diff --git a/drivers/video/logo/logo.c b/drivers/video/logo/logo.c
> index 91535f884..7f8b04ecf 100644
> --- a/drivers/video/logo/logo.c
> +++ b/drivers/video/logo/logo.c
> @@ -11,6 +11,9 @@
>   */
>  
>  #include <linux/linux_logo.h>
> +#include <linux/of.h>
> +#include <linux/sizes.h>
> +#include <linux/slab.h>
>  #include <linux/stddef.h>
>  #include <linux/module.h>
>  
> @@ -22,6 +25,155 @@ static bool nologo;
>  module_param(nologo, bool, 0);
>  MODULE_PARM_DESC(nologo, "Disables startup logo");
>  
> +#ifdef CONFIG_LOGO_DT_CLUT224


With the #ifdef above, your logo code will only be compiled when
people enable CONFIG_LOGO_DT_CLUT224, and as such coding errors
(maybe even introduced by other patches) will only show up randomly.

I usually prefer if people use the IS_ENABLED(CONFIG_XXX) macro instead
and put it at specific entry places, so that while the compiler can do
compile-time checking the code, it can optimize it away too, when the
option isn't enabled.

As an *example*, see my patch below (on top you your code). It compiles cleanly
for me and does the compile-time checking as well.

While respinning your other patches, maybe you can check if something similiar
can be used there too (but only if it makes sense there!).

Helge


diff --git a/drivers/video/logo/logo.c b/drivers/video/logo/logo.c
index 66bcb37e78d5..f68ded458d2e 100644
--- a/drivers/video/logo/logo.c
+++ b/drivers/video/logo/logo.c
@@ -27,7 +27,8 @@ static bool nologo;
 module_param(nologo, bool, 0);
 MODULE_PARM_DESC(nologo, "Disables startup logo");
 
-#ifdef CONFIG_LOGO_DT_CLUT224
+
+/* LOGO in devicetree: */
 
 #define LOGO_DT_COMPATIBLE	"linux,boot-logo-clut224"
 #define LOGO_DT_MAX_CLUT	224
@@ -229,6 +230,9 @@ static const struct linux_logo *logo_dt_find(void)
 	struct device_node *np;
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_LOGO_DT_CLUT224))
+		return NULL;
+
 	if (probed)
 		return logo_dt_data ? &logo_dt_clut224 : NULL;
 
@@ -252,6 +256,9 @@ static const struct linux_logo *logo_dt_find(void)
 
 static void logo_dt_free(void)
 {
+	if (!IS_ENABLED(CONFIG_LOGO_DT_CLUT224))
+		return;
+
 	logo_dt_clut224.clut = NULL;
 	logo_dt_clut224.data = NULL;
 
@@ -262,17 +269,6 @@ static void logo_dt_free(void)
 	logo_dt_data = NULL;
 }
 
-#else /* !CONFIG_LOGO_DT_CLUT224 */
-
-static inline const struct linux_logo *logo_dt_find(void)
-{
-	return NULL;
-}
-
-static inline void logo_dt_free(void) { }
-
-#endif /* CONFIG_LOGO_DT_CLUT224 */
-
 /*
  * Logos are located in the initdata, and will be freed in kernel_init.
  * Use late_init to mark the logos as freed to prevent any further use.
