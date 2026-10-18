Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BD3CCF2C4
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:31:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C2B210E05B;
	Sun, 18 Oct 2026 13:31:13 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1D4010E05B
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 13:31:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 81B3B60D87;
 Sun, 18 Oct 2026 13:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750721F000C6;
 Sun, 18 Oct 2026 13:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1792330266;
 bh=NxusC2ZkrRWNZg9kKmWEMlTgz182myS5LwkDwojrAfg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=0KliaDxRdXf8rn0xkZtximAv2Z5u780620LtuBd/6LseJzUguoPNPL6SL4Cy+BoWb
 3if977qMG1Kx15HmC1qhnVKIKsRjrpnE/FDMVK0Uvzp4ynQb7uQ4nCqPIrv4VofBfS
 nrrs4RvW6rWJZNX2XNEVlLo/cRi4kq1SOa/k4bZY=
Date: Sun, 18 Oct 2026 15:31:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Bashirah Lawal <bashirahlawal017@gmail.com>
Cc: andy@kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: fbtft: Fix continuation line alignment
Message-ID: <2026101834-gizzard-evaluator-3c7a@gregkh>
References: <20261018123430.148379-1-bashirahlawal017@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018123430.148379-1-bashirahlawal017@gmail.com>
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

On Sun, Oct 18, 2026 at 08:34:30AM -0400, Bashirah Lawal wrote:
> Signed-off-by: Bashirah Lawal <bashirahlawal017@gmail.com>
> ---
>  drivers/staging/fbtft/fb_tinylcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
> index afa8f1c740c5..d58b1247262b 100644
> --- a/drivers/staging/fbtft/fb_tinylcd.c
> +++ b/drivers/staging/fbtft/fb_tinylcd.c
> @@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
>  	write_reg(par, 0xE5, 0x00);
>  	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
>  	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
> -		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
> +		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);


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

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.


If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
