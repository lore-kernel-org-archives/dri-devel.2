Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3716DCDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 08:13:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92F5D10E518;
	Mon, 22 Jun 2026 08:13:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TUAjB7S9";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6434310E518
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 08:13:48 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so31062295e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 01:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782116027; x=1782720827; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y69DNLtkcPX106ySVX6ZlNH6S9rjQScn7EBr8UTU9k0=;
 b=TUAjB7S9rubIJef7F/H1DxG1uQepKx/jfI/fCwfHYyBGz7qVgxr4ozqa9HYjZNq+MX
 pBJBrWncvxSXXkqnadWoI9VoTi4TYpD1mWvGfku9gZc2atMo90by+MIf5Il2qEOjlZFx
 7TGjLflbB7xYR90FayaWdyr/jV2pYtdaKzqTXzujBlGvrXmkw4PA4Ze5Lz53MEInTmXI
 N1AAf0pHaG6h3rf3PZNM/IOoRRDw69aaTHw2fZjtFlHRcLiDR+5c0FuqaQURzMOON8fQ
 WCeF7tySuPygGqpozMo8/LatIo27ou1lQWwSlDxG0qi3deYH0j3oM8F+u1F4/4is35tq
 bYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782116027; x=1782720827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y69DNLtkcPX106ySVX6ZlNH6S9rjQScn7EBr8UTU9k0=;
 b=TW/14ShHlMmD7ynn+UkYR58/4tIMr87xRQDhH2iwzl7U1yzf+INrB0tlwnpEOzNGnF
 WqB3HtrarVquAj0nTwV/XejvJ+SW+LTVJX5rFWJ1fw4m4FF7w4TKC8rHDcMPSGnKZ0Le
 oB3+A7Dypfl3FBFyYzVFSws05ulGCbDpo8xuA9TR2YfAAXCnYKULgpWKMd/VuWbW1ff6
 LRDEATVwvdxAs8iaeBZw+HiFHaumT2uDDw+TCKEW2SWUlDLN70STwuio9BaHeZf8EYRW
 Yw2HF+CX44FsT2+8U907mJ0cWCbAm7JlvET08/x1sR6mdKOJTEiPRr5r8kph/23IJnTB
 VY/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+thi2nP35AZzolZz8TLodVTcAl8Tj41pBU9FXonL9LwKQwK1JsGVuA18DJ4DeTJxmkJZwinSTJMo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwsKdD/ShYwSO0tfwWOGGNDLvB0zchCncznBHRXurdoXegZ7YTt
 GvcnxlVbo/Uqi+qaGbul6tzAbiHqO4FCYRR6jriI+x8ko45jv0MFX+ar
X-Gm-Gg: AfdE7cksI7XwxKRX9f4lMP+ncNMy4OU/6HjzXWwX5vbjtKW1zRR7ZYO7YB+RLUCwKWt
 jWOc2HG/ZKCFZPQWjEJo9vbqlzluEjoeqi2FUMLzxqpQaCb9CoY+ikznavobNsPfa8WXPFW1hcr
 uDYKecyFFSzcnYSD9PWcuXUB5BqwyXv45dNu6sH61dkN12Zg3IYNOZGXWsNySdp04PZqKk1hCx3
 Q2QWXFcNl0T5qHq4LnPOo16n0lQwOIHF7JaIfZypF84Ls0RI4eZocvmm51dB5rkqHLErCr3zgzH
 pgPRpvj2TLQidIMwFAX641UEBzcJtWi0ro4NfkQ97XV+daXrRtIGtoqc/sx0aZw+AyKX3GdIGFA
 xb8F/c7gWtbSZspr2CG3ZQdw3WXI64w0Hk5yH6BkRXVnS8p0hdOtQWnOb8J12+Wk5IfRb+ExffB
 OB7cu3wwxwtjGbXYqaW2TZIYW5a506wcTTBorlSVbxiGxPb9LchA==
X-Received: by 2002:a05:600c:8719:b0:492:4c60:bfb8 with SMTP id
 5b1f17b1804b1-4924c60bfdemr121648545e9.28.1782116026585; 
 Mon, 22 Jun 2026 01:13:46 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fd30078sm274806595e9.7.2026.06.22.01.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 01:13:45 -0700 (PDT)
Date: Mon, 22 Jun 2026 09:13:44 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Hu <xuehaohu@google.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, "Christian =?UTF-8?B?S8O2bmln?="
 <christian.koenig@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen
 <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Kevin Tian
 <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, Alex Williamson
 <alex@shazbot.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com,
 praan@google.com, kpberry@google.com, sashiko-bot <sashiko-bot@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH] dma-buf: Split sgl by largest page-aligned chunk
