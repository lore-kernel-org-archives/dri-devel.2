Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5FCCD5BD1
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 22:44:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6869D10F63F;
	Tue,  2 Jun 2026 22:44:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="tEvbjnvw";
	dkim-atps=neutral
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com
 [95.215.58.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E3DC10F63F
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 22:44:29 +0000 (UTC)
Date: Wed, 3 Jun 2026 00:44:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1780440267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v0L4kZCFL6r3fPJtAkqsclFqnfoARljWtQTrNXqgcjI=;
 b=tEvbjnvwYzs5Kuk0IutQDjkGMejXhiu2VZxYVQAkQVsYj0i73ZVCRPDVsKegTfSoI5Qqbr
 pEyNg8zdv1S6+n0SfubXaZn0IfzXgl/F4urf45X8GcyPTCFqGr8tbpi+rSAhuwlZv+WFGI
 YvVcfHtvX5tTKpvrACLm12+IXhWPXA0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T.J. Mercier" <tjmercier@google.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] dma-buf: heaps: use max3 in dma_heap_ioctl
Message-ID: <ah9cwXA2CO5VB6Kf@linux.dev>
References: <20260517172352.3615-2-thorsten.blum@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517172352.3615-2-thorsten.blum@linux.dev>
X-Migadu-Flow: FLOW_OUT
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

Gentle ping?

On Sun, May 17, 2026 at 07:23:53PM +0200, Thorsten Blum wrote:
> Replace two nested max() calls with a single max3() in dma_heap_ioctl().
> 
> Reviewed-by: T.J. Mercier <tjmercier@google.com>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Include minmax.h as suggested by T.J. Mercier
> - v1: https://lore.kernel.org/lkml/20260427172519.417333-3-thorsten.blum@linux.dev/
> ---
>  drivers/dma-buf/dma-heap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> index ac5f8685a649..d49188893608 100644
> --- a/drivers/dma-buf/dma-heap.c
> +++ b/drivers/dma-buf/dma-heap.c
> @@ -13,6 +13,7 @@
>  #include <linux/err.h>
>  #include <linux/export.h>
>  #include <linux/list.h>
> +#include <linux/minmax.h>
>  #include <linux/nospec.h>
>  #include <linux/syscalls.h>
>  #include <linux/uaccess.h>
> @@ -153,7 +154,7 @@ static long dma_heap_ioctl(struct file *file, unsigned int ucmd,
>  		in_size = 0;
>  	if ((ucmd & kcmd & IOC_OUT) == 0)
>  		out_size = 0;
> -	ksize = max(max(in_size, out_size), drv_size);
> +	ksize = max3(in_size, out_size, drv_size);
>  
>  	/* If necessary, allocate buffer for ioctl argument */
>  	if (ksize > sizeof(stack_kdata)) {
