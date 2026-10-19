Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2C7CCF2CC
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 00:36:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F036310E17F;
	Mon, 19 Oct 2026 00:36:23 +0000 (UTC)
X-Greylist: delayed 429 seconds by postgrey-1.36 at gabe;
 Mon, 19 Oct 2026 00:36:16 UTC
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECBAD10E17F
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 00:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inria.fr; s=dc;
 h=date:from:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=PX9P4epPwQGrFseDhd6txC4pMNLWfiLbHeHoD9TPFYg=;
 b=S45bTdRVqIqKRLHuDeIcwLUVNoWdl+fDC2+tNKm4l3BHe/IiGO/Q1fYM
 mL3Pr+5hKnqsJBqL1lX8sFJTlyZCoD3lu9IpuoUVJEJhPNadHNDpAgTS9
 0ItLtnmjNZ8rkiyqCBDE938QFTbQvpXJ6Hh0MXezy4gx/yLj6wiZU2Rk7 o=;
X-CSE-ConnectionGUID: ZX1RDQVJTku0PRIMR/E0VA==
X-CSE-MsgGUID: fVzwDvrMQ1yHSljIa7uTtQ==
Authentication-Results: mail2-relais-roc.national.inria.fr;
 dkim=none (message not signed) header.i=none;
 spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr;
 dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.27,166,1787004000"; d="scan'208";a="300770566"
Received: from c-76-123-3-53.hsd1.va.comcast.net (HELO hadrien) ([76.123.3.53])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 02:29:05 +0200
Date: Sun, 18 Oct 2026 20:29:02 -0400 (EDT)
From: Julia Lawall <julia.lawall@inria.fr>
To: Bashirah Lawal <bashirahlawal017@gmail.com>
cc: andy@kernel.org, gregkh@linuxfoundation.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: fbtft: Fix continuation line alignment
In-Reply-To: <20261018123430.148379-1-bashirahlawal017@gmail.com>
Message-ID: <d1df7421-8b3-132-68c1-feb29ed47b41@inria.fr>
References: <20261018123430.148379-1-bashirahlawal017@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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



On Sun, 18 Oct 2026, Bashirah Lawal wrote:

Hello Bashirah,

As noted by Greg's automatic message, you can't rely on the subject line
to explain everything.  Every patch must have a comment saying what you
have done and why.

julia

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
>  	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
>  	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
>  	fsleep(250);
> --
> 2.53.0
>
>
>
