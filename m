Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8915CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 05:45:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28498112DA5;
	Mon,  1 Jun 2026 05:45:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y9SD/6OB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 643AF112DA5
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 05:45:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 54EC760018;
 Mon,  1 Jun 2026 05:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8F31F00893;
 Mon,  1 Jun 2026 05:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1780292729;
 bh=dryJxJkomuWU7M3myzEaD2QKxPzT0+x9I5gV0266eeA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Y9SD/6OB0HmVQ7cXSkQzFThV+pLRGz5r2olxPr0vQ1gO02PkTbCzdul57kCneWp3t
 yVCHlarjuYZmglGHNbTsMN8mUS26vmYMDcAg7TaprRDjmNA5zaVkMmLpLh1uC9uujM
 mi/L6qckTVQ8/vNHpFr2vOkTKt7icT1d6zHy2DnA=
Date: Mon, 1 Jun 2026 07:44:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Enchanted Hunter <enchantedredhunter@gmail.com>
Cc: linux-staging@lists.linux.dev, andy@kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] staging: fbtft: replace sprintf with snprintf
Message-ID: <2026060110-unlisted-headache-aec7@gregkh>
References: <CAOSULec2OpwTGB3OUb_n3CdKO6H_DGJnxw=qsBswbd+JBjemKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOSULec2OpwTGB3OUb_n3CdKO6H_DGJnxw=qsBswbd+JBjemKA@mail.gmail.com>
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

On Mon, Jun 01, 2026 at 03:43:55AM +0300, Enchanted Hunter wrote:
> This patch replaces unsafe sprintf calls with snprintf
> infbtft_register_framebuffer() to prevent potential buffer
> overflow.Signed-off-by: rat1bor <enchantedredhunter@gmail.com>

> From a79c6098f2e8bb2ee9e276d339710522175db977 Mon Sep 17 00:00:00 2001
> From: rat1bor <enchantedredhunter@gmail.com>
> Date: Mon, 1 Jun 2026 03:18:59 +0300
> Subject: [PATCH] staging: fbtft: replace sprintf with snprintf
> 
> Signed-off-by: rat1bor <enchantedredhunter@gmail.com>
> ---
>  drivers/staging/fbtft/fbtft-core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
> index ca0c38221c16..66509347255a 100644
> --- a/drivers/staging/fbtft/fbtft-core.c
> +++ b/drivers/staging/fbtft/fbtft-core.c
> @@ -784,10 +784,11 @@ int fbtft_register_framebuffer(struct fb_info *fb_info)
>  	fbtft_sysfs_init(par);
>  
>  	if (par->txbuf.buf && par->txbuf.len >= 1024)
> -		sprintf(text1, ", %zu KiB buffer memory", par->txbuf.len >> 10);
> +		snprintf(text1, sizeof(text1), ", %zu KiB buffer memory", par->txbuf.len >> 10);
>  	if (spi)
> -		sprintf(text2, ", spi%d.%d at %d MHz", spi->controller->bus_num,
> -			spi_get_chipselect(spi, 0), spi->max_speed_hz / 1000000);
> +		snprintf(text2, sizeof(text2), ", spi%d.%d at %d MHz",
> +			 spi->controller->bus_num, spi_get_chipselect(spi, 0),
> +			 spi->max_speed_hz / 1000000);
>  	fb_dbg(fb_info,
>  	       "%s frame buffer, %dx%d, %d KiB video memory%s, fps=%lu%s\n",
>  	       fb_info->fix.id, fb_info->var.xres, fb_info->var.yres,
> -- 
> 2.34.1
> 


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch was attached, please place it inline so that it can be
  applied directly from the email message itself.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
