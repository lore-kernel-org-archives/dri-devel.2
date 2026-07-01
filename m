Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DFCC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 20:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6EF910EFEC;
	Wed,  1 Jul 2026 20:05:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CbVYFDl4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 221B310EFEC
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 20:05:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1D9416001D;
 Wed,  1 Jul 2026 20:05:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E33A1F000E9;
 Wed,  1 Jul 2026 20:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782936340;
 bh=g7/A390eY5J9OJzf+cYzH6TGGqISp3TPh1uGKzUtdKY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=CbVYFDl4Shd272uwnCiHpQE1ttFBPprzn5qjetkapaoNjn5iNWiFmCLK1GtLc9av2
 vIK63933K01L7Bza6tkk4xdRXCuhFrvKe1cOXCWgKO2ZR2Droc4143XPqph1crI5+v
 soVnzcks2sZOCwZwBZ1y6LmdB0DNCI4VzPfOf2YBaFm6tb8fZho/2ujsIv4gWGkgLw
 jlet6LVoU/9Amn0GXS+BRTm2IOSwN2bOAqq8NBlOLn0riWiyOAkzljqSbEH1qgxeXB
 UmlfKSgrW0nFTAEZ3bGaaeDXlxrBkC3ygQpSuOJZgiC8/PDJ0JcghWFKp+tKYh6ko/
 EWHV451NN+b/A==
Message-ID: <bb91ed5e-0fe9-4317-b73d-b28b593d4c25@kernel.org>
Date: Wed, 1 Jul 2026 21:05:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: fastrpc: reject overflowing invoke buffer ranges
To: Yousef Alhouseen <alhouseenyousef@gmail.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
References: <20260624174410.6074-1-alhouseenyousef@gmail.com>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <20260624174410.6074-1-alhouseenyousef@gmail.com>
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



On 6/24/26 6:44 PM, Yousef Alhouseen wrote:
> fastrpc_get_buff_overlaps() builds end addresses from user ranges.
> 
> A wrapped end can understate the payload size.
> 
> It can also feed bad ranges into the invoke metadata.
> 
> Reject invoke buffers whose pointer plus length overflows.
> 
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
You have sent 11 patches independently, I would prefer it to be sent as
single series.

Are these patches fixing anything that your usecases are hitting?

Have you looked at the patches in the mailing list which fixes some of
these issues?

Or

Is AI generating these patches ?


--srini


> ---
>  drivers/misc/fastrpc.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f3a493845..ba4ade874 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/of.h>
> +#include <linux/overflow.h>
>  #include <linux/platform_device.h>
>  #include <linux/sort.h>
>  #include <linux/of_platform.h>
> @@ -607,14 +608,17 @@ static int olaps_cmp(const void *a, const void *b)
>  	return st == 0 ? ed : st;
>  }
>  
> -static void fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
> +static int fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
>  {
>  	u64 max_end = 0;
>  	int i;
>  
>  	for (i = 0; i < ctx->nbufs; ++i) {
>  		ctx->olaps[i].start = ctx->args[i].ptr;
> -		ctx->olaps[i].end = ctx->olaps[i].start + ctx->args[i].length;
> +		if (check_add_overflow(ctx->olaps[i].start,
> +				       ctx->args[i].length,
> +				       &ctx->olaps[i].end))
> +			return -EOVERFLOW;
>  		ctx->olaps[i].raix = i;
>  	}
>  
> @@ -641,6 +645,8 @@ static void fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
>  			max_end = ctx->olaps[i].end;
>  		}
>  	}
> +
> +	return 0;
>  }
>  
>  static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
> @@ -675,7 +681,13 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
>  			return ERR_PTR(-ENOMEM);
>  		}
>  		ctx->args = args;
> -		fastrpc_get_buff_overlaps(ctx);
> +		ret = fastrpc_get_buff_overlaps(ctx);
> +		if (ret) {
> +			kfree(ctx->olaps);
> +			kfree(ctx->maps);
> +			kfree(ctx);
> +			return ERR_PTR(ret);
> +		}
>  	}
>  
>  	/* Released in fastrpc_context_put() */

