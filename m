Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 033CECDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:29:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45F2B10F2B0;
	Thu, 25 Jun 2026 14:29:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="MnWZqGEn";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 4B17210F2B0;
 Thu, 25 Jun 2026 14:29:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 262973165;
 Thu, 25 Jun 2026 07:29:09 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 669E53F836;
 Thu, 25 Jun 2026 07:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782397753; bh=qjgPdRm4ZE5PWnURF3lUNHIhYW/JfrxqkVr5Kw1oNwE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MnWZqGEnKH2EhQavXCW7Yl0+Q8r4veQKBRHMWp+oc8Bz6nX8Ny55VHMzy1n3XM1v3
 Ci0wWwUw/VUTmG1EyJiBOhzksBI6DlkdWWg194tllBG2FoG7rgJurqCmkvMxyf580d
 jnj2+fdQZRxD5uEIgUBAUEqxO9xom3Jd/BkU1ceY=
Message-ID: <ce5f27fd-82be-4750-8592-2eeb31a54523@arm.com>
Date: Thu, 25 Jun 2026 15:29:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drivers/iommu: Unroll unsuccessful mapping
To: Krzysztof Karas <krzysztof.karas@intel.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev
Cc: Andi Shyti <andi.shyti@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
References: <20260625134342.1102921-1-krzysztof.karas@intel.com>
 <20260625134342.1102921-2-krzysztof.karas@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260625134342.1102921-2-krzysztof.karas@intel.com>
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

On 25/06/2026 2:43 pm, Krzysztof Karas wrote:
> Currently, if iommu maps fewer bytes than requested (iova_len),
> it proceeds to free the iova, but never tries to unmap already
> touched bytes. This behavior may cause memory hogging down the
> line.

Huh? iommu_map_sg() has always unmapped internally upon any error - can 
you clarify how you've seen it returning a short mapping in a non-error 
case?

Thanks,
Robin.

> Correct that by unmapping before exiting.
> 
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
>   drivers/iommu/dma-iommu.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 381b60d9e7ce..c4c058ba07ef 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1515,8 +1515,14 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>   	 * implementation - it knows better than we do.
>   	 */
>   	ret = iommu_map_sg(domain, iova, sg, nents, prot, GFP_ATOMIC);
> -	if (ret < 0 || ret < iova_len)
> +	if (ret < 0 || ret < iova_len) {
> +		if (ret > 0) {
> +			/* Unmap partially mapped bytes before freeing IOVA */
> +			if (iommu_unmap(domain, iova, ret) != ret)
> +				ret = -EIO;
> +		}
>   		goto out_free_iova;
> +	}
>   
>   	return __finalise_sg(dev, sg, nents, iova);
>   
> @@ -1525,7 +1531,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>   out_restore_sg:
>   	__invalidate_sg(sg, nents);
>   out:
> -	if (ret != -ENOMEM && ret != -EREMOTEIO)
> +	if (ret != -ENOMEM && ret != -EREMOTEIO && ret != -EIO)
>   		return -EINVAL;
>   	return ret;
>   }