Message-ID: <20260622091344.794e0d74@pumpkin>
In-Reply-To: <20260621222130.1667453-1-xuehaohu@google.com>
References: <20260621222130.1667453-1-xuehaohu@google.com>
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

On Sun, 21 Jun 2026 22:21:30 +0000
David Hu <xuehaohu@google.com> wrote:

> Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
> This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
> first entry, resulting in non-page-aligned DMA addresses for all
> subsequent entries.

How did you find this?
It requires a single buffer over 4GB - seems highly unlikely.


> 
> While the underlying IOMMU mapping may be contiguous, hardware
> DMA engines often require explicit address alignment (e.g., page,
> cacheline, or storage sector boundaries). Passing unaligned
> addresses and lengths can cause explicit failures in DMA descriptor
> creation or silent data corruption if lower unaligned bits are
> truncated.
> 
> Fix this by splitting the scatterlist by the largest possible page
> aligned chunk within `UINT_MAX` (`ALIGN_DOWN(UINT_MAX, PAGE_SIZE)`).
> This ensures all scatterlist DMA addresses and lengths remain page
> aligned and satisfy hardware constraints.

It would almost certainly better to spilt into 2G chunks.
That removes any need for any divisions.

> Page-aligned entries allow the system to cleanly chunk payloads into
> PCIe MaxPayloadSize (MPS) (e.g., 128 bytes, 256 bytes, 512 bytes).
> As a result, this may help reduce TLP fragmentation in P2P transfers
> and alleviate potential congestion within a logical PCIe switch
> partition, especially when Relaxed Ordering is not possible due to
> hardware constraints.
> 
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260609165431.778061F00893@smtp.kernel.org/
> Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hu <xuehaohu@google.com>
> ---
>  drivers/dma-buf/dma-buf-mapping.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
> index 794acff2546a..f2bde38fdb1f 100644
> --- a/drivers/dma-buf/dma-buf-mapping.c
> +++ b/drivers/dma-buf/dma-buf-mapping.c
> @@ -5,6 +5,9 @@
>   */
>  #include <linux/dma-buf-mapping.h>
>  #include <linux/dma-resv.h>
> +#include <linux/align.h>
> +
> +#define MAX_ENT_SZ ALIGN_DOWN(UINT_MAX, PAGE_SIZE)

>  
>  static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
>  					 dma_addr_t addr)
> @@ -12,9 +15,9 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
>  	unsigned int len, nents;
>  	int i;
>  
> -	nents = DIV_ROUND_UP(length, UINT_MAX);
> +	nents = DIV_ROUND_UP(length, MAX_ENT_SZ);
>  	for (i = 0; i < nents; i++) {

Why not change that to 'while (length) {' to avoid the division above.

> -		len = min_t(size_t, length, UINT_MAX);
> +		len = min_t(size_t, length, MAX_ENT_SZ);

I bet that doesn't need to be min_t()

>  		length -= len;
>  		/*
>  		 * DMABUF abuses scatterlist to create a scatterlist
> @@ -24,7 +27,7 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
>  		 * does not require the CPU list for mapping or unmapping.
>  		 */
>  		sg_set_page(sgl, NULL, 0, 0);
> -		sg_dma_address(sgl) = addr + (dma_addr_t)i * UINT_MAX;
> +		sg_dma_address(sgl) = addr + (dma_addr_t)i * MAX_ENT_SZ;
>  		sg_dma_len(sgl) = len;

Replace the multiply with 'addr += len'.

-- David

>  		sgl = sg_next(sgl);
>  	}
> @@ -41,14 +44,14 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
>  
>  	if (!state || !dma_use_iova(state)) {
>  		for (i = 0; i < nr_ranges; i++)
> -			nents += DIV_ROUND_UP(phys_vec[i].len, UINT_MAX);
> +			nents += DIV_ROUND_UP(phys_vec[i].len, MAX_ENT_SZ);
>  	} else {
>  		/*
>  		 * In IOVA case, there is only one SG entry which spans
>  		 * for whole IOVA address space, but we need to make sure
>  		 * that it fits sg->length, maybe we need more.
>  		 */
> -		nents = DIV_ROUND_UP(size, UINT_MAX);
> +		nents = DIV_ROUND_UP(size, MAX_ENT_SZ);
>  	}
>  
>  	return nents;

