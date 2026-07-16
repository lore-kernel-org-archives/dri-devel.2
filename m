Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA4EC4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B04110E6F8;
	Thu, 16 Jul 2026 13:48:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="rw9/oT9U";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id BBD0710E352;
 Thu, 16 Jul 2026 13:48:29 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF7E71476;
 Thu, 16 Jul 2026 06:48:24 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70DAA3F66F;
 Thu, 16 Jul 2026 06:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1784209709; bh=fOb141Ib2L+UTpx/ZKcyPVUuXMCgsPlSHvwRGIat9R4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rw9/oT9UAq3SZ70Ytdx15x5W5vjNPwwH5iUBRNk/VbP2bR5+bGmiHvQd+ZXcNisjI
 qVOkYPsGUXZeP3UuGx8esAXzcmRazOxzZ81BnOr/l8rF0NGLKBqrEkbKox1KfujGfN
 Vn/Ld+TMemmMJCNugU2euxW7HnItw4QwE3TREJ+4=
Message-ID: <0e5120ea-8851-41e2-b3b0-021fb35f61b7@arm.com>
Date: Thu, 16 Jul 2026 14:48:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] iommu/dma: Catch scatterlist length overflows
To: Krzysztof Karas <krzysztof.karas@intel.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev
Cc: Andi Shyti <andi.shyti@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Micha=C5=82_Grzelak?= <michal.grzelak@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
References: <20260713095812.1014365-1-krzysztof.karas@intel.com>
 <20260713095812.1014365-3-krzysztof.karas@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260713095812.1014365-3-krzysztof.karas@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 13/07/2026 10:58 am, Krzysztof Karas wrote:
> It is possible, when a very large mapping uses only one
> scatterlist, that padding overflows scatterlist's length field.
> This results in:
>   1) silently wrapping the value
>   2) smaller than desired mappings produced by iommu_map_sg
>   3) leaving mapped bytes in memory (no iommu_unmap)
> 
> Address this issue by adding overflow detection for scatterlist
> length field.
> 
> Fixes: 809eac54cdd6 ("iommu/dma: Implement scatterlist segment merging")
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
> v3:
>   * Used check_add_overflow suggested by Jason.
> 
> I decided not to include previous r-bs due to the change in the
> core of this patch: overflows_type -> check_add_overflow and I
> obvserved some folks have heavy preference for one or the other.
> 
>   drivers/iommu/dma-iommu.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 381b60d9e7ce..1a36fd9bf10b 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1493,7 +1493,18 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>   		 *   time through here (i.e. before it has a meaningful value).
>   		 */

Sorry to be a pain, but since we *have* now spent the time reasoning 
through the details, for completeness I think it would be worth also 
explicitly checking "s_length & UINT_MAX != 0" (or equivalent) after the 
the prior iova_align() - since that's only rounding up an unsigned int 
value to a power of 2 it can't arbitrarily overflow like the addition 
below, but it could still wrap to zero in the assignment to s->length, 
or indeed in the size_t itself on 32-bit.

>   		if (pad_len && pad_len < s_length - 1) {
> -			prev->length += pad_len;
> +			unsigned int new_pad_len;

Super-nit: "pad_len" is the amount of potential padding from the end of 
the previous segment up to the next segment boundary; the value we're 
calculating here is the updated *total* segment length, so 
"new_prev_len" would be more accurate and a bit clearer - the logic here 
is fiddly enough as it is, so every little helps :)

With those tweaks (since it sounds like there's still another respin or 
two to go for the rest of the series anyway),

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Cheers,
Robin.

> +			/*
> +			 * For large mappings spanning multiple GBs we
> +			 * may not be able to fit all needed padding into
> +			 * sg->length.
> +			 */
> +			if (check_add_overflow(prev->length, pad_len, &new_pad_len)) {
> +				ret = -EOVERFLOW;
> +				goto out_restore_sg;
> +			}
> +
> +			prev->length = new_pad_len;
>   			iova_len += pad_len;
>   		}
>   

