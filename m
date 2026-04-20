Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132D5F557F2
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 09:29:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F32910E480;
	Mon, 20 Apr 2026 09:29:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hfqlAkhR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF95010E480
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 09:29:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3F341401B2;
 Mon, 20 Apr 2026 09:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C817DC19425;
 Mon, 20 Apr 2026 09:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1776677361;
 bh=2BfDlA6VY39y9tYQjOaTN6uHaUdWSfjiCwLjUz39juk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hfqlAkhRfz+KuAPhk5XXEvXxALNIoU9QbEQ2Jlf5L89nehJ1rQTz6snbHojbQbOS1
 m5zqrzViNaKqUIwreAEsPNFC76T/YSlS1jQLRjrwdSELsgFSwYuaIs2zq8vRf75Azu
 nAd7ro5VOj/qgJeixv0q1lOmT7KQUXNrQu11jwes=
Date: Mon, 20 Apr 2026 11:29:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Baker <mzndmzn@gmail.com>
Cc: andy@kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: fbtft: replace empty macro args with
 identity converter
Message-ID: <2026042004-unblock-giblet-cbbc@gregkh>
References: <20260412173317.3329-1-mzndmzn@gmail.com>
 <20260412173317.3329-2-mzndmzn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260412173317.3329-2-mzndmzn@gmail.com>
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

On Sun, Apr 12, 2026 at 12:33:17PM -0500, Baker wrote:
> The define_fbtft_write_reg macro calls 'modifier' as a function.
> Passing an empty token as modifier is undefined behavior in C for
> fixed-arity macros. Introduce fbtft_no_conv() as an identity
> function to replace the empty args in the no-conversion cases.
> 
> Signed-off-by: Baker <mzndmzn@gmail.com>
> ---
>  drivers/staging/fbtft/fbtft-bus.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
> index 30e436ff19e4..7f3fd30576ab 100644
> --- a/drivers/staging/fbtft/fbtft-bus.c
> +++ b/drivers/staging/fbtft/fbtft-bus.c
> @@ -11,6 +11,8 @@
>   *
>   *****************************************************************************/
>  
> +#define fbtft_no_conv(x) (x)
> +
>  #define define_fbtft_write_reg(func, buffer_type, data_type, modifier)        \
>  void func(struct fbtft_par *par, int len, ...)                                \
>  {                                                                             \
> @@ -62,9 +64,9 @@ out:									      \
>  }                                                                             \
>  EXPORT_SYMBOL(func);
>  
> -define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
> +define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, fbtft_no_conv)
>  define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
> -define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
> +define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, fbtft_no_conv)
>  
>  void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
>  {
> -- 
> 2.47.3
> 
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
