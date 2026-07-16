Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06D4C4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B0AD10E76E;
	Thu, 16 Jul 2026 12:39:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OLwr7NJC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F2E210E340;
 Thu, 16 Jul 2026 12:39:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 405E16001A;
 Thu, 16 Jul 2026 12:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BD91F00A3F;
 Thu, 16 Jul 2026 12:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784205570;
 bh=ONEYSRbHrj5WrahlWna8PWRUDAAMMlM2zTr2tPRhXF8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OLwr7NJCTL8jEBbqhvymHgq8wpgmgyUdoRuZHsCTERhWVgkZ8h+rD8VdGdP1/fMhL
 NDqUxFf0NhpIzPyFoJAIxpZVNXiXHe1m3GzIo/JLuRGAuhIHuZIbm+xWkWrRTwC7K3
 U2W8NpAN9oADMX6f5JG1e/tIQT3R0EsdWuEaaNNKHlUUdee18Zh9lmZ/WQ1tpbJtCr
 RnNej4NGCZuECOVyPJBhkv1DlCHPYBIeJki2nqV7H4JvZiK9vwkw7WuShn6S40dY1k
 zxDdUlP+UJBxeNQk5Kp350yVB374Hh57i4+dVDf86jB7JlI/nR9i+3WGugcU4E8KVe
 UpafNwIY9Wpbg==
Date: Thu, 16 Jul 2026 14:39:27 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>, 
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, 
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v3 2/5] iommu/dma: Catch scatterlist length overflows
Message-ID: <aljQ6zuu8DQYbSgs@zenone.zhora.eu>
References: <20260713095812.1014365-1-krzysztof.karas@intel.com>
 <20260713095812.1014365-3-krzysztof.karas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713095812.1014365-3-krzysztof.karas@intel.com>
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

Jason, Robin? Any comment here?

Thanks,
Andi

On Mon, Jul 13, 2026 at 09:58:09AM +0000, Krzysztof Karas wrote:
> It is possible, when a very large mapping uses only one
> scatterlist, that padding overflows scatterlist's length field.
> This results in:
>  1) silently wrapping the value
>  2) smaller than desired mappings produced by iommu_map_sg
>  3) leaving mapped bytes in memory (no iommu_unmap)
> 
> Address this issue by adding overflow detection for scatterlist
> length field.
> 
> Fixes: 809eac54cdd6 ("iommu/dma: Implement scatterlist segment merging")
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
> v3:
>  * Used check_add_overflow suggested by Jason.
> 
> I decided not to include previous r-bs due to the change in the
> core of this patch: overflows_type -> check_add_overflow and I
> obvserved some folks have heavy preference for one or the other.
> 
>  drivers/iommu/dma-iommu.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 381b60d9e7ce..1a36fd9bf10b 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1493,7 +1493,18 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>  		 *   time through here (i.e. before it has a meaningful value).
>  		 */
>  		if (pad_len && pad_len < s_length - 1) {
> -			prev->length += pad_len;
> +			unsigned int new_pad_len;
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
>  			iova_len += pad_len;
>  		}
>  
> -- 
> 2.34.1
> 
