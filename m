Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58022CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 06:48:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EF3210E30B;
	Fri, 26 Jun 2026 06:48:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rUN/htI4";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B93910E30B
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 06:48:14 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-490cdae130cso3646015e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 23:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782456493; x=1783061293; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9N0cksKNHvZ81428H3lVKSOV4A7mJ0/dw00DfAdSSuw=;
 b=rUN/htI4FyB+uO/qOltqAj939aq4II9NeRkDdmRdnAy/Hnb/s+shkpVMBjEQA0XOrz
 TyCY6OMvHP8zASQ04w5PHXSyU26ngdKRxmryp3XoqJ0mucFjfVOHy4F2SMngsDeVbeAb
 HfTIcGk9ub0FCUh0SStfbcNhlGyF8bEZbU3DRq4igWuq3BVGyZcQOtmFXDeB2vYOGOvQ
 BKrPr4R6OS6ViWm2ETqUEz8HpfK4RNHyIZLM2j6SksjNyn999sOYGFgls72Eop8hSp20
 cevvSU0fYyqsGT+G1KVKcA3l4ODchu3X86wv8HBPk+fFkPG0x/rHckC+pk3jpVm5iiTJ
 Bwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782456493; x=1783061293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9N0cksKNHvZ81428H3lVKSOV4A7mJ0/dw00DfAdSSuw=;
 b=OtgEjMtcKzckqb3OPtGXYC53flE/FiwxvASRN4FQhOxC6Q8tUzuWIuDHmGKIs1jJ5E
 y8gzYPWIXaHPXQCmGM1TFrejhh+L0W3SSQ52UjOZib2q3/ITd9I1tn0orGligUDs2GB0
 rQsWm+WPvkXQVl9LfHaOTTYqNvYcq1wf/dvCvXLNmhgfA3D0FiPQbIR5f2RijkZbqtdo
 NkGJEUIoteONDV9wea0dn3kTDMKppT79yX+fdYlFYiSetT76X6Ks4mLOWHF0WrzuXSx1
 IAOPGBAFIevrJ/Glw/AFqPo0yRI9Xl0GYXEMHQAk1Wol9p3MVHKCHEtmUBHe2RDV3WbN
 0Spw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+jB7dNCG6f64ICBVi7uCw/VLRKK7BiFOVN85T18vaeR3Dv5L7FiQGB2JHTtr+/Co/9zSmhA4dQ2pg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyaDVwMzp/j+EmSNwo8shIrG187TjTNBFThYA2cwfEQQkubdgtc
 6j8rxMrD2rTVjHOPPV+HNhwRpEkaryTcdbRvqlcHoA9E9j7Nd9vkZvo9
X-Gm-Gg: AfdE7ckI7dW0ddHrNh8+hjMcjwLEUT4km7rdxJra2DYF4YG1f3rC6hX3KVrrgvPrAJp
 BGdQ6OKGghXAObGkpNGfrqQQJu19YvXovGIIW1hkir2K7QqRep4RcIk9II5nU7nzbNEwWwPMt5S
 uDlAkmF9ykGbPSELTHWa7ZY7nr4XUIyGyuNLSYBBBrKgbI4X+efRbTOmVdTgh6Il0O9/WEPCoM8
 49Shtm/yIg9kfNcUF1WB95VjtC66/uQsspS8XG1cN9UdLnkGq9NYF9zZf4pBe3RGkokk5M6ilmY
 BbUPn+7AI10Up6X/M6MN5ZERz3oTCUVqMCFRLjYR7l8hnGzVf3EkshlKiKGQgtAc35s+p2FEztK
 pR+MCiW+lNtylinI9QQMyKS1PdHETatdr05mm4h1rVwdOJAD16+gUIXYaceZNtpnCiOdeNYKehs
 nXkEeKYo4nOh/+e7hiNswi8V8Kt1QmQphD19r6vhMZnff3exMZqg==
X-Received: by 2002:a05:600c:3143:b0:492:4cce:53e2 with SMTP id
 5b1f17b1804b1-4926683b1a2mr69365785e9.3.1782456492535; 
 Thu, 25 Jun 2026 23:48:12 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492690a1a85sm93653035e9.15.2026.06.25.23.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 23:48:12 -0700 (PDT)
Date: Fri, 26 Jun 2026 07:48:10 +0100
From: David Laight <david.laight.linux@gmail.com>
To: suryasaimadhu <suryasaimadhu369@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix unaligned access and buffer size
 when startbyte is used
Message-ID: <20260626074810.433c4006@pumpkin>
In-Reply-To: <20260625103041.281190-1-suryasaimadhu369@gmail.com>
References: <20260625103041.281190-1-suryasaimadhu369@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 25 Jun 2026 18:30:41 +0800
suryasaimadhu <suryasaimadhu369@gmail.com> wrote:

> When par->startbyte is non-zero, buf is advanced by one byte creating
> an unaligned pointer for 16-bit types (u16, __be16). Dereferencing this
> unaligned pointer can cause a kernel panic on strict-alignment
> architectures.
> 
> Fix by using put_unaligned() instead of direct pointer dereference.
> 
> Also fix incorrect buffer size calculation in fbtft_write_buf_dc() call:
>   len * (sizeof(data_type) + offset)  /* wrong: multiplies offset by len */
>   len * sizeof(data_type) + offset    /* correct: one startbyte +
>                                          len items */

That should probably be a separate patch.

> 
> Signed-off-by: suryasaimadhu <suryasaimadhu369@gmail.com>
> ---
>  drivers/staging/fbtft/fbtft-bus.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
> index 2169f8d1d..cfcf4d7e7 100644
> --- a/drivers/staging/fbtft/fbtft-bus.c
> +++ b/drivers/staging/fbtft/fbtft-bus.c
> @@ -4,6 +4,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/spi/spi.h>
>  #include "fbtft.h"
> +#include <linux/unaligned.h>
>  
>  /*****************************************************************************
>   *
> @@ -40,7 +41,7 @@ void func(struct fbtft_par *par, int len, ...)                                \

I'd consider changing that to:
	func(struct fbtft_par *par, int len, u8 cmd, ...)
and probably reducing len by one.

It makes it more obvious that the first parameter is mandatory and the ... is
associated data.

	David

>  		offset = 1;                                                   \
>  	}                                                                     \
>  									      \
> -	*buf = modifier((data_type)va_arg(args, unsigned int));               \
> +	put_unaligned(modifier((data_type)va_arg(args, unsigned int)), buf);  \
>  	ret = fbtft_write_buf_dc(par, par->buf, sizeof(data_type) + offset,   \
>  				 0);                                          \
>  	if (ret < 0)							      \
> @@ -52,11 +53,13 @@ void func(struct fbtft_par *par, int len, ...)                                \
>  									      \
>  	if (len) {                                                            \
>  		i = len;                                                      \
> -		while (i--)						      \
> -			*buf++ = modifier((data_type)va_arg(args,             \
> -							    unsigned int));   \
> +		while (i--) {                                                 \
> +			put_unaligned(modifier((data_type)va_arg(args,        \
> +					       unsigned int)), buf);          \
> +			buf++;                                                \
> +		}                                                             \
>  		fbtft_write_buf_dc(par, par->buf,			      \
> -				   len * (sizeof(data_type) + offset), 1);    \
> +				   len * sizeof(data_type) + offset, 1);      \
>  	}                                                                     \
>  out:									      \
>  	va_end(args);                                                         \

